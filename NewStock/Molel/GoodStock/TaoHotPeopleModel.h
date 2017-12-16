//
//  TaoHotPeopleModel.h
//  NewStock
//
//  Created by 王迪 on 2017/3/6.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface TaoHotPeopleModel : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong) NSString *p;

@property (nonatomic, strong) NSString *n;

@property (nonatomic, strong) NSString *k;

@end
