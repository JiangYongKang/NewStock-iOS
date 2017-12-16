//
//  VerSionManage.m
//

#import "VersionManager.h"
#import <StoreKit/StoreKit.h>
#import "Alert.h"
#import "Defination.h"
#import "NativeUrlRedirectAction.h"

#define IS_VAILABLE_IOS8  ([[[UIDevice currentDevice] systemVersion] intValue] >= 8)
NSString * const VSERSION = @"Version";
NSString * const VSERSIONMANAGER = @"VersionManager";
static VersionManager *manager = nil;
@interface VersionManager()<SKStoreProductViewControllerDelegate, UIAlertViewDelegate>{
    NSString *url_;
    NSMutableDictionary *versionManagerDic;
    NSString *_appstore_ID;
}
/**
 *  应用内打开Appstore
 */
- (void)openAppWithIdentifier;
@end
@implementation VersionManager
+ (void)checkVerSion {
    if (manager) {
        [manager checkVerSion];
    } else {
        manager = [[VersionManager alloc] init];
        [manager checkVerSion];
    }
}

- (instancetype)init {
    if (manager) {
        return manager;
    } else {
        return self = [super init];
    }
}

/**
 *   showAlert 设置中主动触发版本更新，
 *  @param showAlert     YES-需要提示“已经是最新”
 *  @param callBackBlock 检查完毕后可能需要做的处理
 */
- (void)checkVerSion{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSDictionary *dic = [[NSUserDefaults standardUserDefaults] objectForKey:VSERSIONMANAGER];
        versionManagerDic = [NSMutableDictionary dictionaryWithCapacity:0];
        if (dic) {
            [versionManagerDic addEntriesFromDictionary:dic];
        }
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        NSString *appPackageName = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
        NSString *firstLaunchKey = [NSString stringWithFormat:@"VersionManage_%@" , appPackageName];
        NSString *str = [versionManagerDic objectForKey:firstLaunchKey];
        if (![str boolValue]) {
            /*这个版本是第一次*/
            /*清除上一版本存储的信息*/
            /*第一次是NO*/
            /*第二次是YES*/
            [versionManagerDic removeAllObjects];
            [versionManagerDic setValue:@"YES" forKey:firstLaunchKey];
            [[NSUserDefaults standardUserDefaults] setValue:versionManagerDic forKey:VSERSIONMANAGER];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"http://itunes.apple.com/lookup?bundleId=%@",[infoDictionary objectForKey:@"CFBundleIdentifier"]]];
        NSURLRequest *request = [NSURLRequest requestWithURL:URL];
        NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (error) {
                manager = nil;
            } else {
                NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
                NSString *currentVersion = [infoDic objectForKey:@"CFBundleShortVersionString"];
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
                NSArray *infoArray = [dic objectForKey:@"results"];
                if ([infoArray isKindOfClass:[NSArray class]] && [infoArray count]>0) {
                    NSDictionary *releaseInfo = [infoArray objectAtIndex:0];
                    NSString *appstoreVersion = [releaseInfo objectForKey:@"version"];
                    url_ = [releaseInfo objectForKey:@"trackViewUrl"];
                    _appstore_ID = [NSString stringWithFormat:@"%@", [releaseInfo objectForKey:@"artistId"]];
                    if ([[versionManagerDic valueForKey:VSERSION] isEqual:appstoreVersion]) {
                        /*记录下来的和appstoreVersion相比, 相同的表示已经检查过的版本,不需要在去提示*/
                        manager = nil;
                        return ;
                    }
                    NSArray *appstoreVersionAry = [appstoreVersion componentsSeparatedByString:@"."];
                    NSInteger appstoreCount = [appstoreVersionAry count];
                    NSArray *currentVersionAry = [currentVersion componentsSeparatedByString:@"."];
                    NSInteger currentCount = [currentVersionAry count];
                    NSInteger count = currentCount>appstoreCount?appstoreCount:currentCount;
                    for (int i = 0; i<count; i++) {
                        if ([[appstoreVersionAry objectAtIndex:i] intValue]>[[currentVersionAry objectAtIndex:i] intValue]){
                            /*appstore版本有更新*/
                            /*记录下来版本号*/
                            [versionManagerDic setObject:appstoreVersion forKey:VSERSION];
                            [[NSUserDefaults standardUserDefaults] setValue:versionManagerDic forKey:VSERSIONMANAGER];
                            [[NSUserDefaults standardUserDefaults] synchronize];
                            dispatch_async(dispatch_get_main_queue(), ^{
                                Alert *alert = [[Alert alloc] initWithTitle:@"有新版本更新" message:[NSString stringWithFormat:@"更新内容:\n%@", releaseInfo[@"releaseNotes"]] delegate:nil cancelButtonTitle:@"关闭" otherButtonTitles:@"更新", nil];
                                [alert setContentAlignment:NSTextAlignmentLeft];
                                [alert setLineSpacing:5];
                                [alert setClickBlock:^(Alert *alertView, NSInteger buttonIndex) {
                                    if (buttonIndex == 0) {
                                        manager = nil;
                                        [UIView animateWithDuration:0.25 animations:^{
                                            exit(0);
                                        } completion:nil];
                                    } else {
                                        /*更新*/
                                        [self openAppWithIdentifier];
                                    }
                                }];
                                [alert show];
                            });
                            return;
                        } else if ([[appstoreVersionAry objectAtIndex:i] intValue]<[[currentVersionAry objectAtIndex:i] intValue]){
                            /*本地版本号高于Appstore版本号,测试时候出现,不会提示出来*/
                            
                            dispatch_async(dispatch_get_main_queue(), ^{
                                Alert *alert = [[Alert alloc] initWithTitle:@"有新版本更新" message:[NSString stringWithFormat:@"更新内容:\n%@", releaseInfo[@"releaseNotes"]] delegate:nil cancelButtonTitle:@"关闭" otherButtonTitles:@"更新", nil];
                                [alert setContentAlignment:NSTextAlignmentLeft];
                                [alert setLineSpacing:5];
                                __weak typeof(alert)weakAlert = alert;
                                [alert setClickBlock:^(Alert *alertView, NSInteger buttonIndex) {
                                    if (buttonIndex == 0) {
                                        manager = nil;
                                        [UIView animateWithDuration:0.25 animations:^{
                                            exit(0);
                                        } completion:nil];
                                    } else {
                                        /*更新*/
                                        [weakAlert show];
                                        [self openAppWithIdentifier];
                                    }
                                }];
                                [alert show];
                            });
                            
                            return;
                        } else{
                            continue;
                        }
                    }
                }
            }
        }];
        [dataTask resume];
    });
}

/**
 *  应用内打开Appstore
 */
- (void)openAppWithIdentifier{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSString *str = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/us/app/id%@?mt=8",APP_ID];
//        NSString *str = @"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=1160573329&onlyLatestVersion=true&pageNumber=0&sortOrdering=1&type=Purple+Software";
//        NSString *str = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%@",APP_ID];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    });
}

- (void)productViewControllerDidFinish:(SKStoreProductViewController *)viewController {
    [viewController dismissViewControllerAnimated:YES completion:nil];
    manager = nil;
}

#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_8_0
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        /*关闭*/
        manager = nil;
    } else {
        /*更新*/
        [self openAppWithIdentifier];
    }
}
#endif


@end
