//
//  APIAnimatingRequestAccessory.h
//


#import <UIKit/UIKit.h>

#import "APIBaseRequest.h"
#import "MBProgressHUD.h"

@interface APIAnimatingRequestAccessory : NSObject <APIRequestAccessory> {
    MBProgressHUD *_progressHUD;
}

@property(nonatomic, weak) UIView *animatingView;

@property(nonatomic, strong) NSString *animatingText;

- (id)initWithAnimatingView:(UIView *)animatingView;

- (id)initWithAnimatingView:(UIView *)animatingView animatingText:(NSString *)animatingText;

+ (id)accessoryWithAnimatingView:(UIView *)animatingView;

+ (id)accessoryWithAnimatingView:(UIView *)animatingView animatingText:(NSString *)animatingText;

@end
