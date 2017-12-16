//
//  EmbedWebViewController.m
//  NewStock
//
//  Created by Willey on 16/8/22.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "EmbedWebView.h"
#import "Masonry.h"
#import "WebViewController.h"
#import "AppDelegate.h"

@implementation EmbedWebView
@synthesize delegate;

- (id)initWithUrl:(NSString *)url {
    self = [super init];
    if (self)  {
        
        self.myUrl = url;
        
        _webView = [[UIWebView alloc] init];
        [_webView setUserInteractionEnabled: YES ];	 //是否支持交互
        [_webView setDelegate:self];	 //委托
        [_webView setOpaque:YES];	 //透明
        _webView.scrollView.scrollEnabled = NO;
        _webView.scrollView.bounces = NO;
        _webView.scrollView.delegate = self;

        [self addSubview:_webView];	 //加载到自己的view
        [_webView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(_webView.superview).with.insets(UIEdgeInsetsMake(0,0,0,0));
            
        }];
        
//        _progressProxy = [[NJKWebViewProgress alloc] init];
//        _webView.delegate = _progressProxy;
//        _progressProxy.webViewProxyDelegate = self;
//        _progressProxy.progressDelegate = self;
//        
//        CGFloat progressBarHeight = 2.f;
//        _progressView = [[NJKWebViewProgressView alloc] init];
//        _progressView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
//        [self addSubview:_progressView];
//        [_progressView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.left.right.equalTo(_progressView.superview);
//            make.height.mas_equalTo(progressBarHeight);
//        }];
        
        if (_myUrl) {
            NSString *urlStr = [_myUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

            NSURL *url = [[NSURL alloc] initWithString:urlStr];
            [_webView loadRequest:[ NSURLRequest requestWithURL:url]];
        }
    
    }
    
    return self;

}

- (void)setUrl:(NSString *)url {
    self.myUrl = url;
    NSString *urlStr = [_myUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *newUrl = [[NSURL alloc] initWithString:urlStr];
    [_webView loadRequest:[ NSURLRequest requestWithURL:newUrl]];
}

#pragma mark - NJKWebViewProgressDelegate
- (void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress {
    [_progressView setProgress:progress animated:YES];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if([self.delegate respondsToSelector:@selector(scrollViewDidScroll:)]) {
        [self.delegate scrollViewDidScroll:_webView.scrollView];
    }
}

- (void)webViewDidFinishLoad:(UIWebView *)wb {
    NSInteger height = [[_webView stringByEvaluatingJavaScriptFromString:@"document.body.scrollHeight"] integerValue];

    NSLog(@"~~~~~~~contentSize width:%lf, height:%lf",wb.scrollView.contentSize.width,wb.scrollView.contentSize.height);
    
    if([self.delegate respondsToSelector:@selector(embedWebView:webViewHeight:)]) {
        [self.delegate embedWebView:self webViewHeight:height];
    }
    
    if ([self.delegate respondsToSelector:@selector(didFinishLoadWebView)]) {
        [self.delegate didFinishLoadWebView];
    }

    [_webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitUserSelect='none';"];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    NSLog(@"didFailLoadWithError");
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {

    
    [UrlRedirectAction sharedUrlRedirectAction].delegate = self.delegate;
    

    if(self.type == 1) {
        NSRange urlRange = [[request.URL path]  rangeOfString:H5_FM0200];
        NSRange urlRange2 = [[request.URL path] rangeOfString:H5_FM0100];
        NSRange urlRange3 = [[request.URL path] rangeOfString:H5_ACCOUNT_MY_ASSET];
        NSRange urlRange4 = [[request.URL path] rangeOfString:H5_ACCOUNT_MY_HISTORY];
        if ((urlRange.length >0)||
            (urlRange2.length >0)||
            (urlRange3.length >0)||
            (urlRange4.length >0)) {
            return YES;
        } else {
            return [UrlRedirectAction redirectActionWithUrl:request.URL from:self.myUrl navigationType:navigationType];
        }
    }
    
    return [UrlRedirectAction redirectActionWithUrl:request.URL from:self.myUrl navigationType:navigationType];

}

- (void)commentDidFinished {
    [_webView reload];
}



@end
