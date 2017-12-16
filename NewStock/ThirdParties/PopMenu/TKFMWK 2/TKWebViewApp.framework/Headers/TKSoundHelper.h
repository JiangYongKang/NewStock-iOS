//
//  TKSoundHelper.h
//  TKUtil_V1
//
//  Created by liubao on 14-11-10.
//  Copyright (c) 2014年 liubao. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  @Author 刘宝, 2014-12-15 02:12:30
 *
 *  铃声处理帮组类
 */
@interface TKSoundHelper : NSObject

/**
 *  从资源文件中查找声音文件名和扩展名进行播放
 *
 *  @param fileName 文件名
 *  @param type     文件类型
 */
+(void)playSoundByName:(NSString*)fileName ofType:(NSString*)type;

/**
 *  声音震动
 */
+(void)deviceVibrate;

@end
