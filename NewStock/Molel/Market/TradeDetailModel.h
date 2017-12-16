//
//  TradeDetailModel.h
//  NewStock
//
//  Created by Willey on 16/8/12.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface TradeDetailModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, strong) NSString * ask;
@property (nonatomic, strong) NSString * bid;
@property (nonatomic, strong) NSString * hand;
@property (nonatomic, strong) NSString * largeOrder;
@property (nonatomic, strong) NSString * presentPrice;
@property (nonatomic, strong) NSString * prevClose;
@property (nonatomic, strong) NSString * pricePrecision;
@property (nonatomic, strong) NSDate * time;
@property (nonatomic, strong) NSString * volume;

@property (nonatomic, strong) NSString * stroke;

@end
