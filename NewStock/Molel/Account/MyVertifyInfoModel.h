//
//  MyVertifyInfoModel.h
//  NewStock
//
//  Created by 王迪 on 2017/4/19.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface MyVertifyInfoModel : MTLModel<MTLJSONSerializing>


@property (nonatomic, copy) NSString *idn;
@property (nonatomic, copy) NSString *rn;
@property (nonatomic, copy) NSString *rs;
@property (nonatomic, copy) NSString *rmsg;
@property (nonatomic, copy) NSString *st;
@property (nonatomic, copy) NSString *ph;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *ico;


@end
