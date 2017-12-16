//
//  QingHuaiBottomView.h
//  NewStock
//
//  Created by 王迪 on 2017/1/13.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QingHuaiBottomView : UIView

@property (nonatomic, assign) NSInteger page;

@property (nonatomic, copy) void (^colorBlock)(UIColor *);

@property (nonatomic, copy) void (^pageBlock)(NSInteger);

@end
