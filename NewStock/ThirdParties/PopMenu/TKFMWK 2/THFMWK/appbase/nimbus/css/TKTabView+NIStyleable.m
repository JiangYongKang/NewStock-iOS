//
//  TabView+NIStyleable.m
//  TKAppBase_V1
//
//  Created by liubao on 15-9-10.
//  Copyright (c) 2015年 liubao. All rights reserved.
//

#import "TKTabView+NIStyleable.h"
#import "UIView+NIStyleable.h"
#import "NICSSRuleset.h"
#import "NimbusCore.h"

#if !defined(__has_feature) || !__has_feature(objc_arc)
#error "Nimbus requires ARC support."
#endif

NI_FIX_CATEGORY_BUG(TKTabView_NIStyleable)

@implementation TKTabView (NIStyleable)

- (void)applyTabViewStyleWithRuleSet:(NICSSRuleset *)ruleSet {
    [self applyTabViewStyleWithRuleSet:ruleSet inDOM:nil];
}

- (void)applyTabViewStyleWithRuleSet:(NICSSRuleset *)ruleSet inDOM:(NIDOM *)dom {
    if ([ruleSet hasSelectedBackgroundColor]) { self.currentTabSelectedColor = ruleSet.selectedBackgroundColor; }
    if ([ruleSet hasSelectedTextColor]) { self.currentTabSelectedTextColor = ruleSet.selectedTextColor;}
    if ([ruleSet hasBackgroundColor]) { self.currentTabNormalColor = ruleSet.backgroundColor; }
    if ([ruleSet hasTextColor]) { self.currentTabNormalTextColor = ruleSet.textColor;}
    if ([ruleSet hasIndicatorColor]) {self.indicatorColor = ruleSet.indicatorColor;}
    if ([ruleSet hasIndicatorLineColor]) {self.indicatorLineColor = ruleSet.indicatorLineColor;}
}

- (void)applyStyleWithRuleSet:(NICSSRuleset *)ruleSet inDOM:(NIDOM *)dom {
    [self applyViewStyleWithRuleSet:ruleSet inDOM:dom];
    [self applyTabViewStyleWithRuleSet:ruleSet inDOM:dom];
}

@end
