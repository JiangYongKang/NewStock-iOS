//
//  BoardListViewController.m
//  NewStock
//
//  Created by Willey on 16/8/7.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "BoardListViewController.h"
#import "SystemUtil.h"
#import "MarketConfig.h"
#import "AppDelegate.h"

#import "BoardListAPI.h"
#import "Mantle.h"
#import "BoardListModel.h"
#import "BoardDetailListViewController.h"

#import "BlockTableViewCell.h"
#import "BoardListTitleCell.h"

@implementation BoardListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _mainView.backgroundColor = REFRESH_BG_COLOR;
    _navBar.hidden = YES;
    [_scrollView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(30, 0, 0, 0));
    }];
 
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WIDTH, 30)];
    topView.backgroundColor = kUIColorFromRGB(0xf1f1f1);
    [self.view addSubview:topView];
    
    int Xcenter = MAIN_SCREEN_WIDTH/2;
    
    UILabel *nameLb = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 100, 30)];
    nameLb.backgroundColor = [UIColor clearColor];
    nameLb.textColor = kUIColorFromRGB(0x666666);
    nameLb.font = [UIFont systemFontOfSize:12.0f];
    nameLb.text = @"名称";
    [topView addSubview:nameLb];
    
    UILabel *valueLb = [[UILabel alloc] initWithFrame:CGRectMake(Xcenter-75, 0, 150, 30)];
    valueLb.backgroundColor = [UIColor clearColor];
    valueLb.textColor = kUIColorFromRGB(0x666666);
    valueLb.font = [UIFont systemFontOfSize:12.0f];
    valueLb.text = @"涨跌幅";
    valueLb.textAlignment = NSTextAlignmentCenter;
    [topView addSubview:valueLb];
    
    UILabel *changeRateLb = [[UILabel alloc] initWithFrame:CGRectMake(MAIN_SCREEN_WIDTH-120, 0, 100, 30)];
    changeRateLb.backgroundColor = [UIColor clearColor];
    changeRateLb.textColor = kUIColorFromRGB(0x666666);
    changeRateLb.font = [UIFont systemFontOfSize:12.0f];
    changeRateLb.text = @"领涨股";
    changeRateLb.textAlignment = NSTextAlignmentRight;
    [topView addSubview:changeRateLb];
    
}

- (void)initRequestAPI {
    NSString *category;
    NSString *upDown = @"0";
    switch (self.BoardDetailType) {
        case BoardDetailType_10: {
            category = @"10";
            break;
        }
        case BoardDetailType_20: {
            category = @"20";
            break;
        }
        case BoardDetailType_30: {
            category = @"30";
            break;
        }
    }
    _listRequestAPI = [[BoardListAPI alloc] initWithCategory:category upDown:upDown fromNo:1 toNo:PAGE_COUNT];
}

- (Class)getModelClass {
    return [BoardListModel class];
}

- (void)analyzeData:(id)responseJSONObject {
    //上涨、下跌、平盘
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
    BlockTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    
    if (cell==nil)
    {
        cell=[[BlockTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }

    long index=[indexPath row];

    BoardListModel *model = [_resultListArray objectAtIndex:index];
    
    [cell setName:model.industryName changeRate:[SystemUtil getPercentage:[model.industryUp doubleValue]]];
    
    
    NSString *leadingStock = model.leadingStock;
    NSArray *array = [leadingStock componentsSeparatedByString:@":"];
    NSString *leadingStockCode = @"";
    if ([array count]>3)
    {
        leadingStockCode = [array objectAtIndex:1];
    }
    
    NSString *d = model.leadingStockName;
    NSArray *array2 = [d componentsSeparatedByString:@":"];
    NSString *leadingStockName = @"";
    if ([array2 count]>1)
    {
        leadingStockName = [array2 objectAtIndex:0];
    }
    [cell setLeadingStockName:leadingStockName LeadingStockCode:leadingStockCode];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_resultListArray.count == 0) {
        return;
    }
    long index = indexPath.row;
    BoardListModel *model = [_resultListArray objectAtIndex:index];
    if (model.industryName.length == 0) {
        return;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    BoardDetailListViewController *viewController = [[BoardDetailListViewController alloc] init];
    viewController.title = model.industryName;
    viewController.boardListModel = model;
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate.navigationController pushViewController:viewController animated:YES];
}

@end
