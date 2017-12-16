//
//  Dock+NIStyleable.h
//  TKAppBase_V1
//
//  Created by liubao on 15-5-6.
//  Copyright (c) 2015年 liubao. All rights reserved.
//

/**
 *  @Author 刘宝, 2015-05-06 11:05:19
 *
 *  自定义tabbar
 */
@class NICSSRuleset;
@class NIDOM;

@interface Dock (NIStyleable)

/**
 * Applies the given rule set to this navigation bar. Use applyNavigationBarStyleWithRuleSet:inDOM: instead
 *
 * This method is exposed primarily for subclasses to use when implementing the
 * applyStyleWithRuleSet: method from NIStyleable.
 */
- (void)applyDockStyleWithRuleSet:(NICSSRuleset *)ruleSet DEPRECATED_ATTRIBUTE;

/**
 * Applies the given rule set to this navigation bar.
 *
 * This method is exposed primarily for subclasses to use when implementing the
 * applyStyleWithRuleSet: method from NIStyleable.
 */
- (void)applyDockStyleWithRuleSet:(NICSSRuleset *)ruleSet inDOM: (NIDOM*) dom;

@end