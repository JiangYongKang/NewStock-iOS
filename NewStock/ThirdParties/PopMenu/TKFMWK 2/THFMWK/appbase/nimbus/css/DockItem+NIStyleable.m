//
//  DockItem+NIStyleable.m
//  TKAppBase_V1
//
//  Created by liubao on 15-5-6.
//  Copyright (c) 2015年 liubao. All rights reserved.
//

#import "DockItem+NIStyleable.h"
/**
 *  @Author 刘宝, 2015-05-06 11:05:27
 *
 *  自定义的tabbar按钮
 */
#import "UIView+NIStyleable.h"
#import "NICSSRuleset.h"
#import "NimbusCore.h"
#import "UIButton+NIStyleable.h"

#if !defined(__has_feature) || !__has_feature(objc_arc)
#error "Nimbus requires ARC support."
#endif

NI_FIX_CATEGORY_BUG(DockItem_NIStyleable)

@implementation DockItem(NIStyleable)

- (void)applyStyleWithRuleSet:(NICSSRuleset *)ruleSet inDOM:(NIDOM *)dom {
    [self applyButtonStyleBeforeViewWithRuleSet:ruleSet inDOM:dom];
    [self applyViewStyleWithRuleSet:ruleSet inDOM:dom];
    [self applyButtonStyleWithRuleSet:ruleSet inDOM:dom];
}

@end