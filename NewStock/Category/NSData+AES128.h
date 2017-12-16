//
//  NSData+AES128.h
//  NewStock
//
//  Created by Willey on 16/8/19.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCryptor.h>

@interface NSData (AES128)
- (NSData *)AES128Operation:(CCOperation)operation key:(NSString *)key iv:(NSString *)iv;
- (NSData *)AES128EncryptWithKey:(NSString *)key iv:(NSString *)iv;
- (NSData *)AES128DecryptWithKey:(NSString *)key iv:(NSString *)iv;
@end
