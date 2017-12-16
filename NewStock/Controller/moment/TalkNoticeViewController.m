//
//  TalkNoticeViewController.m
//  NewStock
//
//  Created by 王迪 on 2017/3/31.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "TalkNoticeViewController.h"
#import "DetailWebViewController.h"
#import "MomentUnreadListAPI.h"
#import "MomentUnreadOperAPI.h"
#import "MomentNoticeTableViewCell.h"
#import "MomentNoticeModel.h"
#import "Defination.h"
#import "MarketConfig.h"

static NSString *cellID = @"TalkNoticeCell";

@interface TalkNoticeViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) MomentUnreadListAPI *unreadListAPI;
@property (nonatomic, strong) MomentUnreadOperAPI *operationAPI;
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray <MomentNoticeModel *> *dataArray;

@end

@implementation TalkNoticeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_mainView removeFromSuperview];
    [_scrollView removeFromSuperview];
    
    if ([self.res_code isEqualToString:@"S_DISCLOSE"]) {
        self.title = @"匿名通知";
        [_navBar setTitle:self.title];
    } else {
        self.title = @"股侠通知";
        [_navBar setTitle:self.title];
    }
    
    [self.view addSubview:self.tableView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self loadData];
}

#pragma mark requset

- (void)loadData {
    if (self.res_code.length) {
        [self.unreadListAPI start];
    }
}

- (void)requestFailed:(APIBaseRequest *)request {
    NSLog(@"failed");
}

- (void)requestFinished:(APIBaseRequest *)request {
    self.dataArray = [MTLJSONAdapter modelsOfClass:[MomentNoticeModel class] fromJSONArray:request.responseJSONObject error:nil];
    [self.tableView reloadData];
}

#pragma mark tableview

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 68 * kScale;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MomentNoticeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    cell.model = self.dataArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MomentNoticeModel *model = self.dataArray[indexPath.row];
    model.st = @"1";

    self.operationAPI.ids = model.ids;
    self.operationAPI.st = @"1";
    
    [self.operationAPI startWithCompletionBlockWithSuccess:^(__kindof APIBaseRequest *request) {
        NSLog(@"%@",request.responseJSONObject);
    } failure:^(__kindof APIBaseRequest *request) {
        NSLog(@"查看失败");
    }];
    
    NSLog(@"%@",model.fid);
    DetailWebViewController *viewController = [[DetailWebViewController alloc] init];
    viewController.type = WEB_VIEW_TYPE_COMMENT;
    NSString *url = [MarketConfig getUrlWithPath:model.url];
    viewController.myUrl = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        MomentNoticeModel *model = self.dataArray[indexPath.row];
        
        self.operationAPI.ids = model.ids;
        self.operationAPI.st = @"4";
        
        [self.operationAPI startWithCompletionBlockWithSuccess:^(__kindof APIBaseRequest *request) {
            NSLog(@"%@",request.responseJSONObject);
        } failure:^(__kindof APIBaseRequest *request) {
            NSLog(@"查看失败");
        }];
        
        NSMutableArray *nmArr = [NSMutableArray arrayWithArray:self.dataArray];
        [nmArr removeObject:model];
        self.dataArray = nmArr.copy;
        [self.tableView reloadData];
        
    }
}

#pragma mark  lazy

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, MAIN_SCREEN_WIDTH, MAIN_SCREEN_HEIGHT - 64) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.separatorColor = kUIColorFromRGB(0xe4e4e4);
        _tableView.separatorInset = UIEdgeInsetsMake(0, 60 * kScale, 0, 0);
        [_tableView registerClass:[MomentNoticeTableViewCell class] forCellReuseIdentifier:cellID];
    }
    return _tableView;
}

- (MomentUnreadOperAPI *)operationAPI {
    if (_operationAPI == nil) {
        _operationAPI = [MomentUnreadOperAPI new];
        _operationAPI.ids = @"";
        _operationAPI.st = @"1";
    }
    return _operationAPI;
}

- (MomentUnreadListAPI *)unreadListAPI {
    if (_unreadListAPI == nil) {
        _unreadListAPI = [MomentUnreadListAPI new];
        _unreadListAPI.delegate = self;
        _unreadListAPI.page = @"1";
        _unreadListAPI.count = @"1000";
        _unreadListAPI.res_code = self.res_code;
    }
    return _unreadListAPI;
}

@end
