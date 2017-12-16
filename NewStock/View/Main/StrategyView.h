//
//  StrategyView.h
//  NewStock
//
//  Created by Willey on 16/8/16.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"

@protocol StrategyViewDelegate;

@interface StrategyView : UIView<UIGestureRecognizerDelegate>
{
    UIImageView *_bgImgView;
    UILabel *_titleLb;
    UILabel *_descLb;
}
@property (weak, nonatomic) id<StrategyViewDelegate> delegate;

- (void)setDelegate:(id)theDelegate tag:(int)tag;

-(void)setImgUrl:(NSString *)url;
-(void)setTitle:(NSString *)title content:(NSString *)content;
@end



@protocol StrategyViewDelegate <NSObject>
@optional
- (void)strategyView:(StrategyView*)strategyView tag:(NSUInteger)tag;
@end
