//
//  StockCodesModel.h
//  NewStock
//
//  Created by Willey on 16/8/3.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface StockCodesModel : MTLModel<MTLJSONSerializing>
@property (nonatomic, strong) NSString * modified;
@property (nonatomic, strong) NSString * lastModified;
@property (nonatomic, strong) NSArray * gxCodeList;
@end






@interface StockCodeInfo : MTLModel<MTLJSONSerializing>
@property (nonatomic, strong) NSString * t;//类型
@property (nonatomic, strong) NSString * s;//股票代码
@property (nonatomic, strong) NSString * m;//证券市场类型
@property (nonatomic, strong) NSString * n;//名称
@property (nonatomic, strong) NSString * p;//拼音缩写
@property (nonatomic, strong) NSString * d;//描述
@property (nonatomic, strong) NSString * h;//
@property (nonatomic, strong) NSString * r;//
@property (nonatomic, strong) NSString * th;//

@end