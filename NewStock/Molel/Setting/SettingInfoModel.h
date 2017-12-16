//
//  SettingInfoModel.h
//  NewStock
//
//  Created by Willey on 16/9/6.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface SettingInfoModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, strong) NSString * cv;
@property (nonatomic, strong) NSString * ev;
@property (nonatomic, strong) NSString * n;
@property (nonatomic, strong) NSString * pres_code;
@property (nonatomic, strong) NSString * res_code;
@property (nonatomic, strong) NSString * sv;
@property (nonatomic, strong) NSString * uid;

@end
