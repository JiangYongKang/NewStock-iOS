//
//  MessageModel.h
//  NewStock
//
//  Created by Willey on 16/10/18.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface MessageModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, strong) NSString * c;
@property (nonatomic, strong) NSString * ico;
@property (nonatomic, strong) NSString * mId;
@property (nonatomic, strong) NSString * tm;
@property (nonatomic, strong) NSString * tt;
@property (nonatomic, strong) NSString * ty;
@property (nonatomic, strong) NSString * url;

@end
