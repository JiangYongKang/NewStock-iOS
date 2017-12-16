//
//APIBatchRequest+AnimatingAccessory.h
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "APIBatchRequest.h"

@interface APIBatchRequest (AnimatingAccessory)

@property (weak, nonatomic) UIView *animatingView;

@property (strong, nonatomic) NSString *animatingText;

@end
