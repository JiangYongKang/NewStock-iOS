//
//  TaoHotStockModel.h
//  NewStock
//
//  Created by 王迪 on 2017/2/27.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface TaoHotStockModel : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy) NSString *t;
@property (nonatomic, copy) NSString *s;
@property (nonatomic, copy) NSString *n;
@property (nonatomic, copy) NSString *m;

@end
