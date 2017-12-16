//
//  ForeignTableViewController.m
//  NewStock
//
//  Created by 王迪 on 2016/12/8.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "ForeignTableViewController.h"
#import "IndexInfoAPI.h"
#import "StockListTitleCell.h"
#import "ForeignTableViewCell.h"
#import "Defination.h"
#import "IndexInfoModel.h"
#import "MarketConfig.h"
#import "MJRefresh.h"


@interface ForeignTableViewController ()

@end

@implementation ForeignTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_scrollView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(30, 0, 0, 0));
    }];
    
    _tableView.mj_footer = nil;
    
    
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
    _listRequestAPI = [[IndexInfoAPI alloc] init];
}

- (Class)getModelClass {
    return [IndexInfoAPI class];
}

- (void)requestFinished:(APIBaseRequest *)request {
    NSLog(@"succeed");
    NSArray * modelArray = [MTLJSONAdapter modelsOfClass:[IndexInfoModel class] fromJSONArray:_listRequestAPI.responseJSONObject error:nil];
    
    _listRequestAPI.totalNum = _totalNum;
    
    [_resultListArray addObjectsFromArray:modelArray];
    
    NSMutableArray *nmArr = [NSMutableArray array];
    NSArray *symbolArr = @[@"HSI",@"IXIC",@"DJI",@"SPX500",@"N225",@"FTSE100"];
    for (IndexInfoModel *model in _resultListArray) {
        if ([symbolArr containsObject:model.symbol]) {
            [nmArr addObject:model];
        }
    }
    _resultListArray = nmArr;
    [_tableView reloadData];
    [_tableView.mj_header endRefreshing];
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

        static NSString *cellid=@"foreignTableViewCell";
        ForeignTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        
        if (cell==nil)
        {
            cell=[[ForeignTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        }
    
        long index=[indexPath row];
        IndexInfoModel *model = [_resultListArray objectAtIndex:index];
        
        [cell setName:model.symbolName value:[SystemUtil getPrecisionPrice:[model.consecutivePresentPrice doubleValue] precision:2] changeRate:[SystemUtil getPercentage:[model.tradeIncrease doubleValue]]];
        
        return cell;
}






@end
