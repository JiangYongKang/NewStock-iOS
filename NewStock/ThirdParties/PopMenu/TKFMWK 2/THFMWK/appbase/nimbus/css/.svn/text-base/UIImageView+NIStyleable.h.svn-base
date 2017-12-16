//
//  UIImageView+NIStyleable.h
//  TKAppBase_V1
//
//  Created by liubao on 15-5-5.
//  Copyright (c) 2015年 liubao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NICSSRuleset;
@class NIDOM;

@interface UIImageView (NIStyleable)

/**
 * Applies the given rule set to this navigation bar. Use applyNavigationBarStyleWithRuleSet:inDOM: instead
 *
 * This method is exposed primarily for subclasses to use when implementing the
 * applyStyleWithRuleSet: method from NIStyleable.
 */
- (void)applyImageViewStyleWithRuleSet:(NICSSRuleset *)ruleSet DEPRECATED_ATTRIBUTE;

/**
 * Applies the given rule set to this navigation bar.
 *
 * This method is exposed primarily for subclasses to use when implementing the
 * applyStyleWithRuleSet: method from NIStyleable.
 */
- (void)applyImageViewStyleWithRuleSet:(NICSSRuleset *)ruleSet inDOM: (NIDOM*) dom;

@end