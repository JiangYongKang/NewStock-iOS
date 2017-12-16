//
//  AppDelegate.h
//  NewStock
//
//  Created by Willey on 16/7/5.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StockCodesModel.h"
#import "StockCodesInstance.h"
#import "BaseViewController.h"
#import "WDNavController.h"
#import "WXTabBarController.h"
#import "EAIntroView.h"

//static NSString *appKey = @"e06e313a6c8d91821b38e38f";
static NSString *channel = @"appstore";

#ifdef DEBUG
static BOOL isProduction = NO;
#else
static BOOL isProduction = YES;
#endif

@interface AppDelegate : UIResponder <UIApplicationDelegate, UITabBarControllerDelegate,EAIntroDelegate>
{
    NSString *_curTitle;
    BaseViewController *_curViewController;
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) WDNavController *navigationController;
@property (nonatomic, assign) BOOL isEable;

@property (strong, nonatomic) StockCodesModel *stockCodesModel;
@property (nonatomic, strong) WXTabBarController *tabBarController;

- (void)showIntroView;

@end

