//
//  Y-KLineGroupModel.m
//  BTC-Kline
//
//  Created by yate1996 on 16/4/28.
//  Copyright © 2016年 yate1996. All rights reserved.
//

#import "Y_KLineGroupModel.h"
#import "Y_KLineModel.h"
@implementation Y_KLineGroupModel
+ (instancetype) objectWithArray:(NSArray *)arr {
    
    if([arr count] == 0)return nil;
    NSAssert([arr isKindOfClass:[NSArray class]], @"arr不是一个数组");
    
    Y_KLineGroupModel *groupModel = [Y_KLineGroupModel new];
    NSMutableArray *mutableArr = @[].mutableCopy;
    __block Y_KLineModel *preModel = [[Y_KLineModel alloc] init];
    
    //设置数据
    for (NSDictionary *valueDic in arr)
    {
        Y_KLineModel *model = [Y_KLineModel new];
        model.PreviousKlineModel = preModel;
        [model initWithDictionary:valueDic];
        model.ParentGroupModel = groupModel;
        
        [mutableArr addObject:model];
        
        preModel = model;
    }
    
    groupModel.models = mutableArr;
    
    
    //初始化第一个Model的数据
    Y_KLineModel *firstModel = mutableArr[0];
    [firstModel initFirstModel];
    
    //初始化其他Model的数据
    [mutableArr enumerateObjectsUsingBlock:^(Y_KLineModel *model, NSUInteger idx, BOOL * _Nonnull stop) {
        [model initData];
    }];

    return groupModel;
}

+ (instancetype) objectWith5MinArray:(NSArray *)arr
{
    
    if([arr count] == 0)return nil;
    NSAssert([arr isKindOfClass:[NSArray class]], @"arr不是一个数组");
    
    Y_KLineGroupModel *groupModel = [Y_KLineGroupModel new];
    NSMutableArray *mutableArr = @[].mutableCopy;
    __block Y_KLineModel *preModel = [[Y_KLineModel alloc]init];
    
    //设置数据
    //for (NSDictionary *valueDic in arr)
    
    long five_min = 5*60*1000;//5分钟

    for (int i = 0; i < [arr count]; i ++)
    {
        NSDictionary *valueDic = [arr objectAtIndex:i];
        
        long longDate = [[valueDic objectForKey:@"createChartTime"] longValue];

//        double doubleDate = [[valueDic objectForKey:@"createChartTime"] doubleValue]/1000;
//        NSDate *date = [NSDate dateWithTimeIntervalSince1970:doubleDate];
//        NSDateFormatter *formatter = [NSDateFormatter new];
//        formatter.dateFormat = @"mm";
//        NSString *dateStr = [formatter stringFromDate:date];
        //if([dateStr intValue]%5)
        
        if ((longDate % five_min) == 0)
        {
            Y_KLineModel *model = [Y_KLineModel new];
            model.PreviousKlineModel = preModel;
            [model initWithDictionary:valueDic];
            model.ParentGroupModel = groupModel;
            
            [mutableArr addObject:model];
            
            preModel = model;
        }
       
    }
    
    groupModel.models = mutableArr;
    
    
    //初始化第一个Model的数据
    Y_KLineModel *firstModel = mutableArr[0];
    [firstModel initFirstModel];
    
    //初始化其他Model的数据
    [mutableArr enumerateObjectsUsingBlock:^(Y_KLineModel *model, NSUInteger idx, BOOL * _Nonnull stop) {
        [model initData];
    }];
    
    return groupModel;
}
@end
