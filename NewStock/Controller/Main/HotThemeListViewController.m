//
//  HotThemeListViewController.m
//  NewStock
//
//  Created by 王迪 on 2017/5/10.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "HotThemeListViewController.h"
#import "IndexChartViewController.h"
#import "StockChartViewController.h"
#import "NativeUrlRedirectAction.h"
#import "ThemeTimeLineAPI.h"
#import "MJRefresh.h"
#import "MJChiBaoZiFooter.h"
#import "MJChiBaoZiHeader.h"
#import "MainThemeCell.h"
#import "ThemeTimeLineModel.h"
#import "Defination.h"
#import <Masonry.h>

static NSString *cellID = @"HotThemeListViewControllerCellID";

@interface HotThemeListViewController ()<UITableViewDelegate,UITableViewDataSource,MainThemeCellDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) ThemeTimeLineAPI *themeTimeLineAPI;

@end

@implementation HotThemeListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _navBar.backgroundColor = kTitleColor;
    [_navBar setLeftBtnImg:[UIImage imageNamed:@"ic_back1_nor"]];
    
    self.title = @"热门题材";
    UILabel *titlelb = [_navBar valueForKeyPath:@"_titleLb"];
    NSMutableAttributedString *nmAttrStr = [[NSMutableAttributedString alloc] initWithString:self.title attributes:@{
                                                                                                                     NSForegroundColorAttributeName:kUIColorFromRGB(0xffffff),
                                                                                                                     NSFontAttributeName : [UIFont boldSystemFontOfSize:18]                                        }];
    titlelb.attributedText = nmAttrStr.copy;
    
    [_mainView removeFromSuperview];
    [_scrollView removeFromSuperview];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(_navBar.mas_bottom);
    }];
    
    self.tableView.mj_header = [MJChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    _tableView.mj_footer = [MJChiBaoZiFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
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

#pragma mark loaddata 

- (void)loadData {
    [self.tableView.mj_header beginRefreshing];
}

- (void)loadNewData {
    self.themeTimeLineAPI.page = @"1";
    [self.themeTimeLineAPI start];
}

- (void)loadMoreData {
    NSString *page = self.themeTimeLineAPI.page;
    self.themeTimeLineAPI.page = [NSString stringWithFormat:@"%zd",page.integerValue + 1];
    [self.themeTimeLineAPI start];
}

- (void)requestFinished:(APIBaseRequest *)request {
    NSLog(@"%@",request.responseJSONObject);
    
    NSArray *array = [MTLJSONAdapter modelsOfClass:[ThemeTimeLineModel class] fromJSONArray:request.responseJSONObject error:nil];
    
    if ([[request valueForKey:@"page"] isEqualToString:@"1"]) {
        self.dataArray = [NSMutableArray arrayWithArray:array];
        [_tableView.mj_header endRefreshing];
    } else {
        [self.dataArray addObjectsFromArray:array];
    }
    
    [self.tableView reloadData];
    NSString *count = (NSString *)[request valueForKey:@"count"];
    if (array.count < count.integerValue) {
        [_tableView.mj_footer endRefreshingWithNoMoreData];
    } else {
        [_tableView.mj_footer endRefreshing];
    }
    
}

- (void)requestFailed:(APIBaseRequest *)request {
    NSLog(@"failed");
    [self.tableView.mj_header endRefreshing];
}

#pragma action

- (void)MainThemeCellDelegate:(MainThemeStockModel *)model {
    MainThemeStockModel *item = model;
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

#pragma mark tableDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    ThemeTimeLineModel *model = self.dataArray[indexPath.section];
    MainThemeModel *m = model.list[indexPath.row];
    
    NSString *tt = m.tt;
    UIFont *font = [UIFont boldSystemFontOfSize:16 * kScale];
    CGFloat w = [tt boundingRectWithSize:CGSizeMake(MAXFLOAT, font.lineHeight) options:1 attributes:@{NSFontAttributeName : font} context:nil].size.width;
    
    CGFloat height = 0;
    
    if (w > MAIN_SCREEN_WIDTH - 48 * kScale) {
        if (indexPath.section == 0) {
            height = 163;
        } else {
            height = 144;
        }
    } else {
        if (indexPath.section == 0) {
            height = 137;
        } else {
            height = 118;
        }
    }
    
    if (indexPath.row == model.list.count - 1) {
        return (height - 12) * kScale;
    }
    return height * kScale;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40 * kScale;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WIDTH, 35 * kScale)];
    
    UILabel *lb = [UILabel new];
    if (section == 0) {
        lb.textColor = kTitleColor;
    } else {
        lb.textColor = kUIColorFromRGB(0x666666);
    }
    ThemeTimeLineModel *model = self.dataArray[section];
    lb.text = model.tt;
    lb.font = [UIFont systemFontOfSize:12 * kScale];
    lb.textAlignment = NSTextAlignmentCenter;
    
    UILabel *leftLine = [UILabel new];
    leftLine.backgroundColor = kUIColorFromRGB(0xd3d3d3);
    UILabel *rightLine = [UILabel new];
    rightLine.backgroundColor = kUIColorFromRGB(0xd3d3d3);
    
    [v addSubview:lb];
    [v addSubview:leftLine];
    [v addSubview:rightLine];
    
    [lb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(v);
    }];
    
    [leftLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(v);
        make.right.equalTo(lb.mas_left).offset(-10 * kScale);
        make.width.equalTo(@(20 * kScale));
        make.height.equalTo(@(0.5));
    }];
    
    [rightLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(v);
        make.left.equalTo(lb.mas_right).offset(10 * kScale);
        make.width.height.equalTo(leftLine);
    }];
    
    return v;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    ThemeTimeLineModel *model = self.dataArray[section];
    return model.list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MainThemeCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    ThemeTimeLineModel *model = self.dataArray[indexPath.section];
    MainThemeModel *tModel = model.list[indexPath.row];
    cell.model = tModel;
    cell.delegate = self;
    cell.backgroundColor = kUIColorFromRGB(0xf1f1f1);
    if (indexPath.section == 0) {
        cell.index = indexPath.row;
    } else {
        cell.index = -1;
    }
    
    if (model.list.count - 1 == indexPath.row) {
        cell.isLastOne = YES;
    } else {
        cell.isLastOne = NO;
    }
    
    cell.style = MainThemeCellStyleShadow;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ThemeTimeLineModel *m = self.dataArray[indexPath.section];
    MainThemeModel *model = m.list[indexPath.row];
    [[NativeUrlRedirectAction sharedNativeUrlRedirectAction] redictNativeUrl:model.url];
}

#pragma mark lazy loading

- (ThemeTimeLineAPI *)themeTimeLineAPI {
    if (_themeTimeLineAPI == nil) {
        _themeTimeLineAPI = [ThemeTimeLineAPI new];
        _themeTimeLineAPI.delegate = self;
        _themeTimeLineAPI.animatingView = self.view;
        _themeTimeLineAPI.page = @"1";
        _themeTimeLineAPI.count = @"5";
    }
    return _themeTimeLineAPI;
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        [_tableView registerClass:[MainThemeCell class] forCellReuseIdentifier:cellID];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    }
    return _tableView;
}

- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

@end
