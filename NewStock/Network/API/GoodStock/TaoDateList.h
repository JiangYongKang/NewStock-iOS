//
//  TaoDateList.h
//  NewStock
//
//  Created by 王迪 on 2017/2/22.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "APIRequest.h"

@interface TaoDateList : APIRequest

@property (nonatomic, copy) NSString *s;
@property (nonatomic, strong) NSNumber *t;
@property (nonatomic, strong) NSNumber *m;

@property (nonatomic, copy) NSString *code;

@property (nonatomic, strong) NSNumber *count;

@end
