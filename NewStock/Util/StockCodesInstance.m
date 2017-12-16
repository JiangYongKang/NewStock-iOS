//
//  StockCodesInstance.m
//  NewStock
//
//  Created by Willey on 16/8/3.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "StockCodesInstance.h"

@implementation StockCodesInstance
SYNTHESIZE_SINGLETON_FOR_CLASS(StockCodesInstance)


- (NSString *)getStockNameWithSymbol:(NSString *)s type:(NSString *)t market:(NSString *)m {
    NSArray *array = self.stockCodesArray;
    
    for (int i = 0; i < [array count]; i ++) {
        StockCodeInfo *item = [array objectAtIndex:i];
        NSString *symbol = item.s;
        NSString *market = item.m;
        NSString *type = item.t;
        if([symbol isEqualToString:s]&&([market intValue] == [m intValue])&&([type intValue] == [t intValue])) {
            return item.n;
        }
    }
    return @"";
}

- (void)setUserArray:(NSArray *)userArray {
    _userArray = userArray;
    NSMutableArray *nmArr = [NSMutableArray array];
    for (TaoHotPeopleModel *model in _userArray) {
        if (model.k.integerValue == 18) {
            [nmArr addObject:model];
        }
    }
    _pureUserArray = nmArr;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"allUserArrayFinished" object:nil];
}

@end
