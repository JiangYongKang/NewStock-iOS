//
//  Navbar+NIStyleable.m
//  TKAppBase_V1
//
//  Created by liubao on 15-5-5.
//  Copyright (c) 2015年 liubao. All rights reserved.
//

#import "Navbar+NIStyleable.h"
#import "UIView+NIStyleable.h"
#import "NICSSRuleset.h"
#import "NimbusCore.h"
#import "UINavigationBar+NIStyleable.h"

#if !defined(__has_feature) || !__has_feature(objc_arc)
#error "Nimbus requires ARC support."
#endif

NI_FIX_CATEGORY_BUG(Navbar_NIStyleable)

@implementation Navbar (NIStyleable)

- (void)applyNavbarStyleWithRuleSet:(NICSSRuleset *)ruleSet {
    [self applyNavbarStyleWithRuleSet:ruleSet inDOM:nil];
}

- (void)applyNavbarStyleWithRuleSet:(NICSSRuleset *)ruleSet inDOM:(NIDOM *)dom {
    [super applyNavigationBarStyleWithRuleSet:ruleSet inDOM:dom];
    if ([ruleSet hasNavStateBarColor]) { self.stateBarColor = ruleSet.navStateBarColor; }
    if ([ruleSet hasNavStateBarImage]) { self.stateBarImage = [TKImageHelper imageByName:ruleSet.navStateBarImage];}
    if ([ruleSet hasBackgroundColor]) { self.backgroundColor = ruleSet.backgroundColor; }
    if ([ruleSet hasBackgroundImage]) { self.backgroundImage = [TKImageHelper imageByName:ruleSet.backgroundImage];}
    if ([ruleSet hasBarTitleColor]) {self.barTitleColor = ruleSet.barTitleColor;}
}

- (void)applyStyleWithRuleSet:(NICSSRuleset *)ruleSet inDOM:(NIDOM *)dom {
    [self applyViewStyleWithRuleSet:ruleSet inDOM:dom];
    [self applyNavbarStyleWithRuleSet:ruleSet inDOM:dom];
}

@end
