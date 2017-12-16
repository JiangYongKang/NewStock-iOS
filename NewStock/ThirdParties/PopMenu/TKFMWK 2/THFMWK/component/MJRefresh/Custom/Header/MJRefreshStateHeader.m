//
//  MJRefreshStateHeader.m
//  MJRefreshExample
//
//  Created by MJ Lee on 15/4/24.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import "MJRefreshStateHeader.h"

@interface MJRefreshStateHeader()
{
    /** 显示上一次刷新时间的label */
    __weak UILabel *_lastUpdatedTimeLabel;
    /** 显示刷新状态的label */
    __weak UILabel *_stateLabel;
}
/** 所有状态对应的文字 */
@property (strong, nonatomic) NSMutableDictionary *stateTitles;
@end

@implementation MJRefreshStateHeader
#pragma mark - 懒加载
- (NSMutableDictionary *)stateTitles
{
    if (!_stateTitles) {
        self.stateTitles = [NSMutableDictionary dictionary];
    }
    return _stateTitles;
}

- (UILabel *)stateLabel
{
    if (!_stateLabel) {
        [self addSubview:_stateLabel = [UILabel label]];
        _stateLabel.frame = CGRectMake(0, self.frame.size.height - 20, self.frame.size.width, 20);
        _stateLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _stateLabel;
}

- (UILabel *)lastUpdatedTimeLabel
{
    if (!_lastUpdatedTimeLabel) {
        [self addSubview:_lastUpdatedTimeLabel = [UILabel label]];
    }
    if (self.isSingleRow)
    {
        _lastUpdatedTimeLabel.hidden = YES;
    }
    return _lastUpdatedTimeLabel;
}

#pragma mark - 公共方法
- (void)setTitle:(NSString *)title forState:(MJRefreshState)state
{
    if (title == nil) return;
    self.stateTitles[@(state)] = title;
    self.stateLabel.text = self.stateTitles[@(self.state)];
}

#pragma mark key的处理
- (void)setLastUpdatedTimeKey:(NSString *)lastUpdatedTimeKey
{
    [super setLastUpdatedTimeKey:lastUpdatedTimeKey];
    
    NSDate *lastUpdatedTime = [[NSUserDefaults standardUserDefaults] objectForKey:lastUpdatedTimeKey];
    if (!lastUpdatedTime)
    {
        lastUpdatedTime = [NSDate date];
    }
    // 如果有block
    if (self.lastUpdatedTimeText) {
        self.lastUpdatedTimeLabel.text = self.lastUpdatedTimeText(lastUpdatedTime);
        return;
    }
    
    if (lastUpdatedTime) {
        // 1.获得年月日
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSUInteger unitFlags = NSCalendarUnitYear| NSCalendarUnitMonth | NSCalendarUnitDay |NSCalendarUnitHour |NSCalendarUnitMinute;
        NSDateComponents *cmp1 = [calendar components:unitFlags fromDate:lastUpdatedTime];
        NSDateComponents *cmp2 = [calendar components:unitFlags fromDate:[NSDate date]];
        // 2.格式化日期
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        if (self.isSingleRow)
        {
            if (self.state == MJRefreshStateIdle)
            {
                formatter.dateFormat = @"MM/dd HH:mm:ss";
            }
            else if (self.state == MJRefreshStatePulling)
            {
                formatter.dateFormat = @"HH:mm:ss";
            }
            NSString *time = [formatter stringFromDate:lastUpdatedTime];
            // 3.显示日期
            self.lastUpdatedTimeLabel.text = [NSString stringWithFormat:@"%@", time];
        }
        else
        {
            if ([cmp1 day] == [cmp2 day]) { // 今天
                formatter.dateFormat = @"今天 HH:mm";
            } else if ([cmp1 year] == [cmp2 year]) { // 今年
                formatter.dateFormat = @"MM-dd HH:mm";
            } else {
                formatter.dateFormat = @"yyyy-MM-dd HH:mm";
            }
            NSString *time = [formatter stringFromDate:lastUpdatedTime];
            
            // 3.显示日期
            self.lastUpdatedTimeLabel.text = [NSString stringWithFormat:@"最后更新：%@", time];
        }
    } else {
        if (self.isSingleRow)
        {
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"MM/dd HH:mm:ss";
            NSString *time = [formatter stringFromDate:lastUpdatedTime];
            // 3.显示日期
            self.lastUpdatedTimeLabel.text = [NSString stringWithFormat:@"%@", time];
        }
        else
        {
            self.lastUpdatedTimeLabel.text = @"最后更新：无记录";
        }
    }
}

#pragma mark - 覆盖父类的方法
- (void)prepare
{
    [super prepare];
    if (self.isSingleRow)
    {
        // 初始化文字
        [self setTitle:@"释放刷新" forState:MJRefreshStateIdle];
        [self setTitle:@"释放刷新 最后更新" forState:MJRefreshStatePulling];
        [self setTitle:@"更新中..." forState:MJRefreshStateRefreshing];
    }
    else
    {
        // 初始化文字
        [self setTitle:MJRefreshHeaderIdleText forState:MJRefreshStateIdle];
        [self setTitle:MJRefreshHeaderPullingText forState:MJRefreshStatePulling];
        [self setTitle:MJRefreshHeaderRefreshingText forState:MJRefreshStateRefreshing];
    }
}

- (void)placeSubviews
{
    [super placeSubviews];
    
    if (self.stateLabel.hidden) return;
    
    if (self.lastUpdatedTimeLabel.hidden) {
        // 状态
        self.stateLabel.frame = self.bounds;
    } else {
        // 状态
        self.stateLabel.mj_x = 0;
        self.stateLabel.mj_y = 0;
        self.stateLabel.mj_w = self.mj_w;
        self.stateLabel.mj_h = self.mj_h * 0.5;
        
        // 更新时间
        self.lastUpdatedTimeLabel.mj_x = 0;
        self.lastUpdatedTimeLabel.mj_y = self.stateLabel.mj_h;
        self.lastUpdatedTimeLabel.mj_w = self.mj_w;
        self.lastUpdatedTimeLabel.mj_h = self.mj_h - self.lastUpdatedTimeLabel.mj_y;
    }
}

- (void)setState:(MJRefreshState)state
{
    if (self.isSingleRow)
    {
        // 初始化文字
        [self setTitle:@"释放刷新" forState:MJRefreshStateIdle];
        [self setTitle:@"释放刷新 最后更新" forState:MJRefreshStatePulling];
        [self setTitle:@"更新中..." forState:MJRefreshStateRefreshing];
    }
    else
    {
        // 初始化文字
        [self setTitle:MJRefreshHeaderIdleText forState:MJRefreshStateIdle];
        [self setTitle:MJRefreshHeaderPullingText forState:MJRefreshStatePulling];
        [self setTitle:MJRefreshHeaderRefreshingText forState:MJRefreshStateRefreshing];
    }
    MJRefreshCheckState
    // 重新设置key（重新显示时间）
    self.lastUpdatedTimeKey = self.lastUpdatedTimeKey;
    // 设置状态文字
    if (self.isSingleRow)
    {
        self.stateLabel.text = [NSString stringWithFormat:@"%@ %@",self.stateTitles[@(state)],self.lastUpdatedTimeLabel.text];
    }
    else
    {
        self.stateLabel.text = self.stateTitles[@(state)];
    }
}
@end
