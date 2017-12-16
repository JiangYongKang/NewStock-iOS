//
//  ThemeTimeLineModel.h
//  NewStock
//
//  Created by 王迪 on 2017/5/10.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import <Mantle/Mantle.h>
#import "MainPageModel.h"

@interface ThemeTimeLineModel : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong) NSString *tt;
@property (nonatomic, strong) NSArray *list;

@end
