//
//  QLNGViewController.m
//  NewStock
//
//  Created by 王迪 on 2017/6/22.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "QLNGViewController.h"
#import "BlurCommentView.h"
#import "TaoQLNGAPI.h"
#import "TaoQLNGModel.h"
#import "SharedInstance.h"
#import "Defination.h"
#import <Masonry.h>
#import "MarketConfig.h"
#import "CommentAPI.h"
#import "MJRefresh.h"
#import "MJChiBaoZiHeader.h"
#import "MJChiBaoZiFooter.h"
#import "NativeUrlRedirectAction.h"
#import "TaoCommedTableViewCell.h"
#import "TaoQLNGTableViewCell.h"
#import "TaoQLNGBottomView.h"
#import "QLNGHistoryViewController.h"
#import "TaoQLNGCommentViewController.h"

static NSString *cellID = @"QLNGViewControllerCell";

@interface QLNGViewController () <UITableViewDelegate,UITableViewDataSource,TaoQLNGBottomViewDelegate,BlurCommentViewDelegate>

@property (nonatomic, strong) TaoQLNGAPI *qlngAPI;
@property (nonatomic, strong) CommentAPI *commentAPI;

@property (nonatomic, strong) NSArray *dataArray;

@property (nonatomic, strong) UIImageView *topImage;
@property (nonatomic, strong) UILabel *topLabel;

@property (nonatomic, strong) UIView *day3View;
@property (nonatomic, strong) UIView *day5View;
@property (nonatomic, strong) UIView *winView;
@property (nonatomic, strong) UILabel *day3TextLb;
@property (nonatomic, strong) UILabel *day3ZdfLb;
@property (nonatomic, strong) UILabel *day5TextLb;
@property (nonatomic, strong) UILabel *day5ZdfLb;
@property (nonatomic, strong) UILabel *winTextLb;
@property (nonatomic, strong) UILabel *winZdfLb;
@property (nonatomic, strong) UIView *starView;
@property (nonatomic, strong) UIView *userComLb;
@property (nonatomic, strong) TaoCommedTableViewCell *cell;
@property (nonatomic, strong) UIView *noCommentView;
@property (nonatomic, strong) UIButton *moreComBtn;
@property (nonatomic, strong) UIView *suggestView;
@property (nonatomic, strong) UILabel *suggestLb;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) TaoQLNGBottomView *bottomView;
@property (nonatomic, strong) UIView *tableFooterView;
@property (nonatomic, strong) NSMutableAttributedString *saveText;
@property (nonatomic, strong) UIButton *historyBtn;

@property (nonatomic) UIImageView *star1;
@property (nonatomic) UIImageView *star2;
@property (nonatomic) UIImageView *star3;
@property (nonatomic) UIImageView *star4;
@property (nonatomic) UIImageView *star5;

@property (nonatomic) NSMutableArray *starArray;

@end

@implementation QLNGViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_mainView removeFromSuperview];
    [_scrollView removeFromSuperview];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [_navBar setLeftBtnImg:[UIImage imageNamed:@"ic_back1_nor"]];
    UILabel *titlelb = [_navBar valueForKeyPath:@"_titleLb"];
    NSMutableAttributedString *nmAttrStr = [[NSMutableAttributedString alloc] initWithString:self.title attributes:@{
                                                                                                                     NSForegroundColorAttributeName:kUIColorFromRGB(0xffffff),
                                                                                                                     NSFontAttributeName : [UIFont boldSystemFontOfSize:18]                                        }];
    titlelb.attributedText = nmAttrStr.copy;
    _navBar.line_view.hidden = YES;
    
    self.view.backgroundColor = kUIColorFromRGB(0xf1f1f1);
    
    [self setupUI];
    [self.view bringSubviewToFront:_navBar];
    _navBar.backgroundColor = [UIColor clearColor];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self loadData];
    });
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

- (void)setupUI {
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.bottomView];
    
    [self.headerView addSubview:self.topImage];
    [self.headerView addSubview:self.topLabel];
    [self.headerView addSubview:self.day3View];
    [self.headerView addSubview:self.day5View];
    [self.headerView addSubview:self.winView];
    [self.headerView addSubview:self.starView];
    [self.headerView addSubview:self.userComLb];
    [self.headerView addSubview:self.cell];
    [self.headerView addSubview:self.moreComBtn];
    [self.headerView addSubview:self.suggestView];
    [self.headerView addSubview:self.noCommentView];
    
    [self.day3View addSubview:self.day3TextLb];
    [self.day3View addSubview:self.day3ZdfLb];
    [self.day5View addSubview:self.day5TextLb];
    [self.day5View addSubview:self.day5ZdfLb];
    [self.winView addSubview:self.winTextLb];
    [self.winView addSubview:self.winZdfLb];

    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.height.equalTo(@(160 * kScale + 60 * kScale + 8 * kScale * 3 + 40 * kScale * 4 + 100 * kScale));
    }];
    
    [self.topImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.headerView);
        make.height.equalTo(@(160 * kScale));
    }];
    
    [self.topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headerView).offset(12 * kScale);
        make.centerY.equalTo(_topImage.mas_top).offset(64 + 50 * kScale);
    }];
    
    [self.day3View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_topImage.mas_bottom);
        make.left.equalTo(self.headerView);
        make.width.equalTo(@(MAIN_SCREEN_WIDTH / 3));
        make.height.equalTo(@(60 * kScale));
    }];
    
    [self.day5View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.width.height.equalTo(self.day3View);
        make.left.equalTo(self.day3View.mas_right);
    }];
    
    [self.winView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.top.equalTo(self.day3View);
        make.right.equalTo(self.view);
    }];
    
    [self.day3ZdfLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.day3View).offset(8 * kScale);
        make.left.equalTo(self.day3View).offset(12 * kScale);
    }];
    
    [self.day3TextLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.day3ZdfLb);
        make.bottom.equalTo(self.day3View).offset(-10 * kScale);
    }];
    
    [self.day5ZdfLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.day3ZdfLb);
        make.left.equalTo(self.day5View).offset(12 * kScale);
    }];
    
    [self.day5TextLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.day5ZdfLb);
        make.bottom.equalTo(self.day3TextLb);
    }];
    
    [self.winZdfLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.day5ZdfLb);
        make.left.equalTo(self.winView).offset(12 * kScale);
    }];
    
    [self.winTextLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.winZdfLb);
        make.bottom.equalTo(self.day3TextLb);
    }];
    
    [self.starView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.day3View.mas_bottom).offset(8 * kScale);
        make.left.right.equalTo(self.headerView);
        make.height.equalTo(@(40 * kScale));
    }];
    
    [self.userComLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.starView.mas_bottom).offset(8 * kScale);
        make.left.right.height.equalTo(self.starView);
    }];
    
    [self.cell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.headerView);
        make.top.equalTo(self.userComLb.mas_bottom);
        make.height.equalTo(@(200 * kScale));
    }];
    
    [self.noCommentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(_cell);
        make.height.equalTo(@(32 * kScale));
    }];
    
    [self.moreComBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.headerView);
        make.top.equalTo(self.cell.mas_bottom);
        make.height.equalTo(@(38 * kScale));
    }];
    
    [self.suggestView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(self.starView);
        make.top.equalTo(self.userComLb.mas_bottom).offset(8 * kScale + 32 * kScale);
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-49 * kScale);
    }];
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(self.view);
        make.height.equalTo(@(49 * kScale));
    }];
    
    [self.starView addSubview:self.star1];
    [self.starView addSubview:self.star2];
    [self.starView addSubview:self.star3];
    [self.starView addSubview:self.star4];
    [self.starView addSubview:self.star5];
    
    [self.starArray addObject:self.star1];
    [self.starArray addObject:self.star2];
    [self.starArray addObject:self.star3];
    [self.starArray addObject:self.star4];
    [self.starArray addObject:self.star5];
    
    [self.star1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_starView).offset(-75 * kScale);
        make.centerY.equalTo(_starView);
    }];
    
    [self.star2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.star1.mas_right).offset(2 * kScale);
        make.top.equalTo(self.star1);
    }];
    
    [self.star3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.star2.mas_right).offset(2 * kScale);
        make.top.equalTo(self.star2);
    }];
    
    [self.star4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.star3.mas_right).offset(2 * kScale);
        make.top.equalTo(self.star3);
    }];
    
    [self.star5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.star4.mas_right).offset(2 * kScale);
        make.top.equalTo(self.star4);
    }];
    
}

#pragma mark requset

- (void)loadData {
    [self.qlngAPI start];
}

- (void)requestFailed:(APIBaseRequest *)request {
    [self.tableView.mj_header endRefreshing];
}

- (void)requestFinished:(APIBaseRequest *)request {
    NSLog(@"%@",request.responseJSONObject);
    if ([request isKindOfClass:[CommentAPI class]]) {
        [self loadData];
        return;
    }
    TaoQLNGModel *model = [MTLJSONAdapter modelOfClass:[TaoQLNGModel class] fromJSONDictionary:request.responseJSONObject error:nil];
    self.dataArray = [MTLJSONAdapter modelsOfClass:[TaoQLNGStockModel class] fromJSONArray:request.responseJSONObject[@"list"] error:nil];
    
    NSMutableParagraphStyle *para = [NSMutableParagraphStyle new];
    para.lineSpacing = 12 * kScale;
    
    self.topLabel.attributedText = [[NSAttributedString alloc] initWithString:model.desc attributes:@{NSParagraphStyleAttributeName : para}];
    _topLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    
    [self.topImage sd_setImageWithURL:[NSURL URLWithString:model.url]];
    self.day3ZdfLb.text = [NSString stringWithFormat:@"%.2lf%%",model.three.floatValue];
    self.day5ZdfLb.text = [NSString stringWithFormat:@"%.2lf%%",model.five.floatValue];
    self.winZdfLb.text = [NSString stringWithFormat:@"%.2lf%%",model.win.floatValue];
    
    if (model.three.floatValue > 0) {
        _day3ZdfLb.textColor = RISE_COLOR;
    } else if (model.three.floatValue < 0) {
        _day3ZdfLb.textColor = FALL_COLOR;
    } else {
        _day3ZdfLb.textColor = PLAN_COLOR;
    }
    
    if (model.five.floatValue > 0) {
        _day5ZdfLb.textColor = RISE_COLOR;
    } else if (model.five.floatValue < 0) {
        _day5ZdfLb.textColor = FALL_COLOR;
    } else {
        _day5ZdfLb.textColor = PLAN_COLOR;
    }
    
    if (model.win.floatValue > 0) {
        _winZdfLb.textColor = RISE_COLOR;
    } else if (model.win.floatValue < 0) {
        _winZdfLb.textColor = FALL_COLOR;
    } else {
        _winZdfLb.textColor = PLAN_COLOR;
    }
    
    CGFloat commentCellHeight = 8 * kScale;
    if (model.comment == nil) {
        self.noCommentView.hidden = NO;
        self.cell.hidden = YES;
        self.moreComBtn.hidden = YES;
        commentCellHeight += 32 * kScale;
    } else {
        self.noCommentView.hidden = YES;
        self.cell.hidden = NO;
        self.moreComBtn.hidden = NO;
        CGFloat cellH = [self.cell setUserIcon:model.comment.icon n:model.comment.name c:model.comment.c];
        commentCellHeight = commentCellHeight + cellH + 40 * kScale;
        [self.cell mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(cellH));
        }];
    }
    [self dealWithStar:model.star.floatValue];
    self.suggestLb.text = [NSString stringWithFormat:@"今日推荐个股(%@)",model.tm];
    
    [self.suggestView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.userComLb.mas_bottom).offset(commentCellHeight);
    }];
    
    [self.headerView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(160 * kScale + 60 * kScale + 8 * kScale * 2 + 40 * kScale * 3 + commentCellHeight));
    }];
    
    [self.headerView layoutIfNeeded];
    [self.view layoutIfNeeded];
    
    [self.tableView reloadData];
    [self.tableView.mj_header endRefreshing];
}

#pragma BlurCommentViewDelegate
- (void)commentDidFinished:(NSString *)commentText {
    
    if ([commentText isEqualToString:@""]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"评论不能为空！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
    }else {
        _commentAPI = [[CommentAPI alloc] init];
        _commentAPI.uid = [SystemUtil getCache:USER_ID];
        _commentAPI.c = commentText;
        _commentAPI.fid = _ids;
        _commentAPI.delegate = self;
        [_commentAPI start];
    }
}

#pragma mark action 

- (void)moreBtnClick:(UIButton *)btn {
    TaoQLNGCommentViewController *vc = [TaoQLNGCommentViewController new];
    vc.title = self.title;
    vc.ids = self.ids;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)taoQLNGBottomViewDelegatePushTo:(NSString *)url {
    NSLog(@"%@",url);
    if ([url isEqualToString:@"fx"]) {
        [self share];
    } else if ([url isEqualToString:@"dy"]) {
        [self starFollow];
    } else if ([url isEqualToString:@"pj"]) {
        [self comment];
    }
}

- (void)dealWithStar:(CGFloat )count {
    for (UIImageView *iv in self.starArray) {
        iv.image = [UIImage imageNamed:@"tao_star_empty"];
    }
    
    NSInteger num = count * 2 ;
    for (int i = 0; i < 5; i ++) {
        UIImageView *iv = self.starArray[i];
        if (num >= 2) {
            iv.image = [UIImage imageNamed:@"tao_star_full"];
            num -= 2;
        } else if (num == 1) {
            iv.image = [UIImage imageNamed:@"tao_star_half"];
            break;
        } else {
            break;
        }
    }
}

- (void)comment {
    if (![SystemUtil isSignIn]) {
        [self popLoginViewController];
        return;
    }
    [BlurCommentView commentshowDelegate:self];
}

- (void)share {
    NSString *url = [NSString stringWithFormat:@"%@%@?id=%@",API_URL,H5_SM0001,_ids];

    [SharedInstance sharedSharedInstance].image = [UIImage imageNamed:@"shareLogo"];
    [SharedInstance sharedSharedInstance].tt = self.title;
    [SharedInstance sharedSharedInstance].c = self.topLabel.text;
    [SharedInstance sharedSharedInstance].url = url;
    [SharedInstance sharedSharedInstance].res_code = @"S_STRATEGY";
    [SharedInstance sharedSharedInstance].sid = self.ids;
    [[SharedInstance sharedSharedInstance] shareWithImage:NO];
}

- (void)starFollow {
    
}

- (void)historyBtnClick:(UIButton *)btn {
    NSLog(@"lishi");
    QLNGHistoryViewController *vc = [QLNGHistoryViewController new];
    vc.title = self.title;
    vc.ids = self.ids;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark table view

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat alpha = 1.0 / 200.0 * (scrollView.contentOffset.y);
    _navBar.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:alpha];
    
    if (alpha > 0.8) {
        [_navBar setLeftBtnImg:[UIImage imageNamed:@"navbar_back"]];
//        [_navBar setTitle:self.title];
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    } else {
//        [_navBar setTitle:@""];
        [_navBar setLeftBtnImg:[UIImage imageNamed:@"ic_back1_nor"]];
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    }

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 35 * kScale;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [self header];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 55 * kScale;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TaoQLNGTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    TaoQLNGStockModel *model = self.dataArray[indexPath.row];
    
    [cell setN:model.n s:model.s zx:model.zx zdf:model.zdf enterPrice:model.ip maxZdf:model.maxzdf];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TaoQLNGStockModel *model = self.dataArray[indexPath.row];
    [NativeUrlRedirectAction nativePushToStock:model.n s:model.s t:model.t m:model.m];
}

#pragma mark lazyloading

- (TaoQLNGAPI *)qlngAPI {
    if (_qlngAPI == nil) {
        _qlngAPI = [TaoQLNGAPI new];
        _qlngAPI.delegate = self;
        _qlngAPI.ids = self.ids;
        _qlngAPI.animatingView = self.view;
    }
    return _qlngAPI;
}

- (UIImageView *)topImage {
    if (_topImage == nil) {
        _topImage = [UIImageView new];
        _topImage.contentMode = UIViewContentModeScaleAspectFill;
        _topImage.clipsToBounds = YES;
    }
    return _topImage;
}

- (UILabel *)topLabel {
    if (_topLabel == nil) {
        _topLabel = [UILabel new];
        _topLabel.textColor = kUIColorFromRGB(0xffffff);
        _topLabel.font = [UIFont systemFontOfSize:11 * kScale];
        _topLabel.preferredMaxLayoutWidth = MAIN_SCREEN_WIDTH - 24 * kScale;
        _topLabel.numberOfLines = 3;
    }
    return _topLabel;
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.backgroundColor = kUIColorFromRGB(0xf1f1f1);
        _tableView.delegate = self;
        _tableView.separatorInset = UIEdgeInsetsMake(0, 12, 0, 12);
        _tableView.separatorColor = kUIColorFromRGB(0xe4e4e4);
        [_tableView registerClass:[TaoQLNGTableViewCell class] forCellReuseIdentifier:cellID];
        _tableView.mj_header = [MJChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
        _tableView.tableHeaderView = self.headerView;
        _tableView.tableFooterView = self.tableFooterView;
    }
    return _tableView;
}

- (UIView *)day3View {
    if (_day3View == nil) {
        _day3View = [UIView new];
        _day3View.backgroundColor = kUIColorFromRGB(0xffffff);
        UILabel *lb = [UILabel new];
        lb.backgroundColor = kUIColorFromRGB(0xe4e4e4);
        [_day3View addSubview:lb];
        [lb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_day3View);
            make.height.equalTo(_day3View).multipliedBy(0.5);
            make.right.equalTo(_day3View);
            make.width.equalTo(@(0.5));
        }];
    }
    return _day3View;
}

- (UIView *)day5View {
    if (_day5View == nil) {
        _day5View = [UIView new];
        _day5View.backgroundColor = kUIColorFromRGB(0xffffff);
        UILabel *lb = [UILabel new];
        lb.backgroundColor = kUIColorFromRGB(0xe4e4e4);
        [_day5View addSubview:lb];
        [lb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_day5View);
            make.height.equalTo(_day5View).multipliedBy(0.5);
            make.right.equalTo(_day5View);
            make.width.equalTo(@(0.5));
        }];
    }
    return _day5View;
}

- (UIView *)winView {
    if (_winView == nil) {
        _winView = [UIView new];
        _winView.backgroundColor = kUIColorFromRGB(0xffffff);
    }
    return _winView;
}

- (UILabel *)day3TextLb {
    if (_day3TextLb == nil) {
        _day3TextLb = [UILabel new];
        _day3TextLb.textColor = kUIColorFromRGB(0x999999);
        _day3TextLb.font = [UIFont systemFontOfSize:12 * kScale];
        _day3TextLb.text = @"3日涨幅";
    }
    return _day3TextLb;
}

- (UILabel *)day5TextLb {
    if (_day5TextLb == nil) {
        _day5TextLb = [UILabel new];
        _day5TextLb.textColor = kUIColorFromRGB(0x999999);
        _day5TextLb.font = [UIFont systemFontOfSize:12 * kScale];
        _day5TextLb.text = @"5日涨幅";
    }
    return _day5TextLb;
}

- (UILabel *)winTextLb {
    if (_winTextLb == nil) {
        _winTextLb = [UILabel new];
        _winTextLb.textColor = kUIColorFromRGB(0x999999);
        _winTextLb.font = [UIFont systemFontOfSize:12 * kScale];
        _winTextLb.text = @"胜率";
    }
    return _winTextLb;
}

- (UILabel *)day3ZdfLb {
    if (_day3ZdfLb == nil) {
        _day3ZdfLb = [UILabel new];
        _day3ZdfLb.font = [UIFont systemFontOfSize:20 * kScale];
    }
    return _day3ZdfLb;
}

- (UILabel *)day5ZdfLb {
    if (_day5ZdfLb == nil) {
        _day5ZdfLb = [UILabel new];
        _day5ZdfLb.font = [UIFont systemFontOfSize:20 * kScale];
    }
    return _day5ZdfLb;
}

- (UILabel *)winZdfLb {
    if (_winZdfLb == nil) {
        _winZdfLb = [UILabel new];
        _winZdfLb.font = [UIFont systemFontOfSize:20 * kScale];
    }
    return _winZdfLb;
}

- (UIView *)starView {
    if (_starView == nil) {
        _starView = [UIView new];
        _starView.backgroundColor = kUIColorFromRGB(0xffffff);
        UILabel *lb = [UILabel new];
        lb.text = @"综合评分";
        lb.textColor = kUIColorFromRGB(0x333333);
        lb.font = [UIFont systemFontOfSize:13 * kScale];
        
        [_starView addSubview:lb];
        [lb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_starView).offset(12 * kScale);
            make.centerY.equalTo(_starView);
        }];
    }
    return _starView;
}

- (UIView *)userComLb {
    if (_userComLb == nil) {
        _userComLb = [UIView new];
        _userComLb.backgroundColor = kUIColorFromRGB(0xffffff);
        UILabel *c = [UILabel new];
        c.textColor= kUIColorFromRGB(0x333333);
        c.text = @"用户评价";
        c.font = [UIFont systemFontOfSize:13 * kScale];
        [_userComLb addSubview:c];
        [c mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_userComLb).offset(12 * kScale);
            make.centerY.equalTo(_userComLb);
        }];
        
        UILabel *line = [UILabel new];
        line.backgroundColor = kUIColorFromRGB(0xe4e4e4);
        [_userComLb addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.left.right.equalTo(_userComLb);
            make.height.equalTo(@(0.5));
        }];
    }
    return _userComLb;
}

- (TaoCommedTableViewCell *)cell {
    if (_cell == nil) {
        _cell = [TaoCommedTableViewCell new];
    }
    return _cell;
}

- (UIButton *)moreComBtn {
    if (_moreComBtn == nil) {
        _moreComBtn = [UIButton new];
        _moreComBtn.backgroundColor = [UIColor whiteColor];
        [_moreComBtn setTitle:@"查看全部评价" forState:UIControlStateNormal];
        [_moreComBtn setTitleColor:kUIColorFromRGB(0x358ee7) forState:UIControlStateNormal];
        _moreComBtn.titleLabel.font = [UIFont systemFontOfSize:12 * kScale];
        [_moreComBtn addTarget:self action:@selector(moreBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        UILabel *lb = [UILabel new];
        lb.backgroundColor = kUIColorFromRGB(0xe4e4e4);
        [_moreComBtn addSubview:lb];
        [lb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.equalTo(_moreComBtn);
            make.height.equalTo(@(0.5));
        }];
    }
    return _moreComBtn;
}

- (UIView *)suggestView {
    if (_suggestView == nil) {
        _suggestView = [UIView new];
        _suggestView.backgroundColor = kUIColorFromRGB(0xffffff);
        [_suggestView addSubview:self.suggestLb];
        [_suggestLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_suggestView).offset(12 * kScale);
            make.centerY.equalTo(_suggestView);
        }];
        [_suggestView addSubview:self.historyBtn];
        [_historyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(_suggestView).offset(-12 * kScale);
            make.centerY.equalTo(_suggestView);
        }];
    }
    return _suggestView;
}

- (UILabel *)suggestLb {
    if (_suggestLb == nil) {
        _suggestLb = [UILabel new];
        _suggestLb.textColor = kUIColorFromRGB(0x333333);
        _suggestLb.font = [UIFont systemFontOfSize:13 * kScale];
    }
    return _suggestLb;
}

- (UIView *)header {
    UIView *view = [UIView new];
    view.backgroundColor = kUIColorFromRGB(0xf1f1f1);
    
    UILabel *lb1 = [UILabel new];
    lb1.text = @"名称代码";
    lb1.textColor = kUIColorFromRGB(0x808080);
    lb1.font = [UIFont systemFontOfSize:14 * kScale];
    
    UILabel *lb2 = [UILabel new];
    lb2.text = @"入选价格";
    lb2.textColor = kUIColorFromRGB(0x808080);
    lb2.font = [UIFont systemFontOfSize:14 * kScale];
    
    UILabel *lb3 = [UILabel new];
    lb3.text = @"最新";
    lb3.textColor = kUIColorFromRGB(0x808080);
    lb3.font = [UIFont systemFontOfSize:14 * kScale];
    
    UILabel *lb4 = [UILabel new];
    lb4.text = @"最高涨幅";
    lb4.textColor = kUIColorFromRGB(0x808080);
    lb4.font = [UIFont systemFontOfSize:14 * kScale];
    
    [view addSubview:lb1];
    [view addSubview:lb2];
    [view addSubview:lb3];
    [view addSubview:lb4];
    
    [lb1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(view);
        make.left.equalTo(view).offset(12 * kScale);
    }];
    
    [lb2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(view.mas_centerX).offset(-18 * kScale);
        make.centerY.equalTo(view);
    }];
    
    [lb3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(view);
        make.left.equalTo(view.mas_centerX).offset(40 * kScale);
    }];
    
    [lb4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(view);
        make.right.equalTo(view).offset(-12 * kScale);
    }];
    
    return view;
}

- (UIView *)headerView {
    if (_headerView == nil) {
        _headerView = [UIView new];
    }
    return _headerView;
}

- (UIView *)noCommentView {
    if (_noCommentView == nil) {
        _noCommentView = [UIView new];
        _noCommentView.backgroundColor = [UIColor whiteColor];
        UILabel *lb = [UILabel new];
        lb.text = @"暂无评论";
        lb.font = [UIFont systemFontOfSize:12 * kScale];
        lb.textColor = kUIColorFromRGB(0x999999);
        [_noCommentView addSubview:lb];
        [lb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_noCommentView).offset(12 * kScale);
            make.centerY.equalTo(_noCommentView);
        }];
    }
    return _noCommentView;
}

- (TaoQLNGBottomView *)bottomView {
    if (_bottomView == nil) {
        _bottomView = [TaoQLNGBottomView new];
        _bottomView.delegate = self;
    }
    return _bottomView;
}

- (UIView *)tableFooterView {
    if (_tableFooterView == nil) {
        _tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WIDTH, 50 * kScale)];
        UILabel *lb = [UILabel new];
        lb.text = @"以上结果仅供参考,不构成投资依据";
        lb.textColor = kUIColorFromRGB(0x999999);
        lb.font = [UIFont systemFontOfSize:11 * kScale];
        [_tableFooterView addSubview:lb];
        [lb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_tableFooterView).offset(20 * kScale);
            make.centerX.equalTo(_tableFooterView);
        }];
    }
    return _tableFooterView;
}

- (UIButton *)historyBtn {
    if (_historyBtn == nil) {
        _historyBtn = [UIButton new];
        [_historyBtn setImage:[UIImage imageNamed:@"theme_arror_ico"] forState:UIControlStateNormal];
        [_historyBtn setTitle:@"历史数据" forState:UIControlStateNormal];
        [_historyBtn setTitleColor:kUIColorFromRGB(0x999999) forState:UIControlStateNormal];
        _historyBtn.titleLabel.font = [UIFont systemFontOfSize:12 * kScale];
        [_historyBtn addTarget:self action:@selector(historyBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        _historyBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -10 * kScale, 0, 10 * kScale);
        _historyBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 50 * kScale, 0, -50 * kScale);
    }
    return _historyBtn;
}

- (UIImageView *)star1 {
    if (_star1 == nil) {
        _star1 = [UIImageView new];
    }
    return _star1;
}

- (UIImageView *)star2 {
    if (_star2 == nil) {
        _star2 = [UIImageView new];
    }
    return _star2;
}

- (UIImageView *)star3 {
    if (_star3 == nil) {
        _star3 = [UIImageView new];
    }
    return _star3;
}

- (UIImageView *)star4 {
    if (_star4 == nil) {
        _star4 = [UIImageView new];
    }
    return _star4;
}

- (UIImageView *)star5 {
    if (_star5 == nil) {
        _star5 = [UIImageView new];
    }
    return _star5;
}

- (NSMutableArray *)starArray {
    if (_starArray == nil) {
        _starArray = [NSMutableArray array];
    }
    return _starArray;
}


@end
