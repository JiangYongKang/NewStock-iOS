//
// APIBaseRequest+AnimatingAccessory.h
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "APIBaseRequest.h"

@interface APIBaseRequest (AnimatingAccessory)

@property (weak, nonatomic) UIView *animatingView;

@property (strong, nonatomic) NSString *animatingText;

@end
