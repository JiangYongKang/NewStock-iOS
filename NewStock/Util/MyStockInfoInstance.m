//
//  MyStockInfoInstance.m
//  NewStock
//
//  Created by 王迪 on 2016/12/27.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "MyStockInfoInstance.h"
#import "GetMyStockAPI.h"
#import "AddMyStockAPI.h"
#import "DelMyStockAPI.h"
#import "ResetMyStockAPI.h"
#import "StockCodesModel.h"

@interface MyStockInfoInstance ()

@property (nonatomic, strong) GetMyStockAPI *getMyStockAPI;
@property (nonatomic, strong) AddMyStockAPI *addMyStockAPI;
@property (nonatomic, strong) DelMyStockAPI *delMyStockAPI;
@property (nonatomic, strong) ResetMyStockAPI *resetMyStockAPI;

@end

@implementation MyStockInfoInstance
SYNTHESIZE_SINGLETON_FOR_CLASS(MyStockInfoInstance)

- (GetMyStockAPI *)getMyStockAPI {

    if (_getMyStockAPI == nil) {
        _getMyStockAPI = [GetMyStockAPI new];
    }
    return _getMyStockAPI;
}

- (AddMyStockAPI *)addMyStockAPI {

    if (_addMyStockAPI == nil) {
        _addMyStockAPI = [AddMyStockAPI new];
    }
    return _addMyStockAPI;
}

- (DelMyStockAPI *)delMyStockAPI {

    if (_delMyStockAPI == nil) {
        _delMyStockAPI = [DelMyStockAPI new];
    }
    return _delMyStockAPI;
}

- (ResetMyStockAPI *)resetMyStockAPI {
    
    if (_resetMyStockAPI == nil) {
        _resetMyStockAPI = [[ResetMyStockAPI alloc]initWithArray:self.myStockListArray];
    }
    return _resetMyStockAPI;
}

- (void)getAllMyStock:(void (^)(NSArray *))callBack {
    
    [self.getMyStockAPI startWithCompletionBlockWithSuccess:^(__kindof APIBaseRequest *request) {
//        NSLog(@"%@",request.responseJSONObject);
        NSArray *array = [MTLJSONAdapter modelsOfClass:[StockCodeInfo class] fromJSONArray:request.responseJSONObject error:nil];
        callBack(array);
    } failure:^(__kindof APIBaseRequest *request) {
        NSLog(@"fail");
    }];
}

- (void)deleteStockWiths:(NSString *)s t:(NSString *)t m:(NSString *)m {
    self.delMyStockAPI.modelArray = nil;
    self.delMyStockAPI.t = [NSString stringWithFormat:@"%lld",t.longLongValue];
    self.delMyStockAPI.s = s;
    self.delMyStockAPI.m = [NSString stringWithFormat:@"%lld",m.longLongValue];
    [self.delMyStockAPI startWithCompletionBlockWithSuccess:^(__kindof APIBaseRequest *request) {
//        NSLog(@"%@",request.responseJSONObject);
    } failure:^(__kindof APIBaseRequest *request) {
        NSLog(@"%@",request.responseString);
    }];
}

- (void)addStockWiths:(NSString *)s t:(NSString *)t m:(NSString *)m {

    self.addMyStockAPI.t = [NSString stringWithFormat:@"%lld",t.longLongValue];
    self.addMyStockAPI.s = s;
    self.addMyStockAPI.m = [NSString stringWithFormat:@"%lld",m.longLongValue];
    [self.addMyStockAPI startWithCompletionBlockWithSuccess:^(__kindof APIBaseRequest *request) {
//        NSLog(@"%@",request.responseJSONObject);
    } failure:^(__kindof APIBaseRequest *request) {
        NSLog(@"fail");
    }];
}

- (void)deleteStockWith:(StockCodeInfo *)model {
    [self deleteStockWiths:model.s t:model.t m:model.m];
}

- (void)deleteStockWithArr:(NSArray<StockCodeInfo *> *)array {
    self.delMyStockAPI.modelArray = array;
    [self.delMyStockAPI startWithCompletionBlockWithSuccess:^(__kindof APIBaseRequest *request) {
        NSLog(@"%@",request.responseJSONObject);
    } failure:^(__kindof APIBaseRequest *request) {
        NSLog(@"%@",request.responseString);
    }];
}

- (void)addStockWith:(StockCodeInfo *)model {
    [self addStockWiths:model.s t:model.t m:model.m];
}

- (void)resetStockWith:(NSArray<StockCodeInfo *> *)modelArray {

    [self.resetMyStockAPI setMyStockArray:modelArray];
    
    [self.resetMyStockAPI startWithCompletionBlockWithSuccess:^(__kindof APIBaseRequest *request) {
//        NSLog(@"%@",request.responseJSONObject);
    } failure:^(__kindof APIBaseRequest *request) {
        NSLog(@"fail");
    }];
}

@end
