//
//  StockListViewController.m
//  NewStock
//
//  Created by Willey on 16/7/28.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "StockListViewController.h"
#import "StockTableViewCell.h"
#import "MarketConfig.h"
#import "StockListTitleCell.h"
#import "BoardDetailTitleCell.h"
#import "SystemUtil.h"
#import "AppDelegate.h"

#import "RankListAPI.h"
#import "Mantle.h"
#import "StockListModel.h"

#import "StockChartViewController.h"

@interface StockListViewController () {

    UILabel *_changeRateLb;
}

@end

@implementation StockListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _navBar.line_view.hidden = YES;
    
    [_scrollView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(NAV_BAR_HEIGHT + 30, 0, 0, 0));
    }];
    
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, MAIN_SCREEN_WIDTH, 30)];
    topView.backgroundColor = kUIColorFromRGB(0xf1f1f1);
    [self.view addSubview:topView];
    
    int Xcenter = MAIN_SCREEN_WIDTH/2;
    
    UILabel *nameLb = [[UILabel alloc] initWithFrame:CGRectMake(12, 0, 100, 30)];
    nameLb.backgroundColor = [UIColor clearColor];
    nameLb.textColor = kUIColorFromRGB(0x666666);//[UIColor darkGrayColor];
    nameLb.font = [UIFont systemFontOfSize:12.0f];
    nameLb.text = @"名称/代码";
    [topView addSubview:nameLb];
    
    UILabel *valueLb = [[UILabel alloc] initWithFrame:CGRectMake(Xcenter-75, 0, 150, 30)];
    valueLb.backgroundColor = [UIColor clearColor];
    valueLb.textColor = kUIColorFromRGB(0x666666);//[UIColor darkGrayColor];
    valueLb.font = [UIFont systemFontOfSize:12.0f];
    valueLb.text = @"最新价";
    valueLb.textAlignment = NSTextAlignmentCenter;
    [topView addSubview:valueLb];
    
    _changeRateLb = [[UILabel alloc] initWithFrame:CGRectMake(MAIN_SCREEN_WIDTH - 117, 0, 100, 30)];
    _changeRateLb.backgroundColor = [UIColor clearColor];
    _changeRateLb.textColor = kUIColorFromRGB(0x666666);//[UIColor darkGrayColor];
    _changeRateLb.font = [UIFont systemFontOfSize:12.0f];
    _changeRateLb.textAlignment = NSTextAlignmentRight;
    [topView addSubview:_changeRateLb];
    
    switch (self.RankType) {
        case RankType_ZF: {
            _changeRateLb.text = @"涨幅";
            break;
        }
        case RankType_DF: {
            _changeRateLb.text = @"跌幅";
            break;
        }
        case RankType_5MIN: {
            _changeRateLb.text = @"5分钟涨幅";
            break;
        }
        case RankType_VOLUME: {
            _changeRateLb.text = @"成交额";
            break;
        }
        case RankType_TURNOVER: {
            _changeRateLb.text = @"换手率";
            break;
        }
    }
    
}

- (void)initRequestAPI {
    NSString *rankName;
    NSString *upDown;
    switch (self.RankType) {
        case RankType_ZF: {
            rankName = @"03";
            upDown = @"0";
            break;
        }
        case RankType_DF: {
            rankName = @"03";
            upDown = @"1";
            break;
        }
        case RankType_5MIN: {
            rankName = @"02";
            upDown = @"0";
            break;
        }
        case RankType_VOLUME: {
            rankName = @"07";
            upDown = @"0";
            break;
        }
        case RankType_TURNOVER: {
            rankName = @"05";
            upDown = @"0";
            break;
        }
    }
    
    _listRequestAPI = [[RankListAPI alloc] initWithRankName:rankName upDown:upDown fromNo:1 toNo:PAGE_COUNT];
}

- (Class)getModelClass {
    return [StockListModel class];
}

- (void)requestFailed:(APIBaseRequest *)request {
    NSLog(@"failed");
}

#pragma UITableView
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (indexPath.row == 0)
//    {
//        return 30;
//    }
//    else
//    {
    return MARKET_CELL_HEIGHT;
//    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_resultListArray count];//+1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (indexPath.row == 0)
//    {
//        static NSString *cellid=@"stockListTitleCell";
//        StockListTitleCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//        
//        if (cell==nil)
//        {
//            cell=[[StockListTitleCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
//        }
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        
//        if(self.RankType == RankType_VOLUME)
//        {
//            [cell setName:@"名称/代码" value:@"最新价" changeRate:@"成交额"];
//
//        }
//        else if(self.RankType == RankType_TURNOVER)
//        {
//            [cell setName:@"名称/代码" value:@"最新价" changeRate:@"换手率"];
//
//        }
//        else if(self.RankType == RankType_DF)
//        {
//            [cell setName:@"名称/代码" value:@"最新价" changeRate:@"跌幅"];
//        }
//        else if(self.RankType == RankType_5MIN)
//        {
//            [cell setName:@"名称/代码" value:@"最新价" changeRate:@"5分钟涨幅"];
//        }
//        else
//        {
//            [cell setName:@"名称/代码" value:@"最新价" changeRate:@"涨幅"];
//        }
//
//        cell.backgroundColor = kUIColorFromRGB(0xf1f1f1);
////        [[cell layer] setBorderWidth:0.5];
////        [[cell layer] setBorderColor:SEP_LINE_COLOR.CGColor];
//        return cell;
//    }
//    else
//    {
        static NSString *cellid=@"stockTableViewCell";
        StockTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        
        if (cell==nil)
        {
            cell=[[StockTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        }
//        if([_resultListArray count]<=indexPath.row-1)return cell;

        long index=[indexPath row] ;
        StockListModel *model = [_resultListArray objectAtIndex:index];

        [cell setCode:model.symbol name:model.symbolName value:model.consecutivePresentPrice changeRate:[SystemUtil getPercentage:[model.tradeIncrease doubleValue]] marketCd:model.marketCd];

        if(self.RankType == RankType_VOLUME)
        {
            [cell setVoluem:model.volumePrice];
        }
        else if(self.RankType == RankType_TURNOVER)
        {
            [cell setTurnover:model.turnover];
        }
        else if(self.RankType == RankType_5MIN)
        {
            [cell setMin5UpDown:[SystemUtil getPercentage:[model.min5UpDown doubleValue]]];
        }
        
        return cell;
//    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    long index = indexPath.row;
    StockListModel *model = [_resultListArray objectAtIndex:index];

    if (!(model.symbolTyp && model.symbol && model.marketCd && model.symbolName)) {
        return;
    }
    StockChartViewController *viewController = [[StockChartViewController alloc] init];
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    

    viewController.stockListModel = model;
    [appDelegate.navigationController pushViewController:viewController animated:YES];
}


@end
