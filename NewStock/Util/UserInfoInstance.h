//
//  UserInfoInstance.h
//  NewStock
//
//  Created by Willey on 16/8/26.
//  Copyright © 2016年 Willey. All rights reserved.


#import <Foundation/Foundation.h>
#import "ARCSingletonTemplate.h"
#import "UserInfoModel.h"
#import "MyStockInfoInstance.h"
#import <UIKit/UIKit.h>

@interface UserInfoInstance : NSObject

@property (strong, nonatomic) UserInfoModel *userInfoModel;
@property (nonatomic, strong) MyStockInfoInstance *myStockInfo;
@property (nonatomic, copy) NSString *lastIcon;

//匿名保存相关
@property (nonatomic, copy) NSAttributedString *postSecretString;
@property (nonatomic, strong) UIImage *postSecretImage;
@property (nonatomic, assign) BOOL isAMS;

SYNTHESIZE_SINGLETON_FOR_HEADER(UserInfoInstance)

@end

