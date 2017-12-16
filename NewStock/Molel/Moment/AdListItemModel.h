//
//  AdListItemModel.h
//  NewStock
//
//  Created by Willey on 16/8/22.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface AdListItemModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, strong) NSString * adId;
@property (nonatomic, strong) NSString * img;
@property (nonatomic, strong) NSString * tt;
@property (nonatomic, strong) NSString * ty;
@property (nonatomic, strong) NSString * url;

@end
