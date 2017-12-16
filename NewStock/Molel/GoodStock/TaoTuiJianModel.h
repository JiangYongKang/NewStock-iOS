//
//  TaoTuiJianModel.h
//  NewStock
//
//  Created by 王迪 on 2017/3/10.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import <Mantle/Mantle.h>
#import <UIKit/UIKit.h>

@interface TaoTuiJianModel : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy) NSString *n;
@property (nonatomic, copy) NSString *s;
@property (nonatomic, copy) NSString *t;
@property (nonatomic, copy) NSString *m;
@property (nonatomic, copy) NSString *close;
@property (nonatomic, copy) NSString *zdf;
@property (nonatomic, copy) NSString *rs;

@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) BOOL isSelected;

@end
