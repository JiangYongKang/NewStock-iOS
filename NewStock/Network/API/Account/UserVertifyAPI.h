//
//  UserVertifyAPI.h
//  NewStock
//
//  Created by 王迪 on 2017/4/19.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "APIRequest.h"

@interface UserVertifyAPI : APIRequest

@property (nonatomic, strong) NSString *idn;
@property (nonatomic, strong) NSString *idf;
@property (nonatomic, strong) NSString *idb;
@property (nonatomic, strong) NSString *idu;
@property (nonatomic, strong) NSString *rn;
@property (nonatomic, strong) NSString *an;
@property (nonatomic, strong) NSString *rs;
@property (nonatomic, strong) NSArray *aspic;

@end
