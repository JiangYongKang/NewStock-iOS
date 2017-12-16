//
// APIChainRequest+AnimatingAccessory.h
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "APIChainRequest.h"

@interface APIChainRequest (AnimatingAccessory)

@property (weak, nonatomic) UIView *animatingView;

@property (strong, nonatomic) NSString *animatingText;

@end
