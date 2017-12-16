//
//  AboutViewController.m
//  NewStock
//
//  Created by Willey on 16/8/23.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "AboutViewController.h"
#import "WebViewController.h"
#import "MarketConfig.h"
#import "AppDelegate.h"


@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"关于我们";
    [_navBar setTitle:self.title];
    _navBar.line_view.hidden = YES;
    //    [_scrollView mas_remakeConstraints:^(MASConstraintMaker *make) {
    //        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(NAV_BAR_HEIGHT, 0, 0, 0));
    //    }];
    //    [_scrollView layoutIfNeeded];
    
    UIImageView *headerView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ic_logo"]];
    [self.view addSubview:headerView];
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(headerView.superview);
        make.top.equalTo(_navBar.mas_bottom).offset(20);
        make.height.width.equalTo(@58);
    }];
    
    
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    NSString *verS = [NSString stringWithFormat:@"V%@",version];
    
    UILabel *version_lb = [[UILabel alloc]init];
    version_lb.text = verS;
    version_lb.font = [UIFont systemFontOfSize:18];
    version_lb.textColor = kUIColorFromRGB(0x666666);
    [self.view addSubview:version_lb];
    [version_lb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headerView.mas_bottom).offset(5);
        make.centerX.equalTo(headerView);
    }];
    
    
    _tableView.contentInset = UIEdgeInsetsMake(120, 0, 0, 0);
    // 1.第0组：3个
    [self add0SectionItems];
    
}

#pragma mark 添加第0组的模型数据
- (void)add0SectionItems {
    __weak typeof(self) weakSelf = self;
    ZFSettingItem *push1 = [ZFSettingItem itemWithIcon:@"" title:@"新手指引" type:ZFSettingItemTypeArrow];//about_icon
    //cell点击事件
    push1.operation = ^{

        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];

        [appDelegate showIntroView];
    };
    
    ZFSettingItem *push = [ZFSettingItem itemWithIcon:@"" title:@"风险提示" type:ZFSettingItemTypeArrow];//about_icon
    //cell点击事件
    push.operation = ^{

        WebViewController *viewController = [[WebViewController alloc] init];
        
        
        NSString *url = [NSString stringWithFormat:@"%@%@",API_URL,H5_MY2902];
        NSString *urlStr = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        viewController.myUrl = urlStr;
        viewController.mytitle = @"风险提示";
        
        //
        viewController.view.backgroundColor = kUIColorFromRGB(0xffffff);
        UIView *_navbar = [viewController valueForKey:@"_navBar"];
        UIView *lineView = [UIView new];
        lineView.backgroundColor = kUIColorFromRGB(0xf1f1f1);
        [_navbar addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(lineView.superview);
            make.height.equalTo(@0.5);
        }];
        
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        [appDelegate.navigationController pushViewController:viewController animated:YES];
    };
    
    ZFSettingItem *phone = [ZFSettingItem itemWithIcon:@"" title:@"客服热线" type:ZFSettingItemTypeDetail detail:@"021-58976636"];//about_icon
    phone.operation = ^{
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您确认要拨打客服电话？" delegate:weakSelf cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
        [alertView show];
    };
    
    ZFSettingItem *weixin = [ZFSettingItem itemWithIcon:@"" title:@"微信公众号" type:ZFSettingItemTypeDetail detail:@"StockSuperman"];
    weixin.operation = ^ {
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.string = @"StockSuperman";
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"\"StockSuperman\" 已复制 " delegate:weakSelf cancelButtonTitle:nil otherButtonTitles: nil];
        [alertView show];
        alertView.delegate = self;
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [alertView dismissWithClickedButtonIndex:0 animated:YES];
        });
    };
    
    ZFSettingItem *qq = [ZFSettingItem itemWithIcon:@"" title:@"QQ群" type:ZFSettingItemTypeDetail detail:@"433985872"];
    
    qq.operation = ^ {
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.string = @"433985872";
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"\"433985872\" 已复制" delegate:weakSelf cancelButtonTitle:nil otherButtonTitles: nil];
        [alertView show];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [alertView dismissWithClickedButtonIndex:0 animated:YES];
        });
    };
    
    
    ZFSettingItem *sina = [ZFSettingItem itemWithIcon:@"" title:@"新浪微博" type:ZFSettingItemTypeDetail detail:@"股怪侠"];
    
    sina.operation = ^ {
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"http://weibo.com/u/6016291674"]];
    };
    

    
    ZFSettingGroup *group = [[ZFSettingGroup alloc] init];
    group.footer = @"上海嘉贝信息科技有限公司版权所有";
    group.items = @[push1,push,phone,weixin,qq,sina];
    [_allGroups addObject:group];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if(buttonIndex == 0)
    {
        [SystemUtil callPhone:@"021-58976636"];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section ==0)
    {
        return 10;
    }
    return 30;//这个方法不写，或者return 0跟return 12的效果一样
    //return 0.01;//把高度设置很小，效果可以看成footer的高度等于0
}


@end
