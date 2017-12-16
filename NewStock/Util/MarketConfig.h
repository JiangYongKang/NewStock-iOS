//
//  MarketConfig.h
//  NewStock
//
//  Created by Willey on 16/7/26.
//  Copyright © 2016年 Willey. All rights reserved.
//
#ifndef NewStock_MarketConfig_h
#define NewStock_MarketConfig_h

//自选股最大个数
#define MY_STOCK_MAX_NUM 100

//历史记录最大个数
#define HIS_STOCK_MAX_NUM 20

//每页请求个数
#define PAGE_COUNT 20

//行情刷新时间
#define DEFAULT_REFRESH_TIME 15
#define DEFAULT_WIFI_REFRESH_TIME 5

//下拉刷新颜色
#define REFRESH_BG_COLOR [UIColor colorWithRed:241.0/255.0 green:241.0/255.0 blue:241.0/255.0 alpha:1.0]//[UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:0.9]

//上涨颜色
#define RISE_COLOR [UIColor colorWithRed:243.0/255.0 green:72.0/255.0 blue:81.0/255.0 alpha:1.0]//[UIColor redColor]  0xff1919

//下跌颜色
#define FALL_COLOR [UIColor colorWithRed:26.0/255.0 green:174.0/255.0 blue:82.0/255.0 alpha:1.0]//[UIColor greenColor]  0x009d00

//平盘颜色
#define PLAN_COLOR [UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1.0]//[UIColor greenColor]  0x009d00

//标题栏背景
#define TITLE_BAR_BG_COLOR kUIColorFromRGB(0xf1f1f1)//[UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1.0]

//分割线背景
#define SEP_BG_COLOR [UIColor colorWithRed:235.0/255.0 green:235.0/255.0 blue:235.0/255.0 alpha:1.0]

//
#define SEP_LINE_COLOR [UIColor colorWithRed:211.0/255.0 green:211.0/255.0 blue:211.0/255.0 alpha:1.0]

//按钮背景
#define BUTTOM_BG_COLOR 0x358ee7


//行情列表高度
#define MARKET_CELL_HEIGHT 49


#endif

#import <Foundation/Foundation.h>

@interface MarketConfig : NSObject

+ (NSString *)getUrlWithPath:(NSString *)path Param:(NSDictionary *)param;
+ (NSString *)getUrlWithPath:(NSString *)path;

+ (float)getRefreshTime;
+ (void)setRefreshTime:(float)f;

+ (float)getAppRefreshTime;

@end
