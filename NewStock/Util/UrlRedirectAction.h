//
//  UrlRedirectAction.h
//  NewStock
//
//  Created by Willey on 16/9/5.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ARCSingletonTemplate.h"
#import "CommentAPI.h"
#import "BlurCommentView.h"

#import "UMSocial.h"

#import "PYPhotoBrowseView.h"



@protocol UrlRedirectActionDelegate <NSObject>
@optional
- (void)commentDidFinished;
@end


@interface UrlRedirectAction : NSObject<BlurCommentViewDelegate,UMSocialUIDelegate,PYPhotoBrowseViewDataSource>

@property (weak, nonatomic) id<UrlRedirectActionDelegate> delegate;
@property (nonatomic, strong) NSString *fid;
@property (nonatomic, strong) NSString *rpid;
@property (nonatomic, strong) NSString *rpuid;
@property (nonatomic, strong) CommentAPI *commentAPI;

SYNTHESIZE_SINGLETON_FOR_HEADER(UrlRedirectAction)


+ (BOOL)redirectActionWithUrl:(NSURL *)url from:(NSString *)fromUrlStr navigationType:(UIWebViewNavigationType)navigationType;

+ (NSDictionary *)parseURLParams:(NSString *)query;

+ (NSString *)getValueStringFromUrl:(NSString *)url forParam:(NSString *)param;

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

@end
