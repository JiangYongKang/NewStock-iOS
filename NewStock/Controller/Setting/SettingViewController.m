//
//  SettingViewController.m
//  NewStock
//
//  Created by Willey on 16/8/23.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "SettingViewController.h"
#import "AboutViewController.h"
#import "SuggestViewController.h"
#import "PushSettingViewController.h"
#import "RefreshSettingViewController.h"
#import "UserInfoInstance.h"
#import "SDImageCache.h"
#import "StockHistoryUtil.h"

#import "SettingInfoModel.h"
#import "SnapImageView.h"


@implementation SettingViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"设置";
    [_navBar setTitle:self.title];
   
    [self add0SectionItems];
    
    [self add1SectionItems];

    [self add3SectionItems];
    
}

- (NSString *)getCacheSize {
    float tmpSize = [[SDImageCache sharedImageCache] getSize];
    float tmpCount = [[SDImageCache sharedImageCache] getDiskCount];
    
    NSLog(@"%f",tmpSize);
    NSLog(@"%f",tmpCount);
    
    NSString *fileSize = [NSString stringWithFormat:@"%.2fM",tmpSize/1024.0/1024.0];
    
    return fileSize;
}

#pragma mark 添加第0组的模型数据
- (void)add0SectionItems {
    __weak typeof(self) weakSelf = self;
    // 1.1.推送和提醒
    ZFSettingItem *push = [ZFSettingItem itemWithIcon:@"" title:@"推送设置" type:ZFSettingItemTypeArrow];//about_icon
    //cell点击事件
    push.operation = ^{
        PushSettingViewController *vc = [[PushSettingViewController alloc] init];
        [weakSelf.navigationController pushViewController:vc animated:YES];
        
    };
    
    // 1.2.声音提示
    ZFSettingItem *shake = [ZFSettingItem itemWithIcon:@"" title:@"行情刷新频率" type:ZFSettingItemTypeArrow];
    //开关事件
    shake.operation = ^{
        RefreshSettingViewController *viewController = [[RefreshSettingViewController alloc] init];
        [weakSelf.navigationController pushViewController:viewController animated:YES];
    };
    
    ZFSettingGroup *group = [[ZFSettingGroup alloc] init];
    group.items = @[push,shake];
    [_allGroups addObject:group];
}

- (void)add1SectionItems {
    __weak typeof(self) weakSelf = self;
    NSString *cacheSize = [self getCacheSize];
    _clearItem = [ZFSettingItem itemWithIcon:@"" title:@"清除缓存" type:ZFSettingItemTypeDetail detail:cacheSize];//about_icon
    _clearItem.operation = ^{
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您确定要清除缓存吗？"
                                                       delegate:weakSelf cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
        alert.tag = 102;
        [alert show];
    };
    
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    NSString *verS = [NSString stringWithFormat:@"V%@",version];
    ZFSettingItem *about = [ZFSettingItem itemWithIcon:@"" title:@"关于我们" type:ZFSettingItemTypeDetail detail:verS];//about_icon
    about.operation = ^{
        AboutViewController *viewController = [[AboutViewController alloc] init];
        viewController.view.backgroundColor = [UIColor lightGrayColor];
        [weakSelf.navigationController pushViewController:viewController animated:YES];
    };
    
    ZFSettingGroup *group = [[ZFSettingGroup alloc] init];
    group.items = @[_clearItem,about];
    [_allGroups addObject:group];
}

- (void)add3SectionItems {
    ZFSettingItem *push = [ZFSettingItem itemWithIcon:@"" title:@"为股怪侠评分" type:ZFSettingItemTypeArrow];
    push.operation = ^{
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=1160573329"]];
    };
    
    
    ZFSettingGroup *group = [[ZFSettingGroup alloc] init];
    group.items = @[push];
    [_allGroups addObject:group];
}

#pragma mark - UIAlertDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {

    if(buttonIndex == 0) {
        
        [[SDImageCache sharedImageCache] clearDiskOnCompletion:nil];
        
        [[SDImageCache sharedImageCache] clearMemory];//可有可无
        
        _clearItem.detail = [self getCacheSize];
        
        [_tableView reloadData];
    }
}


@end
