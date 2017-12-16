//
//  MonthModel.h
//  NewStock
//
//  Created by 王迪 on 2017/2/22.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DayModel.h"

@interface MonthModel : NSObject

@property (nonatomic, copy) NSString *monthStr;

@property (nonatomic, strong) NSMutableArray <DayModel *> *dayArray;

@end
