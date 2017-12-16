//
//  Dock+NIStyleable.m
//  TKAppBase_V1
//
//  Created by liubao on 15-5-6.
//  Copyright (c) 2015年 liubao. All rights reserved.
//

#import "Dock+NIStyleable.h"

/**
 *  @Author 刘宝, 2015-05-06 11:05:40
 *
 *  自定义tabbar
 */
#import "UIView+NIStyleable.h"
#import "NICSSRuleset.h"
#import "NimbusCore.h"
#import "UIScrollView+NIStyleable.h"

#if !defined(__has_feature) || !__has_feature(objc_arc)
#error "Nimbus requires ARC support."
#endif

NI_FIX_CATEGORY_BUG(Dock_NIStyleable)

@implementation Dock(NIStyleable)

- (void)applyDockStyleWithRuleSet:(NICSSRuleset *)ruleSet {
    [self applyDockStyleWithRuleSet:ruleSet inDOM:nil];
}

- (void)applyDockStyleWithRuleSet:(NICSSRuleset *)ruleSet inDOM:(NIDOM *)dom {
    [super applyScrollViewStyleWithRuleSet:ruleSet inDOM:dom];
    if ([ruleSet hasTextColor]) { self.textColor = ruleSet.textColor; }
    if ([ruleSet hasSelectedTextColor]) { self.selectedTextColor = ruleSet.selectedTextColor; }
    if ([ruleSet hasFont]) { self.font = ruleSet.font; }
}

- (void)applyStyleWithRuleSet:(NICSSRuleset *)ruleSet inDOM:(NIDOM *)dom {
    [self applyViewStyleWithRuleSet:ruleSet inDOM:dom];
    [self applyDockStyleWithRuleSet:ruleSet inDOM:dom];
}

@end