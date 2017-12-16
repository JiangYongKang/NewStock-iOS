//
//  TaoSearchDepartmentModel.h
//  NewStock
//
//  Created by 王迪 on 2017/2/24.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface TaoSearchDepartmentListModel : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy) NSString *n;
@property (nonatomic, copy) NSString *s;
@property (nonatomic, copy) NSString *t;
@property (nonatomic, copy) NSString *m;
@property (nonatomic, copy) NSString *sty;
@property (nonatomic, copy) NSString *stn;
@property (nonatomic, copy) NSString *zdf;
@property (nonatomic, copy) NSString *num;
@property (nonatomic, copy) NSString *tm;

@end

@interface TaoSearchDepartmentModel : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong) TaoSearchDepartmentListModel *mnb;
@property (nonatomic, strong) TaoSearchDepartmentListModel *mop;
@property (nonatomic, strong) NSArray *list;

@end


