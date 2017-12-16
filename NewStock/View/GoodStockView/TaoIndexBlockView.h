//
//  TaoIndexBlockView.h
//  NewStock
//
//  Created by 王迪 on 2017/3/10.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaoIndexModel.h"

@interface TaoIndexBlockView : UIView

@property (nonatomic, copy) NSString *btnTitle;

@property (nonatomic, copy) NSString *btnImg;

@property (nonatomic, copy) NSString *dsc;

@property (nonatomic, strong) NSArray *dataArray;

@property (nonatomic, assign) NSInteger index;

@property (nonatomic, copy) void(^moreBlock)();

@property (nonatomic, copy) void(^pushBlock)(TaoIndexModelClildStock *);

@end
