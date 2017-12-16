//
//  
//  WXTabBarController
//
//

#import <UIKit/UIKit.h>
#import "WDTabbar.h"
#import "TabbarView.h"


@interface WXTabBarController : UITabBarController <UITabBarControllerDelegate>

@property (nonatomic, strong) TabbarView *tab;

@property (nonatomic, copy) NSArray<__kindof UIViewController *> *backingViewControllers;

@end
