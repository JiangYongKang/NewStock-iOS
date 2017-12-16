//
//  MyStockTopView.h
//  NewStock
//
//  Created by 王迪 on 2017/6/5.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MyStockTopView;

@protocol MyStockTopViewDelegate <NSObject>

@required

- (void)myStockTopViewPushToStock:(NSString *)t s:(NSString *)s n:(NSString *)n m:(NSString *)m;

- (void)myStockTopViewPushToNative:(NSString *)url;

@end

@interface MyStockTopView : UIView

@property (nonatomic, weak) id <MyStockTopViewDelegate> delegate;

- (void)setCode:(NSString *)code zx:(NSString *)zx zdf:(NSString *)zdf;

@end
