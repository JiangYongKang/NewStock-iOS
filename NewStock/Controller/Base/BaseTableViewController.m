//
//  BaseTableViewController.m
//  NewStock
//
//  Created by Willey on 16/8/7.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "BaseTableViewController.h"
#import "MarketConfig.h"
#import "SystemUtil.h"

#import "MJRefresh.h"
#import "MJChiBaoZiHeader.h"
#import "MJChiBaoZiFooter.h"

#import "Mantle.h"

@implementation BaseTableViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [_navBar setTitle:self.title];
    
    _mainView.backgroundColor = REFRESH_BG_COLOR;
    [_scrollView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(NAV_BAR_HEIGHT, 0, 0, 0));
    }];
    [_scrollView updateConstraints];
    [_scrollView layoutIfNeeded];
    
    _tableView = [[UITableView alloc] init];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.tableFooterView = [UIView new];
    _tableView.separatorInset = UIEdgeInsetsMake(0, 15, 0, 15);

    [_mainView addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_tableView.superview).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    _resultListArray = [[NSMutableArray alloc] init];
    
    _tableView.mj_header = [MJChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    _tableView.mj_footer = [MJChiBaoZiFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    _resultListName = @"rankingLst";
    [self initRequestAPI];
    _listRequestAPI.delegate = self;
    [_tableView.mj_header beginRefreshing];

}

- (void)initRequestAPI {
    _listRequestAPI = [[APIListRequest alloc] init];
}

- (Class)getModelClass {
    return [MTLModel class];
}

- (void)analyzeData:(id)responseJSONObject {
    
}

- (void)requestFinished:(APIBaseRequest *)request {
//    NSLog(@"%@",request.responseJSONObject);
    NSLog(@"succeed");
    NSArray *array = [_listRequestAPI.responseJSONObject objectForKey:_resultListName];
    _totalNum = [[_listRequestAPI.responseJSONObject objectForKey:@"total"] intValue];
    _listRequestAPI.totalNum = _totalNum;
    
    //解析出其他需要的数据
    [self analyzeData:_listRequestAPI.responseJSONObject];
    
    NSArray *modelArray = [MTLJSONAdapter modelsOfClass:[self getModelClass] fromJSONArray:array error:nil];
    [_resultListArray addObjectsFromArray:modelArray];
    [_tableView reloadData];
    
    if (_totalNum > [_resultListArray count])
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
    [_tableView.mj_header endRefreshing];
    [_tableView.mj_footer endRefreshing];
}

#pragma mark - 数据处理相关
#pragma mark 下拉刷新数据
- (void)loadNewData {
    [_resultListArray removeAllObjects];
    [_listRequestAPI loadFirstPage];
}

#pragma mark 上拉加载更多数据
- (void)loadMoreData {
    [_listRequestAPI loadNestPage];
}


#pragma UITableView
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0)
    {
        return 30;
    }
    else
    {
        return MARKET_CELL_HEIGHT;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_resultListArray count]+1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0)
    {
        static NSString *cellid=@"TitleCell";
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        
        if (cell==nil)
        {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        }
        return cell;
    }
    else
    {
        static NSString *cellid=@"stockTableViewCell";
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        
        if (cell==nil)
        {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        }
        
        return cell;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

@end
