//
//  StockInfoView.h
//  NewStock
//
//  Created by Willey on 16/7/29.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,STOCKINFOVIEWTYPE) {
    STOCKINFOVIEWTYPE_INDEX,
    STOCKINFOVIEWTYPE_STOCK
};

@protocol StockInfoViewDelegate;


@interface StockInfoView : UIView<UIGestureRecognizerDelegate>
{    
    UILabel *_lbValue;
    UILabel *_lbChange;
    UILabel *_lbChangeRate;
    
    UILabel *_lbHeighest;
    UILabel *_lbAmount;
    UILabel *_lbLowest;
    UILabel *_lbVolume;
    UILabel *_lbTurnoverRate; //新增换手率 lb
    UILabel *_lbSwing;         //新增振幅 lb
    UILabel *_lbOpen;         //新增今开 lb
}
@property (weak, nonatomic) id<StockInfoViewDelegate> delegate;

- (id)initWithDelegate:(id)theDelegate :(STOCKINFOVIEWTYPE)type;

- (void)setCode:(NSString *)code
          value:(NSString *)value
         change:(NSString *)change
     changeRate:(NSString *)changeRate
        highest:(NSString *)highest
         amount:(NSString *)amount
         lowest:(NSString *)lowest
         volume:(NSString *)volume
   turnoverRate:(NSString *)turnoverRate
           open:(NSString *)open
          swing:(NSString *)swing
      prevClose:(NSString *)prevClose;
@end


@protocol StockInfoViewDelegate <NSObject>
@optional
- (void)stockInfoView:(StockInfoView *)stockInfoView;
@end
