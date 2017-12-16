//
//  StockNoticeViewController.m
//  NewStock
//
//  Created by 王迪 on 2017/6/20.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "StockNoticeViewController.h"
#import "StockNoticeAPI.h"
#import "StockNoticeInfoModel.h"
#import "StockNoticeInfoGetAPI.h"
#import "MarketConfig.h"

@interface StockNoticeViewController ()

@property (nonatomic, strong) StockNoticeAPI *noticeAPI;
@property (nonatomic, strong) StockNoticeInfoGetAPI *infoAPI;

@property (nonatomic, strong) UISwitch *switchBtn;

@property (nonatomic, strong) UITextField *tf_buy;
@property (nonatomic, strong) UITextField *tf_sale;
@property (nonatomic, strong) UITextField *tf_zdf;

@property (nonatomic, strong) UILabel *nameLb;
@property (nonatomic, strong) UILabel *codeLb;
@property (nonatomic, strong) UILabel *zxLb;
@property (nonatomic, strong) UILabel *zxVLb;
@property (nonatomic, strong) UILabel *zdfLb;

@end

@implementation StockNoticeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_mainView removeFromSuperview];
    [_scrollView removeFromSuperview];
    
    [_navBar setLeftBtnImg:[UIImage imageNamed:@"ic_back1_nor"]];
    self.title = @"股价预警";
    UILabel *titlelb = [_navBar valueForKeyPath:@"_titleLb"];
    NSMutableAttributedString *nmAttrStr = [[NSMutableAttributedString alloc] initWithString:self.title attributes:@{
                                                                                                                     NSForegroundColorAttributeName:kUIColorFromRGB(0xffffff),
                                                                                                                     NSFontAttributeName : [UIFont boldSystemFontOfSize:18]                                        }];
    titlelb.attributedText = nmAttrStr.copy;
    _navBar.backgroundColor = kTitleColor;
    
    self.view.backgroundColor = kUIColorFromRGB(0xf1f1f1);
    [self setupUI];
    
    [self.infoAPI startWithCompletionBlockWithSuccess:^(__kindof APIBaseRequest *request) {
        NSLog(@"%@",request.responseJSONObject);
        StockNoticeInfoModel *model = [MTLJSONAdapter modelOfClass:[StockNoticeInfoModel class] fromJSONDictionary:request.responseJSONObject error:nil];
        [self setName:model.n code:model.s zx:model.np zxd:model.szdf zxV:model.sp];
        
        _switchBtn.on = model.st.integerValue == 0 ? YES : NO;
        
        if (model.ins) {
            _tf_buy.text = [NSString stringWithFormat:@"%.2lf",model.ins.floatValue];
        }
        
        if (model.outs) {
            _tf_sale.text = [NSString stringWithFormat:@"%.2lf",model.outs.floatValue];
        }
        
        if (model.zdf) {
            _tf_zdf.text = [NSString stringWithFormat:@"%.2lf",model.zdf.floatValue];
        }
        
        
    } failure:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [self checkNoti];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

- (void)checkNoti {
    if ([[UIApplication sharedApplication] currentUserNotificationSettings].types  == UIUserNotificationTypeNone) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请在设置中允许推送通知" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"好", nil];
        alert.tag = 1;
        [alert show];
    }
}

#pragma mark request

- (void)requestFailed:(APIBaseRequest *)request {
    NSLog(@"failed");
}

- (void)requestFinished:(APIBaseRequest *)request {
    NSLog(@"%@",request.responseJSONObject);
    [self.view endEditing:YES];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"预警成功!" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    alert.tag = 2;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [alert show];
    });
    
}

- (void)setupUI {
    UIView *topView = [UIView new];
    topView.backgroundColor = kUIColorFromRGB(0xffffff);
    [self.view addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(60 * kScale));
        make.left.right.equalTo(self.view);
        make.top.equalTo(_navBar.mas_bottom);
    }];
    
    [topView addSubview:self.nameLb];
    [topView addSubview:self.codeLb];
    [topView addSubview:self.zxLb];
    [topView addSubview:self.zxVLb];
    [topView addSubview:self.zdfLb];
    
    [self.nameLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topView).offset(10 * kScale);
        make.left.equalTo(topView).offset(12 * kScale);
    }];
    
    [self.codeLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLb);
        make.bottom.equalTo(topView).offset(-10 * kScale);
    }];
    
    [self.zxLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(topView.mas_right).offset(-100 * kScale);
        make.top.equalTo(self.nameLb);
    }];
    
    [self.zxVLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.zxLb);
        make.bottom.equalTo(self.codeLb);
    }];
    
    [self.zdfLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(topView).offset(-12 * kScale);
        make.bottom.equalTo(self.codeLb);
    }];
    
    UIView *view1 = [UIView new];
    view1.backgroundColor = kUIColorFromRGB(0xffffff);
    [self.view addSubview:view1];
    [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(49 * kScale));
        make.left.right.equalTo(self.view);
        make.top.equalTo(topView.mas_bottom).offset(10 * kScale);
    }];
    
    UILabel *label1 = [UILabel new];
    label1.text = @"股价提醒";
    label1.textColor = kUIColorFromRGB(0x333333);
    label1.font = [UIFont systemFontOfSize:14 * kScale];
    
    [view1 addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view1).offset(12 * kScale);
        make.centerY.equalTo(view1);
    }];
    
    [view1 addSubview:self.switchBtn];
    [self.switchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(54 * kScale));
        make.height.equalTo(@(30 * kScale));
        make.right.equalTo(self.view).offset(-12 * kScale);
        make.centerY.equalTo(view1);
    }];

    
    UIView *view2 = [UIView new];
    view2.backgroundColor = kUIColorFromRGB(0xffffff);
    [self.view addSubview:view2];
    [view2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.height.equalTo(@(49 * kScale));
        make.top.equalTo(view1.mas_bottom).offset(10 * kScale);
    }];
    
    [view2 addSubview:self.tf_buy];
    [self.tf_buy mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(view2).offset(-12 * kScale);
        make.centerY.equalTo(view2);
    }];
    
    UILabel *label2 = [UILabel new];
    label2.text = @"股票跌破买入目标价";
    label2.textColor = kUIColorFromRGB(0x333333);
    label2.font = [UIFont systemFontOfSize:14 * kScale];
    
    [view2 addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view2).offset(12 * kScale);
        make.centerY.equalTo(view2);
    }];
    
    
    UIView *view3 = [UIView new];
    view3.backgroundColor = kUIColorFromRGB(0xffffff);
    [self.view addSubview:view3];
    [view3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view2.mas_bottom);
        make.left.right.equalTo(self.view);
        make.height.equalTo(view2);
    }];
    
    [view3 addSubview:self.tf_sale];
    [self.tf_sale mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(view3).offset(-12 * kScale);
        make.centerY.equalTo(view3);
    }];
    
    UILabel *line1 = [self line];
    [view3 addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(12 * kScale);
        make.right.equalTo(self.view).offset(-12 * kScale);
        make.height.equalTo(@(0.5));
        make.top.equalTo(view3);
    }];
    
    UILabel *label3 = [UILabel new];
    label3.text = @"股票超过卖出目标价";
    label3.textColor = kUIColorFromRGB(0x333333);
    label3.font = [UIFont systemFontOfSize:14 * kScale];
    
    [view3 addSubview:label3];
    [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view3).offset(12 * kScale);
        make.centerY.equalTo(view3);
    }];
    
    
    UIView *view4 = [UIView new];
    view4.backgroundColor = kUIColorFromRGB(0xffffff);
    [self.view addSubview:view4];
    [view4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view3.mas_bottom);
        make.left.height.right.equalTo(view3);
    }];
    
    [view4 addSubview:self.tf_zdf];
    [self.tf_zdf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(view4).offset(-12 * kScale);
        make.centerY.equalTo(view4);
    }];
    
    UILabel *line2 = [self line];
    [view4 addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(line1);
        make.top.equalTo(view4);
        make.height.equalTo(@(0.5));
    }];
    
    UILabel *label4 = [UILabel new];
    label4.text = @"股票日涨跌幅超过 (%)";
    label4.textColor = kUIColorFromRGB(0x333333);
    label4.font = [UIFont systemFontOfSize:14 * kScale];
    
    [view4 addSubview:label4];
    [label4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view4).offset(12 * kScale);
        make.centerY.equalTo(view4);
    }];
    
    
    UILabel *bottomLb = [UILabel new];
    bottomLb.textColor = kUIColorFromRGB(0xb2b2b2);
    bottomLb.font = [UIFont systemFontOfSize:11 * kScale];
    bottomLb.numberOfLines = 0;
    [self.view addSubview:bottomLb];
    [bottomLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(12 * kScale);
        make.top.equalTo(view4.mas_bottom).offset(10 * kScale);
        make.right.equalTo(self.view).offset(-12 * kScale);
    }];
    NSMutableParagraphStyle *para = [NSMutableParagraphStyle new];
    para.lineSpacing = 4;
    bottomLb.attributedText = [[NSAttributedString alloc] initWithString:@"如果您需要开启股怪侠的股价预警,请在iPhone的\"设置\"-\"通知\"功能中,找到应用程序\"股怪侠\",将提醒样式打开." attributes:@{NSParagraphStyleAttributeName : para}];
    
    UIButton *sureBtn = [UIButton new];
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [sureBtn setTitleColor:kUIColorFromRGB(0xffffff) forState:UIControlStateNormal];
    sureBtn.titleLabel.font = [UIFont systemFontOfSize:16 * kScale];
    sureBtn.backgroundColor = kTitleColor;
    [sureBtn addTarget:self action:@selector(sureBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    sureBtn.layer.cornerRadius = 5;
    
    [self.view addSubview:sureBtn];
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(bottomLb.mas_bottom).offset(30 * kScale);
        make.width.equalTo(@(351 * kScale));
        make.height.equalTo(@(44 * kScale));
    }];
    
    
}

#pragma mark action 

- (void)setName:(NSString *)name code:(NSString *)code zx:(NSString *)zx zxd:(NSString *)zdf zxV:(NSString *)zxv {
    _nameLb.text = name;
    _codeLb.text = code;
    _zxLb.text = [NSString stringWithFormat:@"%.2lf",zx.floatValue];
    _zxVLb.text = [NSString stringWithFormat:@"%.2lf",zxv.floatValue];
    _zdfLb.text = [NSString stringWithFormat:@"%.2lf%%",zdf.floatValue];
    
    UIColor *color = kUIColorFromRGB(0x333333);
    if (zdf.floatValue > 0) {
        color = RISE_COLOR;
//        _zxVLb.text = [NSString stringWithFormat:@"+%@",_zxVLb.text];
//        _zdfLb.text = [NSString stringWithFormat:@"+%@",_zdfLb.text];
    } else if (zdf.floatValue < 0) {
        color = FALL_COLOR;
//        _zxVLb.text = [NSString stringWithFormat:@"-%@",_zxVLb.text];
//        _zdfLb.text = [NSString stringWithFormat:@"-%@",_zdfLb.text];
    }
    _zdfLb.textColor = color;
    _zxVLb.textColor = color;
    _zxLb.textColor = color;
}

- (void)sureBtnClick:(UIButton *)btn {
    if (self.tf_buy.text.length == 0 && self.tf_zdf.text.length == 0 && self.tf_sale.text.length == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示!" message:@"请至少输入一个条件" delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    
    self.noticeAPI.st = self.switchBtn.isOn ? @"0" : @"1";
    self.noticeAPI.ins = self.tf_buy.text.length ? self.tf_buy.text : @"";
    self.noticeAPI.outs = self.tf_sale.text.length ? self.tf_sale.text : @"";
    self.noticeAPI.zdf = self.tf_zdf.text.length ? self.tf_zdf.text : @"";
    
    [self.noticeAPI start];
}

- (void)switchBtnClick:(UISwitch *)switchBtn {
    if (switchBtn.isOn) {
        NSLog(@"on");
    } else {
        NSLog(@"off");
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (alertView.tag == 2) {
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    
    if (buttonIndex) {
        if ([UIDevice currentDevice].systemVersion.floatValue >= 10.0) {
            [[UIApplication sharedApplication]openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        } else {
            NSURL *url = [NSURL URLWithString:@"prefs:root=Bluetooth"];
            
            if ([[UIApplication sharedApplication]canOpenURL:url]) {
                
                [[UIApplication sharedApplication]openURL:url];
                
            }
        }
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

#pragma mark lazy loading

- (StockNoticeAPI *)noticeAPI {
    if (_noticeAPI == nil) {
        _noticeAPI = [StockNoticeAPI new];
        _noticeAPI.s = self.s;
        _noticeAPI.m = self.m;
        _noticeAPI.t = self.t;
        _noticeAPI.animatingView = self.view;
        _noticeAPI.delegate = self;
    }
    return _noticeAPI;
}

- (StockNoticeInfoGetAPI *)infoAPI {
    if (_infoAPI == nil) {
        _infoAPI = [StockNoticeInfoGetAPI new];
        _infoAPI.s = self.s;
        _infoAPI.m = self.m;
        _infoAPI.t = self.t;
        _infoAPI.animatingView = self.view;
    }
    return _infoAPI;
}

- (UILabel *)line {
    UILabel *lb = [UILabel new];
    lb.backgroundColor = kUIColorFromRGB(0xe4e4e4);
    return lb;
}

- (UISwitch *)switchBtn {
    if (_switchBtn == nil) {
        _switchBtn = [[UISwitch alloc] init];
        _switchBtn.onTintColor = kTitleColor;
        [_switchBtn addTarget:self action:@selector(switchBtnClick:) forControlEvents:UIControlEventValueChanged];
    }
    return _switchBtn;
}

- (UITextField *)tf_buy {
    if (_tf_buy == nil) {
        _tf_buy = [[UITextField alloc] init];
        _tf_buy.keyboardType = UIKeyboardTypeDecimalPad;
        _tf_buy.textColor = kUIColorFromRGB(0x666666);
        _tf_buy.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"输入目标价" attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14 * kScale],NSForegroundColorAttributeName : kUIColorFromRGB(0xb2b2b2) }];
    }
    return _tf_buy;
}

- (UITextField *)tf_sale {
    if (_tf_sale == nil) {
        _tf_sale = [[UITextField alloc] init];
        _tf_sale.keyboardType = UIKeyboardTypeDecimalPad;
        _tf_sale.textColor = kUIColorFromRGB(0x666666);
        _tf_sale.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"输入目标价" attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14 * kScale],NSForegroundColorAttributeName : kUIColorFromRGB(0xb2b2b2) }];
    }
    return _tf_sale;
}

- (UITextField *)tf_zdf {
    if (_tf_zdf == nil) {
        _tf_zdf = [[UITextField alloc] init];
        _tf_zdf.keyboardType = UIKeyboardTypeDecimalPad;
        _tf_zdf.textColor = kUIColorFromRGB(0x666666);
        _tf_zdf.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"输入涨跌幅" attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14 * kScale],NSForegroundColorAttributeName : kUIColorFromRGB(0xb2b2b2) }];
    }
    return _tf_zdf;
}

- (UILabel *)nameLb {
    if (_nameLb == nil) {
        _nameLb = [UILabel new];
        _nameLb.textColor = kUIColorFromRGB(0x333333);
        _nameLb.font = [UIFont systemFontOfSize:16 * kScale];
    }
    return _nameLb;
}

- (UILabel *)codeLb {
    if (_codeLb == nil) {
        _codeLb = [UILabel new];
        _codeLb.textColor = kUIColorFromRGB(0xb2b2b2);
        _codeLb.font = [UIFont systemFontOfSize:11 * kScale];
    }
    return _codeLb;
}

- (UILabel *)zxLb {
    if (_zxLb == nil) {
        _zxLb = [UILabel new];
        _zxLb.textColor = PLAN_COLOR;
        _zxLb.font = [UIFont boldSystemFontOfSize:16 * kScale];
    }
    return _zxLb;
}

- (UILabel *)zxVLb {
    if (_zxVLb == nil) {
        _zxVLb = [UILabel new];
        _zxVLb.textColor = PLAN_COLOR;
        _zxVLb.font = [UIFont systemFontOfSize:11 * kScale];
    }
    return _zxVLb;
}

- (UILabel *)zdfLb {
    if (_zdfLb == nil) {
        _zdfLb = [UILabel new];
        _zdfLb.textColor = PLAN_COLOR;
        _zdfLb.font = [UIFont systemFontOfSize:11 * kScale];
    }
    return _zdfLb;
}

@end
