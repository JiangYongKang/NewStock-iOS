//
//  BoardListModel.h
//  NewStock
//
//  Created by Willey on 16/8/7.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface BoardListModel : MTLModel<MTLJSONSerializing>
@property (nonatomic, strong) NSString * symbol;
@property (nonatomic, strong) NSString * symbolTyp;
@property (nonatomic, strong) NSString * marketCd;
@property (nonatomic, strong) NSString * industryName;
@property (nonatomic, strong) NSString * industryUp;
@property (nonatomic, strong) NSString * riseCount;
@property (nonatomic, strong) NSString * keepCount;
@property (nonatomic, strong) NSString * fallCount;

@property (nonatomic, strong) NSString * leadingStock;
@property (nonatomic, strong) NSString * leadingStockName;


@end
