//
//  UserInfoModel.h
//  NewStock
//
//  Created by Willey on 16/8/26.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface UserInfoModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, strong) NSString * userId;//用户id
@property (nonatomic, strong) NSString * n;//用户昵称
@property (nonatomic, strong) NSString * rn;//用户姓名
@property (nonatomic, weak) NSNumber * st;//用户状态

@property (nonatomic, strong) NSString * ico;//图像信息
@property (nonatomic, strong) NSString * origin;//原图地址
@property (nonatomic, strong) NSString * h240;//高240图片地址

@property (nonatomic, strong) NSString * ph;//手机号码
@property (nonatomic, strong) NSString * lv;//用户等级
@property (nonatomic, strong) NSString * lt;//等级名称
@property (nonatomic, strong) NSString * sc;//用户积分
@property (nonatomic, strong) NSString * tsc;//今日用户积分
@property (nonatomic, strong) NSString * aty;//用户认证信息

@property (nonatomic, strong) NSString * su;//第三方用户
@property (nonatomic, strong) NSString * suid;//来源用户id
@property (nonatomic, strong) NSString * sr;//来源

@property (nonatomic, strong) NSString * ss;//用户各项计数
@property (nonatomic, strong) NSString * fs;//粉丝数
@property (nonatomic, strong) NSString * fds;//贴子数
@property (nonatomic, strong) NSString * fl;//关注数
@property (nonatomic, strong) NSString * fv;//收藏数 d
@property (nonatomic, strong) NSString * cs;//评论数
@property (nonatomic, strong) NSString * lk;//点赞数
@property (nonatomic, strong) NSString * lkd;//被点赞数
@property (nonatomic, strong) NSString * ams;//匿名帖子数

@property (nonatomic, strong) NSString * token;//用户登录token
@end
