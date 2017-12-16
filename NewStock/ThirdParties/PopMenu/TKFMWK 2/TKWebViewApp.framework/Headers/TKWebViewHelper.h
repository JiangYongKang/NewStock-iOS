//
//  TKWebViewHelper.h
//  TKUtil
//
//  Created by liubao on 14-11-11.
//  Copyright (c) 2014年 liubao. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  WebView相关帮组类
 */
@interface TKWebViewHelper : NSObject

/**
 *  拼接webview加载html的地址
 *
 *  @param dirPath  文件夹路径 如：www/m/mall
 *  @param pageName 页面名称  index
 *  @param queryStr 携带的url参数字符串 #!/business/index.html 或者?name=liubao&age=10
 *
 *  @return 请求对象
 */
+(NSURLRequest *)getWebViewLoadUrl:(NSString *)dirPath htmlName:(NSString *)pageName queryStr:(NSString *)queryStr __deprecated_msg("方法被建议取消使用，请用‘ +(NSURLRequest *)getWebViewLoadUrl:(NSString *)url isUseRandom:(BOOL)isUseRandom ’方法代替，强烈建议");;

/**
 *  @Author 刘宝, 2015-07-29 11:07:39
 *
 *  通用处理webview的url地址，支持服务器页面路径，支持本地页面路径，强烈建议用
 *
 *  @param url          url地址
                        例如：www/m/mall/index.html#!/business/index.html
                        例如：file:///xxxx/xxx/www/m/mall/index.html#!/business/index.html
                        例如：http://www.baidu.com?name=liubao
 *  @param isUseRandom  是否增加随机数，用于清除缓存
 *
 *  @return
 */
+(NSURLRequest *)getWebViewLoadUrl:(NSString *)url isUseRandom:(BOOL)isUseRandom;


/**
 *  @Author 刘宝, 2015-07-29 11:07:39
 *
 *  通用处理webview的url地址，支持服务器页面路径，支持本地页面路径，强烈建议用
 *
 *  @param url          url地址
                        例如：www/m/mall/index.html#!/business/index.html
                        例如：file:///xxxx/xxx/www/m/mall/index.html#!/business/index.html
                        例如：http://www.baidu.com?name=liubao
 *  @param isUseRandom  是否增加随机数，用于清除缓存
 *
 *  @return
 */
+(NSURLRequest *)getWebViewLoadUrl:(NSString *)url;

@end
