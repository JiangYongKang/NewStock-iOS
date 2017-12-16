//
//  SystemUtil.m
//

#import "SystemUtil.h"
#import <CommonCrypto/CommonDigest.h>
#import <sys/socket.h>
#import <sys/sysctl.h>
#import <net/if.h>
#import <net/if_dl.h>
#import "KeychainIDFA.h"
#import "sys/utsname.h"
#import "Defination.h"
#import "FCUUID.h"
#import "CocoaSecurity.h"
#import "NSData+AES128.h"

#import "SecurityUtil.h"

#import "AESCryptoHelper.h"
#import "AESCipher.h"

#import "AESCrypt.h"



#import "NSData+Base64.h"
#import "NSString+Base64.h"
#import "NSData+CommonCrypto.h"

#import "MarketConfig.h"

#import "AppDelegate.h"

#import "JPUSHService.h"

@implementation SystemUtil


+ (BOOL)isIPhone5 {
    BOOL flag = NO;
    if([[UIScreen mainScreen] bounds].size.height == 568.0f) {
        flag = YES;
    }
    return flag;
}

+ (float)systemVersion {
    return [[[UIDevice currentDevice] systemVersion] floatValue];
}

// Download file from web, save to Documents file
+ (NSString *)saveFileToDocuments:(NSString *)url {
    NSString *resultFilePath = @"";
    if (url.length > 7) {
        
        NSString *destFilePath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:[url substringFromIndex:7]];
        NSString *destFolderPath = [destFilePath stringByDeletingLastPathComponent];
        
        if (! [[NSFileManager defaultManager] fileExistsAtPath:destFolderPath]) {
            
            [[NSFileManager defaultManager] createDirectoryAtPath:destFolderPath withIntermediateDirectories:YES attributes:nil error:nil];
        }
        
        if ([[NSFileManager defaultManager] fileExistsAtPath:destFilePath]) {
            
            resultFilePath = destFilePath;
        } else {
            
            NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
            if ([imageData writeToFile:destFilePath atomically:YES]) {
                resultFilePath = destFilePath;
            }
        }
    }
    return resultFilePath;
}

+ (NSString *)trimTheDate:(NSString *)date {
    NSUInteger theIndex = date.length;
    for (NSUInteger index = 0; index < date.length; index ++) {
        if ([date characterAtIndex:index] == ' ') {
            theIndex = index;
            break;
        }
    }
    NSString *result = [date substringToIndex:theIndex];
    return result;
}

+ (NSString *)getDateString:(NSString *)date {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    NSString *sourceTime = date;
    
    NSDate *createDate = [formatter dateFromString:sourceTime];
    
    if ([self isInThisYear:createDate]) {
        
        NSCalendar *calender = [NSCalendar currentCalendar];
        
        if ([calender isDateInToday:createDate]) {
            
            NSInteger dealt = [[NSDate date] timeIntervalSinceDate:createDate];
            
            if (dealt < 60) {
                return  @"刚刚";
            } else if (dealt < 3600) {
                return [NSString stringWithFormat:@"%zd分钟前",dealt / 60];
            } else {
                formatter.dateFormat = @"HH:mm";
                return [formatter stringFromDate:createDate];
            }
        } else if ([calender isDateInYesterday:createDate]) {
            formatter.dateFormat = @"昨天HH:mm";
            return [formatter stringFromDate:createDate];
        } else {
            formatter.dateFormat = @"MM-dd";
            return [formatter stringFromDate:createDate];
        }
    } else {
        
        formatter.dateFormat = @"yyyy-MM-dd";
        return [formatter stringFromDate:createDate];
    }
    
    return @"火星";
}

+ (BOOL)isInThisYear:(NSDate *)createDate {
    
    NSDateFormatter *formatter = [NSDateFormatter new];
    
    formatter.dateFormat = @"yyyy";
    
    NSString *createStr = [formatter stringFromDate:createDate];
    
    NSString *nowStr = [formatter stringFromDate:[NSDate date]];
    
    if ([createStr isEqualToString:nowStr]) {
        return YES;
    }
    
    return NO;
}


+ (NSString *)formatJSONString:(NSString *)string {
    NSString *resultString = [string stringByReplacingOccurrencesOfString:@"\\n" withString:@"\n"];
    resultString = [resultString stringByReplacingOccurrencesOfString:@"\\r" withString:@"\r"];
    resultString = [resultString stringByReplacingOccurrencesOfString:@"\n" withString:@"\\n"];
    resultString = [resultString stringByReplacingOccurrencesOfString:@"\r" withString:@"\\r"];
    return resultString;
}

//判断用户是否登录
+ (BOOL)isSignIn {
    BOOL flag = NO;
    if ([[NSUserDefaults standardUserDefaults] objectForKey:USER_NAME]) {
        if (! [[[NSUserDefaults standardUserDefaults] objectForKey:USER_NAME] isEqualToString:@""]) {
            flag = YES;
        }
    }
    return flag;
}

//退出登录
+ (void)signOut {
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:USER_ID];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:USER_ID];
    
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:USER_NAME];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:USER_NAME];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    //设置推送别名
    [JPUSHService setTags:nil alias:@"" fetchCompletionHandle:nil];
}

+ (BOOL)extractIdentity:(SecIdentityRef *)outIdentity andTrust:(SecTrustRef*)outTrust fromPKCS12Data:(NSData *)inPKCS12Data {
	OSStatus securityError = errSecSuccess;
	
    //	NSDictionary *optionsDictionary = [NSDictionary dictionaryWithObject:@"" forKey:(id)kSecImportExportPassphrase];
    
    CFStringRef password = CFSTR("EIWnsA1n6tGs"); //证书密码
    const void *keys[] =   { kSecImportExportPassphrase };
    const void *values[] = { password };
    
    CFDictionaryRef optionsDictionary = CFDictionaryCreate(NULL, keys,values, 1,NULL, NULL);
	CFArrayRef items = CFArrayCreate(NULL, 0, 0, NULL);
	securityError = SecPKCS12Import((__bridge CFDataRef)inPKCS12Data,(CFDictionaryRef)optionsDictionary,&items);
	
	if (securityError == 0) {
		CFDictionaryRef myIdentityAndTrust = CFArrayGetValueAtIndex (items, 0);
		const void *tempIdentity = NULL;
		tempIdentity = CFDictionaryGetValue (myIdentityAndTrust, kSecImportItemIdentity);
		*outIdentity = (SecIdentityRef)tempIdentity;
		const void *tempTrust = NULL;
		tempTrust = CFDictionaryGetValue (myIdentityAndTrust, kSecImportItemTrust);
		*outTrust = (SecTrustRef)tempTrust;
	} else {
		NSLog(@"Failed with error code %d",(int)securityError);
        CFRelease(optionsDictionary);
        CFRelease(items);
		return NO;
	}
    CFRelease(optionsDictionary);
    CFRelease(items);
	return YES;
}

//调用拨打电话功能 拼接电话号码
+ (void)callPhone:(NSString *)num {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[@"telprompt://" stringByAppendingString:num]]];
}

//用NSUserDefaults来保存用户注册的用户名密码。
+ (NSString *)getCache:(NSString *)k {
    NSString *v = [[NSUserDefaults standardUserDefaults] objectForKey:k];
    if (!v) {
        v = @"";
    }
    return v;
}
+ (void)putCache:(NSString *)k value:(NSString *)v {
    [[NSUserDefaults standardUserDefaults] setObject:v forKey:k];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    if ([k isEqualToString:USER_ID])
    {
        //设置推送别名
        [JPUSHService setTags:nil alias:v fetchCompletionHandle:nil];
    }
    
}

+ (void)saveCookie {
    NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookiesForURL: [NSURL URLWithString:API_URL]];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:cookies];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"UserDefaultsCookie"];
}
+ (void)setCookie {
    NSData *cookiesdata = [[NSUserDefaults standardUserDefaults] objectForKey:@"UserDefaultsCookie"];
    if([cookiesdata length]) {
        NSArray *cookies = [NSKeyedUnarchiver unarchiveObjectWithData:cookiesdata];
        NSHTTPCookie *cookie;
        for (cookie in cookies) {
            NSLog(@"cookie:%@",cookie);
            [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
        }  
    }
}
+ (void)cleanCookie {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"UserDefaultsCookie"];
}

//MD5加密。
+ (NSString *)md5:(NSString *)value {
    char hexDigits[] = { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f' };
    
    const char * cStr = [value UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    
    int j = 16;
    unsigned char str[48];
    int k = 0;
    for (int i = 0; i < j; i++)
    {
        Byte byte0 = result[i];
        str[k++] = hexDigits[byte0 >> 4 & 0xf];
        str[k++] = hexDigits[byte0 & 0xf];
        str[k++] = hexDigits[byte0 & 3];
    }
    NSString *strNSString = [NSString stringWithFormat:@"%s",str];//[[[NSString alloc] initWithCString:str encoding:NSASCIIStringEncoding] autorelease];
    
    return [strNSString substringToIndex:48];
}

+ (NSString *)customer_md5:(NSString *)value {
    if ([value isEqualToString:@""])
    {
        return @"";
    }
    const char * cStr = [value UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    NSString *output = [NSString stringWithFormat:
                        @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                        result[0], result[1], result[2], result[3],
                        result[4], result[5], result[6], result[7],
                        result[8], result[9], result[10], result[11],
                        result[12], result[13], result[14], result[15]
                        ];
    return output.uppercaseString;
}

+ (NSString *)getSignature {
    if ([SystemUtil isSignIn])
    {
        NSString *pw = [SystemUtil getCache:USER_PW];//@"123456";//
        NSString *pw_md5 = [SystemUtil customer_md5:pw];
        long long customId = [[SystemUtil getCache:USER_ID] longLongValue];
        NSString *toHex = [SystemUtil ToHex:customId];
        NSString *signature = [SystemUtil customer_md5:[NSString stringWithFormat:@"%@%@",pw_md5,toHex]];

        return signature;
    }
    else
    {
        return @"";
    }
}

+ (NSString *)ToHex:(long long int)tmpid {
    NSString *nLetterValue;
    NSString *str =@"";
    long long int ttmpig;
    for (int i = 0; i<9; i++) {
        ttmpig=tmpid%16;
        tmpid=tmpid/16;
        switch (ttmpig)
        {
            case 10:
                nLetterValue =@"A";break;
            case 11:
                nLetterValue =@"B";break;
            case 12:
                nLetterValue =@"C";break;
            case 13:
                nLetterValue =@"D";break;
            case 14:
                nLetterValue =@"E";break;
            case 15:
                nLetterValue =@"F";break;
            default:nLetterValue=[[NSString alloc]initWithFormat:@"%lli",ttmpig];
                
        }
        str = [nLetterValue stringByAppendingString:str];
        if (tmpid == 0) {
            break;  
        }  
        
    }  
    return str;  
}

+ (NSString *)getAppVersion {
    return [NSString stringWithFormat:@"iOS%@",[[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString*)kCFBundleVersionKey]];
}

+ (NSString *)getIOSVersion {
    NSString *version = [[UIDevice currentDevice] systemVersion];
    NSString *systemName = [[UIDevice currentDevice] systemName];
    return [NSString stringWithFormat:@"%@ %@", systemName,version];
}

+ (NSString *)deviceString {
    // 需要#import "sys/utsname.h"
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    return platform;
}

+ (NSString *)getKeychainIDFA {
    return [KeychainIDFA IDFA];
}

+ (NSString *)getUUIDForDevice {
    return [FCUUID uuidForDevice];
}

+ (NSString *)getAsteristString:(NSString *)str {
    if ([SystemUtil isNotNSnull:str] && [str length]>8)
    {
        NSRange range=NSMakeRange(4,[str length]-8);
        NSString *string = [str stringByReplacingCharactersInRange:range withString:@"****"];
        
        return string;
    }
    
    return @"";
}

+ (NSString *)getMobileString:(NSString *)str {
    if([SystemUtil isNotNSnull:str] && [str length] == 11)
    {
        NSRange range=NSMakeRange(3,[str length]-7);
        NSString *string = [str stringByReplacingCharactersInRange:range withString:@"****"];
        
        return string;
    }
    return @"";
}

+ (UIImage *)getQinghuaiImage:(UIView *)view {
    
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, 3);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [view.layer renderInContext:context];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    CGSize imgSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, view.bounds.size.height);
    
    UIGraphicsBeginImageContextWithOptions([UIScreen mainScreen].bounds.size, NO, 3);
    [img drawInRect:CGRectMake(0, 0, imgSize.width, imgSize.height)];
    
    UIImage *bottomImg = [UIImage imageNamed:@"pic_share"];
    [bottomImg drawInRect:CGRectMake(-60, imgSize.height - 5, [UIScreen mainScreen].bounds.size.width + 120, [UIScreen mainScreen].bounds.size.height - imgSize.height + 5)];
    
    UIImage *img1 = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img1;
}

+ (UIImage *)getScreenImage:(UIView *)view {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    UIView *sView = appDelegate.window;
    CGRect rect = sView.frame;
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [sView.layer renderInContext:context];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImage *bottomImg = [UIImage imageNamed:@"QR_code"];
    CGFloat width = 54;
    CGFloat height = 54;
    CGSize offScreenSize = CGSizeMake(MAIN_SCREEN_WIDTH, MAIN_SCREEN_HEIGHT + 64 + 30);
    UIGraphicsBeginImageContextWithOptions(offScreenSize, NO, 0);
    
    [img drawInRect:rect];
    
    NSString *str1 = @"股怪侠APP";
    [str1 drawInRect:CGRectMake(MAIN_SCREEN_WIDTH * 0.25 + 80, MAIN_SCREEN_HEIGHT + 39, 100, 20) withAttributes:@{
                                                                                             
            NSForegroundColorAttributeName : kUIColorFromRGB(0x333333),
                       NSFontAttributeName : [UIFont boldSystemFontOfSize:15]
            
            }];
    
    NSString *str2 = @"短线淘牛股";
    [str2 drawInRect:CGRectMake(MAIN_SCREEN_WIDTH * 0.25 + 80, MAIN_SCREEN_HEIGHT + 61, 150, 15) withAttributes:@{
                    NSForegroundColorAttributeName : kUIColorFromRGB(0x333333),
                               NSFontAttributeName : [UIFont systemFontOfSize:12]
                    
                    }];
    
    CGRect bottomRect = CGRectMake(MAIN_SCREEN_WIDTH * 0.25 + 10, MAIN_SCREEN_HEIGHT + 30 , width , height);
    [bottomImg drawInRect:bottomRect];
    
    UIImage *imagez = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return imagez;
}

+ (UIImage *)getStockShareImg:(UIView *)navBar and:(UIView *)view {

    UIGraphicsBeginImageContextWithOptions(CGSizeMake(MAIN_SCREEN_WIDTH, 64), NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [navBar.layer renderInContext:context];
    UIImage *navImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, 0);
    CGContextRef context1 = UIGraphicsGetCurrentContext();
    [view.layer renderInContext:context1];
    UIImage *stockImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImage *bottomImg = [UIImage imageNamed:@"QR_code"];
    
    UIGraphicsBeginImageContextWithOptions([UIScreen mainScreen].bounds.size, NO, 0);
    [navImg drawInRect:CGRectMake(0, 0, MAIN_SCREEN_WIDTH, 64)];
    [stockImg drawInRect:CGRectMake(0, 64, MAIN_SCREEN_WIDTH, view.bounds.size.height)];
    CGFloat height = 64 + view.bounds.size.height;
    CGFloat delH = MAIN_SCREEN_HEIGHT - height;
    CGFloat bottomY = (delH - 54 * kScale) / 2 + height;
    NSString *str1 = @"股怪侠APP";
    [str1 drawInRect:CGRectMake(MAIN_SCREEN_WIDTH * 0.25 + 80 * kScale, bottomY + 9 * kScale, 100 * kScale, 20 * kScale) withAttributes:@{
                                                                                                                  
                                                                                                                  NSForegroundColorAttributeName : kUIColorFromRGB(0x333333),
                                                                                                                  NSFontAttributeName : [UIFont boldSystemFontOfSize:15 * kScale]
                                                                                                                  
                                                                                                                  }];
    
    NSString *str2 = @"短线淘牛股";
    [str2 drawInRect:CGRectMake(MAIN_SCREEN_WIDTH * 0.25 + 80 * kScale, bottomY + 31 * kScale, 150 * kScale, 15 * kScale) withAttributes:@{
                                                                                                                  NSForegroundColorAttributeName : kUIColorFromRGB(0x333333),
                                                                                                                  NSFontAttributeName : [UIFont systemFontOfSize:12 * kScale]
                                                                                                                                                                                                 }];
    
    CGRect bottomRect = CGRectMake(MAIN_SCREEN_WIDTH * 0.25 + 10 * kScale, bottomY , 54 * kScale , 54 * kScale);
    [bottomImg drawInRect:bottomRect];
    
    UIImage *imagez = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return imagez;
}

+ (UIImage *)imageWithColor:(UIColor*)color andHeight:(CGFloat)height {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (BOOL)isNotNSnull:(id)value {
    if(value && ((NSNull *)value !=[NSNull null]))
    {
        if ([value isKindOfClass:NSString.class])
        {
            if ([value isEqualToString:@""])
            {
                return NO;
            }
        }
        return YES;
    }
    else
    {
        return NO;
    }
}

+ (UIImage *)reSizeImage:(UIImage *)image toSize:(CGSize)reSize {
    UIGraphicsBeginImageContext(CGSizeMake(reSize.width, reSize.height));
    [image drawInRect:CGRectMake(0, 0, reSize.width, reSize.height)];
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return reSizeImage;
}

+ (UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize {
    UIGraphicsBeginImageContext(CGSizeMake(image.size.width * scaleSize, image.size.height * scaleSize));
    [image drawInRect:CGRectMake(0, 0, image.size.width * scaleSize, image.size.height * scaleSize)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
                                
    return scaledImage;
                                
}

+ (BOOL)stringContainsEmoji:(NSString *)string {
    __block BOOL returnValue = NO;
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length])
                               options:NSStringEnumerationByComposedCharacterSequences
                            usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                const unichar hs = [substring characterAtIndex:0];
                                if (0xd800 <= hs && hs <= 0xdbff) {
                                    if (substring.length > 1) {
                                        const unichar ls = [substring characterAtIndex:1];
                                        const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                                        if (0x1d000 <= uc && uc <= 0x1f77f) {
                                            returnValue = YES;
                                        }
                                    }
                                } else if (substring.length > 1) {
                                    const unichar ls = [substring characterAtIndex:1];
                                    if (ls == 0x20e3) {
                                        returnValue = YES;
                                    }
                                } else {
                                    if (0x2100 <= hs && hs <= 0x27ff) {
                                        returnValue = YES;
                                    } else if (0x2B05 <= hs && hs <= 0x2b07) {
                                        returnValue = YES;
                                    } else if (0x2934 <= hs && hs <= 0x2935) {
                                        returnValue = YES;
                                    } else if (0x3297 <= hs && hs <= 0x3299) {
                                        returnValue = YES;
                                    } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                                        returnValue = YES;
                                    }
                                }
                            }];
    return returnValue;
}

+ (UIColor *) hexStringToColor: (NSString *) stringToConvert {
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    
    if ([cString length] < 6) return [UIColor blackColor];
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    if ([cString length] != 6) return [UIColor blackColor];
    
    // Separate into r, g, b substrings
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
    
}

+ (UIFont *)myFont:(CGFloat)fontSize; {
    CGAffineTransform matrix1 =  CGAffineTransformMake(1, 0, tanf(15 * (CGFloat)M_PI / 180), 1, 0, 0);
    
    UIFontDescriptor *desc1 = [ UIFontDescriptor fontDescriptorWithName :[ UIFont systemFontOfSize :fontSize]. fontName matrix :matrix1];
    
    if ( IOS7_OR_LATER )
    {
        return  [UIFont fontWithDescriptor :desc1 size :fontSize];
    }
    else
    {
        return [UIFont systemFontOfSize:fontSize];
    }
}

+ (NSString *)get2decimal:(double)ff {
    double n = (ff+0.000005)*100;
    return [NSString stringWithFormat:@"%.2lf", ((double)n)/100.0];
}

+ (NSString *)get4decimal:(double)ff {
    double n = ff*10000;
    return [NSString stringWithFormat:@"%.4lf", ((double)n)/10000.0];
}

+ (NSString *)getPercentage:(double)ff; {
    double n = (ff+0.000005)*100;
    return [NSString stringWithFormat:@"%.2lf%%", ((double)n)/100.0];
}

+ (NSString *)getPrecisionPrice:(double)ff precision:(int)precision {
    NSString *str = [NSString stringWithFormat:@"%%.%dlf%%",precision];
    //NSLog(@"%@",[NSString stringWithFormat:str, precision]);
    return [NSString stringWithFormat:str, ff];
}

+ (NSString *)getPrecisionPrice:(NSString *)str {
    if ((str == nil) || [str isEqualToString:@""] || [str isEqualToString:@"<null>"])
    {
        return @"--";
    }
    else
    {
        return [NSString stringWithFormat:@"%.2lf", [str doubleValue]];
    }
}

+ (UIColor *)getStockUpDownColor:(float)value preClose:(float)preClose {
    if (value<0.000001 && value>-0.000001)
    {
        return PLAN_COLOR;

    }
    
    if (value>preClose)
    {
        return RISE_COLOR;
    }
    else if(value<preClose)
    {
        return FALL_COLOR;
    }
    else
    {
        return PLAN_COLOR;
    }
}

//+(NSString *)
+ (NSString*)DataTOjsonString:(id)object {
    NSString *jsonString = nil;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    if (! jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonString;
}

+ (NSArray *)rangesOfString:(NSString *)searchString inString:(NSString *)str {
    NSMutableArray *result = [NSMutableArray array];
    NSRange searchRange = NSMakeRange(0, str.length);
    NSRange range;
    while ((range = [str rangeOfString:searchString options:0 range:searchRange]).location != NSNotFound) {
        [result addObject:[NSValue valueWithRange:range]];
        searchRange = NSMakeRange(NSMaxRange(range), str.length - NSMaxRange(range));
    }
    return result;
}

+ (UIColor *)colorwithHexString:(NSString *)color {
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    //r
    NSString *rString = [cString substringWithRange:range];
    
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}

+ (NSString*)weekdayStringFromDate:(NSDate *)inputDate {
    
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"星期日", @"星期一", @"星期二", @"星期三", @"星期四", @"星期五", @"星期六", nil];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierChinese];
    
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    
    [calendar setTimeZone: timeZone];
    
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:inputDate];
    
    return [weekdays objectAtIndex:theComponents.weekday];
    
}

+ (NSString *)FormatNum:(NSString *)num {
    int value = [num intValue];
    if (value >= 0) {
        if (value >= DECIMAL_HUNDRED_MILLION) {
            return [NSString stringWithFormat:@"%.1f亿", (float)value/DECIMAL_HUNDRED_MILLION];
        }
        else if (value >= DECIMAL_TEN_THOUSAND) {
            return [NSString stringWithFormat:@"%.1f万", (float)value/DECIMAL_TEN_THOUSAND];
        }
        return [NSString stringWithFormat:@"%d", value];
    }
    return @"--";
}

+ (NSString *)toCapitalLetters:(NSString *)money {
    //首先转化成标准格式        “200.23”
    NSMutableString *tempStr=[[NSMutableString alloc] initWithString:[NSString stringWithFormat:@"%.2f",[money doubleValue]]];
    /*
    //位
    NSArray *carryArr1=@[@"元", @"拾", @"佰", @"仟", @"万", @"拾", @"佰", @"仟", @"亿", @"拾", @"佰", @"仟", @"兆", @"拾", @"佰", @"仟" ];
    NSArray *carryArr2=@[@"分",@"角"];
    //数字
    NSArray *numArr=@[@"零", @"壹", @"贰", @"叁", @"肆", @"伍", @"陆", @"柒", @"捌", @"玖"];
    */
    
    //位
    NSArray *carryArr1=@[@"", @"十", @"佰", @"仟", @"万", @"拾", @"佰", @"仟", @"亿", @"拾", @"佰", @"仟", @"兆", @"拾", @"佰", @"仟" ];
    //数字
    NSArray *numArr=@[@"零", @"一", @"二", @"三", @"四", @"五", @"六", @"七", @"八", @"九"];
    
    
    NSArray *temarr = [tempStr componentsSeparatedByString:@"."];
    //小数点前的数值字符串
    NSString *firstStr=[NSString stringWithFormat:@"%@",temarr[0]];
    //小数点后的数值字符串
//    NSString *secondStr=[NSString stringWithFormat:@"%@",temarr[1]];
    
    //是否拼接了“零”，做标记
    bool zero=NO;
    //拼接数据的可变字符串
    NSMutableString *endStr=[[NSMutableString alloc] init];
    
    /**
     *  首先遍历firstStr，从最高位往个位遍历    高位----->个位
     */
    
    for(int i=(int)firstStr.length;i>0;i--) {
        //取最高位数
        NSInteger MyData=[[firstStr substringWithRange:NSMakeRange(firstStr.length-i, 1)] integerValue];
        
        if ([numArr[MyData] isEqualToString:@"零"]) {
            
            if ([carryArr1[i-1] isEqualToString:@"万"]||[carryArr1[i-1] isEqualToString:@"亿"]||[carryArr1[i-1] isEqualToString:@"元"]||[carryArr1[i-1] isEqualToString:@"兆"]) {
                //去除有“零万”
                if (zero) {
                    endStr =[NSMutableString stringWithFormat:@"%@",[endStr substringToIndex:(endStr.length-1)]];
                    [endStr appendString:carryArr1[i-1]];
                    zero=NO;
                }else{
                    [endStr appendString:carryArr1[i-1]];
                    zero=NO;
                }
                
                //去除有“亿万”、"兆万"的情况
                if ([carryArr1[i-1] isEqualToString:@"万"]) {
                    if ([[endStr substringWithRange:NSMakeRange(endStr.length-2, 1)] isEqualToString:@"亿"]) {
                        endStr =[NSMutableString stringWithFormat:@"%@",[endStr substringToIndex:endStr.length-1]];
                    }
                    
                    if ([[endStr substringWithRange:NSMakeRange(endStr.length-2, 1)] isEqualToString:@"兆"]) {
                        endStr =[NSMutableString stringWithFormat:@"%@",[endStr substringToIndex:endStr.length-1]];
                    }
                    
                }
                //去除“兆亿”
                if ([carryArr1[i-1] isEqualToString:@"亿"]) {
                    if ([[endStr substringWithRange:NSMakeRange(endStr.length-2, 1)] isEqualToString:@"兆"]) {
                        endStr =[NSMutableString stringWithFormat:@"%@",[endStr substringToIndex:endStr.length-1]];
                    }
                }
                
                
            }else{
                if (!zero) {
                    [endStr appendString:numArr[MyData]];
                    zero=YES;
                }
                
            }
            
        }else{
            //拼接数字
            [endStr appendString:numArr[MyData]];
            //拼接位
            [endStr appendString:carryArr1[i-1]];
            //不为“零”
            zero=NO;
        }
    }
    
    /**
     *  再遍历secondStr    角位----->分位
     */
    /*
    if ([secondStr isEqualToString:@"00"]) {
        [endStr appendString:@"整"];
    }else{
        for(int i=(int)secondStr.length;i>0;i--)
        {
            //取最高位数
            NSInteger MyData=[[secondStr substringWithRange:NSMakeRange(secondStr.length-i, 1)] integerValue];
            
            [endStr appendString:numArr[MyData]];
            [endStr appendString:carryArr2[i-1]];
        }
    }
    */
    return endStr;
}

+ (NSString *)FormatValue:(NSString *)valueStr dig:(int)dig {
    float value = [valueStr floatValue];
    if (value > 0.000001) {
        if (value >= DECIMAL_HUNDRED_MILLION) {
            NSString * sfmt = [NSString stringWithFormat:@"%%.%df亿", dig];
            return [NSString stringWithFormat:sfmt, (float)value/DECIMAL_HUNDRED_MILLION];
        }
        else if (value >= DECIMAL_TEN_THOUSAND) {
            NSString * sfmt = [NSString stringWithFormat:@"%%.%df万", dig];
            return [NSString stringWithFormat:sfmt, (float)value/DECIMAL_TEN_THOUSAND];
        }
        NSString * sfmt = [NSString stringWithFormat:@"%%.%df", dig];
        return [NSString stringWithFormat:sfmt, value];
    }
    return @"--";
}

+ (NSString *)FormatFloatValue:(float)value dig:(int)dig {
    if (value > -0.000001) {
        if (value >= DECIMAL_HUNDRED_MILLION) {
            NSString * sfmt = [NSString stringWithFormat:@"%%.%df亿", dig];
            return [NSString stringWithFormat:sfmt, (float)value/DECIMAL_HUNDRED_MILLION];
        }
        else if (value >= DECIMAL_TEN_THOUSAND) {
            NSString * sfmt = [NSString stringWithFormat:@"%%.%df万", dig];
            return [NSString stringWithFormat:sfmt, (float)value/DECIMAL_TEN_THOUSAND];
        }
        NSString * sfmt = [NSString stringWithFormat:@"%%.%df", dig];
        return [NSString stringWithFormat:sfmt, value];
    }
    return @"--";
}

+ (BOOL)isPureInt:(NSString*)string {
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}

+ (BOOL)isPureFloat:(NSString*)string {
    NSScanner* scan = [NSScanner scannerWithString:string];
    float val;
    return[scan scanFloat:&val] && [scan isAtEnd];
}

+ (UIColor *)getRatioColorWithAsk:(NSString *)ask bid:(NSString *)bid presentPrice:(NSString *)presentPrice {
    UIColor *color = PLAN_COLOR;
    
    NSLog(@"isPureFloat:%d",[SystemUtil isPureFloat:ask]);
    NSLog(@"isPureFloat:%d",[SystemUtil isPureFloat:bid]);
    NSLog(@"isPureFloat:%d",[SystemUtil isPureFloat:presentPrice]);
    if (![SystemUtil isNotNSnull:ask] || ![SystemUtil isNotNSnull:bid] || ![SystemUtil isNotNSnull:presentPrice])
    {
        return color;
    }
    if(ask.floatValue<0.000001 || bid.floatValue<0.000001 || presentPrice.floatValue<0.000001)
    {
        return color;
    }
    
    double askVal = ask.doubleValue;
    double bidVal = bid.doubleValue;
    double preVal = presentPrice.doubleValue;
    
    if (preVal>=askVal){
        color = RISE_COLOR;
    }else if(bidVal>=preVal){
        color = FALL_COLOR;
    }
    
    return color;
}


- (NSString *)getBinaryByhex:(NSString *)hex {
    NSMutableDictionary  *hexDic;// = [[NSMutableDictionary alloc] init];
    
    hexDic = [[NSMutableDictionary alloc] initWithCapacity:16];
    
    [hexDic setObject:@"0000" forKey:@"0"];
    
    [hexDic setObject:@"0001" forKey:@"1"];
    
    [hexDic setObject:@"0010" forKey:@"2"];
    
    [hexDic setObject:@"0011" forKey:@"3"];
    
    [hexDic setObject:@"0100" forKey:@"4"];
    
    [hexDic setObject:@"0101" forKey:@"5"];
    
    [hexDic setObject:@"0110" forKey:@"6"];
    
    [hexDic setObject:@"0111" forKey:@"7"];
    
    [hexDic setObject:@"1000" forKey:@"8"];
    
    [hexDic setObject:@"1001" forKey:@"9"];
    
    [hexDic setObject:@"1010" forKey:@"A"];
    
    [hexDic setObject:@"1011" forKey:@"B"];
    
    [hexDic setObject:@"1100" forKey:@"C"];
    
    [hexDic setObject:@"1101" forKey:@"D"];
    
    [hexDic setObject:@"1110" forKey:@"E"];
    
    [hexDic setObject:@"1111" forKey:@"F"];
    
    NSMutableString *binaryString=[[NSMutableString alloc] init];
    
    for (int i=0; i<[hex length]; i++) {
        
        NSRange rage;
        
        rage.length = 1;
        
        rage.location = i;
        
        NSString *key = [hex substringWithRange:rage];
        
        //NSLog(@"%@",[NSString stringWithFormat:@"%@",[hexDic objectForKey:key]]);
        NSString *s = [NSString stringWithFormat:@"%@%@",binaryString,[NSString stringWithFormat:@"%@",[hexDic objectForKey:key]]];
        
        binaryString = [NSMutableString stringWithString:s];
        
    }
    
    //NSLog(@"转化后的二进制为:%@",binaryString);
    
    return binaryString;
    
}
+ (NSString*)getSha256:(NSString *)str {
    const char *cstr = [str cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:str.length];
    
    uint8_t digest[CC_SHA256_DIGEST_LENGTH];
    
    CC_SHA256(data.bytes, (CC_LONG)data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA256_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA256_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
}
+ (NSString *)getSHA256Key:(NSString *)str {
    CocoaSecurityResult *sha256 = [CocoaSecurity sha256:str];
//    NSLog(@"%@",sha256);
//    NSLog(@"%@",sha256.hex);
//    NSLog(@"%@",sha256.hexLower);
//    NSLog(@"%@",sha256.data);
//    NSLog(@"%@",[SystemUtil dataToHexString:sha256.data]);
//    Byte *bytes = (Byte *)[sha256.data bytes];

    return sha256.hexLower;
}
+ (NSString *)dataToHexString:(NSData *)data {
    NSUInteger len = [data length];
    char *chars = (char *)[data bytes];
    NSMutableString *hexString = [[NSMutableString alloc] init];
    for (NSUInteger i=0; i<len; i++) {
        [hexString appendString:[NSString stringWithFormat:@"%0.2hhx",chars[i]]];
    }
    return hexString;
}
+ (NSString *)getAESPw:(NSString *)pw {
    //NSString *pwd = [SystemUtil getRandomPw:pw];
    NSString *pwd = [SystemUtil customer_md5:pw].lowercaseString;
    //NSString *pwd = [CocoaSecurity md5:pw].hexLower;
    NSString *deviceId = [SystemUtil getUUIDForDevice];//[SystemUtil getUUIDForDevice];//@"linkage";//

    //NSString *hexKey = [SystemUtil getSHA256Key:deviceId];

    NSString *encryptedData = [AESCrypt encrypt:pwd password:deviceId];

    NSLog(@"%@",encryptedData);
    
    

//    CocoaSecurityResult *aes256 = [CocoaSecurity aesEncrypt:pwd
//                                                     hexKey:hexKey
//                                                      hexIv:SECRET_HEX_KEY];
//
//    NSLog(@"%@",aes256.utf8String);
//    NSLog(@"%@",aes256.hexLower);
//    NSLog(@"%@",aes256.base64);
//    NSLog(@"%@",aes256.hex);
//    NSLog(@"%@",aes256.data);
//
//    CocoaSecurityResult *aes256Decrypt = [CocoaSecurity aesDecryptWithBase64:aes256.base64
//                                                                      hexKey:hexKey
//                                                                       hexIv:SECRET_HEX_KEY];
//    NSLog(@"aesDecryptWithBase64:%@",aes256Decrypt.utf8String);

    
    return encryptedData;//aes256.hexLower;

    
    //        AESCryptoHelper *help = [[AESCryptoHelper alloc] initWithKey:hexKey mode:MODE_CBC];//hexKey//SECRET_HEX_KEY
    //        NSString *str = [help encryptPlainText:pwd];
    
//    
//    
//    return str;
    
//    NSData* data=[pw dataUsingEncoding:NSUTF8StringEncoding]; //NSString转NSData
//    NSData *data1 =  [data AES128EncryptWithKey:hexKey iv:SECRET_HEX_KEY];
//    NSString *str = [[NSString alloc] initWithData:data1 encoding:NSUTF8StringEncoding]; //NSData转NSStringNSASCIIStringEncoding
//    char *test=[data1 bytes];
//    NSLog(@"%@",str);

}
+ (NSString *)getRandomPw:(NSString *)pw {
    srand((unsigned)time(0)); //不加这句每次产生的随机数不变
    int i = rand() % 1000000;
    return [NSString stringWithFormat:@"%@|%d",pw,i];
//    //第二种
//    srandom(time(0));
//    int i = random() % 5;
//    //第三种
//    int i = arc4random() % 5 ;
}

@end
