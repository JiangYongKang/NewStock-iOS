//
//  YearModel.h
//  NewStock
//
//  Created by 王迪 on 2017/2/22.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MonthModel.h"

@interface YearModel : NSObject

@property (nonatomic, copy) NSString *yearStr;

@property (nonatomic, strong) NSMutableArray <MonthModel *> *monthArray;

+ (NSArray <YearModel *> *)anayliesDate:(NSArray *)arr ;

@end
