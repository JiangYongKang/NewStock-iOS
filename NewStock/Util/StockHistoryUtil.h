//
//  StockHistoryUtil.h
//  NewStock
//
//  Created by Willey on 16/8/15.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StockCodesModel.h"


//添加自选股状态返回
typedef NS_ENUM(NSInteger, ADD_STOCK_STATU) {
    ADD_STOCK_FALSE,
    ADD_STOCK_SUC,
    ADD_STOCK_FULL,
    ADD_STOCK_EXIST
    
};


@interface StockHistoryUtil : NSObject

+ (void)initMyStock;

+ (NSString *)getStockCodesPath;
+ (NSString *)getStockDepartsmentPath;
+ (NSString *)getMyStockPath;
+ (NSString *)getallUserPath;
+ (NSString *)getStockHistoryPath;

+ (BOOL)addStockToHistory:(NSString *)symbol symbolName:(NSString *)symbolName symbolTyp:(NSString *)symbolTyp marketCd:(NSString *)marketCd;
+ (BOOL)addStockToHistory:(StockCodeInfo *)model;
+ (NSMutableArray *)getStockHistory;
+ (BOOL)searchStockFromHistory:(StockCodeInfo *)model;

+ (ADD_STOCK_STATU)addStockToMyStock:(NSString *)symbol symbolName:(NSString *)symbolName symbolTyp:(NSString *)symbolTyp marketCd:(NSString *)marketCd;
+ (ADD_STOCK_STATU)addStockToMyStock:(StockCodeInfo *)model;
+ (NSMutableArray *)getMyStock;
+ (void)getMyStockFromServer;
+ (BOOL)searchStockFromMyStock:(StockCodeInfo *)model;
+ (BOOL)searchStockFromMyStock:(NSString *)symbol symbolTyp:(NSString *)symbolTyp marketCd:(NSString *)marketCd;
+ (void)deleteMyStock:(NSString *)symbol symbolName:(NSString *)symbolName symbolTyp:(NSString *)symbolTyp marketCd:(NSString *)marketCd;
+ (void)cleanAllMyStock;

+ (void)exchangeObjectAtIndex:(NSUInteger)i withObjectAtIndex:(NSUInteger)ii;
+ (void)moveObjectAtIndex:(NSUInteger)i atIndex:(NSUInteger)ii;



@end
