//
//  DeleteUserDynamic.h
//  NewStock
//
//  Created by 王迪 on 2017/1/10.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "APIRequest.h"

@interface DeleteUserDynamicAPI : APIRequest

@property (nonatomic, strong) NSString *ids;

@property (nonatomic, assign) NSInteger cellIndex;

- (instancetype)initWithid:(NSString *)ids ;

@end
