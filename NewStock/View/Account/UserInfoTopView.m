//
//  UserInfoTopView.m
//  NewStock
//
//  Created by 王迪 on 2017/1/9.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "UserInfoTopView.h"
#import "AccountCenterTableViewCell.h"
#import "Defination.h"
#import <Masonry.h>
#import "UIView+Masonry_Arrange.h"
#import "MarketConfig.h"
#import <UIImageView+WebCache.h>
#import "WDButton.h"

static NSString *cellID = @"UserInfoTopViewCellID";

@interface UserInfoTopView () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIButton *follow_btn;
@property (nonatomic, strong) UIButton *fans_btn;
@property (nonatomic, strong) WDButton *feed_btn;
@property (nonatomic, strong) WDButton *comm_btn;
@property (nonatomic, strong) WDButton *collec_btn;
@property (nonatomic, strong) WDButton *secret_btn;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, copy) NSString *tscStr;

@end

@implementation UserInfoTopView

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.scrollEnabled = NO;
        _tableView.separatorInset = UIEdgeInsetsMake(0, 12, 0, 12);
        _tableView.separatorColor = kUIColorFromRGB(0xe4e4e4);
        [_tableView registerClass:[AccountCenterTableViewCell class] forCellReuseIdentifier:cellID];
    }
    return _tableView;
}

- (UIButton *)follow_btn {
    if (_follow_btn == nil) {
        _follow_btn = [[UIButton alloc] init];
        _follow_btn.tag = 1;
        [_follow_btn setAttributedTitle:[self changeToAttributeString:@"关注0" isBig:YES length:2] forState:UIControlStateNormal];
        [_follow_btn.titleLabel setFont:[UIFont systemFontOfSize:14 * kScale]];
        [_follow_btn setTitleColor:kUIColorFromRGB(0x808080) forState:UIControlStateNormal];
        _follow_btn.backgroundColor = [UIColor whiteColor];
        [_follow_btn addTarget:self action:@selector(actionWithTag:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _follow_btn;
}

- (UIButton *)fans_btn {
    if (_fans_btn == nil) {
        _fans_btn = [[UIButton alloc] init];
        _fans_btn.tag = 2;
        [_fans_btn setAttributedTitle:[self changeToAttributeString:@"粉丝0" isBig:YES length:2] forState:UIControlStateNormal];
        [_fans_btn.titleLabel setFont:[UIFont systemFontOfSize:14 * kScale]];
        [_fans_btn setTitleColor:kUIColorFromRGB(0x808080) forState:UIControlStateNormal];
        _fans_btn.backgroundColor = [UIColor whiteColor];
        [_fans_btn addTarget:self action:@selector(actionWithTag:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _fans_btn;
}

- (WDButton *)feed_btn {
    if (_feed_btn == nil) {
        _feed_btn = [[WDButton alloc] init];
        _feed_btn.tag = 3;
        _feed_btn.custom_lb.attributedText = [self changeToAttributeString:@"帖子0" isBig:NO length:2];
        _feed_btn.custom_img.image = [UIImage imageNamed:@"icon_tiezi_nor"];
        _feed_btn.backgroundColor = [UIColor whiteColor];
        [_feed_btn addTarget:self action:@selector(actionWithTag:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _feed_btn;
}

- (WDButton *)comm_btn {
    if (_comm_btn == nil) {
        _comm_btn = [[WDButton alloc] init];
        _comm_btn.tag = 4;
        _comm_btn.custom_lb.attributedText = [self changeToAttributeString:@"评论0" isBig:NO length:2];
        _comm_btn.custom_img.image = [UIImage imageNamed:@"icon_pinglun_nor"];
        _comm_btn.backgroundColor = [UIColor whiteColor];
        [_comm_btn addTarget:self action:@selector(actionWithTag:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _comm_btn;
}

- (WDButton *)secret_btn {
    if (_secret_btn == nil) {
        _secret_btn = [[WDButton alloc] init];
        _secret_btn.tag = 9;
        _secret_btn.custom_lb.attributedText = [self changeToAttributeString:@"匿名0" isBig:NO length:2];
        _secret_btn.custom_img.image = [UIImage imageNamed:@"icon_secret_btn_nor"];
        _secret_btn.backgroundColor = [UIColor whiteColor];
        [_secret_btn addTarget:self action:@selector(actionWithTag:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _secret_btn;
}

- (WDButton *)collec_btn {
    if (_collec_btn == nil) {
        _collec_btn = [[WDButton alloc] init];
        _collec_btn.tag = 5;
        _collec_btn.custom_lb.attributedText = [self changeToAttributeString:@"收藏0" isBig:NO length:2];
        _collec_btn.custom_img.image = [UIImage imageNamed:@"icon_shoucang_nor"];
        _collec_btn.backgroundColor = [UIColor whiteColor];
        [_collec_btn addTarget:self action:@selector(actionWithTag:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _collec_btn;
}

- (void)setTscStr:(NSString *)tscStr {
    _tscStr = tscStr;
    
    [self.tableView reloadData];
}


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    self.backgroundColor = kUIColorFromRGB(0xf1f1f1);

    [self addSubview:self.follow_btn];
    [self addSubview:self.fans_btn];
    
    [_follow_btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(MAIN_SCREEN_WIDTH * 0.5, 44 * kScale));
    }];
    [_fans_btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(MAIN_SCREEN_WIDTH * 0.5, 44 * kScale));
    }];

    [self distributeSpacingHorizontallyWith:@[_follow_btn,_fans_btn]];
    
    [self addSubview:self.feed_btn];
    [self addSubview:self.comm_btn];
    [self addSubview:self.collec_btn];
//    [self addSubview:self.secret_btn];
    
    [_feed_btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(54 * kScale);
        make.size.mas_equalTo(CGSizeMake(MAIN_SCREEN_WIDTH / 3, 76 * kScale));
    }];
    [_comm_btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(54 * kScale);
        make.size.mas_equalTo(CGSizeMake(MAIN_SCREEN_WIDTH / 3, 76 * kScale));
    }];
    [_collec_btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(54 * kScale);
        make.size.mas_equalTo(CGSizeMake(MAIN_SCREEN_WIDTH / 3, 76 * kScale));
    }];
//    [_secret_btn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(54 * kScale);
//        make.size.mas_equalTo(CGSizeMake(MAIN_SCREEN_WIDTH / 4, 76 * kScale));
//    }];
    
    [self distributeSpacingHorizontallyWith:@[_comm_btn,_collec_btn,_feed_btn]];
    
    [self addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(_comm_btn.mas_bottom).offset(0 * kScale);
        make.bottom.equalTo(self).offset(0 * kScale);
    }];
    
    UIView *bottomLine = [UIView new];
    bottomLine.backgroundColor = kUIColorFromRGB(0xe4e4e4);
    [self addSubview:bottomLine];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.bottom.equalTo(self).offset(-0.1);
        make.height.equalTo(@0.5);
    }];
}

- (NSAttributedString *)changeToAttributeString:(NSString *)string isBig:(BOOL)isBig length:(NSUInteger)length {

    NSMutableAttributedString *nmAttrString = [[NSMutableAttributedString alloc] initWithString:string];
    
    [nmAttrString addAttributes:@{
                                  
                                  NSFontAttributeName : [UIFont systemFontOfSize:isBig ? 14 * kScale : 12 * kScale],
                                  NSForegroundColorAttributeName : kUIColorFromRGB(0x808080)
                                  
                                  } range:NSMakeRange(0, length)];
    [nmAttrString addAttributes:@{
                                  
                                  NSFontAttributeName : [UIFont systemFontOfSize:isBig ? 14 * kScale: 13 * kScale],
                                  NSForegroundColorAttributeName : kUIColorFromRGB(0x333333)
                                  
                                  } range:NSMakeRange(length, string.length - length)];
    
    return nmAttrString.copy;
}

- (NSString *)getZeroString:(NSString *)value {
    if (value.integerValue == 0) {
        return @"0";
    }
    return [NSString stringWithFormat:@"%zd",value.integerValue];
}

- (void)tap:(UIPanGestureRecognizer *)tap {
    if([self.delegate respondsToSelector:@selector(userInfoTopViewDelegateClick:)]) {
        [self.delegate userInfoTopViewDelegateClick:tap.view.tag];
    }
}

- (void)actionWithTag:(UIButton *)btn {
    if([self.delegate respondsToSelector:@selector(userInfoTopViewDelegateClick:)]) {
        [self.delegate userInfoTopViewDelegateClick:btn.tag];
    }
}

- (void)setFollowNum:(NSString *)num1 fs:(NSString *)fs feeds:(NSString *)feeds coms:(NSString *)coms collections:(NSString *)colls secret:(NSString *)secret tsc:(NSString *)tsc isBigV:(BOOL)isBigV {
    
    NSString *foll = [self getZeroString:num1];
    NSString *fens = [self getZeroString:fs];
    NSString *feed = [self getZeroString:feeds];
    NSString *com = [self getZeroString:coms];
    NSString *coll = [self getZeroString:colls];
    NSString *secret1 = [self getZeroString:secret];
    NSString *tscS = [self getZeroString:tsc];
    
    [self.follow_btn setAttributedTitle:[self changeToAttributeString:[NSString stringWithFormat:@"关注%@",foll] isBig:YES length:2] forState:UIControlStateNormal];
    [self.fans_btn setAttributedTitle:[self changeToAttributeString:[NSString stringWithFormat:@"粉丝%@",fens] isBig:YES length:2] forState:UIControlStateNormal];
    self.feed_btn.custom_lb.attributedText = [self changeToAttributeString:[NSString stringWithFormat:@"帖子%@",feed] isBig:NO length:2];
    self.comm_btn.custom_lb.attributedText = [self changeToAttributeString:[NSString stringWithFormat:@"评论%@",com] isBig:NO length:2];
    self.collec_btn.custom_lb.attributedText = [self changeToAttributeString:[NSString stringWithFormat:@"收藏%@",coll] isBig:NO length:2];
    self.secret_btn.custom_lb.attributedText = [self changeToAttributeString:[NSString stringWithFormat:@"匿名%@",secret1] isBig:NO length:2];
    
    self.tscStr = [NSString stringWithFormat:@"今日还可获得%zd积分",45 - tscS.integerValue];
    
    self.feed_btn.isBigV = isBigV;
}

#pragma mark tableview

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44 * kScale;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10 * kScale;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *v = [UIView new];
    v.backgroundColor = kUIColorFromRGB(0xf1f1f1);
    return v;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 5;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    AccountCenterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = @"";
    
    if (indexPath.row == 0) {
        if (indexPath.section == 0) {
            cell.leftStr = @"积分任务";
            cell.rightStr = self.tscStr;// @"今日已获得5积分";
            cell.imageStr = @"ic_scoreTask_nor";
        } else {
            cell.leftStr = @"";
            cell.rightStr = @"成为大V,只差一个\"认证\"的距离";
            cell.imageStr = @"";
            cell.textLabel.font = [UIFont boldSystemFontOfSize:16 * kScale];
            cell.textLabel.textColor = kUIColorFromRGB(0x333333);
            cell.textLabel.text = @"申请认证";
        }
    } else if (indexPath.row == 1) {
        cell.leftStr = @"活动广场";
        cell.rightStr = @"积分兑换活动";
        cell.imageStr = @"ic_scoreActi_nor";
    } else if (indexPath.row == 2) {
        cell.leftStr = @"推荐给好友";
        cell.rightStr = @"";
        cell.imageStr = @"ic_sendToF_nor";
    } else if (indexPath.row == 3) {
        cell.leftStr = @"吐个槽吧";
        cell.rightStr = @"";
        cell.imageStr = @"ic_tuCao_nor";
    } else if (indexPath.row == 4) {
        cell.leftStr = @"为股怪侠评分";
        cell.rightStr = @"";
        cell.imageStr = @"ic_pingfen_nor";
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(![self.delegate respondsToSelector:@selector(userInfoTopViewDelegateClick:)]) {
        return;
    }
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            [self.delegate userInfoTopViewDelegateClick:11];
        } else if (indexPath.row == 1) {
            [self.delegate userInfoTopViewDelegateClick:10];
        } else if (indexPath.row == 2) {
            [self.delegate userInfoTopViewDelegateClick:7];
        } else if (indexPath.row == 3) {
            [self.delegate userInfoTopViewDelegateClick:8];
        } else if (indexPath.row == 4) {
            [self.delegate userInfoTopViewDelegateClick:6];
        }
    } else {
        [self.delegate userInfoTopViewDelegateClick:12];
    }
}



@end
