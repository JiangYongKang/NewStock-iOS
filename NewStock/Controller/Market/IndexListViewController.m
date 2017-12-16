//
//  IndexListViewController.m
//  NewStock
//
//  Created by Willey on 16/8/11.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "IndexListViewController.h"
#import "StockTableViewCell.h"
#import "MarketConfig.h"
#import "StockListTitleCell.h"
#import "BoardDetailTitleCell.h"
#import "SystemUtil.h"
#import "AppDelegate.h"

#import "IndexListAPI.h"
#import "Mantle.h"
#import "StockListModel.h"
#import "MJRefresh.h"

#import "IndexChartViewController.h"

@implementation IndexListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [_scrollView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(30, 0, 0, 0));
    }];
    
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WIDTH, 30)];
    topView.backgroundColor = kUIColorFromRGB(0xf1f1f1);
    [self.view addSubview:topView];
    
    int Xcenter = MAIN_SCREEN_WIDTH/2;
    
    UILabel *nameLb = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 100, 30)];
    nameLb.backgroundColor = [UIColor clearColor];
    nameLb.textColor = kUIColorFromRGB(0x666666);//[UIColor darkGrayColor];
    nameLb.font = [UIFont systemFontOfSize:12.0f];
    nameLb.text = @"名称/代码";
    [topView addSubview:nameLb];
    
    UILabel *valueLb = [[UILabel alloc] initWithFrame:CGRectMake(Xcenter-75, 0, 150, 30)];
    valueLb.backgroundColor = [UIColor clearColor];
    valueLb.textColor = kUIColorFromRGB(0x666666);//[UIColor darkGrayColor];
    valueLb.font = [UIFont systemFontOfSize:12.0f];
    valueLb.text = @"最新";
    valueLb.textAlignment = NSTextAlignmentCenter;
    [topView addSubview:valueLb];
    
    UILabel *changeRateLb = [[UILabel alloc] initWithFrame:CGRectMake(MAIN_SCREEN_WIDTH-120, 0, 100, 30)];
    changeRateLb.backgroundColor = [UIColor clearColor];
    changeRateLb.textColor = kUIColorFromRGB(0x666666);//[UIColor darkGrayColor];
    changeRateLb.font = [UIFont systemFontOfSize:12.0f];
    changeRateLb.text = @"涨跌幅";
    changeRateLb.textAlignment = NSTextAlignmentRight;
    [topView addSubview:changeRateLb];
    
    
}

- (void)initRequestAPI {
    _listRequestAPI = [[IndexListAPI alloc] init];
}

- (Class)getModelClass {
    return [IndexListAPI class];
}

- (void)requestFinished:(APIBaseRequest *)request {
    NSLog(@"succeed");
    NSArray * modelArray = [MTLJSONAdapter modelsOfClass:[IndexInfoModel class] fromJSONArray:_listRequestAPI.responseJSONObject error:nil];

    _totalNum = (int)[modelArray count];
    _listRequestAPI.totalNum = _totalNum;
    
    [_resultListArray addObjectsFromArray:modelArray];
    [_tableView reloadData];
    
    if (_totalNum>[_resultListArray count])
    {
        [_tableView.mj_header endRefreshing];
        [_tableView.mj_footer endRefreshing];
    }
    else
    {
        //没有更多数据的状态
        [_tableView.mj_header endRefreshing];
        [_tableView.mj_footer endRefreshingWithNoMoreData];
    }
}

- (void)requestFailed:(APIBaseRequest *)request {
    NSLog(@"failed");
}

#pragma UITableView
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return MARKET_CELL_HEIGHT;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_resultListArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellid=@"stockTableViewCell";
    StockTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (cell==nil)
    {
        cell=[[StockTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }

    long index=[indexPath row];
    IndexInfoModel *model = [_resultListArray objectAtIndex:index];
    
    [cell setCode:model.symbol name:model.symbolName value:[SystemUtil getPrecisionPrice:[model.consecutivePresentPrice doubleValue] precision:2] changeRate:[SystemUtil getPercentage:[model.tradeIncrease doubleValue]] marketCd:model.marketCd];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    IndexChartViewController *viewController = [[IndexChartViewController alloc] init];
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    long index = indexPath.row;
    IndexInfoModel *model = [_resultListArray objectAtIndex:index];
    
    viewController.indexModel = model;
    [appDelegate.navigationController pushViewController:viewController animated:YES];
}

@end
