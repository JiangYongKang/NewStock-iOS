//
//  EmbedFFViewController.m
//  NewStock
//
//  Created by 王迪 on 2017/1/16.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "EmbedFFViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>

@interface EmbedFFViewController ()<EmbedWebViewDelegate,UIActionSheetDelegate>

@property (nonatomic, copy) NSString *value1;
@property (nonatomic, copy) NSString *value2;

@end

@implementation EmbedFFViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [_scrollView removeFromSuperview];
    
    self.view.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:self.webView];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
//    self.webView.webView.scrollView.scrollEnabled = YES;
}

- (EmbedWebView *)webView {
    if (_webView == nil) {
        _webView = [[EmbedWebView alloc] initWithUrl:self.myUrl];
        _webView.delegate = self;
    }
    return _webView;
}

- (void)didFinishLoadWebView {
    
    JSContext *context = [self.webView.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    context[@"actionSheet"] = ^(NSString *v1,NSString *v2){
        self.value1 = v1;
        self.value2 = v2;
        dispatch_async(dispatch_get_main_queue(), ^{
            UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"确定不再关注此人?" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"确定" otherButtonTitles:nil];
            [actionSheet showInView:self.view];
        });
    };
    
    context[@"getUserId"] = ^{
        return [SystemUtil getCache:USER_ID];
    };
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        [self.webView.webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"B('%@','%@')",self.value1,self.value2]];
    }
}

@end
