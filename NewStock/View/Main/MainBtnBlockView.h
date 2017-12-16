//
//  MainBtnBlockView.h
//  NewStock
//
//  Created by 王迪 on 2017/3/13.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainPageModel.h"

@interface MainBtnBlockView : UIView

@property (nonatomic, copy) void(^pushBlock)(NSString *);

@property (nonatomic, strong) NSArray <LinksModel *> *array;

@end
