//
//  TKNetworkManager.h
//  TKApp
//
//  Created by liubao on 15-2-5.
//  Copyright (c) 2015年 liubao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ResultVo.h"

/**
 *  @Author 刘宝, 2015-08-24 17:08:42
 *
 *  网络监听代理
 */
@protocol TKNetworkManagerDelegate <NSObject>

/**
 *  @Author 刘宝, 2015-08-24 17:08:15
 *
 *  测速结果
 *
 *  @param result
 */
-(void)pingTestResult:(ResultVo *)resultVo;

@end

/**
 *  @Author 刘宝, 2015-02-05 09:02:30
 *
 *  网络智能测速管理模块
 */
@interface TKNetworkManager : NSObject

/**
 *  @Author 刘宝, 2015-08-24 17:08:56
 *
 *  网络测速代理
 */
@property(nonatomic,weak)id<TKNetworkManagerDelegate> delegate;

/**
 *  @Author 刘宝, 2015-08-05 20:08:34
 *
 *  更新地址
 */
@property(nonatomic,copy)NSString *updateUrl;

/**
 *  @Author 刘宝, 2015-08-05 20:08:34
 *
 *  测速地址，为空代表只是通过ping测速网络
 */
@property(nonatomic,copy)NSString *speedUrl;

/**
 *  @author 刘宝, 2016-09-19 19:09:11
 *
 *  当前选择的机房
 */
@property(nonatomic,copy)NSString *roomKey;

/**
 *  @Author 刘宝, 2015-02-05 09:02:10
 *
 *  单例模式
 *
 *  @return
 */
+(TKNetworkManager*)shareInstance;

/**
 *  @Author 刘宝, 2015-04-13 12:04:16
 *
 *  设置服务站点映射列表
 *
 *  @param hostMap 服务站点映射对象
 */
-(void)setHostMap:(NSMutableDictionary *)hostMap;

/**
 *  @Author 刘宝, 2015-02-05 09:02:17
 *
 *  获取最快的网络环境
 *
 *  @param serverName 服务类别
 *
 *  @return 当前类别下最快的服务器地址
 */
-(NSString *)getFlastHost:(NSString *)serverName;

/**
 *  @author 刘宝, 2016-06-22 19:06:10
 *
 *  获取配置的服务器列表
 *
 *  @param serverName 服务器名称
 *
 *  @return 
 */
-(NSArray *)getHostList:(NSString *)serverName;

/**
 *  @author 刘宝, 2016-11-22 13:11:44
 *
 *  获取多机房配置中指定服务器名称的服务器列表（每个机房取出这个名称服务器的一个配置地址）
 *
 *  @param serverName 服务器名称
 *
 *  @return 
 */
-(NSArray *)getRoomsServerList:(NSString *)serverName;

/**
 *  @Author 刘宝, 2015-02-05 14:02:02
 *
 *  开始测速
 */
-(void)startTest;

/**
 *  @Author 刘宝, 2015-08-24 10:08:20
 *
 *  测速某个站点下面的各个线路的速度
 *
 *  @param serverName
 */
-(void)startTest:(NSString *)serverName;

/**
 *  @author 刘宝, 2016-11-22 14:11:31
 *
 *  测速各个机房某个站点下面的地址速度
 *
 *  @param serverName
 */
-(void)startTestRoomsServerList:(NSString *)serverName;

/**
 *  @Author 刘宝, 2015-08-24 10:08:20
 *
 *  测速某个站点下面的各个线路的速度
 *
 *  @param serverName  站点名称
 *  @param isOnlyReturnFast 是否测试到最快的线路就已经返回，并中断其他线路的测速
 */
-(void)startTest:(NSString *)serverName isOnlyReturnFast:(BOOL)isOnlyReturnFast;

/**
 *  @Author 刘宝, 2015-08-24 17:08:29
 *
 *  设置自定义最快站点
 *
 *  @param serverName 服务名称
 *  @param host       最快站点
 */
-(void)setFlashHost:(NSString *)serverName host:(NSString *)host;

/**
 *  @Author 刘宝, 2015-08-24 17:08:29
 *
 *  设置自定义最快站点
 *
 *  @param serverName        服务名称
 *  @param host              最快站点
 *  @param isSaveCache       是否要缓存
 */
-(void)setFlashHost:(NSString *)serverName host:(NSString *)host isSaveCache:(BOOL)isSaveCache;

@end
