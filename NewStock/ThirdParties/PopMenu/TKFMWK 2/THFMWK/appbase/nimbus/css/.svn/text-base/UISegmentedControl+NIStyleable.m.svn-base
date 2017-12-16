//
//  UISegmentedControl+NIStyleable.m
//  TKAppBase_V1
//
//  Created by liubao on 15-5-5.
//  Copyright (c) 2015年 liubao. All rights reserved.
//

#import "UISegmentedControl+NIStyleable.h"
#import "UIView+NIStyleable.h"
#import "NICSSRuleset.h"
#import "NimbusCore.h"

#if !defined(__has_feature) || !__has_feature(objc_arc)
#error "Nimbus requires ARC support."
#endif

NI_FIX_CATEGORY_BUG(UISegmentedControl_NIStyleable)

@implementation UISegmentedControl (NIStyleable)

- (void)applySegmentedControlStyleWithRuleSet:(NICSSRuleset *)ruleSet {
    [self applySegmentedControlStyleWithRuleSet:ruleSet inDOM:nil];
}

- (void)applySegmentedControlStyleWithRuleSet:(NICSSRuleset *)ruleSet inDOM:(NIDOM *)dom {
    if ([ruleSet hasBackgroundColor]) {
        if ([ruleSet hasBorderRadius]){
              [self.layer masksToBounds];
              [self setBackgroundColor:ruleSet.backgroundColor];
        }else{
            UIImage *normalBgImage = [TKImageHelper imageByColor:ruleSet.backgroundColor size:CGSizeMake(1, 29)];
            [self setBackgroundImage:normalBgImage
                            forState:UIControlStateNormal
                          barMetrics:UIBarMetricsDefault];
        }
    }
    if ([ruleSet hasSelectedBackgroundColor]) {
        if ([ruleSet hasBorderRadius]){
            [self setTintColor:ruleSet.selectedBackgroundColor];
        }else{
            UIImage *selectedBgImage = [TKImageHelper imageByColor:ruleSet.selectedBackgroundColor size:CGSizeMake(1, 29)];
            [self setBackgroundImage:selectedBgImage
                            forState:UIControlStateSelected
                          barMetrics:UIBarMetricsDefault];
            [self setDividerImage:selectedBgImage
              forLeftSegmentState:UIControlStateNormal
                rightSegmentState:UIControlStateSelected
                       barMetrics:UIBarMetricsDefault];
        }
    }
    float fontSize = 14;
    if ([ruleSet hasFont]){
        NSArray *values = [[ruleSet getPropers] objectForKey:@"font-size"];
        NSString* value = [values objectAtIndex:0];
        if ([value isEqualToString:@"default"]) {
            fontSize = [UIFont systemFontSize];
        } else {
            fontSize = [value floatValue];
        }
    }
    if ([ruleSet hasTextColor]) {
        [self setTitleTextAttributes:@{
                                       UITextAttributeTextColor: ruleSet.textColor,
                                       UITextAttributeFont: [UIFont systemFontOfSize:fontSize],
                                       UITextAttributeTextShadowOffset:[NSValue valueWithUIOffset:UIOffsetMake(0, 0)] }
                            forState:UIControlStateNormal];
    }
    if ([ruleSet hasSelectedTextColor]) {
        [self setTitleTextAttributes:@{UITextAttributeTextColor: ruleSet.selectedTextColor,
                                       UITextAttributeFont: [UIFont systemFontOfSize:fontSize],
                                       UITextAttributeTextShadowOffset: [NSValue valueWithUIOffset:UIOffsetMake(0, 0)]}
                            forState:UIControlStateSelected];
    }
}

- (void)applyStyleWithRuleSet:(NICSSRuleset *)ruleSet inDOM:(NIDOM *)dom {
    [self applyViewStyleWithRuleSet:ruleSet inDOM:dom];
    [self applySegmentedControlStyleWithRuleSet:ruleSet inDOM:dom];
}

@end