//
//  TKKeyBoardThemeManager.h
//  TKComponent_V1
//
//  Created by liubao on 15-5-7.
//  Copyright (c) 2015年 liubao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TKKeyBoardTheme.h"

typedef enum {
    /**
     *  @Author 刘宝, 2015-05-07 19:05:13
     *
     *  浅色
     */
    TKKeyBoardThemeStyle_Easy,
    /**
     *  @Author 刘宝, 2015-05-07 19:05:22
     *
     *  深色
     */
    TKKeyBoardThemeStyle_Deep,
    
    /**
     *  @Author 刘宝, 2015-05-07 19:05:22
     *
     *  招商配色
     */
    TKKeyBoardThemeStyle_MS
}TKKeyBoardThemeStyle;

/**
 *  @Author 刘宝, 2015-05-07 19:05:41
 *
 *  键盘皮肤类
 */
@interface TKKeyBoardThemeManager : NSObject

/**
 *  @Author 刘宝, 2015-05-07 19:05:32
 *
 *  单例对象
 *
 *  @return
 */
+(TKKeyBoardThemeManager *)shareInstance;

/**
 *  @Author 刘宝, 2015-05-07 19:05:00
 *
 *  皮肤类型
 */
@property (nonatomic,assign)TKKeyBoardThemeStyle themeStyle;

/**
 *  @Author 刘宝, 2015-05-07 19:05:26
 *
 *  获取当前皮肤样式
 */
@property (nonatomic,readonly)TKKeyBoardTheme *theme;

/**
 *  @author 刘宝, 2016-10-18 15:10:29
 *
 *  获取指定的皮肤
 *
 *  @param themeStyle 皮肤样式
 *
 *  @return
 */
-(TKKeyBoardTheme*)getTheme:(TKKeyBoardThemeStyle)themeStyle;

@end
