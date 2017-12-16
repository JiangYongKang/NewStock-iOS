//
//  ZFSettingItem.h
//  ZFSetting
//
//  Created by 任子丰 on 15/9/19.
//  Copyright (c) 2013年 任子丰. All rights reserved.
//  一个Item对应一个Cell
// 用来描述当前cell里面显示的内容，描述点击cell后做什么事情

#import <Foundation/Foundation.h>

typedef enum : NSInteger{
    ZFSettingItemTypeNone, // 什么也没有
    ZFSettingItemTypeArrow, // 箭头
    ZFSettingItemTypeSwitch, // 开关
    ZFSettingItemTypeDetail, // 详情
    ZFSettingItemTypeImage, // 图像
    ZFSettingItemTypeCheckmark, //
} ZFSettingItemType;

@interface ZFSettingItem : NSObject
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *detail;
@property (nonatomic, copy) NSString *imgUrl;
@property (nonatomic, assign) BOOL switchOn;

@property (nonatomic, assign) ZFSettingItemType type;// Cell的样式
/** cell上开关的操作事件 */
@property (nonatomic, copy) void (^switchBlock)(BOOL on) ;
@property (nonatomic, copy) void (^operation)() ; // 点击cell后要执行的操作

+ (id)itemWithIcon:(NSString *)icon title:(NSString *)title type:(ZFSettingItemType)type;
+ (id)itemWithIcon:(NSString *)icon title:(NSString *)title type:(ZFSettingItemType)type detail:(NSString *)detail;
+ (id)itemWithIcon:(NSString *)icon title:(NSString *)title type:(ZFSettingItemType)type imgUrl:(NSString *)imgUrl;
@end
