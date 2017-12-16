//
//  UIImageView+NIStyleable.m
//  TKAppBase_V1
//
//  Created by liubao on 15-5-5.
//  Copyright (c) 2015年 liubao. All rights reserved.
//

#import "UIImageView+NIStyleable.h"
#import "UIView+NIStyleable.h"
#import "NICSSRuleset.h"
#import "NimbusCore.h"

#if !defined(__has_feature) || !__has_feature(objc_arc)
#error "Nimbus requires ARC support."
#endif

NI_FIX_CATEGORY_BUG(UIImageView_NIStyleable)

@implementation UIImageView(NIStyleable)

- (void)applyImageViewStyleWithRuleSet:(NICSSRuleset *)ruleSet {
    [self applyImageViewStyleWithRuleSet:ruleSet inDOM:nil];
}

- (void)applyImageViewStyleWithRuleSet:(NICSSRuleset *)ruleSet inDOM:(NIDOM *)dom {
    if ([ruleSet hasImage]) { self.image = [UIImage imageNamed:ruleSet.image];}
}

- (void)applyStyleWithRuleSet:(NICSSRuleset *)ruleSet inDOM:(NIDOM *)dom {
    [self applyViewStyleWithRuleSet:ruleSet inDOM:dom];
    [self applyImageViewStyleWithRuleSet:ruleSet inDOM:dom];
}

@end