//
//  TKFileHelper.h
//  ios4
//
//  Created by liubao on 14-10-28.
//  Copyright (c) 2014年 liubao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 *  文件帮助类
 */
@interface TKFileHelper : NSObject

/**
 *  获取手机的文档document目录路径
 *
 *  @return 手机的文档document目录路径
 */
+(NSString *) documentFolder;

/**
 *  获取手机应用包的目录路径
 *
 *  @return 手机应用包的目录路径
 */
+(NSString *) bundleFolder;

/**
 *  @Author 刘宝, 2015-01-29 12:01:26
 *
 *  获取应用的根目录路径
 *
 *  @return 应用的根目录路径
 */
+(NSString *)homeFolder;

/**
 *  @Author 刘宝, 2015-01-29 12:01:57
 *
 *  获取应用Library目录路径
 *
 *  @return 应用Library目录路径
 */
+(NSString *)libFolder;

/**
 *  @Author 刘宝, 2015-01-29 12:01:35
 *
 *  获取应用缓存的目录路径
 *
 *  @return 应用缓存的目录路径
 */
+(NSString *)cacheFolder;

/**
 *  @Author 刘宝, 2015-01-29 12:01:07
 *
 *  获取应用的临时目录路径
 *
 *  @return 应用的临时目录路径
 */
+(NSString *)tempFolder;

/**
 *  写xml内容
 *
 *  @param xml xml内容
 *  @param filePath xml文件路径
 */
+(void)writeXml:(NSString *)xml inPath:(NSString *)filePath;

/**
 *  @Author 刘宝, 2014-11-27 14:11:03
 *
 *  读取系统xml配置文件（分为两层,catalog,item）
 *
 *  @param path 文件路径
 *
 *  @return 数据字典
 */
+(NSDictionary *)readSystemConfigXml:(NSString *)path;

/**
 *  @Author 刘宝, 2014-11-27 14:11:11
 *
 *  读取插件的xml配置文件(只有一层 item)
 *
 *  @param path 文件路径
 *
 *  @return 数据字典
 */
+(NSDictionary *)readPlugnConfigXml:(NSString *)path;

/**
 *  @Author 刘宝, 2015-01-29 21:01:34
 *
 *  删除文件或者目录
 *
 *  @param filePath 文件路径
 *
 *  @return 成功标志
 */
+(BOOL)removeFile:(NSString *)filePath;

/**
 *  @Author 刘宝, 2015-01-29 21:01:57
 *
 *  创建文件或目录
 *
 *  @param filePath       文件路径
 *  @param isDirectory    是否是目录
 *
 *  @return 成功标志
 */
+(BOOL)createFile:(NSString *)filePath isDirectory:(BOOL)isDirectory;

/**
 *  @Author 刘宝, 2015-01-29 21:01:10
 *
 *  移动文件
 *
 *  @param srcPath  原始文件
 *  @param destPath 目标文件
 *
 *  @return 成功标志
 */
+(BOOL)moveFile:(NSString *)srcPath to:(NSString *)destPath;

/**
 *  @Author 刘宝, 2015-01-29 21:01:23
 *
 *  复制文件
 *
 *  @param srcPath  原始文件
 *  @param destPath 目标文件
 *
 *  @return 成功标志
 */
+(BOOL)copyFile:(NSString *)srcPath to:(NSString *)destPath;

/**
 *  @Author 刘宝, 2015-01-30 10:01:21
 *
 *  写数据到文件中
 *
 *  @param content  内容
 *  @param filePath 路径
 *  @param isExtend 是否用追加模式
 *
 *  @return 成功标志
 */
+(BOOL)writeContent:(NSObject *)content inFile:(NSString *)filePath isExtend:(BOOL)isExtend;

/**
 *  @Author 刘宝, 2015-01-30 10:01:03
 *
 *  读取文件的内容
 *
 *  @param filePath 文件路径
 *
 *  @return 内容
 */
+(NSData *)readContentOfFile:(NSString *)filePath;

/**
 *  @Author 刘宝, 2015-02-04 10:02:40
 *
 *  判断文件是否存在
 *
 *  @param filePath 文件路径
 *
 *  @return 存在标识
 */
+(BOOL)isFileExists:(NSString *)filePath;

/**
 *  @Author 刘宝, 2015-02-04 10:02:18
 *
 *  获取目录下面的子目录
 *
 *  @param filePath 目录路径
 *
 *  @return 子文件数组
 */
+(NSArray *)listFiles:(NSString *)filePath;

/**
 *  @Author 刘宝, 2015-02-04 14:02:16
 *
 *  判断是否是目录
 *
 *  @param filePath 文件路径
 *
 *  @return 是否是目录
 */
+(BOOL)isDirectory:(NSString *)filePath;

/**
 *  @Author 刘宝, 2015-04-23 14:04:31
 *
 *  获取文件
 *
 *  @param filePath    文件目录的路径
 *  @param isDirectory 是否是目录
 *  @param decimal     小数点位数
 *
 *  @return 大小
 */
+(NSString *)getFileSize:(NSString *)filePath isDirectory:(BOOL)isDirectory decimal:(NSInteger)decimal;

/**
 *  @Author 刘宝, 2015-07-09 01:07:09
 *
 *  获取指定目录下面的文件路径，递归查找
 *
 *  @param name              文件名
 *  @param folder            目录名
 *
 *  @return
 */
+(NSString *)getFilePathByName:(NSString *)name inFiolder:(NSString *)folder;

@end
