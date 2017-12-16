//
//  StockHistoryUtil.m
//  NewStock
//
//  Created by Willey on 16/8/15.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "StockHistoryUtil.h"
#import "MarketConfig.h"
#import "SystemUtil.h"
#import "UMMobClick/MobClick.h"
#import "Defination.h"
#import "MyStockInfoInstance.h"

@implementation StockHistoryUtil


+ (void)initMyStock
{
    NSString *initMyStock = [SystemUtil getCache:@"HasInitMyStock"];
    if ([initMyStock isEqualToString:@"initMyStock"])
    {
        
    }
    else
    {
        //NSMutableArray *array = [[NSMutableArray alloc] init];
        
        //{"t":1,"s":"000001","m":1,"n":"上证指数","p":"szzs","d":2,"h":0,"r":"0","th":"0"}
        StockCodeInfo *model = [[StockCodeInfo alloc] init];
        model.t = @"1";
        model.s = @"000001";
        model.m = @"1";
        model.n = @"上证指数";
        //[array addObject:model];
        
        [StockHistoryUtil addStockToMyStock:model];
        
        //{"t":1,"s":"399001","m":2,"n":"深证成指","p":"szcz","d":2,"h":0,"r":"0","th":"0"}
        StockCodeInfo *model2 = [[StockCodeInfo alloc] init];
        model2.t = @"1";
        model2.s = @"399001";
        model2.m = @"2";
        model2.n = @"深证成指";
        //[array addObject:model2];
        
        [StockHistoryUtil addStockToMyStock:model2];

        [SystemUtil putCache:@"HasInitMyStock" value:@"initMyStock"];

    }
}

+ (NSString *)getStockCodesPath
{
    NSString *pathOfLibrary = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path = [pathOfLibrary stringByAppendingPathComponent:@"stockCodes"];
    return path;
}

+ (NSString *)getallUserPath
{
    NSString *pathOfLibrary = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path = [pathOfLibrary stringByAppendingPathComponent:@"allUser"];
    return path;
}

+ (NSString *)getStockDepartsmentPath
{
    NSString *pathOfLibrary = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path = [pathOfLibrary stringByAppendingPathComponent:@"stockDepartments"];
    return path;
}

+ (NSString *)getMyStockPath
{
    NSString *pathOfLibrary = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path = [pathOfLibrary stringByAppendingPathComponent:@"myStock"];
    return path;
}

+ (NSString *)getStockHistoryPath
{
    NSString *pathOfLibrary = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path = [pathOfLibrary stringByAppendingPathComponent:@"stockHistory"];
    return path;
}
//History
+ (BOOL)addStockToHistory:(NSString *)symbol symbolName:(NSString *)symbolName symbolTyp:(NSString *)symbolTyp marketCd:(NSString *)marketCd
{
    StockCodeInfo *model = [[StockCodeInfo alloc] init];
    model.t = symbolTyp;
    model.s = symbol;
    model.m = marketCd;
    model.n = symbolName;
    
    return [StockHistoryUtil addStockToHistory:model];
}

+ (BOOL)addStockToHistory:(StockCodeInfo *)model
{
    NSString *path = [StockHistoryUtil getStockHistoryPath];
    NSMutableArray *array = [StockHistoryUtil getStockHistory];
    
    if(array == nil)array = [[NSMutableArray alloc] init];
    
    //检查是否已存在
    for (int i = 0; i < [array count]; i ++)
    {
        StockCodeInfo *item = [array objectAtIndex:i];
        if (([item.s isEqualToString:model.s ])
            &&([item.m intValue] == [model.m intValue])
            &&([item.t intValue] == [model.t intValue]))
        {
            [array removeObjectAtIndex:i];
        }
    }
    
    [array insertObject:model atIndex:0];
    //[array addObject:model];
    
    if ([array count] > HIS_STOCK_MAX_NUM)
    {
        [array removeLastObject];
    }

    BOOL b = [NSKeyedArchiver archiveRootObject:array toFile:path];

    return b;
}
+ (NSMutableArray *)getStockHistory
{
    NSString *path = [StockHistoryUtil getStockHistoryPath];
    NSMutableArray *array = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    return array;
}
+ (BOOL)searchStockFromHistory:(StockCodeInfo *)model
{
    NSMutableArray *array = [StockHistoryUtil getStockHistory];
    for (int i=0; i< [array count]; i++)
    {
        StockCodeInfo *item = [array objectAtIndex:i];
        if (([item.s isEqualToString:model.s ])
            &&([item.m intValue] == [model.m intValue])
            &&([item.t intValue] == [model.t intValue]))
        {
            return YES;
        }
    }
    return NO;
}


//My Stock
+ (ADD_STOCK_STATU)addStockToMyStock:(NSString *)symbol symbolName:(NSString *)symbolName symbolTyp:(NSString *)symbolTyp marketCd:(NSString *)marketCd
{
    StockCodeInfo *model = [[StockCodeInfo alloc] init];
    model.t = symbolTyp;
    model.s = symbol;
    model.m = marketCd;
    model.n = symbolName;
    
    return [StockHistoryUtil addStockToMyStock:model];
}

+ (ADD_STOCK_STATU)addStockToMyStock:(StockCodeInfo *)model
{
    //事件统计
    NSDictionary *dict = @{@"name":model.n};
    [MobClick event:ADD_MY_STOCK attributes:dict];
    
    
    
    NSString *path = [StockHistoryUtil getMyStockPath];

    NSMutableArray *array = [StockHistoryUtil getMyStock];
    if(array == nil)array = [[NSMutableArray alloc] init];
    //[array addObject:model];
    [array insertObject:model atIndex:0];
    
    if ([StockHistoryUtil searchStockFromMyStock:model])
    {
        return ADD_STOCK_EXIST;
    }
        
    if ([array count]>MY_STOCK_MAX_NUM)
    {
        return ADD_STOCK_FULL;
    }
    [[MyStockInfoInstance sharedMyStockInfoInstance]addStockWith:model];
    BOOL b = [NSKeyedArchiver archiveRootObject:array toFile:path];
    
    if (b)
    {
        return ADD_STOCK_SUC;
    }
    else
    {
        return ADD_STOCK_FALSE;
    }
}

+ (NSMutableArray *)getMyStock
{
    NSString *path = [StockHistoryUtil getMyStockPath];
    NSMutableArray *array = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    return array;
}

+ (void)getMyStockFromServer {
    
    [[MyStockInfoInstance sharedMyStockInfoInstance]getAllMyStock:^(NSArray *arr) {
        if (arr != nil) {
            [NSKeyedArchiver archiveRootObject:arr toFile:[self getMyStockPath]];
        }
    }];
    
}

+ (BOOL)searchStockFromMyStock:(StockCodeInfo *)model
{
    NSMutableArray *array = [StockHistoryUtil getMyStock];
    for (int i=0; i< [array count]; i++)
    {
        StockCodeInfo *item = [array objectAtIndex:i];
        if (([item.s isEqualToString:model.s ])
            &&([item.m intValue] == [model.m intValue])
            &&([item.t intValue] == [model.t intValue]))
        {
            return YES;
        }
    }
    return NO;
}

+ (BOOL)searchStockFromMyStock:(NSString *)symbol symbolTyp:(NSString *)symbolTyp marketCd:(NSString *)marketCd
{
    NSMutableArray *array = [StockHistoryUtil getMyStock];
    for (int i=0; i< [array count]; i++)
    {
        StockCodeInfo *item = [array objectAtIndex:i];
        if (([item.s isEqualToString:symbol ])
            &&([item.m intValue] == [marketCd intValue])
            &&([item.t intValue] == [symbolTyp intValue]))
        {
            return YES;
        }
    }
    return NO;
}

+ (void)deleteMyStock:(NSString *)symbol symbolName:(NSString *)symbolName symbolTyp:(NSString *)symbolTyp marketCd:(NSString *)marketCd
{
    NSMutableArray *array = [StockHistoryUtil getMyStock];
    
    for (int i=0; i< [array count]; i++)
    {
        StockCodeInfo *item = [array objectAtIndex:i];
        if (([item.s isEqualToString:symbol ])
            &&([item.m intValue] == [marketCd intValue])
            &&([item.t intValue] == [symbolTyp intValue]))
        {
            [array removeObjectAtIndex:i];
            
            NSString *path = [StockHistoryUtil getMyStockPath];

            [[MyStockInfoInstance sharedMyStockInfoInstance]deleteStockWith:item];
            BOOL b = [NSKeyedArchiver archiveRootObject:array toFile:path];
            NSLog(@"delete my stock:%d",b);
            
            //事件统计
            NSDictionary *dict = @{@"name":item.n};
            [MobClick event:DEL_MY_STOCK attributes:dict];
            
            
            return;
        }
    }
}

+ (void)cleanAllMyStock
{
    NSMutableArray *array = [StockHistoryUtil getMyStock];
    [[MyStockInfoInstance sharedMyStockInfoInstance]deleteStockWithArr:array];
    [array removeAllObjects];
    NSString *path = [StockHistoryUtil getMyStockPath];

    
    BOOL b = [NSKeyedArchiver archiveRootObject:array toFile:path];
    NSLog(@"delete my stock:%d",b);
}

+ (void)exchangeObjectAtIndex:(NSUInteger)i withObjectAtIndex:(NSUInteger)ii
{
    NSMutableArray *array = [StockHistoryUtil getMyStock];
    [array exchangeObjectAtIndex:i withObjectAtIndex:ii];
    
    NSString *path = [StockHistoryUtil getMyStockPath];
    [[MyStockInfoInstance sharedMyStockInfoInstance]resetStockWith:array];
    [NSKeyedArchiver archiveRootObject:array toFile:path];
    //BOOL b =
}

+ (void)moveObjectAtIndex:(NSUInteger)i atIndex:(NSUInteger)ii
{
    NSMutableArray *array = [StockHistoryUtil getMyStock];
    StockCodeInfo *item = [array objectAtIndex:i];
    [array removeObjectAtIndex:i];
    [array insertObject:item atIndex:ii];
    [[MyStockInfoInstance sharedMyStockInfoInstance]resetStockWith:array];
    NSString *path = [StockHistoryUtil getMyStockPath];
    [NSKeyedArchiver archiveRootObject:array toFile:path];
    //BOOL b =
}

@end
