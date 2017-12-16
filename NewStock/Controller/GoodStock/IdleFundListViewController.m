//
//  IdleFundListViewController.m
//  NewStock
//
//  Created by 王迪 on 2017/2/14.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "IdleFundListViewController.h"
#import "TaoSearchStockViewController.h"

#import "IdleFundStockModel.h"
#import "IdleFundAPI.h"
#import "SystemUtil.h"

#import "MJChiBaoZiHeader.h"
#import "MJChiBaoZiFooter.h"
#import "MJRefresh.h"
#import "TaoStockUniversalCell.h"

static NSString *cellID = @"idleFundCell";

@interface IdleFundListViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) IdleFundAPI *idleFundAPI;

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation IdleFundListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_scrollView removeFromSuperview];
    [_mainView removeFromSuperview];
    _navBar.hidden = YES;
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(0 * kScale);
        make.left.right.bottom.equalTo(self.view);
    }];
    
    self.tableView.tableFooterView = [UIView new];
    self.tableView.backgroundColor = kUIColorFromRGB(0xf1f1f1);
    
    self.tableView.mj_header = [MJChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    self.tableView.mj_footer = [MJChiBaoZiFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];

}

#pragma mark request

- (void)loadData {
    [self.tableView.mj_header beginRefreshing];
}

- (void)loadNewData {
    if (self.code.length == 0) {
        return;
    }
    
    self.idleFundAPI.code = self.code;
    self.idleFundAPI.page = @"1";
    [self.idleFundAPI start];
}

- (void)loadMoreData {
    self.idleFundAPI.page = [NSString stringWithFormat:@"%zd",self.idleFundAPI.page.integerValue + 1];
    [self.idleFundAPI start];
}

- (void)requestFailed:(APIBaseRequest *)request {
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}

- (void)requestFinished:(APIBaseRequest *)request {
    NSLog(@"%@",request.responseJSONObject);
    
    IdleFundStockModel *model = [MTLJSONAdapter modelOfClass:[IdleFundStockModel class] fromJSONDictionary:request.responseJSONObject error:nil];
    
    NSArray *array = [MTLJSONAdapter modelsOfClass:[IdleFundStockListModel class] fromJSONArray:[request.responseJSONObject objectForKey:@"list"] error:nil];
    
    if ([self.delegate respondsToSelector:@selector(idleFundListViewControllerDelegateDsc:icon:)]) {
        [self.delegate idleFundListViewControllerDelegateDsc:model.dsc icon:model.icon];
    }
    
    if ([[request valueForKey:@"page"] isEqualToString:@"1"]) {
        [self.dataArray removeAllObjects];
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
    [self.tableView reloadData];
}

#pragma mark actions


#pragma mark tableView delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 56 * kScale;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40 * kScale;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_HEIGHT, 40 * kScale)];
    view.backgroundColor = kUIColorFromRGB(0xf1f1f1);
    
    UILabel *lb1 = [UILabel new];
    lb1.text = @"名称代码";
    lb1.font = [UIFont systemFontOfSize:12 * kScale];
    lb1.textColor = kUIColorFromRGB(0x999999);
    
    UILabel *lb2 = [UILabel new];
    lb2.text = @"最新价";
    lb2.font = [UIFont systemFontOfSize:12 * kScale];
    lb2.textColor = kUIColorFromRGB(0x999999);
    
    UILabel *lb3 = [UILabel new];
    lb3.text = @"涨跌幅";
    lb3.font = [UIFont systemFontOfSize:12 * kScale];
    lb3.textColor = kUIColorFromRGB(0x999999);
    
    [view addSubview:lb1];
    [view addSubview:lb2];
    [view addSubview:lb3];
    
    [lb1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(view);
        make.left.equalTo(view).offset(12 * kScale);
    }];
    
    [lb2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(view);
        make.centerX.equalTo(view).offset(5 * kScale);
    }];
    
    [lb3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(view);
        make.right.equalTo(view).offset(-12 * kScale);
    }];
    
    return view;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    TaoStockUniversalCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    IdleFundStockListModel *model = self.dataArray[indexPath.row];
    
    [cell setN:model.n s:model.s t:model.t zx:model.zx zdf:model.zdf];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    IdleFundStockListModel *item = self.dataArray[indexPath.row];
    if (!(item.t && item.s && item.m && item.n)) {
        return;
    }
    if (self.pushBlock) {
        self.pushBlock(item);
    }
}

#pragma mark lazy loading

- (IdleFundAPI *)idleFundAPI {
    if (_idleFundAPI == nil) {
        if (_idleFundAPI == nil) {
            _idleFundAPI = [[IdleFundAPI alloc] init];
            _idleFundAPI.code = self.code;
            _idleFundAPI.page = @"1";
            _idleFundAPI.count = @"20";
            _idleFundAPI.delegate = self;
        }
        return _idleFundAPI;
    }
    return _idleFundAPI;
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorInset = UIEdgeInsetsMake(0, 15 * kScale, 0, 15 * kScale);
        _tableView.separatorColor = kUIColorFromRGB(0xd3d3d3);
        [_tableView registerClass:[TaoStockUniversalCell class] forCellReuseIdentifier:cellID];
    }
    return _tableView;
}

- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray  = [NSMutableArray array];
    }
    return _dataArray;
}

@end
