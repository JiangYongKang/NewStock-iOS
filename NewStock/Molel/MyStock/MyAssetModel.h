//
//  MyAssetModel.h
//  NewStock
//
//  Created by 王迪 on 2017/1/12.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface MyAssetModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, copy) NSString *allEarnings;
@property (nonatomic, copy) NSString *bookValue;
@property (nonatomic, copy) NSString *cost;
@property (nonatomic, copy) NSString *currEarnings;
@property (nonatomic, strong) NSArray *posList;
@end


@interface MyAssetListModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, copy) NSString *symbolName;
@property (nonatomic, copy) NSString *symbol;
@property (nonatomic, copy) NSString *symbolTyp;
@property (nonatomic, copy) NSString *marketCd;
@property (nonatomic, copy) NSString *inPrice;
@property (nonatomic, copy) NSString *qty;
@property (nonatomic, copy) NSString *currPrice;
@property (nonatomic, copy) NSString *currEarnings;
@property (nonatomic, copy) NSString *allEarnings;
@property (nonatomic, copy) NSString *marketValue;
@property (nonatomic, copy) NSString *amplitude;
@end


