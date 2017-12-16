//
//  WDNavController.m
//  NewStock
//
//  Created by 王迪 on 2017/1/16.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "WDNavController.h"

@interface WDNavController ()<UIGestureRecognizerDelegate>

@end

@implementation WDNavController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.interactivePopGestureRecognizer.delegate = self;
}


- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if (self.childViewControllers.count > 1) {
        return YES;
    }else {
        return NO;
    }
}


@end
