//
//  EmbedWebViewController.h
//  NewStock
//
//  Created by Willey on 16/8/22.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NJKWebViewProgress.h"
#import "NJKWebViewProgressView.h"
#import "UrlRedirectAction.h"

@protocol EmbedWebViewDelegate;

@interface EmbedWebView : UIView<UIWebViewDelegate,UIScrollViewDelegate,NJKWebViewProgressDelegate,UrlRedirectActionDelegate>
{
    NJKWebViewProgress *_progressProxy;
}
@property (assign, nonatomic) id<EmbedWebViewDelegate>delegate;

@property(nonatomic,strong)NJKWebViewProgressView *progressView;
@property(nonatomic,strong)UIWebView *webView;
@property(nonatomic,strong)NSString *mytitle;//标题
@property(nonatomic,strong)NSString *myUrl;//网页的连接

@property(nonatomic,assign)int type;//强制跳转

- (id)initWithUrl:(NSString *)url;
- (void)setUrl:(NSString *)url;
@end


@protocol EmbedWebViewDelegate <UrlRedirectActionDelegate>
@optional
- (void)embedWebView:(EmbedWebView*)embedWebView webViewHeight:(CGFloat)height;
- (void)scrollViewDidScroll:(UIScrollView *)scrollView;
- (void)didFinishLoadWebView;

@end
