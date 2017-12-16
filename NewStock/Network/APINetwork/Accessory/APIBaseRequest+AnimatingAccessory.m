//
// APIBaseRequest+AnimatingAccessory.m
//

#import "APIBaseRequest+AnimatingAccessory.h"
#import "APIAnimatingRequestAccessory.h"


@implementation APIBaseRequest (AnimatingAccessory)

- (APIAnimatingRequestAccessory *)animatingRequestAccessory {
    for (id accessory in self.requestAccessories) {
        if ([accessory isKindOfClass:[APIAnimatingRequestAccessory class]]){
            return accessory;
        }
    }
    return nil;
}

- (UIView *)animatingView {
    return self.animatingRequestAccessory.animatingView;
}

- (void)setAnimatingView:(UIView *)animatingView {
    if (!self.animatingRequestAccessory) {
        [self addAccessory:[APIAnimatingRequestAccessory accessoryWithAnimatingView:animatingView animatingText:nil]];
    } else {
        self.animatingRequestAccessory.animatingView = animatingView;
    }
}

- (NSString *)animatingText {
    return self.animatingRequestAccessory.animatingText;
}

- (void)setAnimatingText:(NSString *)animatingText {
    if (!self.animatingRequestAccessory) {
        [self addAccessory:[APIAnimatingRequestAccessory accessoryWithAnimatingView:nil animatingText:animatingText]];
    } else {
        self.animatingRequestAccessory.animatingText = animatingText;
    }
}

@end
