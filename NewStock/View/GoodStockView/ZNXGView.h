//
//  ZNXGView.h
//  NewStock
//
//  Created by 王迪 on 2017/3/9.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaoIndexModel.h"

@interface ZNXGView : UIView

@property (nonatomic, strong) TaoIndexModelList *model;

@property (nonatomic, copy) void(^urlBlock)(NSString *);
@property (nonatomic, copy) void(^pushBlcok)(TaoIndexModelClildStock *);

@end
