//
//  TaoSearchPPlModel.h
//  NewStock
//
//  Created by 王迪 on 2017/3/8.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface TaoSearchPPlModel : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy) NSString *dsc;
@property (nonatomic, strong) NSArray *list;

@end

@interface TaoSearchPPlListModel : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy) NSString *t;
@property (nonatomic, copy) NSString *s;
@property (nonatomic, copy) NSString *m;

@property (nonatomic, copy) NSString *bd;
@property (nonatomic, copy) NSString *cn;
@property (nonatomic, copy) NSString *n;
@property (nonatomic, copy) NSString *sum;

@end
