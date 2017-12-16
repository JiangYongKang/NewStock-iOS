//
//  DrawLotsView.h
//  NewStock
//
//  Created by Willey on 16/11/10.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DrawLotsViewDelegate;

@interface DrawLotsView : UIView<UIGestureRecognizerDelegate>
{
    UILabel *_titleLb;
    UILabel *_descLb;
}
@property (weak, nonatomic) id<DrawLotsViewDelegate> delegate;

-(void)setTitle:(NSString *)title content:(NSString *)content;

@end



@protocol DrawLotsViewDelegate <NSObject>
@optional
- (void)drawLotsView:(DrawLotsView*)drawLotsView drawId:(NSString *)drawId;
- (void)drawLotsView:(DrawLotsView*)drawLotsView;
@end
