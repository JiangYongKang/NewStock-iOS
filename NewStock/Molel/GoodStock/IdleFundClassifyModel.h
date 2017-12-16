//
//  IdleFundClassifyModel.h
//  NewStock
//
//  Created by 王迪 on 2017/2/15.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import <Mantle/Mantle.h>
#import <UIKit/UIKit.h>

@interface IdleFundClassifyModel : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy) NSString *n;

@property (nonatomic, copy) NSString *s;

@end
