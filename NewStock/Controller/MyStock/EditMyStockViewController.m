//
//  EditMyStockViewController.m
//  NewStock
//
//  Created by Willey on 16/8/25.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "EditMyStockViewController.h"
#import "MarketConfig.h"
#import "StockTableViewCell.h"
#import "StockHistoryUtil.h"
#import "MJChiBaoZiHeader.h"
#import "StockListModel.h"
#import "IndexChartViewController.h"
#import "AppDelegate.h"
#import "SearchViewController.h"

@interface EditMyStockViewController ()
{
    MyStockTitle *_headerView;
}

@end

@implementation EditMyStockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"编辑自选";
    [_navBar setTitle:self.title];
    
    [_navBar setRightBtnTitle1:@"添加" title2:@"清空"];
    [_scrollView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(NAV_BAR_HEIGHT, 0, 0, 0));
    }];
    [_scrollView layoutIfNeeded];
    _scrollView.backgroundColor = REFRESH_BG_COLOR;

    NSMutableArray *array = [StockHistoryUtil getMyStock];
    _myStockArray = [[NSMutableArray alloc] init];
    [_myStockArray addObjectsFromArray:array];
    
    _tableView = [[UITableView alloc] init];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorInset = UIEdgeInsetsMake(0, 15, 0, 15);
    _tableView.tableFooterView = [UIView new];
    _tableView.backgroundColor = [UIColor clearColor];
    [_mainView addSubview:_tableView];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_tableView.superview).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    [_tableView setEditing:!_tableView.editing animated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self loadData];
}

- (void)navBar:(NavBar*)navBar rightButton1Tapped:(UIButton*)sender {
    SearchViewController *viewController = [[SearchViewController alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];

}

- (void)navBar:(NavBar*)navBar rightButton2Tapped:(UIButton*)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您确定要清空自选股？"
                                                   delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
    alert.tag = 101;
    [alert show];
}

#pragma mark - UIAlertDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if(alertView.tag == 101)
    {
        if(buttonIndex == 0)
        {
            
            [StockHistoryUtil cleanAllMyStock];
            [self loadData];

        }
    }
}

#pragma mark - loadData
- (void)loadData {
    //[_resultListArray removeAllObjects];
    
    NSMutableArray *array = [StockHistoryUtil getMyStock];
    [_myStockArray removeAllObjects];
    [_myStockArray addObjectsFromArray:array];
    
    [_tableView reloadData];

}

#pragma UITableView

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return MARKET_CELL_HEIGHT;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 35 * kScale;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    _headerView = [[MyStockTitle alloc] initWithFrame:CGRectZero];
     [_headerView setName:@"股票/代码" value:@" " changeRate:@" "];
    _headerView.delegate = self;
    _headerView.tag = 0;
    UIView *v = [_headerView valueForKeyPath:@"_sortBtn"];
    v.hidden = YES;
    return _headerView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_myStockArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellid=@"stockTableViewCell";
    StockTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (cell == nil)
    {
        cell = [[StockTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    
    NSInteger row = [indexPath row];
    
    StockCodeInfo *item = [_myStockArray objectAtIndex:row];
    
    [cell setCode:item.s name:item.n marketCd:item.m];
    
    return cell;
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        //更新数据
        StockCodeInfo *item = [_myStockArray objectAtIndex:indexPath.row];

        [StockHistoryUtil deleteMyStock:item.s symbolName:item.n symbolTyp:item.t marketCd:item.m];
        
        [_myStockArray removeObjectAtIndex:indexPath.row];
        //更新UI
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        [_tableView reloadData];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        
    }
}

- (UITableViewCellEditingStyle )tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    [StockHistoryUtil moveObjectAtIndex:sourceIndexPath.row atIndex:destinationIndexPath.row];
    
    [self loadData];
}

- (void)myStockTitle:(MyStockTitle *)cell selectedIndex:(NSUInteger)index {
    [_tableView setEditing:!_tableView.editing animated:YES];
    
    [_tableView reloadData];
}

@end
