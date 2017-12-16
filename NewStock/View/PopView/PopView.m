//
//  PopView.m
//  LPPopupDemo
//

#import <QuartzCore/QuartzCore.h>
#import "PopView.h"


CGFloat const kPopupDefaultWaitDuration = 1.0f;

static NSString * const kPopupAnimationKey = @"kPopupAnimationKey";

@interface PopView ()

@property (copy, nonatomic) void (^animationCompletion)(void);

@end


@implementation PopView
@synthesize popupColor;
@synthesize forwardAnimationDuration;
@synthesize backwardAnimationDuration;


#pragma mark - Initialization
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self) {
        popupColor = [UIColor whiteColor];//[UIColor colorWithWhite:0.1 alpha:0.8];
        forwardAnimationDuration = 0.3f;
        backwardAnimationDuration = 0.3f;
        
        self.backgroundColor = [UIColor clearColor];
        
        CGRect rect = [[UIScreen mainScreen] applicationFrame];
        _backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, rect.size.width, rect.size.height+20)];
        _backgroundView.backgroundColor = [UIColor colorWithRed:14/255.0 green:14/255.0 blue:14/255.0 alpha:0.85];
        
        UITapGestureRecognizer *singleFingerOne = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissPopup)];
        singleFingerOne.numberOfTouchesRequired = 1;
        singleFingerOne.numberOfTapsRequired = 1;
        singleFingerOne.delegate = self;
        [_backgroundView addGestureRecognizer:singleFingerOne];
        
        
        _doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _doneButton.frame = CGRectMake(self.frame.size.width-80, self.frame.size.height-40, 70, 30);
        [_doneButton addTarget:self action:@selector(areaButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [_doneButton setTitle:@"确定" forState:UIControlStateNormal];
        [_doneButton setTitleColor:[UIColor colorWithRed:0 green:0 blue:0.8 alpha:0.7] forState:UIControlStateNormal];
        [_doneButton setTitleColor:[UIColor colorWithRed:0 green:0 blue:0.8 alpha:0.3] forState:UIControlStateHighlighted];
        _doneButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [self addSubview:_doneButton];
        _doneButton.hidden = YES;
    }
    return self;
}

- (void)dealloc
{
    self.popupColor = nil;
    _backgroundView = nil;
}

- (void)setDoneBtnShow:(BOOL)b
{
    _doneButton.hidden = !b;
}

-(void)areaButtonClick
{
    [self dismissPopup];
}

#pragma mark - Showing popup
- (void)showInView:(UIView *)parentView
         fromPoint:(CGPoint)fromPos
     centerAtPoint:(CGPoint)pos
        completion:(void (^)(void))block
{
    _fromPos = fromPos;
    self.center = fromPos;
    self.animationCompletion = block;
    
    CABasicAnimation *forwardAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    forwardAnimation.duration = self.forwardAnimationDuration;
    forwardAnimation.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.5f :1.7f :0.6f :0.85f];
    forwardAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    forwardAnimation.toValue = [NSNumber numberWithFloat:1.0f];
    
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.animations = [NSArray arrayWithObjects:forwardAnimation, nil];
    //animationGroup.delegate = self;
    animationGroup.duration = forwardAnimation.duration;
    animationGroup.removedOnCompletion = NO;
    animationGroup.fillMode = kCAFillModeForwards;
    
    _backgroundView.alpha = 0.0;
    [parentView addSubview:_backgroundView];
    [parentView addSubview:self];
    [UIView animateWithDuration:animationGroup.duration
                          delay:0.0
                        options:0
                     animations:^{
                         [self.layer addAnimation:animationGroup forKey:kPopupAnimationKey];
                         _backgroundView.alpha = 0.6;
                     }
                     completion:^(BOOL finished) {
                         [self bringSubviewToFront:_doneButton];

                     }];
    
    
    [UIView animateWithDuration:self.forwardAnimationDuration
                          delay:0.0
                        options:0
                     animations:^{
                         self.center = pos;
                     }
                     completion:^(BOOL finished) {

                     }];
    
}

- (void)dismissPopup
{
    CABasicAnimation *reverseAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    reverseAnimation.duration = self.backwardAnimationDuration;
    reverseAnimation.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.4f :0.15f :0.5f :-0.7f];
    reverseAnimation.fromValue = [NSNumber numberWithFloat:1.0f];
    reverseAnimation.toValue = [NSNumber numberWithFloat:0.0f];
    
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.animations = [NSArray arrayWithObjects:reverseAnimation, nil];//reverseAnimation,
    animationGroup.delegate = self;
    animationGroup.duration = reverseAnimation.duration ;
    animationGroup.removedOnCompletion = NO;
    animationGroup.fillMode = kCAFillModeForwards;
    
    
    [UIView animateWithDuration:animationGroup.duration
                          delay:0.0
                        options:0
                     animations:^{
                         [self.layer addAnimation:animationGroup forKey:kPopupAnimationKey];
                         _backgroundView.alpha = 0.0;
                     }
                     completion:^(BOOL finished) {
                     }];
    
    [UIView animateWithDuration:self.backwardAnimationDuration
                          delay:0.0
                        options:0
                     animations:^{
                         self.center = _fromPos;
                     }
                     completion:^(BOOL finished) {
                     }];
    

}


#pragma mark - Core animation delegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if(flag) {
        [_backgroundView removeFromSuperview];
        [self removeFromSuperview];
        
        if(self.animationCompletion)
            self.animationCompletion();
    }
}

#pragma mark - Drawing
- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:CGRectInset(rect, 5.0f, 5.0f)
                                                           cornerRadius:5.0f];
    
    CGContextSetFillColorWithColor(context, self.popupColor.CGColor);
    CGContextFillPath(context);
    
    CGContextSetShadowWithColor(context,
                                CGSizeMake(0.0f, 0.5f),
                                3.0f,
                                [UIColor colorWithWhite:0.0f alpha:0.45f].CGColor);
    
    CGContextAddPath(context, roundedRect.CGPath);
    CGContextDrawPath(context, kCGPathFill);
    
    CGContextRestoreGState(context);
    [super drawRect:rect];
}

@end


