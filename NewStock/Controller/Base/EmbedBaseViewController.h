//
//  EmbedBaseViewController.h
//  NewStock
//
//  Created by Willey on 16/7/23.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"
#import "MMPlaceHolder.h"
#import "Defination.h"
#import "SystemUtil.h"

@interface EmbedBaseViewController : UIViewController
{
    UIScrollView *_scrollView;
    UIView *_mainView;
}

- (void)loadData;

@end
