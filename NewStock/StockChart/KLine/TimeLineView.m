//
//  TimeLineView.h
//

#import "TimeLineView.h"
#import "TimeLineMainView.h"
#import "Y_TLineFollowView.h"

#import "Y_VolumeMAView.h"
#import "Masonry.h"
#import "UIColor+Y_StockChart.h"
#import <QuartzCore/QuartzCore.h>

#import "Y_StockChartGlobalVariable.h"
#import "Y_KLineVolumeView.h"
#import "Y_StockChartRightYView.h"

#import "Defination.h"
#import "SystemUtil.h"

@interface TimeLineView() <UIScrollViewDelegate, TimeLineMainViewDelegate, Y_KLineVolumeViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
/**
 *  主K线图
 */
@property (nonatomic, strong) TimeLineMainView *kLineMainView;

/**
 *  成交量图
 */
@property (nonatomic, strong) Y_KLineVolumeView *kLineVolumeView;


/**
 *  右侧价格图
 */
@property (nonatomic, strong) Y_StockChartRightYView *priceView;
@property (nonatomic, strong) Y_StockChartRightYView *right_priceView;

/**
 *  右侧成交量图
 */
@property (nonatomic, strong) Y_StockChartRightYView *volumeView;


/**
 *  旧的scrollview准确位移
 */
@property (nonatomic, assign) CGFloat oldExactOffset;


//跟随数据View
@property (nonatomic, strong) Y_TLineFollowView *tLineFollowView;


/**
 *  Volume-MAView
 */
@property (nonatomic, strong) Y_VolumeMAView *volumeMAView;


/**
 *  长按后显示的View
 */
@property (nonatomic, strong) UIView *verticalView;
@property (nonatomic, strong) UIView *horizontalView;


@property (nonatomic, strong) MASConstraint *kLineMainViewHeightConstraint;

@property (nonatomic, strong) MASConstraint *kLineVolumeViewHeightConstraint;

@property (nonatomic, strong) MASConstraint *priceViewHeightConstraint;

@property (nonatomic, strong) MASConstraint *volumeViewHeightConstraint;

@end

@implementation TimeLineView

//initWithFrame设置视图比例
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        self.mainViewRatio = [Y_StockChartGlobalVariable kLineMainViewRadio];
        self.volumeViewRatio = [Y_StockChartGlobalVariable kLineVolumeViewRadio];
        
    }
    return self;
}

- (UIScrollView *)scrollView {
    if(!_scrollView)
    {
        _scrollView = [UIScrollView new];
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.minimumZoomScale = 1.0f;
        _scrollView.maximumZoomScale = 1.0f;
//        _scrollView.alwaysBounceHorizontal = YES;
        _scrollView.delegate = self;
        _scrollView.bounces = NO;
        
        self.scrollView.scrollEnabled = NO;

        //缩放手势
        UIPinchGestureRecognizer *pinchGesture = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(event_pichMethod:)];
        [_scrollView addGestureRecognizer:pinchGesture];
        
        //长按手势
        UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(event_longPressMethod:)];
        [_scrollView addGestureRecognizer:longPressGesture];
        
        [self addSubview:_scrollView];
        
        [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self);
            make.right.equalTo(self);//.offset(-48);
            make.left.equalTo(self.mas_left);
            make.bottom.equalTo(self.mas_bottom);
        }];
        
        [self layoutIfNeeded];
    }
    return _scrollView;
}

- (Y_TLineFollowView *)tLineFollowView {
    if (!_tLineFollowView) {
        _tLineFollowView = [Y_TLineFollowView view];
        _tLineFollowView.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:_tLineFollowView];
        [_tLineFollowView mas_makeConstraints:^(MASConstraintMaker *make) {
            //make.right.equalTo(self);
            make.left.equalTo(self);
            make.top.equalTo(self).offset(-30);
            make.width.equalTo(@(MAIN_SCREEN_WIDTH));
            make.height.equalTo(@30);
        }];
    }
    return _tLineFollowView;
}

- (Y_VolumeMAView *)volumeMAView {
    if (!_volumeMAView) {
        _volumeMAView = [Y_VolumeMAView view];
//        _volumeMAView.layer.borderWidth = 0.5;
//        _volumeMAView.layer.borderColor = [[UIColor boarderColor] CGColor];
        
        [self addSubview:_volumeMAView];
        [_volumeMAView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self);
            make.left.equalTo(self);
            make.top.equalTo(self.kLineVolumeView.mas_top);
            make.height.equalTo(@10);
        }];
    }
    return _volumeMAView;
}

- (TimeLineMainView *)kLineMainView {
    if (!_kLineMainView && self) {
        _kLineMainView = [TimeLineMainView new];
//        _kLineMainView.layer.borderWidth = 0.5;
//        _kLineMainView.layer.borderColor = [[UIColor boarderColor] CGColor];
        
        _kLineMainView.delegate = self;
        [self.scrollView addSubview:_kLineMainView];
        [_kLineMainView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.scrollView).offset(0);//.offset(5);
            make.left.equalTo(self.scrollView);
            self.kLineMainViewHeightConstraint = make.height.equalTo(self.scrollView).multipliedBy(self.mainViewRatio);
            make.width.equalTo(self.scrollView);//(@0);
            //make.width.equalTo(self.scrollView);
        }];
        
        
    }
    //加载rightYYView
    self.priceView.backgroundColor = [UIColor clearColor];
    self.right_priceView.backgroundColor = [UIColor clearColor];
    self.volumeView.backgroundColor = [UIColor clearColor];
    return _kLineMainView;
}

- (Y_KLineVolumeView *)kLineVolumeView {
    if(!_kLineVolumeView && self)
    {
        _kLineVolumeView = [Y_KLineVolumeView new];
        _kLineVolumeView.layer.borderWidth = 0.5;
        _kLineVolumeView.layer.borderColor = [kUIColorFromRGB(0xd3d3d3) CGColor];
        _kLineVolumeView.chartType = Y_StockChartcenterViewTypeTimeLine;
        
        _kLineVolumeView.delegate = self;
        [self.scrollView addSubview:_kLineVolumeView];
        [_kLineVolumeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.kLineMainView);
            make.top.equalTo(self.kLineMainView.mas_bottom).offset(2);
            make.width.equalTo(self.kLineMainView.mas_width);
            make.bottom.equalTo(self).offset(-0.5);
            //self.kLineVolumeViewHeightConstraint = make.height.equalTo(self.scrollView.mas_height).multipliedBy(self.volumeViewRatio);
        }];
        [self layoutIfNeeded];
    }
    return _kLineVolumeView;
}

- (Y_StockChartRightYView *)priceView {
    if(!_priceView)
    {
        _priceView = [Y_StockChartRightYView new];
        [self insertSubview:_priceView aboveSubview:self.scrollView];
        [_priceView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self);
            //make.right.equalTo(self.mas_right).offset(-2);
            make.left.equalTo(self).offset(2);
            make.width.equalTo(@(Y_StockChartKLinePriceViewWidth));
            make.bottom.equalTo(self.kLineMainView.mas_bottom).offset(-15);
        }];
        
        [_priceView setAlignment:NSTextAlignmentLeft];
        _priceView.userInteractionEnabled = NO;
    }
    return _priceView;
}

- (Y_StockChartRightYView *)right_priceView {
    if(!_right_priceView)
    {
        _right_priceView = [Y_StockChartRightYView new];
        [self insertSubview:_right_priceView aboveSubview:self.scrollView];
        [_right_priceView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self);
            make.right.equalTo(self.mas_right).offset(-2);
            make.width.equalTo(@(Y_StockChartKLinePriceViewWidth));
            make.bottom.equalTo(self.kLineMainView.mas_bottom).offset(-15);
        }];
        _right_priceView.userInteractionEnabled = NO;
    }
    return _right_priceView;
}

- (Y_StockChartRightYView *)volumeView {
    if(!_volumeView)
    {
        _volumeView = [Y_StockChartRightYView new];
        _volumeView.type = 1;
        [self insertSubview:_volumeView aboveSubview:self.scrollView];
        [_volumeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.kLineVolumeView.mas_top);
            //make.right.width.equalTo(self.priceView);
            make.right.width.equalTo(self.right_priceView);
//            make.height.equalTo(self).multipliedBy(self.volumeViewRatio);
            make.bottom.equalTo(self.kLineVolumeView);
        }];
    }
    return _volumeView;
}

#pragma mark - set方法
- (void)setTimeLineType:(Y_StockTimeLineType)timeLineType {
    _timeLineType = timeLineType;
    _kLineMainView.timeLineType = timeLineType;
}

- (void)setCurrentStockType:(Y_StockType)currentStockType {
    _currentStockType = currentStockType;
    _kLineMainView.currentStockType = currentStockType;
}

#pragma mark kLineModels设置方法
- (void)setKLineModels:(NSArray *)kLineModels {
    if(!kLineModels) {
        [self.kLineMainView resetMainView];
        [self.kLineVolumeView resetMainView];
        return;
    }
    _kLineModels = kLineModels;
    
    
    
    
    [self private_drawKLineMainView];
    //设置contentOffset
//    CGFloat kLineViewWidth = self.kLineModels.count * [Y_StockChartGlobalVariable tLineWidth] + (self.kLineModels.count + 1) * [Y_StockChartGlobalVariable tLineGap];
    //CGFloat offset = kLineViewWidth - self.scrollView.frame.size.width;
//    if (offset > 0)
//    {
//        self.scrollView.contentOffset = CGPointMake(offset, 0);
//    } else {
//        self.scrollView.contentOffset = CGPointMake(0, 0);
//    }
    self.scrollView.contentOffset = CGPointMake(0, 0);

    
    Y_KLineModel *model = [kLineModels lastObject];
    
    [self.tLineFollowView maProfileWithModel:model];
    //[self.tLineFollowView showPriceLabel:NO];
    self.tLineFollowView.hidden = YES;
    
    
    [self.volumeMAView maProfileWithModel:model];

}

#pragma mark - event事件处理方法
#pragma mark 缩放执行方法
- (void)event_pichMethod:(UIPinchGestureRecognizer *)pinch {
    static CGFloat oldScale = 1.0f;
    CGFloat difValue = pinch.scale - oldScale;
    if(ABS(difValue) > Y_StockChartScaleBound) {
        CGFloat oldtLineWidth = [Y_StockChartGlobalVariable tLineWidth];

        NSInteger oldNeedDrawStartIndex = self.kLineMainView.needDrawStartIndex;
        NSLog(@"原来的index%ld",(long)self.kLineMainView.needDrawStartIndex);
        [Y_StockChartGlobalVariable settLineWith:oldtLineWidth * (difValue > 0 ? (1 + Y_StockChartScaleFactor) : (1 - Y_StockChartScaleFactor))];
        oldScale = pinch.scale;
        //更新MainView的宽度
        [self.kLineMainView updateMainViewWidth];
        
        if( pinch.numberOfTouches == 2 ) {
            CGPoint p1 = [pinch locationOfTouch:0 inView:self.scrollView];
            CGPoint p2 = [pinch locationOfTouch:1 inView:self.scrollView];
            CGPoint centerPoint = CGPointMake((p1.x+p2.x)/2, (p1.y+p2.y)/2);
            NSUInteger oldLeftArrCount = ABS((centerPoint.x - self.scrollView.contentOffset.x) - [Y_StockChartGlobalVariable tLineGap]) / ([Y_StockChartGlobalVariable tLineGap] + oldtLineWidth);
            NSUInteger newLeftArrCount = ABS((centerPoint.x - self.scrollView.contentOffset.x) - [Y_StockChartGlobalVariable tLineGap]) / ([Y_StockChartGlobalVariable tLineGap] + [Y_StockChartGlobalVariable tLineWidth]);
            
            self.kLineMainView.pinchStartIndex = oldNeedDrawStartIndex + oldLeftArrCount - newLeftArrCount;
            //            self.kLineMainView.pinchPoint = centerPoint;
            NSLog(@"计算得出的index%lu",(long)self.kLineMainView.pinchStartIndex);
        }
        [self.kLineMainView drawMainView];
    }
}
#pragma mark 长按手势执行方法
- (void)event_longPressMethod:(UILongPressGestureRecognizer *)longPress {
    static CGFloat oldPositionX = 0;
    if(UIGestureRecognizerStateChanged == longPress.state || UIGestureRecognizerStateBegan == longPress.state)
    {
        CGPoint location = [longPress locationInView:self.scrollView];
        if(ABS(oldPositionX - location.x) < ([Y_StockChartGlobalVariable tLineWidth] + [Y_StockChartGlobalVariable tLineGap])/2)
        {
            return;
        }
        
        //暂停滑动
        //self.scrollView.scrollEnabled = NO;
        oldPositionX = location.x;
        
        //初始化竖线
        if(!self.verticalView)
        {
            self.verticalView = [UIView new];
            self.verticalView.clipsToBounds = YES;
            [self.scrollView addSubview:self.verticalView];
            self.verticalView.backgroundColor = [UIColor longPressLineColor];
            [self.verticalView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self).offset(0);
                make.width.equalTo(@(Y_StockChartLongPressVerticalViewWidth));
                make.height.equalTo(self.scrollView.mas_height);
                make.left.equalTo(@(-10));
            }];
        }
        if(!self.horizontalView)
        {
            self.horizontalView = [UIView new];
            self.horizontalView.clipsToBounds = YES;
            [self.scrollView addSubview:self.horizontalView];
            self.horizontalView.backgroundColor = [UIColor longPressLineColor];
            [self.horizontalView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self).offset(-10);
                make.width.equalTo(self.scrollView.mas_width);
                make.height.equalTo(@(Y_StockChartLongPressVerticalViewWidth));
                make.left.equalTo(@(0));
            }];
        }
        
        //更新竖线位置
        CGFloat rightXPosition = [self.kLineMainView getExactXPositionWithOriginXPosition:location.x];
        [self.verticalView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(rightXPosition));
        }];
        [self.verticalView layoutIfNeeded];
        self.verticalView.hidden = NO;
        
        
        //更新横线位置
        CGFloat rightYPosition = [self.kLineMainView getExactYPositionWithOriginYPosition:location.x];
        [self.horizontalView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(rightYPosition);
        }];
        [self.horizontalView layoutIfNeeded];
        self.horizontalView.hidden = NO;
    }
    
    if(longPress.state == UIGestureRecognizerStateEnded)
    {
        //取消竖线
        if(self.verticalView)
        {
            self.verticalView.hidden = YES;
        }
        
        //取消横线
        if(self.horizontalView)
        {
            self.horizontalView.hidden = YES;
        }
        
        oldPositionX = 0;
        //恢复scrollView的滑动
        //self.scrollView.scrollEnabled = YES;
        
        Y_KLineModel *lastModel = self.kLineModels.lastObject;
        
        [self.tLineFollowView maProfileWithModel:lastModel];
        //[self.tLineFollowView showPriceLabel:NO];
        self.tLineFollowView.hidden = YES;

        
        [self.volumeMAView maProfileWithModel:lastModel];
        //[self.accessoryMAView maProfileWithModel:lastModel];
    }
}

#pragma mark 重绘
- (void)reDraw {
    self.kLineMainView.MainViewType = Y_StockChartcenterViewTypeTimeLine;

    [self.kLineMainView drawMainView];
}

#pragma mark - 私有方法
#pragma mark 画KLineMainView
- (void)private_drawKLineMainView {
    self.kLineMainView.kLineModels = self.kLineModels;
    [self.kLineMainView drawMainView];
}

- (void)private_drawKLineVolumeView {
    NSAssert(self.kLineVolumeView, @"kLineVolume不存在");
    //更新约束
    [self.kLineVolumeView layoutIfNeeded];
    [self.kLineVolumeView draw];
}

#pragma mark VolumeView代理
- (void)kLineVolumeViewCurrentMaxVolume:(CGFloat)maxVolume minVolume:(CGFloat)minVolume {
    self.volumeView.maxValue = maxVolume;
    self.volumeView.minValue = minVolume;
    self.volumeView.middleValue = (maxVolume - minVolume)/2 + minVolume;
}

- (void)kLineMainViewCurrentMaxPrice:(CGFloat)maxPrice minPrice:(CGFloat)minPrice {
//    self.priceView.maxValue = maxPrice;
//    self.priceView.minValue = minPrice;
//    self.priceView.middleValue = (maxPrice - minPrice)/2 + minPrice;
    
    float midValue = (maxPrice - minPrice)/2 + minPrice;
    float up = (maxPrice-midValue)/midValue;
    float down =  (minPrice-midValue)/midValue;
    
    [self.priceView setUp:[SystemUtil get2decimal:maxPrice]];
    [self.priceView setPlan:[SystemUtil get2decimal:midValue]];
    [self.priceView setDown:[SystemUtil get2decimal:minPrice]];
    
    [self.right_priceView setUp:[SystemUtil getPercentage:100*up]];
    [self.right_priceView setPlan:[SystemUtil getPercentage:0.0]];
    [self.right_priceView setDown:[SystemUtil getPercentage:100*down]];

    
}

#pragma mark MainView更新时通知下方的view进行相应内容更新
- (void)kLineMainViewCurrentNeedDrawKLineModels:(NSArray *)needDrawKLineModels {
    self.kLineVolumeView.needDrawKLineModels = needDrawKLineModels;
}

- (void)kLineMainViewCurrentNeedDrawKLinePositionModels:(NSArray *)needDrawKLinePositionModels {
    self.kLineVolumeView.needDrawKLinePositionModels = needDrawKLinePositionModels;
}

- (void)kLineMainViewCurrentNeedDrawKLineColors:(NSArray *)kLineColors {
    self.kLineVolumeView.kLineColors = kLineColors;
//    if(self.targetLineStatus >= 103)
//    {
//           self.kLineVolumeView.targetLineStatus = self.targetLineStatus;
//    }
    [self private_drawKLineVolumeView];

}

- (void)kLineMainViewLongPressKLinePositionModel:(Y_KLinePositionModel *)kLinePositionModel kLineModel:(Y_KLineModel *)kLineModel {
    //跟随View
    [self.tLineFollowView maProfileWithModel:kLineModel];
    //[self.tLineFollowView showPriceLabel:YES];
    self.tLineFollowView.hidden = NO;
    
    
    //更新ma信息
    [self.volumeMAView maProfileWithModel:kLineModel];
    //[self.accessoryMAView maProfileWithModel:kLineModel];
}
#pragma mark - UIScrollView代理
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    static BOOL isNeedPostNotification = YES;
//    if(scrollView.contentOffset.x < scrollView.frame.size.width * 2)
//    {
//        if(isNeedPostNotification)
//        {
//            self.oldExactOffset = scrollView.contentSize.width - scrollView.contentOffset.x;
//            isNeedPostNotification = NO;
//        }
//    } else {
//        isNeedPostNotification = YES;
//    }
    
    NSLog(@"这是  %f-----%f=====%f",scrollView.contentSize.width,scrollView.contentOffset.x,self.kLineMainView.frame.size.width);
}

- (void)dealloc {
    [_kLineMainView removeAllObserver];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
