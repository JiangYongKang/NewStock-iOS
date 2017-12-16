//
//  MomentNewsAnalysisModel.h
//  NewStock
//
//  Created by 王迪 on 2017/5/25.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface MomentNewsAnalysisStockModel : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy) NSString *t;
@property (nonatomic, copy) NSString *s;
@property (nonatomic, copy) NSString *n;
@property (nonatomic, copy) NSString *m;
@property (nonatomic, copy) NSString *zdf;

@end

@interface MomentNewsAnalysisModel : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy) NSString *ids;
@property (nonatomic, copy) NSString *tt;
@property (nonatomic, copy) NSString *tm;
@property (nonatomic, copy) NSString *sy;
@property (nonatomic, copy) NSString *pic;
@property (nonatomic, copy) NSString *fid;
@property (nonatomic, copy) NSString *lkd;
@property (nonatomic, copy) NSString *ss;
@property (nonatomic, strong) NSArray *sl;

//
@property (nonatomic, assign) BOOL isShow;
@property (nonatomic, copy) NSAttributedString *showStr;
@property (nonatomic, copy) NSAttributedString *hideStr;
@property (nonatomic, assign) CGFloat showHeight;
@property (nonatomic, assign) CGFloat hideHeight;

@end

@interface MomentNewsAnalysisGroupModel : NSObject

@property (nonatomic, strong) MomentNewsAnalysisModel *model;
@property (nonatomic, copy) NSString *tm;

@end
