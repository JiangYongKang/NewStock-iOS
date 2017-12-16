//
//  StrategyScrollView.m
//  NewStock
//
//  Created by Willey on 16/8/18.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "StrategyScrollView.h"
#import "StrategyView.h"
#import "MainPageModel.h"

@implementation StrategyScrollView
@synthesize myDelegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        //        self.backgroundColor = kUIColorFromRGB(0xc9c9c9);
        self.backgroundColor = [UIColor whiteColor];

        _strategyArray = [[NSMutableArray alloc] init];
        _subViewArray = [[NSMutableArray alloc] init];
        
        _nItemWidth = (self.frame.size.width-2)/3;
        _nItemHeigh = self.frame.size.height;
        
        self.showsHorizontalScrollIndicator = NO;
        self.bounces = NO;
    }
    return self;
}

-(void)setStrategyArray:(NSArray *)array
{
    for (int i=0; i<[_subViewArray count]; i++)
    {
        StrategyView *view = [_subViewArray objectAtIndex:i];
        [view removeFromSuperview];
    }
    [_subViewArray removeAllObjects];
    
    [_strategyArray removeAllObjects];
    [_strategyArray addObjectsFromArray:array];
    //[_strategyArray addObjectsFromArray:array];
    
    
    if ([_strategyArray count]>3)
    {
        long width = _nItemWidth*[_strategyArray count]+[_strategyArray count]-1;
        [self setContentSize:CGSizeMake(width, self.contentSize.height)];
    }
    
    int orignX = 0;
    for (int i=0; i<[_strategyArray count]; i++)
    {
        StrategyListModel *model = [_strategyArray objectAtIndex:i];
        NSArray *array = model.imageList;
        ImageListModel *imgModel = [array objectAtIndex:0];
        
        StrategyView *view = [[StrategyView alloc] initWithFrame:CGRectMake(orignX, 0, _nItemWidth, _nItemHeigh)];
        [view setDelegate:self tag:i];
        view.frame = CGRectMake(orignX, 0, _nItemWidth, _nItemHeigh);
        [view setImgUrl:imgModel.origin];
        [view setTitle:model.name content:model.earningsYield];
        [self addSubview:view];
        orignX = orignX + _nItemWidth + 1;
        [_subViewArray addObject:view];
    }
    
}


- (void)strategyView:(StrategyView*)strategyView tag:(NSUInteger)tag
{
    if([myDelegate respondsToSelector:@selector(strategyScrollView:selectedIndex:)])
    {
        [myDelegate strategyScrollView:self selectedIndex:(int)tag];
    }
}

@end
