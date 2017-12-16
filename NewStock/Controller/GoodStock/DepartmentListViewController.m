//
//  DepartmentListViewController.m
//  NewStock
//
//  Created by 王迪 on 2017/2/24.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "DepartmentListViewController.h"
#import "TaoSearchStockViewController.h"
#import "DepartmentListCell.h"
#import "AppDelegate.h"

static NSString *cellID = @"DepartmentCellID";

@interface DepartmentListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation DepartmentListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_mainView removeFromSuperview];
    [_scrollView removeFromSuperview];
    _navBar.hidden = YES;
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)setDataArray:(NSArray *)dataArray {
    _dataArray = dataArray;
    [self.tableView reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 49 * kScale;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 32 * kScale;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WIDTH, 32 * kScale)];
    view.backgroundColor = kUIColorFromRGB(0xf1f1f1);
    
    UILabel *lb1 = [UILabel new];
    lb1.text = @"上榜个股";
    lb1.textColor = kUIColorFromRGB(0x666666);
    lb1.font = [UIFont systemFontOfSize:12 * kScale];
    
    UILabel *lb2 = [UILabel new];
    lb2.text = @"当日行情";
    lb2.textColor = kUIColorFromRGB(0x666666);
    lb2.font = [UIFont systemFontOfSize:12 * kScale];
    
    UILabel *lb3 = [UILabel new];
    lb3.text = @"类别";
    lb3.textColor = kUIColorFromRGB(0x666666);
    lb3.font = [UIFont systemFontOfSize:12 * kScale];
    
    UILabel *lb4 = [UILabel new];
    lb4.text = @"买卖金额(万)";
    lb4.textColor = kUIColorFromRGB(0x666666);
    lb4.font = [UIFont systemFontOfSize:12 * kScale];
    
    [view addSubview:lb1];
    [view addSubview:lb2];
    [view addSubview:lb3];
    [view addSubview:lb4];
    
    [lb1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(view);
        make.left.equalTo(view).offset(15 * kScale);
    }];
    
    [lb2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(view);
        make.right.equalTo(view.mas_centerX).offset(-23 * kScale);
    }];
    
    [lb3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(view);
        make.left.equalTo(view.mas_centerX).offset(34 * kScale);
    }];
    
    [lb4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(view);
        make.right.equalTo(view).offset(-15 * kScale);
    }];
    
    return view;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    DepartmentListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    cell.model = self.dataArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WIDTH, MAIN_SCREEN_HEIGHT) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.separatorInset = UIEdgeInsetsMake(0, 15 * kScale, 0, 15 * kScale);
        [_tableView registerClass:[DepartmentListCell class] forCellReuseIdentifier:cellID];
    }
    return _tableView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TaoSearchDepartmentListModel *model = self.dataArray[indexPath.row];
    
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    TaoSearchStockViewController *vc = [TaoSearchStockViewController new];
    vc.t = model.t;
    vc.s = model.s;
    vc.m = model.m;
    vc.n = model.n;
    vc.d = @"";
    
    [delegate.navigationController pushViewController:vc animated:YES];
    
}

@end
