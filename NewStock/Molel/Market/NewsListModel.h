//
//  NewsListModel.h
//  NewStock
//
//  Created by Willey on 16/8/17.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface NewsListModel : MTLModel<MTLJSONSerializing>
@property (nonatomic, strong) NSString * m;
@property (nonatomic, strong) NSString * n;
@property (nonatomic, strong) NSString * nid;
@property (nonatomic, strong) NSString * s;
@property (nonatomic, strong) NSString * t;
@property (nonatomic, strong) NSString * tm;
@property (nonatomic, strong) NSString * tt;

@end
