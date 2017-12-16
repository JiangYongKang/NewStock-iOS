//
//  HMBannerView.h
//  HMBannerViewDemo
//
//  Created by Dennis on 13-12-31.
//  Copyright (c) 2013年 Babytree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"

/**
 *  @Author 刘宝, 2015-09-16 18:09:24
 *
 *  滚动方向
 */
typedef NS_ENUM(NSInteger, TKBannerViewScrollDirection)
{
    /**
     *  @Author 刘宝, 2015-09-16 18:09:21
     *
     *  水平滚动
     */
    ScrollDirectionLandscape,
    /**
     *  @Author 刘宝, 2015-09-16 18:09:01
     *
     *  垂直滚动
     */
    ScrollDirectionPortait
};

/**
 *  @Author 刘宝, 2015-09-16 18:09:16
 *
 *  滚动点的位置
 *
 */
typedef NS_ENUM(NSInteger, TKBannerViewPageStyle)
{
    /**
     *  @Author 刘宝, 2015-09-16 18:09:32
     *
     *  没有
     */
    PageStyle_None,
    /**
     *  @Author 刘宝, 2015-09-16 18:09:47
     *
     *  向左
     */
    PageStyle_Left,
    /**
     *  @Author 刘宝, 2015-09-16 18:09:58
     *
     *  向右
     */
    PageStyle_Right,
    /**
     *  @Author 刘宝, 2015-09-16 18:09:07
     *
     *  中间
     */
    PageStyle_Middle
};

@protocol TKBannerViewDelegate;

/**
 *  @Author 刘宝, 2015-09-16 20:09:27
 *
 *  广告栏组件
 */
@interface TKBannerView : UIView<UIScrollViewDelegate,SDWebImageManagerDelegate>

/**
 *  @Author 刘宝, 2015-09-16 18:09:52
 *
 *  bannerView的代理
 */
@property (nonatomic, weak) id <TKBannerViewDelegate> delegate;

/**
 *  @Author 刘宝, 2015-09-16 18:09:05
 *
 *  存放所有需要滚动的图片URL NSString
 */
@property (nonatomic, strong) NSArray *imagesArray;

/**
 *  @Author 刘宝, 2015-09-16 18:09:25
 *
 *  scrollView滚动的方向
 */
@property (nonatomic, assign) TKBannerViewScrollDirection scrollDirection;

/**
 *  @Author 刘宝, 2015-09-16 18:09:33
 *
 *  滚动延期时间
 */
@property (nonatomic, assign) NSTimeInterval rollingDelayTime;

/**
 *  @Author 刘宝, 2015-09-16 18:09:49
 *
 *  初始化
 *
 *  @param frame     区域
 *  @param direction 方向
 *  @param images    图片
 *
 *  @return
 */
- (id)initWithFrame:(CGRect)frame scrollDirection:(TKBannerViewScrollDirection)direction images:(NSArray *)images;

/**
 *  @Author 刘宝, 2015-09-16 18:09:23
 *
 *  重载banner数据
 *
 *  @param images
 */
- (void)reloadBannerWithData:(NSArray *)images;

/**
 *  @Author 刘宝, 2015-09-16 20:09:58
 *
 *  开始下载image
 */
- (void)startDownloadImage;

/**
 *  @Author 刘宝, 2015-09-16 20:09:33
 *
 *  设置圆角的半径
 *
 *  @param asquare
 */
- (void)setSquare:(NSInteger)asquare;

/**
 *  @Author 刘宝, 2015-09-16 20:09:57
 *
 *  页面控制样式
 *
 *  @param pageStyle
 */
- (void)setPageControlStyle:(TKBannerViewPageStyle)pageStyle;

/**
 *  @Author 刘宝, 2015-09-16 20:09:10
 *
 *  显示关闭按钮
 *
 *  @param show
 */
- (void)showClose:(BOOL)show;

/**
 *  @Author 刘宝, 2015-09-16 20:09:35
 *
 *  开始 滚动
 */
- (void)startRolling;

/**
 *  @Author 刘宝, 2015-09-16 20:09:44
 *
 *  停止滚动
 */
- (void)stopRolling;

/**
 *  @Author 刘宝, 2015-09-16 20:09:40
 *
 *  刷新scrollView
 */
- (void)refreshScrollView;

@end

/**
 *  @Author 刘宝, 2015-09-16 20:09:53
 *
 *  广告栏代理
 */
@protocol TKBannerViewDelegate <NSObject>

/**
 *  @Author 刘宝, 2015-09-16 20:09:14
 *
 *  图片缓冲已完成
 *
 *  @param bannerView
 */
- (void)imageCachedDidFinish:(TKBannerView *)bannerView;

@optional

/**
 *  @Author 刘宝, 2015-09-16 20:09:33
 *
 *  bannerView已经选择ImageView
 *
 *  @param bannerView
 *  @param index
 *  @param bannerData
 */
- (void)bannerView:(TKBannerView *)bannerView didSelectImageView:(NSInteger)index withData:(NSDictionary *)bannerData;

/**
 *  @Author 刘宝, 2015-09-16 20:09:48
 *
 *  bannerView已关闭
 *
 *  @param bannerView
 */
- (void)bannerViewdidClosed:(TKBannerView *)bannerView;

@end
