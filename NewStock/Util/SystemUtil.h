//
//  SystemUtil.h
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define DECIMAL_TEN_THOUSAND 10000.0				//1万
#define DECIMAL_HUNDRED_THOUSAND 100000.0			//10万
#define DECIMAL_HUNDRED_MILLION  100000000.0		//1亿
#define DECIMAL_BILLION  1000000000.0               //10亿

//#define SECRET_HEX_KEY  @"AB1002321050AFBCDE708A9BC3F4889A"
#define SECRET_HEX_KEY  @"00000000000000000000000000000000"


@interface SystemUtil : NSObject

+ (BOOL)isIPhone5; // iPhone 5 screen size

+ (float)systemVersion; // get the system version

+ (NSArray *)rangesOfString:(NSString *)searchString inString:(NSString *)str;

+ (UIColor *)colorwithHexString:(NSString *)color;

+ (NSString *)saveFileToDocuments:(NSString *)url;

+ (NSString *)trimTheDate:(NSString *)date;

+ (NSString *)getDateString:(NSString *)date;

+ (NSString *)formatJSONString:(NSString *)string;

+ (NSString*)weekdayStringFromDate:(NSDate *)inputDate;

+ (BOOL)isSignIn;

+ (void)signOut;



+ (BOOL)extractIdentity:(SecIdentityRef *)outIdentity andTrust:(SecTrustRef*)outTrust fromPKCS12Data:(NSData *)inPKCS12Data;

+ (void)callPhone:(NSString *)num;

+ (NSString *)getCache:(NSString *)k;
+ (void)putCache:(NSString *)k value:(NSString *)v;

+ (void)saveCookie;
+ (void)setCookie;
+ (void)cleanCookie;

+ (NSString *)md5:(NSString *)value;
+ (NSString *)customer_md5:(NSString *)value;
+ (NSString *)ToHex:(long long int)tmpid;
+ (NSString *)getSignature;

+ (NSString *)getAppVersion;
+ (NSString*)deviceString;
+ (NSString *)getKeychainIDFA;
+ (NSString *)getUUIDForDevice;
+ (NSString *)getIOSVersion;

+ (NSString *)getMobileString:(NSString *)str;
+ (NSString *)getAsteristString:(NSString *)str;

+ (UIImage *)getScreenImage:(UIView *)view;
+ (UIImage *)getStockShareImg:(UIView *)navBar and:(UIView *)view;
+ (UIImage *)getQinghuaiImage:(UIView *)view;
+ (UIImage*)imageWithColor:(UIColor*)color andHeight:(CGFloat)height;

+ (BOOL)isNotNSnull:(id)value;

+ (UIImage *)reSizeImage:(UIImage *)image toSize:(CGSize)reSize;
+ (UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize;

+ (BOOL)stringContainsEmoji:(NSString *)string;

+ (UIColor *) hexStringToColor: (NSString *) stringToConvert;

+ (UIFont *)myFont:(CGFloat)fontSize;

+ (NSString *)get2decimal:(double)ff;
+ (NSString *)get4decimal:(double)ff;
+ (NSString *)getPercentage:(double)ff;

+ (NSString *)getPrecisionPrice:(double)ff precision:(int)precision;
+ (NSString *)getPrecisionPrice:(NSString *)str;

+ (UIColor *)getStockUpDownColor:(float)value preClose:(float)preClose;

+ (NSString*)DataTOjsonString:(id)object;


+ (NSString *)toCapitalLetters:(NSString *)money;

//
+ (NSString *)FormatNum:(NSString *)num;
+ (NSString *)FormatValue:(NSString *)valueStr dig:(int)dig;
+ (NSString *)FormatFloatValue:(float)value dig:(int)dig;

+ (BOOL)isPureInt:(NSString*)string;

+ (BOOL)isPureFloat:(NSString*)string;

+ (UIColor *)getRatioColorWithAsk:(NSString *)ask bid:(NSString *)bid presentPrice:(NSString *)presentPrice;
/**
 *  1) 取deviceID(getUUIDForDevice)为密钥；
 *  2) 后台提供一个16字节的二进制数据，作为序列化用的参数；（代码中通过配置写死）SECRET_HEX_KEY
 *  3) 前台加密过程
 *  a) 对deviceID执行SHA256签名，得到一个32位字节；
 *  b) 使用 a)中的32字节，以及2)中的16位初始化字节，初始化AES加密算法；
 *  c) 通过AES加密字符串  <密码> + "|" + <随机数>
 *  参照： 利用上述加密算法，使用密钥linkage，对字符串jiabei加密的结果是： CA045E28AA2B
 *
 *  @param outIdentity  <#outIdentity description#>
 *  @param outTrust     <#outTrust description#>
 *  @param inPKCS12Data <#inPKCS12Data description#>
 *
 *  @return <#return value description#>
 */
//+ (NSString *)getBinaryByhex:(NSString *)hex;
+ (NSString*)getSha256:(NSString *)str;
+ (NSString *)getSHA256Key:(NSString *)str;
+ (NSString *)dataToHexString:(NSData *)data;

+ (NSString *)getAESPw:(NSString *)pw;
+ (NSString *)getRandomPw:(NSString *)pw;
@end
