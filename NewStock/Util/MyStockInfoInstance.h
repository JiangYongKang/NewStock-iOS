//
//  MyStockInfoInstance.h
//  NewStock
//
//  Created by 王迪 on 2016/12/27.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ARCSingletonTemplate.h"
#import "StockCodesModel.h"

@interface MyStockInfoInstance : NSObject
SYNTHESIZE_SINGLETON_FOR_HEADER(MyStockInfoInstance)

@property (nonatomic, strong) NSMutableArray <StockCodeInfo *> *myStockListArray;

- (void)getAllMyStock:(void(^)(NSArray *))callBack ;

- (void)deleteStockWiths:(NSString *)s t:(NSString *)t m:(NSString *)m ;
- (void)addStockWiths:(NSString *)s t:(NSString *)t m:(NSString *)m ;

- (void)deleteStockWith:(StockCodeInfo *)model;
- (void)addStockWith:(StockCodeInfo *)model;
- (void)resetStockWith:(NSArray<StockCodeInfo *> *)modelArray;

- (void)deleteStockWithArr:(NSArray<StockCodeInfo *> *)array;

@end
