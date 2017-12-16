//
//  MainThemeViewController.m
//  NewStock
//
//  Created by 王迪 on 2017/5/5.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "MainThemeViewController.h"
#import "IndexChartViewController.h"
#import "StockChartViewController.h"
#import "BoardDetailListViewController.h"
#import "BoardListModel.h"
#import "NativeUrlRedirectAction.h"
#import "ThemeDetailModel.h"
#import "ThemeNewsCell.h"
#import "ThemeDetailAPI.h"
#import "SharedInstance.h"
#import "ThemeCenterStockView.h"
#import "Defination.h"
#import <Masonry.h>

static NSString *cellID = @"MainThemeViewControllerCell";

@interface MainThemeViewController () <UITableViewDelegate,UITableViewDataSource,ThemeCenterStockViewDelegate,ThemeNewsCellDelegate>

@property (nonatomic, strong) ThemeDetailAPI *themeDetailAPI;
@property (nonatomic, strong) ThemeDetailModel *model;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) NSArray *dataArray;

@property (nonatomic, strong) ThemeCenterStockView *centerView;
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UIView *boardView;
@property (nonatomic, strong) UIView *bottomView;

@property (nonatomic, strong) UILabel *titleLb;
@property (nonatomic, strong) UILabel *dscLb;
@property (nonatomic, strong) UILabel *timeLb;
@property (nonatomic, strong) UIButton *topMoreBtn;

@property (nonatomic, strong) UILabel *boardLb;
@property (nonatomic, strong) UILabel *boardZxLb;
@property (nonatomic, strong) UILabel *historyLb;

@property (nonatomic) UIImageView *star1;
@property (nonatomic) UIImageView *star2;
@property (nonatomic) UIImageView *star3;
@property (nonatomic) UIImageView *star4;
@property (nonatomic) UIImageView *star5;

@property (nonatomic) NSMutableArray *starArray;

@end

@implementation MainThemeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_mainView removeFromSuperview];
    [_scrollView removeFromSuperview];
    
    _navBar.backgroundColor = kTitleColor;
    [_navBar setLeftBtnImg:[UIImage imageNamed:@"ic_back1_nor"]];
    [_navBar setRightBtnImg:[UIImage imageNamed:@"ic_share1_nor"]];
    
    self.title = @"题材详情";
    UILabel *titlelb = [_navBar valueForKeyPath:@"_titleLb"];
    NSMutableAttributedString *nmAttrStr = [[NSMutableAttributedString alloc] initWithString:self.title attributes:@{
                                                                                                                 NSForegroundColorAttributeName:kUIColorFromRGB(0xffffff),
                                                                                                                 NSFontAttributeName : [UIFont boldSystemFontOfSize:18]                                        }];
    titlelb.attributedText = nmAttrStr.copy;
    self.view.backgroundColor = kUIColorFromRGB(0xf1f1f1);
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(64);
        make.left.right.bottom.equalTo(self.view);
    }];
    self.tableView.tableHeaderView = self.headerView;
    [self setupUI];
}

- (void)setupUI {
    
    [self.topView addSubview:self.titleLb];
    [_titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.topView).offset(12 * kScale);
        make.right.equalTo(self.topView).offset(-12 * kScale);
        make.top.equalTo(self.topView).offset(30 * kScale);
    }];
    
    [self.topView addSubview:self.timeLb];
    [_timeLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.topView).offset(12 * kScale);
        make.top.equalTo(_titleLb.mas_bottom).offset(25 * kScale);
    }];
    
    [self.topView addSubview:self.dscLb];
    [self.dscLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.timeLb.mas_bottom).offset(25 * kScale);
        make.left.equalTo(self.topView).offset(12 * kScale);
        make.right.equalTo(self.topView).offset(-12 * kScale);
    }];
    
    [self.topView addSubview:self.topMoreBtn];
    [self.topMoreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.topView);
        make.bottom.equalTo(self.topView).offset(5 * kScale);
        make.height.equalTo(@(32 * kScale));
        make.width.equalTo(@(16 * kScale));
    }];
    
    [self.topView addSubview:self.star1];
    [self.topView addSubview:self.star2];
    [self.topView addSubview:self.star3];
    [self.topView addSubview:self.star4];
    [self.topView addSubview:self.star5];
    
    [self.starArray addObject:self.star1];
    [self.starArray addObject:self.star2];
    [self.starArray addObject:self.star3];
    [self.starArray addObject:self.star4];
    [self.starArray addObject:self.star5];
    
    [self.star1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_topView).offset(-75 * kScale);
        make.top.equalTo(self.timeLb);
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
    
    [self.headerView addSubview:self.topView];
    [self.headerView addSubview:self.boardView];
    [self.headerView addSubview:self.centerView];
    [self.headerView addSubview:self.bottomView];
    
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.headerView);
        make.height.equalTo(@(0));
    }];
    
    [self.boardView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.headerView);
        make.top.equalTo(self.topView.mas_bottom).offset(10 * kScale);
        make.height.equalTo(@(49 * kScale));
    }];
    
    [self.centerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.headerView);
        make.top.equalTo(self.boardView.mas_bottom).offset(0 * kScale);
        make.height.equalTo(@(0));
    }];
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.headerView);
        make.height.equalTo(@(44 * kScale));
        make.top.equalTo(self.centerView.mas_bottom);
    }];
    

}

#pragma mark loadData

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self loadData];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

- (void)loadData {
    [self.themeDetailAPI start];
}

- (void)requestFinished:(APIBaseRequest *)request {
    _model = [MTLJSONAdapter modelOfClass:[ThemeDetailModel class] fromJSONDictionary:request.responseJSONObject error:nil];
    [self dealWithTopView:_model];
    [self dealWithStar:_model.star.floatValue];
    self.centerView.dataArray = _model.sl;
    if (_model.sct.count > 0) {
        [self dealWithTheSct:_model.sct[0]];
    }
    self.dataArray = _model.tml;
    [self.tableView reloadData];
    [self analyiseHeight:_model];
}

- (void)dealWithTopView:(ThemeDetailModel *)model {
    NSMutableParagraphStyle *p = [NSMutableParagraphStyle new];
    p.lineSpacing = 4;
    self.titleLb.attributedText = [[NSAttributedString alloc] initWithString:_model.tt attributes:@{NSParagraphStyleAttributeName : p}];;
    [self dealWithTm:model];
    self.historyLb.text = [NSString stringWithFormat:@"%@板块历史",model.n];
    
    NSMutableParagraphStyle *para = [NSMutableParagraphStyle new];
    para.lineSpacing = 6 * kScale;
    NSAttributedString *attrS = [[NSAttributedString alloc] initWithString:model.dsc attributes:@{NSParagraphStyleAttributeName : para,NSFontAttributeName : _dscLb.font}];
    self.dscLb.attributedText = attrS;

    [self.titleLb sizeToFit];
    [self.dscLb sizeToFit];
    CGFloat height = [attrS boundingRectWithSize:CGSizeMake(self.dscLb.bounds.size.width, MAXFLOAT) options:1 context:nil].size.height;
    NSInteger numberOfLines = ceil(height / (self.dscLb.font.lineHeight + para.lineSpacing));
    if (numberOfLines > 7) {
        self.topMoreBtn.hidden = NO;
    }
    
    self.dscLb.numberOfLines = 7;
    [self.dscLb sizeToFit];
}

- (void)dealWithTm:(ThemeDetailModel *)model {
    NSString *tm = model.tm;
    if ([tm hasPrefix:@"2017"]) {
        tm = [tm stringByReplacingOccurrencesOfString:@"2017-" withString:@""];
    }
    if (tm != nil) {
        tm = [tm substringToIndex:tm.length - 3];
    }
    self.timeLb.text = [NSString stringWithFormat:@"发现时间: %@",tm];
}

- (void)dealWithTheSct:(ThemeDetailSctModel *)sct {
    self.boardLb.text = sct.n;
    self.boardLb.tag = sct.s.integerValue;
    self.boardZxLb.text = [NSString stringWithFormat:@"%.2lf%%",sct.zdf.floatValue];
    if (sct.zdf.floatValue > 0) {
        self.boardZxLb.textColor = kUIColorFromRGB(0xff1919);
    } else if (sct.zdf.floatValue < 0) {
        self.boardZxLb.textColor = kUIColorFromRGB(0x009d00);
    } else {
        self.boardZxLb.textColor = kUIColorFromRGB(0x333333);
    }
}

- (void)dealWithStar:(CGFloat )count {
    for (UIImageView *iv in self.starArray) {
        iv.image = [UIImage imageNamed:@"theme_star_empty"];
    }
    
    NSInteger num = count * 2 ;
    for (int i = 0; i < 5; i ++) {
        UIImageView *iv = self.starArray[i];
        if (num >= 2) {
            iv.image = [UIImage imageNamed:@"theme_star_full"];
            num -= 2;
        } else if (num == 1) {
            iv.image = [UIImage imageNamed:@"theme_star_half"];
            break;
        } else {
            break;
        }
    }
}

- (void)analyiseHeight:(ThemeDetailModel *)model {
    [self.headerView layoutIfNeeded];
    CGFloat topHeight = CGRectGetMaxY(self.dscLb.frame) + 20 * kScale;
    [self.topView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(topHeight));
    }];
    
    NSInteger stockCount = _model.sl.count;
    [self.centerView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(44 * kScale + 32 * kScale + 49 * stockCount * kScale));
    }];
    
    [self.headerView layoutIfNeeded];
    
    CGFloat totalH = CGRectGetMaxY(self.bottomView.frame);
    self.headerView.frame = CGRectMake(0, 0, MAIN_SCREEN_WIDTH, totalH);
    self.tableView.tableHeaderView = self.headerView;
}

#pragma action

- (void)ThemeCenterStockViewStockClick:(ThemeDetailStockModel *)item {
    [self pushToStock:item];
}

- (void)ThemeNewsCellDelegateClick:(ThemeDetailStockModel *)model {
    [self pushToStock:model];
}

- (void)pushToStock:(ThemeDetailStockModel *)item {
    if (!(item.t && item.s && item.m && item.n)) {
        return;
    }
    
    if (([item.t intValue] == 1) || ([item.t intValue] == 2)) {
        IndexChartViewController *viewController = [[IndexChartViewController alloc] init];
        
        IndexInfoModel *model = [[IndexInfoModel alloc] init];
        model.marketCd = item.m;
        model.symbol = item.s;
        model.symbolName = item.n;
        model.symbolTyp = item.t;
        
        viewController.indexModel = model;
        [self.navigationController pushViewController:viewController animated:YES];
    } else {
        StockChartViewController *viewController = [[StockChartViewController alloc] init];
        StockListModel *model = [[StockListModel alloc] init];
        model.marketCd = item.m;
        model.symbol = item.s;
        model.symbolName = item.n;
        model.symbolTyp = item.t;
        
        viewController.stockListModel = model;
        [self.navigationController pushViewController:viewController animated:YES];
    }
}

- (void)boardTap:(UITapGestureRecognizer *)tap {
    BoardListModel *model = [BoardListModel new];
    model.symbol = [NSString stringWithFormat:@"%zd",tap.view.tag];
    model.symbolTyp = @"88";
    model.marketCd = @"88";
    model.industryName = _boardLb.text;
    BoardDetailListViewController *vc = [BoardDetailListViewController new];
    vc.title = model.industryName;
    vc.boardListModel = model;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)topMoreBtnClick:(UIButton *)btn {
    self.topMoreBtn.hidden = YES;
    self.dscLb.numberOfLines = 0;
    [self.dscLb sizeToFit];
    [self analyiseHeight:_model];
}

- (void)navBar:(NavBar *)navBar rightButtonTapped:(UIButton *)sender {
    
    NSString *c = _dscLb.text;
    if (c.length > 30) {
        c = [c substringToIndex:30];
    }
    
    NSString *url = [NSString stringWithFormat:@"%@%@?id=%@",API_URL,H5_TH0001,_model.ids];
    
    [SharedInstance sharedSharedInstance].image = [UIImage imageNamed:@"shareLogo"];
    [SharedInstance sharedSharedInstance].tt = _titleLb.text;
    [SharedInstance sharedSharedInstance].c = c;
    [SharedInstance sharedSharedInstance].url = url;
    [[SharedInstance sharedSharedInstance] shareWithImage:NO];
}

#pragma mark tableView delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 95 * kScale;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ThemeNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    
    ThemeDetailTmlModel *model = self.dataArray[indexPath.row];
    cell.delegate = self;
    cell.model = model;
    if (indexPath.row == 0) {
        cell.isFirst = YES;
    } else {
        cell.isFirst = NO;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    ThemeDetailTmlModel *model = self.dataArray[indexPath.row];
//    [[NativeUrlRedirectAction sharedNativeUrlRedirectAction] redictNativeUrl:model.url];
}

#pragma mark lazy loading

- (ThemeDetailAPI *)themeDetailAPI {
    if (_themeDetailAPI == nil) {
        _themeDetailAPI = [ThemeDetailAPI new];
        _themeDetailAPI.delegate = self;
        _themeDetailAPI.animatingView = self.view;
        _themeDetailAPI.ids = self.ids.length ? self.ids : @"";
    }
    return _themeDetailAPI;
}

- (ThemeCenterStockView *)centerView {
    if (_centerView == nil) {
        _centerView = [[ThemeCenterStockView alloc] init];
        _centerView.delegate = self;
        _centerView.backgroundColor = [UIColor redColor];
    }
    return _centerView;
}

- (UIView *)headerView {
    if (_headerView == nil) {
        _headerView = [UIView new];
        _headerView.frame = CGRectZero;
        _headerView.backgroundColor = [UIColor clearColor];
    }
    return _headerView;
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.backgroundColor = kUIColorFromRGB(0xf1f1f1);
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WIDTH, 20 * kScale)];
        v.backgroundColor = [UIColor whiteColor];
        _tableView.tableFooterView = v;
        [_tableView registerClass:[ThemeNewsCell class] forCellReuseIdentifier:cellID];
    }
    return _tableView;
}

- (UIView *)topView {
    if (_topView == nil) {
        _topView = [UIView new];
        _topView.backgroundColor = [UIColor whiteColor];
    }
    return _topView;
}

- (UIView *)bottomView {
    if (_bottomView == nil) {
        _bottomView = [UIView new];
        _bottomView.backgroundColor = kUIColorFromRGB(0xf1f1f1);
        UILabel *lb = [UILabel new];
        lb.backgroundColor = kUIColorFromRGB(0xff1919);
        [_bottomView addSubview:lb];
        [lb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_bottomView);
            make.left.equalTo(_bottomView).offset(12 * kScale);
            make.width.equalTo(@(2 * kScale));
            make.height.equalTo(@(12 * kScale));
        }];
        
        [_bottomView addSubview:self.historyLb];
        [_historyLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(lb);
            make.left.equalTo(lb.mas_right).offset(10 * kScale);
        }];
    }
    return _bottomView;
}

- (UILabel *)titleLb {
    if (_titleLb == nil) {
        _titleLb = [UILabel new];
        _titleLb.textColor = kUIColorFromRGB(0x333333);
        _titleLb.font = [UIFont boldSystemFontOfSize:20 * kScale];
        _titleLb.numberOfLines = 0;
    }
    return _titleLb;
}

- (UILabel *)timeLb {
    if (_timeLb == nil) {
        _timeLb = [UILabel new];
        _timeLb.textColor = kUIColorFromRGB(0x999999);
        _timeLb.font = [UIFont systemFontOfSize:12 * kScale];
    }
    return _timeLb;
}

- (UILabel *)dscLb {
    if (_dscLb == nil) {
        _dscLb = [UILabel new];
        _dscLb.numberOfLines = 0;
        _dscLb.textColor = kUIColorFromRGB(0x333333);
        _dscLb.font = [UIFont systemFontOfSize:14 * kScale];
    }
    return _dscLb;
}

- (UIButton *)topMoreBtn {
    if (_topMoreBtn == nil) {
        _topMoreBtn = [UIButton new];
        UIImage *img = [UIImage imageNamed:@"theme_arror_ico"];
        [_topMoreBtn setImage:img forState:UIControlStateNormal];
        _topMoreBtn.transform = CGAffineTransformMakeRotation(M_PI_2);
        _topMoreBtn.hidden = YES;
        [_topMoreBtn addTarget:self action:@selector(topMoreBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _topMoreBtn;
}

- (UIView *)boardView {
    if (_boardView == nil) {
        _boardView = [UIView new];
        _boardView.backgroundColor = [UIColor whiteColor];
        UILabel *lb1 = [UILabel new];
        lb1.textColor = kUIColorFromRGB(0x333333);
        lb1.font = [UIFont systemFontOfSize:14 * kScale];
        lb1.text = @"所属板块:";
        UILabel *lb2 = [UILabel new];
        lb2.textColor = kUIColorFromRGB(0x333333);
        lb2.font = [UIFont systemFontOfSize:14 * kScale];
        lb2.text = @"最新涨跌幅:";
        
        [_boardView addSubview:lb1];
        [_boardView addSubview:lb2];
        [lb1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_boardView).offset(12 * kScale);
            make.centerY.equalTo(_boardView);
        }];
        
        [lb2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_boardView);
            make.right.equalTo(_boardView).offset(-95 * kScale);
        }];
        
        [_boardView addSubview:self.boardLb];
        [_boardView addSubview:self.boardZxLb];
        [self.boardLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(lb1.mas_right).offset(15 * kScale);
            make.centerY.equalTo(lb1);
        }];
        [self.boardZxLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(lb2.mas_right).offset(15 * kScale);
            make.centerY.equalTo(lb1);
        }];
    }
    return _boardView;
}

- (UILabel *)boardLb {
    if (_boardLb == nil) {
        _boardLb = [UILabel new];
        _boardLb.textColor = kNameColor;
        _boardLb.font = [UIFont systemFontOfSize:14 * kScale];
        _boardLb.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(boardTap:)];
        [_boardLb addGestureRecognizer:tap];
    }
    return _boardLb;
}

- (UILabel *)boardZxLb {
    if (_boardZxLb == nil) {
        _boardZxLb = [UILabel new];
        _boardZxLb.font = [UIFont systemFontOfSize:14 * kScale];
        _boardZxLb.textColor = kUIColorFromRGB(0xff1919);
    }
    return _boardZxLb;
}

- (UILabel *)historyLb {
    if (_historyLb == nil) {
        _historyLb = [UILabel new];
        _historyLb.textColor = kUIColorFromRGB(0x333333);
        _historyLb.font = [UIFont boldSystemFontOfSize:14 * kScale];
    }
    return _historyLb;
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
