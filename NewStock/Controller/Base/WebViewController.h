//
//  WebViewController.h
//  NewStock
//
//  Created by Willey on 16/8/11.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "BaseViewController.h"
#import "NJKWebViewProgress.h"
#import "NJKWebViewProgressView.h"
#import "UrlRedirectAction.h"
#import "ToolBarView.h"
#import "UMSocial.h"


#import "BlurCommentView.h"
#import "CommentAPI.h"
#import "FeedMappedAPI.h"
#import "FavouritesFeedAPI.h"
#import "UserFollowedAPI.h"

typedef NS_ENUM(NSInteger, WEB_VIEW_TYPE) {
    WEB_VIEW_TYPE_NOR,
    WEB_VIEW_TYPE_COMMENT,
    WEB_VIEW_TYPE_OTHER,
    WEB_VIEW_TYPE_SHARE,
    WEB_VIEW_TYPE_ZIXUN,
    WEB_VIEW_TYPE_BAGUA,
    WEB_VIEW_TYPE_PERSONAL,
    WEB_VIEW_TYPE_TOPCLEAR,
};

@interface WebViewController : BaseViewController<UIWebViewDelegate,NJKWebViewProgressDelegate,UrlRedirectActionDelegate,ToolBarViewDelegate,UMSocialUIDelegate,BlurCommentViewDelegate,UIScrollViewDelegate>
{
    UIWebView *_webView;
    NJKWebViewProgressView *_progressView;
    NJKWebViewProgress *_progressProxy;
    
    ToolBarView *_toolBarView;
    
    CommentAPI *_commentAPI;
    FeedMappedAPI *_feedMappedAPI;
    FavouritesFeedAPI *_favouritesFeedAPI;
    UserFollowedAPI *_userFollowedAPI;
    NSString *_sid;
    NSString *_commentNum;
    NSString *_fid;
    BOOL _hcd;//是否已收藏
    BOOL _webViewIsfinishLoad;
    BOOL _bFirst;
    BOOL _isRequesting;
}

@property(nonatomic,strong)NSString *mytitle;//标题

@property(nonatomic,strong)NSString *myUrl;//网页的连接

@property(nonatomic,strong)NSString *nId;//网页新闻的id

@property(nonatomic,assign)WEB_VIEW_TYPE type;//种类

@property(nonatomic,copy) NSAttributedString *saveText; //保存的编辑文字;

@property(nonatomic,assign) BOOL hasParam;  //是否有参数

@property(nonatomic,assign) BOOL fld;     //是否已关注

@end
