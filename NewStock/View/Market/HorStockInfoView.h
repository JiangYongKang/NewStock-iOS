//
//  HorStockInfoView.h
//  NewStock
//
//  Created by Willey on 16/11/2.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol HorStockInfoViewDelegate;

@interface HorStockInfoView : UIView<UIGestureRecognizerDelegate>
{
    UILabel *_lbName;
    UILabel *_lbValue;
    UILabel *_lbChange;
    UILabel *_lbChangeRate;
    
    UILabel *_lbHeighest;
    UILabel *_lbAmount;
    UILabel *_lbLowest;
    UILabel *_lbVolume;

    
    UILabel *_lbTime;

    BOOL _bShowCode;
    
}
@property (weak, nonatomic) id<HorStockInfoViewDelegate> delegate;

- (id)initWithDelegate:(id)theDelegate;

- (void)setCode:(NSString *)code
           name:(NSString *)name
          value:(NSString *)value
         change:(NSString *)change
     changeRate:(NSString *)changeRate
         volume:(NSString *)volume
           time:(NSString *)time;

@end


@protocol HorStockInfoViewDelegate <NSObject>
@optional
- (void)horStockInfoView:(HorStockInfoView*)horStockInfoView;
@end

