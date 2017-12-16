//
//  APIAnimatingRequestAccessory.m
//


#import "APIAnimatingRequestAccessory.h"
//#import "APIAlertUtils.h"


@implementation APIAnimatingRequestAccessory

- (id)initWithAnimatingView:(UIView *)animatingView animatingText:(NSString *)animatingText {
    self = [super init];
    if (self) {
        _animatingView = animatingView;
        _animatingText = animatingText;
        
        _progressHUD = [[MBProgressHUD alloc] initWithView:animatingView];
        _progressHUD.labelText = @"数据加载中";
        [animatingView addSubview:_progressHUD];
    }
    return self;
}

- (id)initWithAnimatingView:(UIView *)animatingView {
    self = [super init];
    if (self) {
        _animatingView = animatingView;
    }
    return self;
}

- (void)setAnimatingText:(NSString *)animatingText
{
    _animatingText = animatingText;
    _progressHUD.labelText = animatingText;
    
    if ([animatingText isEqualToString:@"数据加载中..."])
    {
        _progressHUD.mode = MBProgressHUDModeText;
        
        _progressHUD.color = [UIColor whiteColor];
        //_progressHUD.dimBackground = YES;
        
        _progressHUD.labelColor = [UIColor lightGrayColor];
        _progressHUD.labelFont = [UIFont systemFontOfSize:12];
        
        _progressHUD.minSize = CGSizeMake(80, 20);
        _progressHUD.yOffset = -30;
    }
//    else
//    {
//        _progressHUD.mode = MBProgressHUDModeIndeterminate;
//    }
}

+ (id)accessoryWithAnimatingView:(UIView *)animatingView {
    return [[self alloc] initWithAnimatingView:animatingView];
}

+ (id)accessoryWithAnimatingView:(UIView *)animatingView animatingText:(NSString *)animatingText {
    return [[self alloc] initWithAnimatingView:animatingView animatingText:animatingText];
}

- (void)requestWillStart:(id)request {
    if (_animatingView) {
        dispatch_async(dispatch_get_main_queue(), ^{
            // TODO: show loading
            //[APIAlertUtils showLoadingAlertView:_animatingText inView:_animatingView];
            [_progressHUD show:YES];

            NSLog(@"++++++++++++loading start");
        });
    }
}

- (void)requestWillStop:(id)request {
    if (_animatingView) {
        dispatch_async(dispatch_get_main_queue(), ^{
            // TODO: hide loading
            //[APIAlertUtils hideLoadingAlertView:_animatingView];
            [_progressHUD hide:YES];

            NSLog(@"++++++++++++loading finished");
        });
    }
}

@end
