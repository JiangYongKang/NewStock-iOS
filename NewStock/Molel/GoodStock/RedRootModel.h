//
//  RedRootModel.h
//  NewStock
//
//  Created by 王迪 on 2017/2/13.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import <Mantle/Mantle.h>
#import <UIKit/UIKit.h>

@interface RedRootModel : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy) NSString *tm;
@property (nonatomic, copy) NSString *slg;
@property (nonatomic, copy) NSString *dsc;
@property (nonatomic, copy) NSString *list;

@end

@interface RedRootListModel : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy) NSString *n;
@property (nonatomic, copy) NSString *s;
@property (nonatomic, copy) NSString *t;
@property (nonatomic, copy) NSString *m;
@property (nonatomic, copy) NSString *tv;
@property (nonatomic, copy) NSString *dsc;
@property (nonatomic, copy) NSString *zdf;
@property (nonatomic, copy) NSString *bt;
@property (nonatomic, copy) NSString *st;
@property (nonatomic, copy) NSString *nbuy;
@property (nonatomic, strong) NSArray *buy;
@property (nonatomic, strong) NSArray *sale;

@property (nonatomic, assign) CGFloat rowHeight;
@property (nonatomic, assign) BOOL isSelected;

@end

@interface RedRootBSListModel : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy) NSString *n;
@property (nonatomic, copy) NSString *s;
@property (nonatomic, copy) NSString *b;

@end
