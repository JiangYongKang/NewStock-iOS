//
//  NSData+Encryption.h
//  NewStock
//
//  Created by Willey on 16/8/25.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (Encryption)

- (NSData *)AES256ParmEncryptWithKey:(NSString *)key;   //加密
- (NSData *)AES256ParmDecryptWithKey:(NSString *)key;   //解密

@end
