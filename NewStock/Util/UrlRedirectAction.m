//
//  UrlRedirectAction.m
//  NewStock
//
//  Created by Willey on 16/9/5.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "Defination.h"
#import "AppDelegate.h"
#import "UrlRedirectAction.h"
#import "SharedInstance.h"
#import "UserInfoInstance.h"

#import "IndexChartViewController.h"
#import "StockChartViewController.h"
#import "BoardDetailListViewController.h"
#import "WebViewController.h"
#import "PostViewController.h"
#import "TipOffViewController.h"
#import "LoginViewController.h"
#import "DetailWebViewController.h"

#import "NewMomentViewController.h"
#import "FollowAndFansController.h"

@interface UrlRedirectAction ()

@property (weak, nonatomic) DetailWebViewController *detailVC;

@end

@implementation UrlRedirectAction
SYNTHESIZE_SINGLETON_FOR_CLASS(UrlRedirectAction)

+ (BOOL)redirectActionWithUrl:(NSURL *)url from:(NSString *)fromUrlStr navigationType:(UIWebViewNavigationType)navigationType {

    NSLog(@"%@",url.relativeString);
    NSLog(@"%@",url.absoluteString);
    NSLog(@"%@",url.parameterString);
    NSLog(@"%@",url.path);
    NSLog(@"%@",url.relativePath);
    NSLog(@"%@",url.query);
    NSString *strUrl = url.absoluteString;

    if ([strUrl hasPrefix:@"native://"])
    {
        NSString *subUrl = [strUrl substringFromIndex:9];
        
        if ([subUrl hasPrefix:@"HQ1000"])
        {
            NSLog(@"%@",[subUrl substringFromIndex:7]);

            NSDictionary *dic = [UrlRedirectAction parseURLParams:[subUrl substringFromIndex:7]];
            
            NSString *symbolTyp = [dic objectForKey:@"symbolTyp"];
            if (([symbolTyp intValue] == 1) || ([symbolTyp intValue] == 2))
            {
                IndexChartViewController *viewController = [[IndexChartViewController alloc] init];
                AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                
                IndexInfoModel *model = [[IndexInfoModel alloc] init];
                model.marketCd = [dic objectForKey:@"marketCd"];
                model.symbol = [dic objectForKey:@"symbol"];
                model.symbolName = @"";
                model.symbolTyp = [dic objectForKey:@"symbolTyp"];
                if (!(model.marketCd && model.symbol && model.symbolTyp)) {
                    return NO;
                }
                viewController.indexModel = model;
                [appDelegate.navigationController pushViewController:viewController animated:YES];
            } else {
                StockListModel *model = [[StockListModel alloc] init];
                model.marketCd = [dic objectForKey:@"marketCd"];
                model.symbol = [dic objectForKey:@"symbol"];
                model.symbolName = @"";
                model.symbolTyp = [dic objectForKey:@"symbolTyp"];
                if (!(model.marketCd && model.symbol && model.symbolTyp)) {
                    return NO;
                }
                StockChartViewController *viewController = [[StockChartViewController alloc] init];
                AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                viewController.stockListModel = model;
                [appDelegate.navigationController pushViewController:viewController animated:YES];

            }
        }
        else if ([subUrl hasPrefix:@"Board"])
        {
            NSLog(@"%@",[subUrl substringFromIndex:6]);
            NSDictionary *dic = [UrlRedirectAction parseURLParams:[subUrl substringFromIndex:6]];
            
            BoardDetailListViewController *viewController = [[BoardDetailListViewController alloc] init];
            AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            
            BoardListModel *model = [[BoardListModel alloc] init];
            model.marketCd = [dic objectForKey:@"marketCd"];
            model.symbol = [dic objectForKey:@"symbol"];
            model.industryName = [dic objectForKey:@"industryName"];
            model.symbolTyp = [dic objectForKey:@"symbolTyp"];
            
            viewController.title = model.industryName;
            viewController.boardListModel = model;
            [appDelegate.navigationController pushViewController:viewController animated:YES];
            
        }
        else if ([subUrl hasPrefix:@"Draft"])
        {
            NSLog(@"%@",[subUrl substringFromIndex:6]);
            NSDictionary *dic = [UrlRedirectAction parseURLParams:[subUrl substringFromIndex:6]];
            [dic objectForKey:@"id"];
            [dic objectForKey:@"tt"];
            [dic objectForKey:@"c"];
            [dic objectForKey:@"stag_code"];
            [dic objectForKey:@"ams"];
            
            PostViewController *viewController = [[PostViewController alloc] init];
            viewController.fid = [dic objectForKey:@"id"];
            viewController.titleStr = [dic objectForKey:@"tt"];
            viewController.contentStr = [dic objectForKey:@"c"];
            viewController.stag_code = [dic objectForKey:@"stag_code"];
            viewController.ams = [dic objectForKey:@"ams"];
            
            AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            [appDelegate.navigationController presentViewController:viewController animated:YES completion:^{}];
            
        }
        else if ([subUrl hasPrefix:@"Login"])
        {
            LoginViewController *loginViewController = [[LoginViewController alloc] init];
            AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            [appDelegate.navigationController pushViewController:loginViewController animated:YES];
        }
        else if ([subUrl hasPrefix:@"FM0102"])
        {
            PostViewController *viewController = [[PostViewController alloc] init];
            AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:viewController];

            if ([SystemUtil isSignIn]) {
                [appDelegate.navigationController presentViewController:nav animated:YES completion:^{}];
            }else {
                LoginViewController *loginViewController = [[LoginViewController alloc] init];
                [appDelegate.navigationController pushViewController:loginViewController animated:YES];
            }

        }
        else if ([subUrl hasPrefix:@"CM0103"])
        {
            
            TipOffViewController *viewController = [[TipOffViewController alloc] init];
            
            NSString *subStr = [subUrl substringFromIndex:10];
            viewController.contentId = subStr;
            viewController.ty = @"S_COMMENT";
            AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            [appDelegate.navigationController pushViewController:viewController animated:YES];
            
        }
        else if ([subUrl hasPrefix:@"OpenAccount"])
        {
            TKOpenController *vc = [[TKOpenController alloc] initWithParams:[NSDictionary dictionaryWithObjectsAndKeys:DGZQ_OPENURL,@"h5Url", nil]];//@"channel_url"
            vc.statusBarBgColor = kUIColorFromRGB(0x00A9FF);
            vc.statusBarStyle = UIStatusBarStyleLightContent;
            AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            [appDelegate.navigationController pushViewController:vc animated:YES];
        }
        
        return NO;
    }
    
    if ([strUrl hasPrefix:@"component://"])
    {
        NSString *subUrl = [strUrl substringFromIndex:12];
        if ([subUrl hasPrefix:@"CM0103"]){
            
            TipOffViewController *viewController = [[TipOffViewController alloc] init];
            
            NSString *subStr = [subUrl substringFromIndex:10];
            viewController.contentId = subStr;
            viewController.ty = @"S_COMMENT";
            AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
            [appDelegate.navigationController pushViewController:viewController animated:YES];
            
        }
        if ([subUrl hasPrefix:@"CM0102"]){
            NSString *subStr = [subUrl substringFromIndex:7];
            NSDictionary *dic = [UrlRedirectAction parseURLParams:subStr];
            
            [UrlRedirectAction sharedUrlRedirectAction].fid = [dic objectForKey:@"fid"];
            [UrlRedirectAction sharedUrlRedirectAction].rpid = [dic objectForKey:@"id"];
            [UrlRedirectAction sharedUrlRedirectAction].rpuid = [dic objectForKey:@"rpuid"];
            [BlurCommentView commentshowDelegate:[UrlRedirectAction sharedUrlRedirectAction]];
            
        }
        if ([subUrl hasPrefix:@"FX0000"]){
            
            NSDictionary *dic = [UrlRedirectAction parseURLParams:[subUrl substringFromIndex:7]];
            NSString *tt = [dic objectForKey:@"tt"];
            UIImage *image = [UIImage imageNamed:@"shareLogo"];
            
            NSString *u = [NSString stringWithFormat:@"%@%@?id=%@",API_URL,H5_TALK_SHARE,[dic objectForKey:@"id"]];
            u = [u stringByReplacingOccurrencesOfString:@"https://" withString:@"http://"];
            u = [u stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            u = [u stringByAppendingString:@"&from=ios"];
            NSString *content = [NSString stringWithFormat:@"股怪侠-%@",@"说闻解股"];
            
            [SharedInstance sharedSharedInstance].image = image;
            [SharedInstance sharedSharedInstance].tt = tt;
            [SharedInstance sharedSharedInstance].c = content;
            [SharedInstance sharedSharedInstance].url = u;
            [SharedInstance sharedSharedInstance].sid = [dic objectForKey:@"id"];
            [SharedInstance sharedSharedInstance].res_code = @"S_HOTNEWS";
            [[SharedInstance sharedSharedInstance] shareWithImage:NO];
            
        }
        if ([subUrl hasPrefix:@"sheet"]) {
            NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
            [center postNotificationName:HOLDING_SHEET_MSG object:nil userInfo:nil];
        }
        return NO;
    }
    
    if (navigationType == UIWebViewNavigationTypeLinkClicked) {
        if ([strUrl hasPrefix:@"http://www.guguaixia.com"]||[strUrl hasPrefix:@"https://www.guguaixia.com"]||[strUrl hasPrefix:API_URL]) {
            WebViewController *viewController = [[WebViewController alloc] init];

            if ([url.path hasSuffix:@"MY9902"]) {
                viewController.myUrl = url.absoluteString;
                AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                viewController.type = WEB_VIEW_TYPE_PERSONAL;
                [appDelegate.navigationController pushViewController:viewController animated:YES];
                return NO;
            }else {
                viewController.myUrl = url.absoluteString;
                AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                [appDelegate.navigationController pushViewController:viewController animated:YES];
                return NO;
            }

        }else {
            return NO;
        }
    }
    
    NSRange range = [fromUrlStr rangeOfString:url.path];
    if (range.location == NSNotFound) {
        NSLog(@"fromUrlStr:%@",fromUrlStr);
        NSLog(@"url.path:%@",url.path);
        
        if(![fromUrlStr isEqualToString:url.absoluteString]) {
            if ([url.path hasSuffix:@"HP0105"]) {
                WebViewController *viewController = [[WebViewController alloc] init];
                viewController.myUrl = url.absoluteString;
                viewController.type = WEB_VIEW_TYPE_ZIXUN;
                viewController.hasParam = YES;
                
                AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                [appDelegate.navigationController pushViewController:viewController animated:YES];
                
                return NO;
                
            } else if ([url.path hasSuffix:@"HQ1009"] || [url.path hasSuffix:@"HQ1008"] || [url.path hasSuffix:@"HQ1007"] || [url.path hasSuffix:@"HQ1003"]) {
                
                WebViewController *viewController = [[WebViewController alloc]init];
                viewController.myUrl = url.absoluteString;
                viewController.type = WEB_VIEW_TYPE_OTHER;
                
                AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                [appDelegate.navigationController pushViewController:viewController animated:YES];
                
                return NO;
            
            } else if ([url.path hasSuffix:@"FM0301"]) {
            
                WebViewController *viewController = [[WebViewController alloc]init];
                viewController.myUrl = url.absoluteString;
                viewController.type = WEB_VIEW_TYPE_BAGUA;
                
                AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                [appDelegate.navigationController pushViewController:viewController animated:YES];
                
                return NO;
                
                
            } else if ([url.path hasSuffix:@"MY9902"]) {
                
                WebViewController *viewController = [[WebViewController alloc]init];
                viewController.myUrl = url.absoluteString;
                viewController.type = WEB_VIEW_TYPE_PERSONAL;
                
                AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                [appDelegate.navigationController pushViewController:viewController animated:YES];
                return NO;
                
            } else if ([url.path hasSuffix:@"MY0500"]) {
                
                FollowAndFansController *ffvc = [FollowAndFansController new];
                ffvc.url0500 = url.absoluteString;
                ffvc.view.backgroundColor = [UIColor whiteColor];
                ffvc.segmentedControl.selectedSegmentIndex = 0;
                AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                [appDelegate.navigationController pushViewController:ffvc animated:YES];
                return NO;
            
            } else if ([url.path hasSuffix:@"MY0501"]) {
                FollowAndFansController *ffvc = [FollowAndFansController new];
                ffvc.url0501 = url.absoluteString;
                ffvc.view.backgroundColor = [UIColor whiteColor];
                ffvc.segmentedControl.selectedSegmentIndex = 1;
                AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                [appDelegate.navigationController pushViewController:ffvc animated:YES];
                return NO;
                
            } else if ([strUrl hasPrefix:@"http://www.guguaixia.com"]||[strUrl hasPrefix:@"https://www.guguaixia.com"]||[strUrl hasPrefix:API_URL]) {
                //帖子详情
                DetailWebViewController *viewController = [[DetailWebViewController alloc] init];

                viewController.myUrl = url.absoluteString;

                [UrlRedirectAction sharedUrlRedirectAction].detailVC = viewController;
                
                NSRange urlRange = [url.absoluteString rangeOfString:@"comment=true"];
                if (urlRange.length > 0) {
                    viewController.type = WEB_VIEW_TYPE_COMMENT;
                }
                
                AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                [appDelegate.navigationController pushViewController:viewController animated:YES];
                
                return NO;
            } else if ([strUrl containsString:@"dgzq.com.cn"]) {
                WebViewController *viewController = [[WebViewController alloc] init];
                viewController.myUrl = url.absoluteString;
                AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                [appDelegate.navigationController pushViewController:viewController animated:YES];
                
                return NO;
            }
              else {
                return NO;
            }
        }
        
    }
    
    return YES;
}

/**
 * 解析URL参数的工具方法。
 */
+ (NSDictionary *)parseURLParams:(NSString *)query {
    NSArray *pairs = [query componentsSeparatedByString:@"&"];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    for (NSString *pair in pairs) {
        NSArray *kv = [pair componentsSeparatedByString:@"="];
        if (kv.count == 2) {
            NSString *val =[[kv objectAtIndex:1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            [params setObject:val forKey:[kv objectAtIndex:0]];
        }else if (kv.count >= 5) {
            NSString *val1 = [[kv objectAtIndex:1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

            NSString *newStr = [pair stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            NSRange range = [newStr rangeOfString:val1];
            NSString *totalStr = [[newStr substringFromIndex:range.location] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            [params setObject:totalStr forKey:[kv objectAtIndex:0]];
        }
    }
    return params;
}

/*
 * 根据指定的参数名，从URL中找出并返回对应的参数值。
 */
+ (NSString *)getValueStringFromUrl:(NSString *)url forParam:(NSString *)param {
    NSString * str = nil;
    NSRange start = [url rangeOfString:[param stringByAppendingString:@"="]];
    if (start.location != NSNotFound) {
        NSRange end = [[url substringFromIndex:start.location + start.length] rangeOfString:@"&"];
        NSUInteger offset = start.location+start.length;
        str = end.location == NSNotFound
        ? [url substringFromIndex:offset]
        : [url substringWithRange:NSMakeRange(offset, end.location)];
        str = [str stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    }
    
    return str;
}

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}


#pragma BlurCommentViewDelegate
- (void)commentDidFinished:(NSString *)commentText {
    NSLog(@"send text:%@",commentText);
    
    if(!self.commentAPI) {
        self.commentAPI = [[CommentAPI alloc] init];
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        _commentAPI.animatingView = appDelegate.window.rootViewController.view;
        _commentAPI.animatingText = @"数据提交中";
    }
    
    if ([SystemUtil isSignIn]) {
        if ([commentText isEqualToString:@""]) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"评论不能为空！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alertView show];
        } else {
            self.commentAPI.uid = [SystemUtil getCache:USER_ID];
            self.commentAPI.c = commentText;
            self.commentAPI.fid = self.fid;
            self.commentAPI.rpid = [UrlRedirectAction sharedUrlRedirectAction].rpid;
            self.commentAPI.rpuid = [UrlRedirectAction sharedUrlRedirectAction].rpuid;
            AppDelegate *appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
            BaseViewController *vc = (BaseViewController *)appdelegate.navigationController.visibleViewController;
            if ([vc isKindOfClass:[DetailWebViewController class]]) {
                NSString *_myUrl = [vc valueForKeyPath:@"_myUrl"];
                if ([_myUrl containsString:@"FM0401"]) {
                    _commentAPI.ams = [UserInfoInstance sharedUserInfoInstance].isAMS ? @"N" : @"Y";
                }
            }
            [UrlRedirectAction sharedUrlRedirectAction].rpid  = nil;
            [UrlRedirectAction sharedUrlRedirectAction].rpuid = nil;
            
            [self.commentAPI startWithCompletionBlockWithSuccess:^(APIBaseRequest *request) {
                NSLog(@"%@",request.responseJSONObject);

                UINavigationController *nav = (UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController ;
                if (nav.viewControllers.count > 1) {
                    DetailWebViewController *newVC ;//= nav.viewControllers[1];
                    for (UIViewController *vc in nav.viewControllers) {
                        if ([vc isKindOfClass:[DetailWebViewController class]]) {
                            newVC = (DetailWebViewController *)vc;
                            break;
                        }
                    }
                    UIWebView *webView = [newVC valueForKeyPath:@"_webView"];
                    NSString *s = [request.responseString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                    if (webView) {
                        [webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"A('%@')",s]];
                        [webView stringByEvaluatingJavaScriptFromString:@"B()"];
                    }else {
                        
                        [self performSelector:@selector(delayMethod) withObject:nil afterDelay:0.4f];
                    }
                }
                
            } failure:^(APIBaseRequest *request) {
                NSString *msg = [request.responseJSONObject objectForKey:@"msg"];
                if (msg.length == 0) {
                    msg = @"系统繁忙,请稍候再试!";
                }
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                
                [alertView show];
            }];

        }
        
    } else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请先登录！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        alertView.tag = 10001;
        [alertView show];
    }
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (alertView.tag == 10001) {
        LoginViewController *loginViewController = [[LoginViewController alloc] init];
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        [appDelegate.navigationController pushViewController:loginViewController animated:YES];
    }
}

- (void)delayMethod {
    if ([_delegate respondsToSelector:@selector(commentDidFinished)]) {
        [_delegate commentDidFinished];
    }
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"提交成功！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    alertView.tag = 1001;
    [alertView show];
    
}


@end
