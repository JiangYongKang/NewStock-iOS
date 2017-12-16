//
//  StockBoardViewController.m
//  NewStock
//
//  Created by Willey on 16/7/23.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "StockBoardViewController.h"
#import "BlockTableViewCell.h"
#import "MarketConfig.h"
#import "AppDelegate.h"
#import "BoardListAPI.h"
#import "BoardListModel.h"
#import "BoardDetailListViewController.h"
#import "BoardListViewController.h"

#import "MJChiBaoZiHeader.h"

@interface StockBoardViewController ()
{
    BoardListAPI *_boardListAPI;
    BoardListAPI *_boardListAPI2;
    BoardListAPI *_boardListAPI3;
    
    
    NSMutableArray *_boardListArray;
    NSMutableArray *_boardListArray2;
    NSMutableArray *_boardListArray3;
}
@end

@implementation StockBoardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    int padding1 = 5;
    
    [_mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_scrollView);
        make.width.equalTo(_scrollView);
        make.height.mas_equalTo(MARKET_CELL_HEIGHT*15+30*3+padding1);
        //make.height.equalTo(_scrollView).multipliedBy(2.5);
        
    }];
    [_scrollView layoutIfNeeded];//
    
    
    _tableview = [[SKSTableView alloc] init];
    _tableview.SKSTableViewDelegate = self;
    [_mainView addSubview:_tableview];
    [_tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_tableview.superview).with.insets(UIEdgeInsetsMake(0,0,0,0));
        
    }];
    _tableview.bounces = NO;
    
   
    _boardListAPI = [[BoardListAPI alloc] initWithCategory:@"10" upDown:@"0" fromNo:1 toNo:5];
    _boardListAPI2 = [[BoardListAPI alloc] initWithCategory:@"30" upDown:@"0" fromNo:1 toNo:5];
    _boardListAPI3 = [[BoardListAPI alloc] initWithCategory:@"20" upDown:@"0" fromNo:1 toNo:5];

    
    
    _boardListArray = [[NSMutableArray alloc] init];
    _boardListArray2 = [[NSMutableArray alloc] init];
    _boardListArray3 = [[NSMutableArray alloc] init];
    
    
    _scrollView.mj_header = [MJChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];

}


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (NSInteger)tableView:(SKSTableView *)tableView numberOfSubRowsAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0)
    {
        return 5;
        //return [_boardListArray count];
    }
    else if(indexPath.row == 1)
    {
        return 5;
        //return [_boardListArray2 count];
    }
    else if(indexPath.row == 2)
    {
        return 5;
        //return [_boardListArray3 count];
    }
    
    return 0;
}

- (BOOL)tableView:(SKSTableView *)tableView shouldExpandSubRowsOfCellAtIndexPath:(NSIndexPath *)indexPath {
    
    return YES;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"StockTitleTableViewCell";
    
    StockTitleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell)
    {
        cell = [[StockTitleTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.delegate = self;
    }
    
    switch (indexPath.row)
    {
        case 0:
            cell.textLabel.text = @"热点概念";
            break;
        case 1:
            cell.textLabel.text = @"热点行业";
            break;
        case 2:
            cell.textLabel.text = @"地区板块";
            break;
            
        default:
            cell.textLabel.text = @"";
            
            break;
    }
    //cell.expandable = YES;
    cell.tag = indexPath.row;
    cell.textLabel.font = [UIFont systemFontOfSize:12];
    cell.textLabel.textColor = [UIColor darkGrayColor];
    
    cell.expandedColor = kUIColorFromRGB(0x358ee7);
    cell.planColor = kUIColorFromRGB(0x666666);
    
//    [[cell layer] setBorderWidth:0.5];
//    [[cell layer] setBorderColor:SEP_LINE_COLOR.CGColor];
    return cell;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForSubRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"UITableViewCell";
    
    BlockTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell)
        cell = [[BlockTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
    //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    long index = indexPath.subRow-1;
    BoardListModel *model;
    if (indexPath.row == 0)
    {
        if ([_boardListArray count]<5)
        {
            model = nil;
        }
        else
        {
            model = [_boardListArray objectAtIndex:index];
        }
    }
    else if (indexPath.row == 1)
    {
        if ([_boardListArray2 count]<5)
        {
            model = nil;
        }
        else
        {
            model = [_boardListArray2 objectAtIndex:index];
        }
    }
    else if (indexPath.row == 2)
    {
        if ([_boardListArray3 count]<5)
        {
            model = nil;
        }
        else
        {
            model = [_boardListArray3 objectAtIndex:index];
        }
    }
    
    if (model) {
        [cell setName:model.industryName changeRate:[SystemUtil getPercentage:[model.industryUp doubleValue]]];
    }
    else
    {
        [cell setName:@"--" changeRate:@"--"];
    }
    
    return cell;
}

- (CGFloat)tableView:(SKSTableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 30;
}

- (CGFloat)tableView:(SKSTableView *)tableView heightForSubRowAtIndexPath:(NSIndexPath *)indexPath {
    return MARKET_CELL_HEIGHT;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

}

- (void)tableView:(SKSTableView *)tableView didSelectSubRowAtIndexPath:(NSIndexPath *)indexPath {

    
    long index = indexPath.subRow-1;
    //BoardListModel *model = [_boardListArray objectAtIndex:index];
    BoardListModel *model;
    if (indexPath.row == 0)
    {
        if ([_boardListArray count]<5)
        {
            model = nil;
        }
        else
        {
            model = [_boardListArray objectAtIndex:index];
        }
    }
    else if (indexPath.row == 1)
    {
        if ([_boardListArray2 count]<5)
        {
            model = nil;
        }
        else
        {
            model = [_boardListArray2 objectAtIndex:index];
        }
    }
    else if (indexPath.row == 2)
    {
        if ([_boardListArray3 count]<5)
        {
            model = nil;
        }
        else
        {
            model = [_boardListArray3 objectAtIndex:index];
        }
    }
    
    
    if (model) {
        if (model.industryName.length == 0) {
            return;
        }
        BoardDetailListViewController *viewController = [[BoardDetailListViewController alloc] init];
        viewController.title = model.industryName;
        viewController.boardListModel = model;
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        [appDelegate.navigationController pushViewController:viewController animated:YES];
    }
    
}

#pragma mark - Actions
- (void)stockTitleTableViewCell:(StockTitleTableViewCell*)cell selectedIndex:(NSUInteger)index {
    
    BoardListViewController *viewController = [[BoardListViewController alloc] init];
    
    switch (index)
    {
        case 0:
            viewController.title = @"热点概念";
            viewController.BoardDetailType = BoardDetailType_10;
            break;
        case 1:
            viewController.title = @"热点行业";
            viewController.BoardDetailType = BoardDetailType_30;
            break;
        case 2:
            viewController.title = @"地区板块";
            viewController.BoardDetailType = BoardDetailType_20;
            break;
            
        default:
            viewController.title = @"热点概念";
            viewController.BoardDetailType = BoardDetailType_10;
            break;
    }
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate.navigationController pushViewController:viewController animated:YES];
}

- (void)loadData {
    _boardListAPI.ignoreCache = YES;
    //    _boardListAPI.animatingText = @"正在加载";
    //    _boardListAPI.animatingView = self.view;
    [_boardListAPI startWithCompletionBlockWithSuccess:^(APIBaseRequest *request) {
        NSArray *array = [_boardListAPI.responseJSONObject objectForKey:@"rankingLst"];
        [_boardListArray removeAllObjects];
        NSArray *modelArray = [MTLJSONAdapter modelsOfClass:[BoardListModel class] fromJSONArray:array error:nil];
        [_boardListArray addObjectsFromArray:modelArray];
        //[_tableview refreshData];
        [_tableview reloadData];

        [_scrollView.mj_header endRefreshing];

    } failure:^(APIBaseRequest *request) {
        NSLog(@"failed");
        [_scrollView.mj_header endRefreshing];

    }];
    
    //2
    [_boardListAPI2 startWithCompletionBlockWithSuccess:^(APIBaseRequest *request) {
        NSArray *array = [_boardListAPI2.responseJSONObject objectForKey:@"rankingLst"];
        [_boardListArray2 removeAllObjects];
        NSArray *modelArray = [MTLJSONAdapter modelsOfClass:[BoardListModel class] fromJSONArray:array error:nil];
        [_boardListArray2 addObjectsFromArray:modelArray];
        //[_tableview refreshData];
        [_tableview reloadData];

    } failure:^(APIBaseRequest *request) {
        NSLog(@"failed");
    }];
    
    //3
    [_boardListAPI3 startWithCompletionBlockWithSuccess:^(APIBaseRequest *request) {
        NSArray *array = [_boardListAPI3.responseJSONObject objectForKey:@"rankingLst"];
        [_boardListArray3 removeAllObjects];
        NSArray *modelArray = [MTLJSONAdapter modelsOfClass:[BoardListModel class] fromJSONArray:array error:nil];
        [_boardListArray3 addObjectsFromArray:modelArray];
        //[_tableview refreshData];
        [_tableview reloadData];

    } failure:^(APIBaseRequest *request) {
        NSLog(@"failed");
    }];
}

@end
