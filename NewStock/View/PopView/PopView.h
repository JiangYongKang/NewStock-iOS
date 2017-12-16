//
//  PopView.h
//
/*
 
 #import "PopView.h"

 PopView *popView = [[PopView alloc] initWithFrame:CGRectMake(0, 0, 250, 250)];
 [popView showInView:self.view
 fromPoint:CGPointMake(160, 550)
 centerAtPoint:self.view.center
 completion:nil];
 
 */

#import <UIKit/UIKit.h>

extern CGFloat const kPopupDefaultWaitDuration;

@interface PopView : UIView <UIGestureRecognizerDelegate,CAAnimationDelegate>
{
    UIView *_backgroundView;
    CGPoint _fromPos;
    
    UIButton *_doneButton;
}

@property (strong, nonatomic) UIColor *popupColor UI_APPEARANCE_SELECTOR;

@property (assign, nonatomic) CGFloat forwardAnimationDuration;
@property (assign, nonatomic) CGFloat backwardAnimationDuration;

- (void)setDoneBtnShow:(BOOL)b;
- (void)dismissPopup;

#pragma mark - Showing popup
- (void)showInView:(UIView *)parentView
         fromPoint:(CGPoint)fromPos
     centerAtPoint:(CGPoint)pos
        completion:(void (^)(void))block;
@end
