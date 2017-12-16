//
//  TaoIndexModel.h
//  NewStock
//
//  Created by 王迪 on 2017/2/15.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import <Mantle/Mantle.h>
#import <UIKit/UIKit.h>


@interface TaoIndexModelClildStock : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy) NSString *n;
@property (nonatomic, copy) NSString *s;
@property (nonatomic, copy) NSString *t;
@property (nonatomic, copy) NSString *m;
@property (nonatomic, copy) NSString *zdf;

@end

@interface TaoIndexModelListClild : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy) NSString *n;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *ico;
@property (nonatomic, copy) NSString *ids;
@property (nonatomic, copy) NSString *c;
@property (nonatomic, copy) NSString *count;
@property (nonatomic, strong) TaoIndexModelClildStock *stock;

@end

@interface TaoIndexModelList : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) NSArray *list;

@end

@interface TaoIndexModel :  MTLModel <MTLJSONSerializing>

@property (nonatomic, strong) TaoIndexModelList *centerData;
@property (nonatomic, strong) TaoIndexModelList *skillStock;
@property (nonatomic, strong) TaoIndexModelList *smartStock;

@end

