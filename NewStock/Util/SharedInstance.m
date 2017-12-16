//
//  SharedInstance.m
//  NewStock
//
//  Created by 王迪 on 2017/1/18.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "SharedInstance.h"
#import "SnapImageView.h"
#import "Defination.h"
#import <UMSocial.h>

@interface SharedInstance ()

@property (nonatomic, assign) BOOL isOnlyImage;

@property (nonatomic, strong) NSArray *toArray;

@end

@implementation SharedInstance

SYNTHESIZE_SINGLETON_FOR_CLASS(SharedInstance)

- (NSArray *)toArray {
    if (_toArray == nil) {
        _toArray = @[@"wxsession",@"wxmoment",@"sina",@"qq",@"qzone"];
    }
    return _toArray;
}

- (void)shareWithImg:(NSString *)img file:(UIImage *)file url:(NSString *)url c:(NSString *)c tt:(NSString *)tt ty:(NSString *)ty sid:(NSString *)sid res_code:(NSString *)res_code to:(NSString *)to {
    
    ShareAPI *shareAPI = [[ShareAPI alloc] initWithImg:img url:url tt:tt c:c ty:ty sid:sid res_code:res_code to:to];
    shareAPI.file = file;
    
    [shareAPI startWithCompletionBlockWithSuccess:^(__kindof APIBaseRequest *request) {
        NSLog(@"%@",request.responseJSONObject);
    } failure:^(__kindof APIBaseRequest *request) {
        NSLog(@"%@",request.requestOperationError);
    }];
    
}

- (void)shareWithImage:(BOOL)onlyImg {
    
    _isOnlyImage = onlyImg;
    
    UMSocialUrlResource *urlRes = [[UMSocialUrlResource alloc]initWithSnsResourceType:UMSocialUrlResourceTypeWeb url:self.url];
    SnapImageView *snapView = [[SnapImageView alloc] init];
    [[UIApplication sharedApplication].keyWindow addSubview:snapView];
    snapView.frame = [UIApplication sharedApplication].keyWindow.bounds;
    [snapView startBtnAnimation];
    
    if (onlyImg) {
        [UMSocialData defaultData].extConfig.wxMessageType = UMSocialWXMessageTypeImage;
        [UMSocialData defaultData].extConfig.qqData.qqMessageType = UMSocialQQMessageTypeImage;
        [UMSocialData defaultData].extConfig.wechatTimelineData.wxMessageType = UMSocialWXMessageTypeImage;
    }else {
        [UMSocialData defaultData].extConfig.wxMessageType = UMSocialWXMessageTypeWeb;
        [UMSocialData defaultData].extConfig.wechatTimelineData.wxMessageType = UMSocialWXMessageTypeWeb;
        [UMSocialData defaultData].extConfig.qqData.qqMessageType = UMSocialQQMessageTypeDefault;
        [UMSocialData defaultData].extConfig.wechatTimelineData.url = self.url;
        [UMSocialData defaultData].extConfig.qqData.url = self.url;
    }
    [UMSocialData defaultData].extConfig.title = self.tt;

    __weak typeof(snapView)weakView = snapView;
    snapView.btnBlock = ^(NSInteger tag){
        if (tag == 1) {
            [[UMSocialDataService defaultDataService] postSNSWithTypes:@[UMShareToWechatSession] content:self.c image:self.image location:nil urlResource:urlRes presentedController:nil completion:^(UMSocialResponseEntity *response) {
                [self sendToServer:tag];
            }];
        }else if (tag == 2) {
            [[UMSocialDataService defaultDataService] postSNSWithTypes:@[UMShareToWechatTimeline] content:self.c image:self.image location:nil urlResource:urlRes presentedController:nil completion:^(UMSocialResponseEntity *response) {
                [self sendToServer:tag];
            }];
        }else if (tag == 3) {
            [[UMSocialDataService defaultDataService] postSNSWithTypes:@[UMShareToSina] content:[NSString stringWithFormat:@"%@ %@",self.tt,self.url] image:self.image location:nil urlResource:nil presentedController:nil completion:^(UMSocialResponseEntity *response) {
                [self sendToServer:tag];
            }];
        }else if (tag == 4) {
            [[UMSocialDataService defaultDataService] postSNSWithTypes:@[UMShareToQQ] content:self.c image:self.image location:nil urlResource:nil presentedController:nil completion:^(UMSocialResponseEntity *response) {
                [self sendToServer:tag];
            }];
        }else if (tag == 5) {
            [[UMSocialDataService defaultDataService] postSNSWithTypes:@[UMShareToQzone] content:self.c image:self.image location:nil urlResource:nil presentedController:nil completion:^(UMSocialResponseEntity *response) {
                [self sendToServer:tag];
            }];
        }else if (tag == 6) {
            [weakView fuzhiBtnClickWithUrl:self.url];
        }

    };
    
}

- (void)sendToServer:(NSInteger)index {
    
    if (_isOnlyImage) {
        [self shareWithImg:nil file:self.image url:nil c:nil tt:self.tt ty:@"2" sid:self.sid res_code:self.res_code to:self.toArray[index - 1]];
    }else {
        [self shareWithImg:LOGO_ASSERT file:self.image url:self.url c:self.c tt:self.tt ty:@"1" sid:self.sid res_code:self.res_code to:self.toArray[index - 1]];
    }
    
}




@end
