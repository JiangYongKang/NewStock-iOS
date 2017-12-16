//
//  UITabBar+NIStyleable.m
//  TKAppBase_V1
//
//  Created by liubao on 15-5-5.
//  Copyright (c) 2015年 liubao. All rights reserved.
//

#import "UITabBar+NIStyleable.h"
#import "UIView+NIStyleable.h"
#import "NICSSRuleset.h"
#import "NimbusCore.h"

#if !defined(__has_feature) || !__has_feature(objc_arc)
#error "Nimbus requires ARC support."
#endif

NI_FIX_CATEGORY_BUG(UITabBar_NIStyleable)

@implementation UITabBar (NIStyleable)

- (void)applyTabBarStyleWithRuleSet:(NICSSRuleset *)ruleSet {
    [self applyTabBarStyleWithRuleSet:ruleSet inDOM:nil];
}

- (void)applyTabBarStyleWithRuleSet:(NICSSRuleset *)ruleSet inDOM:(NIDOM *)dom {
    if ([ruleSet hasTintColor]) { self.tintColor = ruleSet.tintColor; }
    if ([ruleSet hasBarTintColor]) { self.barTintColor = ruleSet.barTintColor; }
    if ([ruleSet hasIndicatorColor])
    {
        self.shadowImage = [TKImageHelper imageByColor:ruleSet.indicatorColor size:CGSizeMake(self.frame.size.width, 1)];
        self.backgroundImage = [UIImage new];
    }
}

- (void)applyStyleWithRuleSet:(NICSSRuleset *)ruleSet inDOM:(NIDOM *)dom {
    [self applyViewStyleWithRuleSet:ruleSet inDOM:dom];
    [self applyTabBarStyleWithRuleSet:ruleSet inDOM:dom];
}

@end