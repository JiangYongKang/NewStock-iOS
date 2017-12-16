//
//  UserInfoInstance.m
//  NewStock
//
//  Created by Willey on 16/8/26.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "UserInfoInstance.h"


@implementation UserInfoInstance
SYNTHESIZE_SINGLETON_FOR_CLASS(UserInfoInstance)

- (MyStockInfoInstance *)myStockInfo {

    if (_myStockInfo == nil) {
        _myStockInfo = [MyStockInfoInstance sharedMyStockInfoInstance];
    }
    return _myStockInfo;
}


@end
