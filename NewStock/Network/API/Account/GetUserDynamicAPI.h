//
//  GetUserDynamicAPI.h
//  NewStock
//
//  Created by 王迪 on 2017/1/9.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "APIRequest.h"

@interface GetUserDynamicAPI : APIRequest

@property (nonatomic, copy) NSString *page;

@property (nonatomic, copy) NSString *count;

- (instancetype)initWithPage:(NSString *)page count:(NSString *)count;

@end
