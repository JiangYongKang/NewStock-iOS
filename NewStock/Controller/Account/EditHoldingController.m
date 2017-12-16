//
//  EditHoldingController.m
//  NewStock
//
//  Created by Willey on 16/8/24.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "EditHoldingController.h"
#import "RecordHoldingController.h"

@implementation EditHoldingController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"编辑持仓";
    [_navBar setTitle:self.title];
    _navBar.line_view.hidden = YES;
    
    [_navBar setRightBtnTitle1:@"添加" title2:@"清空"];
    
    
    _clearPosAPI = [[ClearPosAPI alloc] init];
    _clearPosAPI.delegate = self;
    _clearPosAPI.animatingView = _mainView;
    _clearPosAPI.animatingText = @"正在清空";
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
        
    [_webView reload];

}

- (void)navBar:(NavBar*)navBar rightButton1Tapped:(UIButton*)sender {
    RecordHoldingController *viewController = [[RecordHoldingController alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
    
}

- (void)navBar:(NavBar*)navBar rightButton2Tapped:(UIButton*)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您确定要清空持仓？"
                                                   delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
    alert.tag = 101;
    [alert show];
}

#pragma mark - UIAlertDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if(alertView.tag == 101)
    {
        if(buttonIndex == 0)
        {
            NSString *userId = [SystemUtil getCache:USER_ID];
            _clearPosAPI.userId = userId;
            
            [_clearPosAPI start];
          

        }
    }
}

- (void)requestFinished:(APIBaseRequest *)request {
    NSLog(@"succeed:%@",request.responseJSONObject);

    [_webView reload];
}

- (void)requestFailed:(APIBaseRequest *)request {
    NSLog(@"fail:%@",request.responseJSONObject);
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:[request.responseJSONObject objectForKey:@"msg"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alertView show];
}

@end
