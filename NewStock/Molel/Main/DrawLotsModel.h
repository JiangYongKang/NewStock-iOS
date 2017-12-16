//
//  DrawLotsModel.h
//  NewStock
//
//  Created by Willey on 16/11/14.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface DrawLotsModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, strong) NSString * mId;
@property (nonatomic, strong) NSString * no;
@property (nonatomic, strong) NSString * n;
@property (nonatomic, strong) NSString * vc;
@property (nonatomic, strong) NSString * rn;
@property (nonatomic, strong) NSString * funcUrl;

@property (nonatomic, assign) BOOL  had;

@property (nonatomic, strong) NSArray * contentArr;

@end
