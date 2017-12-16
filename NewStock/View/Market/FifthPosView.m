//
//  FifthPosView.m
//  NewStock
//
//  Created by Willey on 16/8/12.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "FifthPosView.h"
#import "Defination.h"
#import "SystemUtil.h"
#import <QuartzCore/QuartzCore.h>
#import "UIColor+Y_StockChart.h"
#import "FifthPosCell.h"
#import "TradeDetailModel.h"
#import "MarketConfig.h"

@interface FifthPosView ()

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) HMSegmentedControl *segmentedControl;

@end

@implementation FifthPosView

- (id)initWithWidth:(int)width height:(int)height {
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
//        self.layer.borderWidth = 0.5;
//        self.layer.borderColor = [[UIColor boarderColor] CGColor];
        
        _fifthPosModel = nil;
        
        int viewWidth = width;//MAIN_SCREEN_WIDTH * X_FifthPositionViewRadio;
        int viewHeight = height;
        _segmentedControl = [[HMSegmentedControl alloc] initWithFrame:CGRectMake(0, viewHeight - 20 * kScale, viewWidth, 20 * kScale)];
        _segmentedControl.sectionTitles = @[@"五档", @"明细"];
        _segmentedControl.selectedSegmentIndex = 0;
        _segmentedControl.backgroundColor = [UIColor whiteColor];
        _segmentedControl.titleTextAttributes = @{NSFontAttributeName : [UIFont systemFontOfSize:12.0f * kScale], NSForegroundColorAttributeName : [SystemUtil hexStringToColor:@"#358ee7"]};
        _segmentedControl.selectedTitleTextAttributes = @{NSForegroundColorAttributeName : [SystemUtil hexStringToColor:@"#ffffff"]};
        _segmentedControl.selectionIndicatorColor = [SystemUtil hexStringToColor:@"#358ee7"];
        _segmentedControl.selectionIndicatorBoxOpacity = 1.0;
        _segmentedControl.selectionStyle = HMSegmentedControlSelectionStyleBox;
        _segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationNone;

            _segmentedControl.verticalDividerEnabled = YES;
            _segmentedControl.verticalDividerColor = kUIColorFromRGB(0xd3d3d3);
            _segmentedControl.verticalDividerWidth = 0.0f;
        
        _segmentedControl.layer.borderWidth = 0.5;
        _segmentedControl.layer.borderColor = kUIColorFromRGB(0x358ee7).CGColor;
        
        __weak typeof(self) weakSelf = self;
        [_segmentedControl setIndexChangeBlock:^(NSInteger index) {
            [weakSelf.scrollView scrollRectToVisible:CGRectMake(viewWidth * index, 0, viewWidth, viewHeight-20) animated:YES];
            
            if([weakSelf.delegate respondsToSelector:@selector(fifthPosView:selectIndex:)])
            {
                [weakSelf.delegate fifthPosView:weakSelf selectIndex:index];
            }
        }];
        
        [self addSubview:_segmentedControl];
        
        self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, viewWidth, viewHeight-20)];
        //self.scrollView.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
        self.scrollView.pagingEnabled = YES;
        self.scrollView.showsHorizontalScrollIndicator = NO;
        self.scrollView.contentSize = CGSizeMake(viewWidth * 2, viewHeight-20);
        self.scrollView.delegate = self;
        //[self.scrollView scrollRectToVisible:CGRectMake(0, 0, viewWidth, viewHeight-20) animated:NO];
        [self addSubview:self.scrollView];

        //
        _fifthPosTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, viewWidth, viewHeight-20)];
        _fifthPosTableView.delegate = self;
        _fifthPosTableView.dataSource = self;
        _fifthPosTableView.bounces = NO;
        _fifthPosTableView.scrollEnabled = NO;
        _fifthPosTableView.separatorColor = [UIColor clearColor];
        _fifthPosTableView.backgroundColor = [UIColor whiteColor];
        _fifthPosTableView.rowHeight = self.scrollView.frame.size.height/10;
        [self.scrollView addSubview:_fifthPosTableView];
        
        UIView *sepLine = [[UIView alloc] initWithFrame:CGRectMake(5, (viewHeight - 20) / 2, viewWidth - 10, 0.5)];
        sepLine.backgroundColor = kUIColorFromRGB(0xd3d3d3);
        [_fifthPosTableView addSubview: sepLine];
        
        _detailTableView = [[UITableView alloc] initWithFrame:CGRectMake(viewWidth, 0, viewWidth, viewHeight - 20)];
        _detailTableView.delegate = self;
        _detailTableView.dataSource = self;
        _detailTableView.bounces = NO;
        _detailTableView.scrollEnabled = NO;
        _detailTableView.separatorColor = [UIColor clearColor];
        _detailTableView.backgroundColor = [UIColor whiteColor];
        _detailTableView.rowHeight = self.scrollView.frame.size.height/10;
        [self.scrollView addSubview:_detailTableView];
        
    }
    return self;
}

- (void)segmentedControlChangedValue:(HMSegmentedControl *)segmentedControl {
    NSLog(@"Selected index %ld (via UIControlEventValueChanged)", (long)segmentedControl.selectedSegmentIndex);
    
}

- (void)uisegmentedControlChangedValue:(UISegmentedControl *)segmentedControl {
    NSLog(@"Selected index %ld", (long)segmentedControl.selectedSegmentIndex);
}

- (void)setFifthPosModel:(FifthPosModel *)fifthPosModel {
    _fifthPosModel = fifthPosModel;
    [_fifthPosTableView reloadData];
    
    _prevClose = [fifthPosModel.prevClose floatValue];
}

- (void)setTradeArray:(NSMutableArray *)array {
    _tradeArray = [[NSMutableArray alloc] initWithArray:array];

    [_detailTableView reloadData];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat pageWidth = scrollView.frame.size.width;
    NSInteger page = scrollView.contentOffset.x / pageWidth;
    
    [_segmentedControl setSelectedSegmentIndex:page animated:YES];
    
    if([self.delegate respondsToSelector:@selector(fifthPosView:selectIndex:)])
    {
        [self.delegate fifthPosView:self selectIndex:page];
    }
}

#pragma UITableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == _fifthPosTableView)
    {
        if (_fifthPosModel)
        {
            return 10;
        }
        else
        {
            return 0;
        }
    }
    else
    {
        if (_tradeArray)
        {
            //return  [_tradeArray count];
            return 10;
        }
        else
        {
            return 0;
        }
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == _fifthPosTableView)
    {
        static NSString *cellid=@"fifthPosCell";
        FifthPosCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        
        if (cell==nil)
        {
            cell=[[FifthPosCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        }
        
        [cell setPrevClose:_prevClose];
        
        switch (indexPath.row) {
            case 0:
                [cell setName:@"卖5" value:_fifthPosModel.sellPrice5 hands:[NSString stringWithFormat:@"%ld",lroundf(_fifthPosModel.sellCount5.floatValue/100)]];
                break;
            case 1:
                [cell setName:@"卖4" value:_fifthPosModel.sellPrice4 hands:[NSString stringWithFormat:@"%ld",lroundf(_fifthPosModel.sellCount4.floatValue/100)]];
                break;
            case 2:
                [cell setName:@"卖3" value:_fifthPosModel.sellPrice3 hands:[NSString stringWithFormat:@"%ld",lroundf(_fifthPosModel.sellCount3.floatValue/100)]];
                break;
            case 3:
                [cell setName:@"卖2" value:_fifthPosModel.sellPrice2 hands:[NSString stringWithFormat:@"%ld",lroundf(_fifthPosModel.sellCount2.floatValue/100)]];
                break;
            case 4:
                [cell setName:@"卖1" value:_fifthPosModel.sellPrice1 hands:[NSString stringWithFormat:@"%ld",lroundf(_fifthPosModel.sellCount1.floatValue/100)]];
                break;
                
            case 5:
                [cell setName:@"买1" value:_fifthPosModel.buyPrice1 hands:[NSString stringWithFormat:@"%ld",lroundf(_fifthPosModel.buyCount1.floatValue/100)]];
                break;
            case 6:
                [cell setName:@"买2" value:_fifthPosModel.buyPrice2 hands:[NSString stringWithFormat:@"%ld",lroundf(_fifthPosModel.buyCount2.floatValue/100)]];
                break;
            case 7:
                [cell setName:@"买3" value:_fifthPosModel.buyPrice3 hands:[NSString stringWithFormat:@"%ld",lroundf(_fifthPosModel.buyCount3.floatValue/100)]];
                break;
            case 8:
                [cell setName:@"买4" value:_fifthPosModel.buyPrice4 hands:[NSString stringWithFormat:@"%ld",lroundf(_fifthPosModel.buyCount4.floatValue/100)]];
                break;
            case 9:
                [cell setName:@"买5" value:_fifthPosModel.buyPrice5 hands:[NSString stringWithFormat:@"%ld",lroundf(_fifthPosModel.buyCount5.floatValue/100)]];
                break;
                
            default:
                break;
        }
        //[cell setName:@"买一" value:@"23.25" hands:@"135"];
        
        return cell;
    }
    else
    {
        static NSString *detailCellid=@"detailChangeCell";
        FifthPosCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        
        if (cell==nil)
        {
            cell=[[FifthPosCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:detailCellid];
        }

        long row = indexPath.row;
        
        if (row < [_tradeArray count])
        {
            TradeDetailModel *model = [_tradeArray objectAtIndex:row];
            
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"HH:mm"];//@"yyyy-MM-dd HH:mm:ss zzz"
            NSString *destDateString = [dateFormatter stringFromDate:model.time];
            
            [cell setPrevClose:_prevClose];

            [cell setName:destDateString value:model.presentPrice hands:[NSString stringWithFormat:@"%ld",lroundf(model.volume.floatValue/100)]];
            
            
            UIColor *color = [SystemUtil getRatioColorWithAsk:model.ask bid:model.bid presentPrice:model.presentPrice];
            [cell setHandsColor:color];
            
        }
        else
        {
            [cell setName:@"" value:@"" hands:@""];
        }
        
        return cell;
        
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}


@end
