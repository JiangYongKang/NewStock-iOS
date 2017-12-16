//
//  RefreshSettingViewController.m
//  NewStock
//
//  Created by Willey on 16/8/23.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "RefreshSettingViewController.h"
#import "MarketConfig.h"

@implementation RefreshSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"行情刷新频率";
    [_navBar setTitle:self.title];
    
    //    [_scrollView mas_remakeConstraints:^(MASConstraintMaker *make) {
    //        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(NAV_BAR_HEIGHT, 0, 0, 0));
    //    }];
    //    [_scrollView layoutIfNeeded];
    
    
    // 1.第0组：3个
    [self add0SectionItems];
    
    // 2.第1组：
    [self add1SectionItems];
    
    [self updateStatus];

}

-(void)updateStatus
{
 
    
    float f = [MarketConfig getRefreshTime];
    if (fabsf(f-5)<0.000001)
    {
        _item0.type = ZFSettingItemTypeNone;
        _item1.type = ZFSettingItemTypeCheckmark;
        _item2.type = ZFSettingItemTypeNone;
        _item3.type = ZFSettingItemTypeNone;
    }
    else if (fabsf(f-15)<0.000001)
    {
        _item0.type = ZFSettingItemTypeNone;
        _item1.type = ZFSettingItemTypeNone;
        _item2.type = ZFSettingItemTypeCheckmark;
        _item3.type = ZFSettingItemTypeNone;
    }
    else if (fabsf(f-30)<0.000001)
    {
        _item0.type = ZFSettingItemTypeNone;
        _item1.type = ZFSettingItemTypeNone;
        _item2.type = ZFSettingItemTypeNone;
        _item3.type = ZFSettingItemTypeCheckmark;
    }
    else if (fabsf(f-100000)<0.000001)
    {
        _item0.type = ZFSettingItemTypeCheckmark;
        _item1.type = ZFSettingItemTypeNone;
        _item2.type = ZFSettingItemTypeNone;
        _item3.type = ZFSettingItemTypeNone;
    }
    
    
    [_tableView reloadData];

}

#pragma mark 添加第0组的模型数据
- (void)add0SectionItems
{
    __weak typeof(self) weakSelf = self;

    _item0 = [ZFSettingItem itemWithIcon:@"" title:@"不刷新" type:ZFSettingItemTypeNone];
    //cell点击事件
    _item0.operation = ^{
        
        [MarketConfig setRefreshTime:100000.0];
        [weakSelf updateStatus];

    };
    
    
    _item1 = [ZFSettingItem itemWithIcon:@"" title:@"5秒" type:ZFSettingItemTypeNone];
    //cell点击事件
    _item1.operation = ^{
        
        [MarketConfig setRefreshTime:5.0];
        
        [weakSelf updateStatus];
    };
    
    _item2 = [ZFSettingItem itemWithIcon:@"" title:@"15秒" type:ZFSettingItemTypeNone];
    //cell点击事件
    _item2.operation = ^{
        
        [MarketConfig setRefreshTime:15.0];

        [weakSelf updateStatus];

    };
    
    _item3 = [ZFSettingItem itemWithIcon:@"" title:@"30秒" type:ZFSettingItemTypeNone];
    //cell点击事件
    _item3.operation = ^{
        
        [MarketConfig setRefreshTime:30.0];

        [weakSelf updateStatus];

    };
    
    
    
    ZFSettingGroup *group = [[ZFSettingGroup alloc] init];
//    group.header = @"2G/3G/4G";
    group.items = @[_item0,_item1,_item2,_item3];
    [_allGroups addObject:group];
}

- (void)add1SectionItems
{
//    __weak typeof(self) weakSelf = self;
    ZFSettingItem *item = [ZFSettingItem itemWithIcon:@"" title:@"不刷新" type:ZFSettingItemTypeNone];
    //cell点击事件
    item.operation = ^{
        
    };
    
    
    ZFSettingItem *item1 = [ZFSettingItem itemWithIcon:@"" title:@"5秒" type:ZFSettingItemTypeCheckmark];
    //cell点击事件
    item1.operation = ^{
        
    };
    
    
    ZFSettingGroup *group = [[ZFSettingGroup alloc] init];
//    group.header = @"WIFI";
    group.items = @[item, item1];
    [_allGroups addObject:group];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30.0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    //return 10;//这个方法不写，或者return 0跟return 12的效果一样
    return 0.01;//把高度设置很小，效果可以看成footer的高度等于0
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UILabel *lb = [[UILabel alloc]initWithFrame:CGRectMake(15, 3, MAIN_SCREEN_WIDTH, 24)];
    
    lb.backgroundColor = kUIColorFromRGB(0xf1f1f1);
    
    lb.font = [UIFont systemFontOfSize:12];
    
    UIView *bg = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WIDTH, 24)];
    
    [bg addSubview:lb];
    
    if (section == 0) {
        
        lb.text = @"2G/3G/4G";
    }else {
    
        lb.text = @"WIFI";
    }
    
    return bg;
}





@end
