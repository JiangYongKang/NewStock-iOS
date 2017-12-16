//
//  TaoPPlUserSearchAPI.h
//  NewStock
//
//  Created by 王迪 on 2017/3/7.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "APIRequest.h"

@interface TaoPPlUserSearchAPI : APIRequest
@property (nonatomic, copy) NSString *n;

@property (nonatomic, strong) NSNumber *count;
@property (nonatomic, copy) NSString *sd;
@property (nonatomic, copy) NSString *ed;

@end
