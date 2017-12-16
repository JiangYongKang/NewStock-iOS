//
//  IdleFundStockModel.h
//  NewStock
//
//  Created by 王迪 on 2017/2/15.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import <Mantle/Mantle.h>
#import <UIKit/UIKit.h>

@interface IdleFundStockModel :  MTLModel <MTLJSONSerializing>

@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *code;
@property (nonatomic, copy) NSString *dsc;
@property (nonatomic, copy) NSString *list;
@property (nonatomic, copy) NSString *title;

@end


@interface IdleFundStockListModel : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy) NSString *n;
@property (nonatomic, copy) NSString *s;
@property (nonatomic, copy) NSString *t;
@property (nonatomic, copy) NSString *m;
@property (nonatomic, copy) NSString *zx;
@property (nonatomic, copy) NSString *zdf;

@end
