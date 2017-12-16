//
//  UserDynamicModel.h
//  NewStock
//
//  Created by 王迪 on 2017/1/9.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface UserDynamicModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, strong) NSString *origin;
@property (nonatomic, strong) NSString *n;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *aty;
@property (nonatomic, strong) NSString *sn;
@property (nonatomic, strong) NSString *tm;
@property (nonatomic, strong) NSString *sty;
@property (nonatomic, strong) NSString *ids;
@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSString *ty;
@property (nonatomic, strong) NSArray *listArray;
@end


@interface UserDynamicList : MTLModel<MTLJSONSerializing>
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *tt;
@property (nonatomic, strong) NSString *sty; //FORUM
@property (nonatomic, strong) NSString *sy;

@end
