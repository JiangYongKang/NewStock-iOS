//
//  StockCodesInstance.h
//  NewStock
//
//  Created by Willey on 16/8/3.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ARCSingletonTemplate.h"
#import "StockCodesModel.h"
#import "TaoHotPeopleModel.h"

@interface StockCodesInstance : NSObject
{
}
@property (strong, nonatomic) StockCodesModel *stockCodesModel;
@property (strong, nonatomic) NSArray *stockCodesArray;
@property (strong, nonatomic) NSArray *departmentArray;
@property (strong, nonatomic) NSArray <TaoHotPeopleModel *> *userArray;
@property (strong, nonatomic) NSArray <TaoHotPeopleModel *> *pureUserArray;

SYNTHESIZE_SINGLETON_FOR_HEADER(StockCodesInstance)

-(NSString *)getStockNameWithSymbol:(NSString *)s type:(NSString *)t market:(NSString *)m;
@end
