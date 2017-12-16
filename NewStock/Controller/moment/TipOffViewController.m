//
//  TipOffViewController.m
//  NewStock
//
//  Created by Willey on 16/9/26.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "TipOffViewController.h"
#import "Defination.h"

@interface TipOffViewController ()

@end

@implementation TipOffViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"举报";
    [_navBar setTitle:self.title];
    
    [self add0SectionItems];
    
    _tipOffAPI = [[TipOffAPI alloc] init];
    _tipOffAPI.delegate = self;
    _tipOffAPI.animatingView = _mainView;
    _tipOffAPI.animatingText = @"数据提交中";
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"提交" forState:UIControlStateNormal];
    [btn setTitleColor:kTitleColor forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:16];
    btn.backgroundColor = [UIColor whiteColor];
//    btn.layer.cornerRadius = 6;
//    btn.layer.masksToBounds = YES;
    [_mainView addSubview:btn];
    
    int offset = (_nMainViewHeight-44*6-30)/2;
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_mainView).offset(-offset-10);
        make.left.equalTo(_mainView).offset(0);
        make.right.equalTo(_mainView).offset(0);
        make.height.mas_equalTo(44);
    }];
}

- (void)selectIndex:(int)index {
    
    ZFSettingItem *item;
    if (index == 1)
    {
        item = _item1;
    }
    else if (index == 2)
    {
        item = _item2;
    }
    else if (index == 3)
    {
        item = _item3;
    }
    else if (index == 4)
    {
        item = _item4;
    }
    else if (index == 5)
    {
        item = _item5;
    }
    else if (index == 6)
    {
        item = _item6;
    }
    
    if (item.type == ZFSettingItemTypeCheckmark)
    {
        item.type = ZFSettingItemTypeNone;
    }
    else
    {
        item.type = ZFSettingItemTypeCheckmark;
    }
    
    [_tableView reloadData];
}

#pragma mark 添加第0组的模型数据
- (void)add0SectionItems {
    __weak typeof(self) weakSelf = self;
    
    
    _item1 = [ZFSettingItem itemWithIcon:@"" title:@"淫秽色情" type:ZFSettingItemTypeNone];
    //cell点击事件
    _item1.operation = ^{
        [weakSelf selectIndex:1];
    };
    
    _item2 = [ZFSettingItem itemWithIcon:@"" title:@"政治谣言" type:ZFSettingItemTypeNone];
    _item2.operation = ^{
        [weakSelf selectIndex:2];
    };
    
    _item3 = [ZFSettingItem itemWithIcon:@"" title:@"广告或垃圾营销" type:ZFSettingItemTypeNone];
    _item3.operation = ^{
        [weakSelf selectIndex:3];
    };
    
    _item4 = [ZFSettingItem itemWithIcon:@"" title:@"有害信息" type:ZFSettingItemTypeNone];
    _item4.operation = ^{
        [weakSelf selectIndex:4];
    };
    
    _item5 = [ZFSettingItem itemWithIcon:@"" title:@"违法信息" type:ZFSettingItemTypeNone];
    _item5.operation = ^{
        [weakSelf selectIndex:5];
    };
    
    _item6 = [ZFSettingItem itemWithIcon:@"" title:@"人身攻击" type:ZFSettingItemTypeNone];
    _item6.operation = ^{
        [weakSelf selectIndex:6];
    };
    
    
    
    ZFSettingGroup *group = [[ZFSettingGroup alloc] init];
//    group.header = @"请选择举报类型";
    group.items = @[_item1,_item2,_item3,_item4,_item5,_item6];
    [_allGroups addObject:group];
}

- (void)btnAction:(id)sender {
    NSMutableString *str = [[NSMutableString alloc] init];

    if (_item1.type == ZFSettingItemTypeCheckmark)
    {
        [str appendString:@"色情"];
    }
    if (_item2.type == ZFSettingItemTypeCheckmark)
    {
        [str appendString:@"/反动"];
    }
    if (_item3.type == ZFSettingItemTypeCheckmark)
    {
        [str appendString:@"/广告"];
    }
    
    if (_item4.type == ZFSettingItemTypeCheckmark)
    {
        [str appendString:@"/有害信息"];//水贴
    }
    if (_item4.type == ZFSettingItemTypeCheckmark)
    {
        [str appendString:@"/违法信息"];//抄袭
    }
    if (_item4.type == ZFSettingItemTypeCheckmark)
    {
        [str appendString:@"/人身攻击"];
    }
    
    
    
    if ([SystemUtil isSignIn])
    {
        _tipOffAPI.uid = [SystemUtil getCache:USER_ID];
        _tipOffAPI.contentId = self.contentId;
        _tipOffAPI.ty = self.ty;
        _tipOffAPI.cty = str;
        [_tipOffAPI start];
    }
    else
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请先登录！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        alertView.tag = 10001;

        [alertView show];
    }
}

- (void)requestFinished:(APIBaseRequest *)request {
    NSLog(@"succeed:%@",request.responseJSONObject);
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"提交成功！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    alertView.tag = 1001;
    [alertView show];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == 1001)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else if (alertView.tag == 10001)
    {
        [self popLoginViewController];
        
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    //return 10;//这个方法不写，或者return 0跟return 12的效果一样
    return 0.01;//把高度设置很小，效果可以看成footer的高度等于0
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    UILabel *lb = [[UILabel alloc]init];
    lb.text = @"请选择举报类型";
    lb.textColor = kUIColorFromRGB(0x333333);
    lb.font = [UIFont systemFontOfSize:12];
    lb.frame = CGRectMake(15, 9, MAIN_SCREEN_WIDTH - 15, 11);
    UIView *bg = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WIDTH, 20)];
    [bg addSubview:lb];
    
    return bg;
}


@end
