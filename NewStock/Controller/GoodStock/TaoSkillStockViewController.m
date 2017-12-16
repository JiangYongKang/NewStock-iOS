//
//  TaoSkillStockViewController.m
//  NewStock
//
//  Created by 王迪 on 2017/6/19.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "TaoSkillStockViewController.h"
#import "QLNGHistoryViewController.h"
#import "TaoSkillHistoryListViewController.h"
#import "TaoSkillStockListAPI.h"
#import "TaoSkillStockListModel.h"
#import "TaoStockUniversalCell.h"
#import "NativeUrlRedirectAction.h"

#import "MJRefresh.h"
#import "MJChiBaoZiFooter.h"
#import "MJChiBaoZiHeader.h"

#import "Defination.h"
#import <Masonry.h>

static NSString *cellID = @"TaoSkillStockViewControllerCell";

@interface TaoSkillStockViewController () <UITableViewDelegate ,UITableViewDataSource>

@property (nonatomic, strong) TaoSkillStockListModel *model;

@property (nonatomic, strong) NSArray <TaoSkillStockListArrayModel *> *dataArray;

@property (nonatomic, strong) TaoSkillStockListAPI *skillStockAPI;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIImageView *topImageView;

@property (nonatomic, strong) UILabel *topLabel;

@property (nonatomic, strong) UILabel *starLabel;

@property (nonatomic, strong) UIView *centerView;

@property (nonatomic, strong) UILabel *centerLabel;

@property (nonatomic, strong) UIButton *historyBtn;

@property (nonatomic, strong) UILabel *bottomLabel;

@property (nonatomic, strong) UIView *starView;

@property (nonatomic) UIImageView *star1;
@property (nonatomic) UIImageView *star2;
@property (nonatomic) UIImageView *star3;
@property (nonatomic) UIImageView *star4;
@property (nonatomic) UIImageView *star5;

@property (nonatomic) NSMutableArray *starArray;

@end

@implementation TaoSkillStockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_mainView removeFromSuperview];
    [_scrollView removeFromSuperview];
    
    [_navBar setRightBtnImg:[UIImage imageNamed:@"ic_share1_nor"]];
    [_navBar setLeftBtnImg:[UIImage imageNamed:@"ic_back1_nor"]];
    
    UILabel *titlelb = [_navBar valueForKeyPath:@"_titleLb"];
    NSMutableAttributedString *nmAttrStr = [[NSMutableAttributedString alloc] initWithString:self.title attributes:@{
                                                                                                                 NSForegroundColorAttributeName:kUIColorFromRGB(0xffffff),
                                                                                                                 NSFontAttributeName : [UIFont boldSystemFontOfSize:18]                                        }];
    titlelb.attributedText = nmAttrStr.copy;
    
    self.view.backgroundColor = kUIColorFromRGB(0xf1f1f1);
    
    [self setupUI];
    
    [self loadData];
    
    _navBar.line_view.hidden = YES;
    [_navBar setBackgroundColor:[UIColor clearColor]];
    [self.view bringSubviewToFront:_navBar];
}

- (void)setupUI {

    [self.topImageView addSubview:self.topLabel];
    [self.topImageView addSubview:self.starLabel];
    [self.centerView addSubview:self.centerLabel];
    [self.centerView addSubview:self.historyBtn];
    [self.view addSubview:self.topImageView];
    [self.view addSubview:self.starView];
    [self.view addSubview:self.centerView];
    [self.view addSubview:self.tableView];
//    [self.view addSubview:self.bottomLabel];
    
    [self.topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(12 * kScale);
        make.right.equalTo(self.view).offset(-12 * kScale);
        make.top.equalTo(_navBar.mas_bottom).offset(20 * kScale);
    }];
    
//    [self.starLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.topLabel.mas_bottom).offset(10 * kScale);
//        make.left.equalTo(self.topLabel);
//    }];
    
    [self.topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.equalTo(@(64 + 95 * kScale));
    }];
    
    [self.starView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(40 * kScale));
        make.left.right.equalTo(self.view);
        make.top.equalTo(_topImageView.mas_bottom);
    }];
    
    [self.centerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.centerView).offset(12 * kScale);
        make.centerY.equalTo(self.centerView);
    }];
    
    [self.centerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.starView.mas_bottom).offset(8 * kScale);
        make.height.equalTo(@(40 * kScale));
    }];
    
    [self.historyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.centerView);
        make.right.equalTo(self.centerView).offset(-12 * kScale);
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
        make.top.equalTo(self.centerView.mas_bottom);
    }];
    
//    [self.bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.tableView.mas_bottom);
//        make.centerX.equalTo(self.view);
//    }];
    
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

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

#pragma mark loadData

- (void)loadData {
    [self.tableView.mj_header beginRefreshing];
}

- (void)loadNewData {
    [self.skillStockAPI start];
}

- (void)requestFinished:(APIBaseRequest *)request {
    NSLog(@"%@",request.responseJSONObject);
    self.model = [MTLJSONAdapter modelOfClass:[TaoSkillStockListModel class] fromJSONDictionary:request.responseJSONObject error:nil];
    [self dealWithHeight:self.model];
    
    self.title = self.model.title;
    [self.topImageView sd_setImageWithURL:[NSURL URLWithString:self.model.imgUrls]];
    //star
    [self dealWithStar:self.model.star.floatValue];
    self.centerLabel.text = [NSString stringWithFormat:@"%@ 更新",self.model.tm];
    
    self.dataArray = self.model.list;
    [_tableView.mj_header endRefreshing];
    [self.tableView reloadData];
}

- (void)requestFailed:(APIBaseRequest *)request {
    [_tableView.mj_header endRefreshing];
}

- (void)dealWithHeight:(TaoSkillStockListModel *)model {
    
    NSString *title = self.model.desc;
    
    NSMutableParagraphStyle *para = [NSMutableParagraphStyle new];
    para.lineSpacing = 4 * kScale;
    
    NSAttributedString *str = [[NSAttributedString alloc] initWithString:title attributes:@{NSParagraphStyleAttributeName : para}];
    
    CGFloat titleHeight = [str boundingRectWithSize:CGSizeMake(MAIN_SCREEN_WIDTH - 24, MAXFLOAT) options:1 context:nil].size.height;
    
    CGFloat imageHeight = titleHeight + 64 + 20 * kScale + 10 * kScale + 11 * kScale + 15 * kScale;
    
    [self.topImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(imageHeight));
    }];
    
    self.topLabel.attributedText = str;
}

#pragma mark action

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

- (void)historyBtnClick:(UIButton *)btn {
    NSLog(@"btn click");
    
    TaoSkillHistoryListViewController *vc = [TaoSkillHistoryListViewController new];
    vc.title = self.title;
    vc.ids = self.ids;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)navBar:(NavBar *)navBar rightButtonTapped:(UIButton *)sender {
    NSLog(@"share");
}

#pragma mark dataSource

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40 * kScale;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [UIView new];
    view.backgroundColor = kUIColorFromRGB(0xf1f1f1);
    
    UILabel *leftLb = [UILabel new];
    leftLb.text = @"名称/代码";
    leftLb.font = [UIFont systemFontOfSize:13 * kScale];
    leftLb.textColor = kUIColorFromRGB(0x999999);
    
    UILabel *centerLb = [UILabel new];
    centerLb.text = @"最新价";
    centerLb.font = [UIFont systemFontOfSize:13 * kScale];
    centerLb.textColor = kUIColorFromRGB(0x999999);
    
    UILabel *rightLb = [UILabel new];
    rightLb.text = @"涨跌幅";
    rightLb.font = [UIFont systemFontOfSize:13 * kScale];
    rightLb.textColor = kUIColorFromRGB(0x999999);
    
    [view addSubview:leftLb];
    [view addSubview:centerLb];
    [view addSubview:rightLb];
    
    [leftLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(view);
        make.left.equalTo(view).offset(12 * kScale);
    }];
    [centerLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(view);
        make.centerX.equalTo(view);
    }];
    [rightLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(view);
        make.right.equalTo(view).offset(-12 * kScale);
    }];
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 55 * kScale;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TaoStockUniversalCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    TaoSkillStockListArrayModel *model = self.dataArray[indexPath.row];
    
    [cell setN:model.n s:model.s t:model.t zx:model.zx zdf:model.zdf];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TaoSkillStockListArrayModel *model = self.dataArray[indexPath.row];
    [NativeUrlRedirectAction nativePushToStock:model.n s:model.s t:model.t m:model.m];
}

#pragma mark lazy loading

- (TaoSkillStockListAPI *)skillStockAPI {
    if (_skillStockAPI == nil) {
        _skillStockAPI = [TaoSkillStockListAPI new];
        _skillStockAPI.delegate = self;
        _skillStockAPI.sid = self.ids;
    }
    return _skillStockAPI;
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [_tableView registerClass:[TaoStockUniversalCell class] forCellReuseIdentifier:cellID];
        _tableView.mj_header = [MJChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
        _tableView.tableFooterView = self.bottomLabel;
    }
    return _tableView;
}

- (UIImageView *)topImageView {
    if (_topImageView == nil) {
        _topImageView = [[UIImageView alloc] init];
        _topImageView.contentMode = UIViewContentModeScaleAspectFill;
        _topImageView.clipsToBounds = YES;
    }
    return _topImageView;
}

- (UILabel *)topLabel {
    if (_topLabel == nil) {
        _topLabel = [UILabel new];
        _topLabel.textColor = kUIColorFromRGB(0xffffff);
        _topLabel.numberOfLines = 0;
        _topLabel.preferredMaxLayoutWidth = MAIN_SCREEN_WIDTH - 24 * kScale;
        _topLabel.font = [UIFont systemFontOfSize:11 * kScale];
    }
    return _topLabel;
}

- (UILabel *)starLabel {
    if (_starLabel == nil) {
        _starLabel = [UILabel new];
        _starLabel.textColor = kUIColorFromRGB(0xffffff);
        _starLabel.text = @"综合评分:";
        _starLabel.font = [UIFont systemFontOfSize:11 * kScale];
    }
    return _starLabel;
}

- (UIView *)centerView {
    if (_centerView == nil) {
        _centerView = [UIView new];
        _centerView.backgroundColor = [UIColor whiteColor];
    }
    return _centerView;
}

- (UILabel *)centerLabel {
    if (_centerLabel == nil) {
        _centerLabel = [UILabel new];
        _centerLabel.textColor = kUIColorFromRGB(0x333333);
        _centerLabel.font = [UIFont systemFontOfSize:12 * kScale];
    }
    return _centerLabel;
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

- (UILabel *)bottomLabel {
    if (_bottomLabel == nil) {
        _bottomLabel = [UILabel new];
        _bottomLabel.textColor = kUIColorFromRGB(0x999999);
        _bottomLabel.font = [UIFont systemFontOfSize:11 * kScale];
        _bottomLabel.textAlignment = NSTextAlignmentCenter;
        _bottomLabel.text = @"以上结果仅供参考,不构成投资依据";
    }
    return _bottomLabel;
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
//        
//        UILabel *line = [UILabel new];
//        [_starView addSubview:line];
//        line.backgroundColor = kUIColorFromRGB(0xe4e4e4);
//        [line mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.bottom.left.right.equalTo(_starView);
//            make.height.equalTo(@(0.5));
//        }];
    }
    return _starView;
}

@end
