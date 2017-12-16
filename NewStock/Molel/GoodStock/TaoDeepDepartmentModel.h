//
//  TaoDeepDepartmentModel.h
//  NewStock
//
//  Created by 王迪 on 2017/6/27.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface TaoDeepDepartmentModel : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong) NSString *n;
@property (nonatomic, strong) NSString *buy;
@property (nonatomic, strong) NSString *sales;
@property (nonatomic, strong) NSString *count;

@end
