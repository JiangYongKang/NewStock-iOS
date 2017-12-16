//
//  TaoSkillStockListModel.h
//  NewStock
//
//  Created by 王迪 on 2017/6/19.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface TaoSkillStockListArrayModel : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong) NSString *t;
@property (nonatomic, strong) NSString *s;
@property (nonatomic, strong) NSString *n;
@property (nonatomic, strong) NSString *m;
@property (nonatomic, strong) NSString *zx;
@property (nonatomic, strong) NSString *zdf;

@end

@interface TaoSkillStockListModel : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, strong) NSString *star;
@property (nonatomic, strong) NSString *imgUrls;
@property (nonatomic, strong) NSString *tm;
@property (nonatomic, strong) NSArray *list;

@end
