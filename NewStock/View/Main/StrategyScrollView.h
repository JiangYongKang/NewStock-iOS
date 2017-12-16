//
//  StrategyScrollView.h
//  NewStock
//
//  Created by Willey on 16/8/18.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StrategyView.h"
@protocol StrategyScrollViewDelegate;

@interface StrategyScrollView : UIScrollView<StrategyViewDelegate>
{
    NSMutableArray *_strategyArray;
    NSMutableArray *_subViewArray;
    
    int _nItemWidth;
    int _nItemHeigh;
}

@property (assign, nonatomic) id<StrategyScrollViewDelegate>myDelegate;

-(void)setStrategyArray:(NSArray *)array;
@end


@protocol StrategyScrollViewDelegate <NSObject>
@optional
- (void)strategyScrollView:(StrategyScrollView*)strategyScrollView selectedIndex:(int)index;

@end