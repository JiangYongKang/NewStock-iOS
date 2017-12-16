//
//  MomentNoticeModel.h
//  NewStock
//
//  Created by 王迪 on 2017/3/31.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface MomentNoticeModel : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong) NSString *n;
@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSString *origin;
@property (nonatomic, strong) NSString *dsc;
@property (nonatomic, strong) NSString *ids;
@property (nonatomic, strong) NSString *c;
@property (nonatomic, strong) NSString *tm;
@property (nonatomic, strong) NSString *fid;
@property (nonatomic, strong) NSString *st;
@property (nonatomic, strong) NSString *url;

@end
