//
//  StockListViewController.h
//  NewStock
//
//  Created by Willey on 16/7/28.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "BaseTableViewController.h"

typedef NS_ENUM(NSInteger , StockListType) {
    StockListType_Normal_Rank = 0,
    StockListType_Board_Detail
};

typedef NS_ENUM(NSInteger , RankType) {
    RankType_ZF = 0,
    RankType_DF,
    RankType_5MIN,
    RankType_VOLUME,
    RankType_TURNOVER
};

@interface StockListViewController : BaseTableViewController
{
    
}
@property (nonatomic, assign) StockListType StockListType;

@property (nonatomic, assign) RankType RankType;

@end
