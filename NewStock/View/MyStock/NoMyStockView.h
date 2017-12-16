//
//  NoMyStockView.h
//  NewStock
//
//  Created by Willey on 16/9/27.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, NO_RECORD_TYPE) {
    NO_RECORD_TYPE_STOCK,
    NO_RECORD_TYPE_NEWS,
    NO_RECORD_TYPE_HOLD,
};


@protocol NoMyStockViewDelegate;

@interface NoMyStockView : UIView
{
    UIButton *_btn;
    UILabel *_tipsLb;
}
@property (weak, nonatomic) id<NoMyStockViewDelegate> delegate;

-(void)setType:(NO_RECORD_TYPE)type;
@end



@protocol NoMyStockViewDelegate <NSObject>
@optional
- (void)noMyStockView:(NoMyStockView*)noMyStockView;
@end
