//
//  MoviePlayerViewController.h
//  MoviePlayerViewController
//
//  Created by pljhonglu on 13-12-18.
//  Copyright (c) 2013年 pljhonglu. All rights reserved.
//

/*
 依赖框架：AVfoundation.framework
 */
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>


@protocol TKMoviePlayerViewControllerDelegate <NSObject>
- (void)movieFinished:(CGFloat)progress;
@end

@protocol TKMoviePlayerViewControllerDataSource <NSObject>

//key of dictionary
#define KTitleOfMovieDictionary @"title"
#define KURLOfMovieDicTionary @"url"

@required
- (NSDictionary *)nextMovieURLAndTitleToTheCurrentMovie;
- (NSDictionary *)previousMovieURLAndTitleToTheCurrentMovie;
- (BOOL)isHaveNextMovie;
- (BOOL)isHavePreviousMovie;
@end


@interface TKMoviePlayerViewController : UIViewController
typedef enum {
    TKMoviePlayerViewControllerModeNetwork = 0,
    TKMoviePlayerViewControllerModeLocal
} TKMoviePlayerViewControllerMode;

@property (nonatomic,strong,readonly)NSURL *movieURL;
@property (nonatomic,strong,readonly)NSArray *movieURLList;
@property (readonly,nonatomic,copy)NSString *movieTitle;
@property (nonatomic,assign)BOOL isSupportRoute;
@property (nonatomic,assign)BOOL isHiddenTitle;
@property (nonatomic,assign)CGRect frame;
@property (nonatomic, assign) id<TKMoviePlayerViewControllerDelegate> delegate;
@property (nonatomic, assign) id<TKMoviePlayerViewControllerDataSource> datasource;
@property (nonatomic, assign) TKMoviePlayerViewControllerMode mode;

- (id)initNetworkMoviePlayerViewControllerWithURL:(NSURL *)url movieTitle:(NSString *)movieTitle;

- (id)initLocalMoviePlayerViewControllerWithURL:(NSURL *)url movieTitle:(NSString *)movieTitle;
- (id)initLocalMoviePlayerViewControllerWithURLList:(NSArray *)urlList movieTitle:(NSString *)movieTitle;
@end
