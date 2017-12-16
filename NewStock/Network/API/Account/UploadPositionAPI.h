//
//  UploadPositionAPI.h
//  NewStock
//
//  Created by Willey on 16/8/30.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "APIRequest.h"

@interface UploadPositionAPI : APIRequest

@property (nonatomic, strong) NSString *symbol;
@property (nonatomic, strong) NSString *symbolTyp;
@property (nonatomic, strong) NSString *marketCd;

@property (nonatomic, strong) NSString *qty;
@property (nonatomic, strong) NSString *inPrice;

@end
