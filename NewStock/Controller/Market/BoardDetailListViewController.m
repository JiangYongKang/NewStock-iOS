//
//  BoardDetailListViewController.m
//  NewStock
//
//  Created by Willey on 16/8/7.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "BoardDetailListViewController.h"
#import "SystemUtil.h"
#import "MarketConfig.h"
#import "AppDelegate.h"

#import "BoardDetailsAPI.h"
#import "Mantle.h"
#import "StockListModel.h"

#import "BoardDetailTitleCell.h"
#import "StockTableViewCell.h"

#import "StockChartViewController.h"

@implementation BoardDetailListViewController


- (void)initRequestAPI {
    _resultListName = @"symbolDetailsLst";
    
    _listRequestAPI = [[BoardDetailsAPI alloc] initWithSectorSymbolTyp:_boardListModel.symbolTyp sectorSymbol:_boardListModel.symbol sectorMarketCd:_boardListModel.marketCd fromNo:1 toNo:PAGE_COUNT sortTermKbn:@"tradeIncrease" sortOrderKbn:@"2"];
}
- (Class)getModelClass {
    return [StockListModel class];
}
- (void)analyzeData:(id)responseJSONObject {
    //上涨、下跌、平盘
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
        static NSString *cellid=@"boardDetailTitleCell";
        BoardDetailTitleCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        
        if (cell==nil)
        {
            cell=[[BoardDetailTitleCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        if(_boardListModel.riseCount&&_boardListModel.fallCount&&_boardListModel.keepCount)
            [cell setUp:_boardListModel.riseCount down:_boardListModel.fallCount plan:_boardListModel.keepCount];
        
        cell.backgroundColor = kUIColorFromRGB(0xf1f1f1);
//        [[cell layer] setBorderWidth:0.5];
//        [[cell layer] setBorderColor:SEP_LINE_COLOR.CGColor];
        return cell;
        
        
    }
    else
    {
        static NSString *cellid=@"stockTableViewCell";
        StockTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        
        
        if (cell==nil)
        {
            cell=[[StockTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        }
        if([_resultListArray count]<=indexPath.row-1)return cell;

        long index=[indexPath row] -1;
        StockListModel *model = [_resultListArray objectAtIndex:index];
        
        [cell setCode:model.symbol name:model.symbolName value:model.presentPrice changeRate:[SystemUtil getPercentage:[model.tradeIncrease doubleValue]] marketCd:model.marketCd];
        
        return cell;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if([_resultListArray count]<=indexPath.row-1)return;
    
    long index = indexPath.row-1;
    StockListModel *model = [_resultListArray objectAtIndex:index];
    
    if (!(model.symbol && model.marketCd && model.symbolTyp && model.symbolName)) {
        return;
    }

    StockChartViewController *viewController = [[StockChartViewController alloc] init];
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    viewController.stockListModel = model;
    
    [appDelegate.navigationController pushViewController:viewController animated:YES];
}

@end
