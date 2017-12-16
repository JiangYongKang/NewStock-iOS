//
//  ReqParamVo.h
//  TKApp
//
//  Created by liubao on 14-11-24.
//  Copyright (c) 2014年 liubao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoadInfo.h"

/**
 *  @Author 刘宝, 2014-11-26 10:11:11
 *
 *  Dao的类型
 */
typedef enum{
    DaoType_Http = 0,
    DaoType_Javascript = 1,
    DaoType_WebService = 2,
    DaoType_BUSV1 = 3,
    DaoType_BUSV2 = 4,
    DaoType_QUOTEV3 = 5,
    DaoType_TRADEV3 = 6,
    DaoType_NEWSV3 = 7,
    DaoType_TFBUSV3 = 8,
    DaoType_SDBUSV3 = 9,
    DaoType_BUSAUTO = 99
}DaoType;

/**
 编码格式
 */
typedef enum {
  CharEncoding_DEFAULT = 0,
  CharEncoding_UTF_8,
  CharEncoding_GBK
}CharEncoding;

/**
 *  @Author 刘宝, 2015-09-15 09:09:21
 *
 *  Dao请求模式
 */
typedef enum{
    /**
     *  @Author 刘宝, 2015-09-15 09:09:57
     *
     *  短连接
     */
    DaoMode_Short = 0,
    /**
     *  @Author 刘宝, 2015-09-15 09:09:12
     *
     *  长连接
     */
    DaoMode_Long = 1
}DaoMode;

typedef enum{
    /**
     *  @Author 刘宝, 2015-09-15 09:09:57
     *
     *  AES加密
     */
    EncryMode_Aes = 0,
    /**
     *  @Author 刘宝, 2015-09-15 09:09:12
     *
     *  DES加密
     */
    EncryMode_Des = 1
}EncryMode;

typedef enum{
    /**
     *  @Author 刘宝, 2015-09-15 09:09:57
     *
     *  正常数据
     */
    DataType_Normal = 0,
    /**
     *  @Author 刘宝, 2015-09-15 09:09:12
     *
     *  AES加密
     */
    DataType_AesEncryt = 1,
    /**
     *  @author 刘宝, 2016-11-17 20:11:47
     *
     *  压缩
     */
    DataType_Compress = 2,
    /**
     *  @author 刘宝, 2016-11-17 20:11:27
     *
     *  先加密后压缩
     */
    DataType_AesEncryt_Compress = 3,
    /**
     *  @author 刘宝, 2016-11-17 20:11:00
     *
     *  先压缩后加密
     */
    DataType_Compress_AesEncryt = 4
}DataType;

/**
 *  @Author 刘宝, 2015-09-08 20:09:29
 *
 *  上传代理
 */
@protocol TKUploadDelegate <NSObject>

@optional

/**
 *  @Author 刘宝, 2015-09-08 20:09:03
 *
 *  显示进度百分比
 *
 *  @param newProgress
 */
- (void)showProgress:(float)newProgress;

/**
 *  @Author 刘宝, 2015-09-08 20:09:28
 *
 *  显示上传进度数据
 *
 *  @param loadInfo
 */
- (void)showProgressData:(LoadInfo *)loadInfo;

@end

/**
 *  请求对象
 */
@interface ReqParamVo : DynModel

/**
 *  流水号
 */
@property (nonatomic,copy)NSString *flowNo;

/**
 *  Http的请求的头
 */
@property (nonatomic,retain)NSDictionary *headerFiledDic;

/**
 *  请求对象
 */
@property (nonatomic,retain)NSMutableDictionary *reqParam;

/**
 *  URL地址
 */
@property (nonatomic,copy)NSString *url;

/**
 *  是否post请求
 */
@property (nonatomic,assign)BOOL isPost;

/**
 *  @author 刘宝, 2017-01-19 16:01:54
 *
 *  Http请求方法
 */
@property (nonatomic,copy)NSString *httpMethod;

/**
 *  是否异步
 */
@property (nonatomic,assign)BOOL isAsync;

/**
 *  @Author 刘宝, 2015-10-09 21:10:55
 *
 *  请求超时时间，单位秒
 */
@property(nonatomic,assign)NSInteger timeOut;

/**
 *  请求的协议
 */
@property (nonatomic,assign)DaoType protocol;

/**
 *  调用开始时间
 */
@property (nonatomic,assign)NSTimeInterval beginTime;

/**
 *  是否显示缓冲效果（转菊花）
 */
@property (nonatomic,assign)BOOL isShowWait;

/**
 *  缓冲效果的文字
 */
@property (nonatomic,copy)NSString *waitTip;

/**
 *  @Author 刘宝, 2015-05-04 20:05:21
 *
 *  是否显示网络缓冲效果
 */
@property (nonatomic,assign)BOOL isShowNetworkWait;

/**
 *  是否返回list数据
 */
@property (nonatomic,assign)BOOL isReturnList;

/**
 *  请求组号,如果是javascript请求，传对应浏览器对象的名称
 */
@property (nonatomic,copy)NSString *group;

/**
 *  数据处理函数，一般走默认不需要设置
 */
@property (nonatomic,weak)id processDataFunc;

/**
 *  @Author 刘宝, 2014-11-26 22:11:51
 *
 *  扩展字段对象，目前javascript协议的时候传的是WebView对象，其他后面在定义
 */
@property (nonatomic,retain)id userInfo;

/**
 *  @Author 刘宝, 2014-11-25 17:11:31
 *
 *  数据服务代理对象，一般走默认不需要设置
 */
@property(nonatomic,weak) id serviceDelegate;

/**
 *  @Author 刘宝, 2015-04-22 10:04:46
 *
 *  是否上传文件
 */
@property(nonatomic,assign)BOOL isUpload;

/**
 *  @Author 刘宝, 2015-09-08 20:09:34
 *
 *  上传代理
 */
@property(nonatomic,weak)id<TKUploadDelegate> uploadDelegate;

/**
 *  @Author 刘宝, 2015-04-21 19:04:36
 *
 *  是否缓存
 */
@property(nonatomic,assign)BOOL isCache;

/**
 *  @Author 刘宝, 2015-10-12 12:10:16
 *
 *  缓存类型
 */
@property(nonatomic,assign)CacheType cacheType;

/**
 *  @Author 刘宝, 2015-10-09 21:10:15
 *
 *  缓存时间，单位是秒
 */
@property(nonatomic,assign)NSInteger cacheTime;

/**
 *  @Author 刘宝, 2015-10-26 13:10:56
 *
 *  自定义dao的实现类名称，一般不需要设置
 */
@property(nonatomic,copy)NSString *daoName;

/**
 *  @Author 刘宝, 2015-04-21 19:04:36
 *
 *  是否对参数进行url编码
 */
@property(nonatomic,assign)BOOL isURLEncode;

/**
 *  @Author 刘宝, 2015-04-21 19:04:36
 *
 *  是否对参数进行签名
 */
@property(nonatomic,assign)BOOL isURLSign;

/**
 *  @author 刘宝, 2016-08-12 12:08:44
 *
 *  签名key
 */
@property(nonatomic,copy)NSString *signKey;

/**
 *  @author 刘宝, 2016-08-12 12:08:28
 *
 *  签名ID
 */
@property(nonatomic,copy)NSString *signAppId;

/**
 *  @author 刘宝, 2016-04-29 10:04:23
 *
 *  是否对参数进行加密
 */
@property(nonatomic,assign)BOOL isURLEncry;

/**
 *  @author 刘宝, 2016-04-29 13:04:27
 *
 *  对参数进行加密模式
 */
@property(nonatomic,assign)EncryMode encryMode;

/**
 *  @author 刘宝, 2016-08-12 12:08:05
 *
 *  加密key
 */
@property(nonatomic,copy)NSString *encryKey;

/**
 *  @author 刘宝, 2016-11-17 20:11:51
 *
 *  请求公司编号
 */
@property(nonatomic,copy)NSString *companyId;

/**
 *  @author 刘宝, 2016-11-17 20:11:43
 *
 *  系统编号
 */
@property(nonatomic,copy)NSString *systemId;

/**
 *  @author 刘宝, 2017-01-14 14:01:11
 *
 *  是否登录请求
 */
@property(nonatomic,assign)BOOL isLoginReq;

/**
 *  @Author 刘宝, 2016-01-29 00:01:16
 *
 *  返回字符编码集
 */
@property(nonatomic,assign)CharEncoding charEncoding;

/**
 *  @author 刘宝, 2016-11-17 20:11:18
 *
 *  数据类型协议
 */
@property(nonatomic,assign)DataType dataType;

/**
 *  @Author 刘宝, 2015-09-15 09:09:41
 *
 *  Dao请求模式,目前针对2进制socket协议有效，支持长短连接
 */
@property(nonatomic,assign)DaoMode daoMode;

/**
 *  @author 刘宝, 2016-11-30 15:11:25
 *
 *  Https是否验证SSl证书的合法性
 */
@property(nonatomic,assign)BOOL isValidatesSSLCertificate;

@end
