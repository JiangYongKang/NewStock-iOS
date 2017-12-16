//
//  EmbedBaseViewController.m
//  NewStock
//
//  Created by Willey on 16/7/23.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "EmbedBaseViewController.h"
#import "MarketConfig.h"

@interface EmbedBaseViewController ()

@end

@implementation EmbedBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _scrollView = [[UIScrollView alloc] init];
    [self.view addSubview:_scrollView];
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    _mainView = [[UIView alloc] init];
    _mainView.backgroundColor = REFRESH_BG_COLOR;
    [_scrollView addSubview:_mainView];

    [_scrollView layoutIfNeeded];
}

- (void)loadData {
    
}

@end
