//
//  MJChiBaoZiHeader.m
//  MJRefreshExample
//
//  Created by MJ Lee on 15/6/12.
//  Copyright © 2015年 小码哥. All rights reserved.
//

#import "MJChiBaoZiHeader.h"
#import "Defination.h"

@interface MJChiBaoZiHeader ()

@property (nonatomic, strong) NSArray *textArray;

@end

@implementation MJChiBaoZiHeader
#pragma mark - 重写方法
#pragma mark 基本设置

- (void)prepare {
    [super prepare];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeText) name:@"MJRefreshChangeText" object:nil];
    // 设置普通状态的动画图片
    NSMutableArray *idleImages = [NSMutableArray array];
    for (NSUInteger i = 1; i <= 5; i ++) {
        //UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_anim__000%zd", i]];
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_loading_0%zd", i]];
        [idleImages addObject:image];
    }
    [self setImages:idleImages forState:MJRefreshStateIdle];
    
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (NSUInteger i = 1; i <= 5; i ++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_loading_0%zd", i]];
        [refreshingImages addObject:image];
    }
    [self setImages:refreshingImages forState:MJRefreshStatePulling];
    self.stateLabel.font = [UIFont systemFontOfSize:12];

    // 设置正在刷新状态的动画图片
    [self setImages:refreshingImages forState:MJRefreshStateRefreshing];
    self.lastUpdatedTimeLabel.font = [UIFont systemFontOfSize:11];
    self.lastUpdatedTimeLabel.textColor = kUIColorFromRGB(0x808080);
}

- (void)changeText {
    NSString *text = self.textArray[(NSInteger )arc4random_uniform((uint32_t)self.textArray.count)];
    [self setTitle:text forState:MJRefreshStateRefreshing];
    [self setTitle:text forState:MJRefreshStatePulling];
    [self setTitle:text forState:MJRefreshStateWillRefresh];
    [self setTitle:text forState:MJRefreshStateIdle];
}

- (NSArray *)textArray {
    if (_textArray == nil) {
        _textArray = @[
                       @"K线：发明于日本米市故又称为日本线。",
                       @"利空：是促使股价下跌，对空头有利的因素和消息。",
                       @"利多：是刺激股价上涨，对多头有利的因素和消息",
                       @"牛市：指整个股市价格呈上升趋势",
                       @"熊市：指整个股市价格普遍下跌的行情",
                       @"A股的正式名称是人民币普通股票",
                       @"B股的正式名称是人民币特种股票",
                       @"H股，即内地注册，在香港上市的的外资股",
                       @"“T”类股票包括ST股和PT股",
                       @"深沪两市的集合竞价时间为交易日上午9:15至9:25",
                       @"股票的每日涨跌幅限制为前个交易日收盘价的10％ ",
                       @"ST股的每日涨跌幅限制为前个交易日收盘价的5％",
                       @"沪深交易时间:(法定节假日除外)每日9:30-11:30，13:00-15:00",
                       @"新股上市首日不受涨跌幅度限制",
                       @"股票买卖单位为“手”，1手=100股",
                       @"股票投资是一种没有期限的长期投资",
                       @"我国目前2个证券交易所：上海证券交易所+深圳证券交易所",
                       @"大盘股一般指股本较大，流通盘大于5个亿的股票",
                       @"小盘股一般指股本较小，流通盘小于1个亿的股票",
                       @"当天买入的股票，下一个交易日才能卖出",
                       @"ST股是指公司经营连续二年亏损，特别处理的股票",
                       @"*ST股指公司经营连续三年亏损，有退市预警的股票",
                       @"股侠圈是我们的交流场所，欢迎您多发贴分享观点",
                       @"“牛散达人”可以帮助您快速的查看股东增减持信息",
                       @"“龙虎榜”更新时间为每天4:30之后",
                       @"“炒个情怀”里面都是股市的名言集锦与大佬秘籍",
                       @"股票代码\"600\"或\"601\"开头的是沪市A股",
                       @"股票代码“000”开头的是深市A股",
                       @"股票代码“300”开头的是创业板的股票",
                       ];
    }
    return _textArray;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
