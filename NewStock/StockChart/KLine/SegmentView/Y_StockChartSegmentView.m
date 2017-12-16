//
//  Y_StockChartSegmentView.m
//  BTC-Kline
//
//  Created by yate1996 on 16/5/2.
//  Copyright © 2016年 yate1996. All rights reserved.
//

#import "Y_StockChartSegmentView.h"
#import "Masonry.h"
#import "UIColor+Y_StockChart.h"
#import "SystemUtil.h"
#import "MarketConfig.h"
#import "Defination.h"
#import "PopoverView.h"

static NSInteger const Y_StockChartSegmentStartTag = 2000;

@interface Y_StockChartSegmentView()

@property (nonatomic, strong) UIButton *selectedBtn;
@property (nonatomic, strong) PopoverView *pop;
@property (nonatomic, assign) CGFloat btnFontSize;

@end

@implementation Y_StockChartSegmentView

- (instancetype)initWithItems:(NSArray *)items {
    self = [super initWithFrame:CGRectZero];
    if(self) {
        self.items = items;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        self.backgroundColor = [UIColor assistBackgroundColor];
    }
    return self;
}

- (void)setItems:(NSArray *)items {
    _items = items;
    if(items.count == 0 || !items)
    {
        return;
    }
    NSInteger index = 0;
    NSInteger count = items.count;
    UIButton *preBtn = nil;
    
    for (NSString *title in items) {
        UIButton *btn = [self private_createButtonWithTitle:title tag:Y_StockChartSegmentStartTag+index];
        UIView *view = [UIView new];
        view.backgroundColor = SEP_BG_COLOR;
        [self addSubview:btn];
        [self addSubview:view];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top);
            make.height.equalTo(self);
            make.width.equalTo(self).multipliedBy(1.0f/count);
            if(preBtn)
            {
                make.left.equalTo(preBtn.mas_right).offset(0.5);
            } else {
                make.left.equalTo(self);
            }
        }];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(btn);
            make.left.equalTo(btn.mas_right);
            make.width.equalTo(@0.5);
        }];
        preBtn = btn;
        index++;
    }
}

#pragma mark 设置底部按钮index
- (void)setSelectedIndex:(NSUInteger)selectedIndex {
    _selectedIndex = selectedIndex;
    UIButton *btn = (UIButton *)[self viewWithTag:Y_StockChartSegmentStartTag + selectedIndex];
    NSAssert(btn, @"按钮初始化出错");
    [self event_segmentButtonClicked:btn];
}

- (void)setSelectedBtn:(UIButton *)selectedBtn {
    
    UIView *btn = [_selectedBtn viewWithTag:10];
    btn.hidden = YES;
    
    UIView *btn1 = [selectedBtn viewWithTag:10];
    btn1.hidden = NO;
    
    _selectedBtn.titleLabel.font = [UIFont systemFontOfSize:self.btnFontSize];
    selectedBtn.titleLabel.font = [UIFont boldSystemFontOfSize:self.btnFontSize];
    
    [_selectedBtn setSelected:NO];
    [selectedBtn setSelected:YES];
    _selectedBtn = selectedBtn;

    _selectedIndex = selectedBtn.tag - Y_StockChartSegmentStartTag;
    [self layoutIfNeeded];
}

#pragma mark - 私有方法
#pragma mark 创建底部按钮
- (UIButton *)private_createButtonWithTitle:(NSString *)title tag:(NSInteger)tag {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitleColor:[UIColor mainTextColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor btnSelectedColor] forState:UIControlStateSelected];

    [btn setBackgroundImage:[self createImageWithColor:[SystemUtil hexStringToColor:@"#ffffff"]] forState:UIControlStateSelected];
    
    UILabel *line = [[UILabel alloc] init];
    line.tag = 10;
    line.backgroundColor = [SystemUtil hexStringToColor:@"#358ee7"];
    [btn addSubview:line];
    line.hidden = YES;
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(33 * kScale));
        make.height.equalTo(@(3 * kScale));
        make.centerX.equalTo(btn);
        make.bottom.equalTo(btn);
    }];
    
    btn.titleLabel.font = [UIFont systemFontOfSize:self.btnFontSize];
    btn.tag = tag;
    [btn addTarget:self action:@selector(event_segmentButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:title forState:UIControlStateNormal];
    return btn;
}

- (UIImage*) createImageWithColor: (UIColor*) color {
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

- (void)reloadData {
    UIButton *btn = self.selectedBtn;//(UIButton *)[self viewWithTag:Y_StockChartSegmentStartTag + _selectedIndex];
    //if ([btn.titleLabel.text hasPrefix:@"分钟"])
    NSRange range = [btn.titleLabel.text rangeOfString:@"分钟"];//判断字符串是否包含
    if (range.length > 0) {
        if(self.delegate && [self.delegate respondsToSelector:@selector(y_StockChartSegmentView:clickSegmentButtonIndex:)]) {
            [self.delegate y_StockChartSegmentView:self clickSegmentButtonIndex: btn.tag-Y_StockChartSegmentStartTag+_subSelectedIndex];
        }
        
    } else {
        if(self.delegate && [self.delegate respondsToSelector:@selector(y_StockChartSegmentView:clickSegmentButtonIndex:)])
        {
            [self.delegate y_StockChartSegmentView:self clickSegmentButtonIndex: btn.tag-Y_StockChartSegmentStartTag];
        }
    }
}

#pragma mark 按钮点击事件
- (void)event_segmentButtonClicked:(UIButton *)btn {
    //    if ([btn.titleLabel.text hasPrefix:@"分钟"])
    NSRange range = [btn.titleLabel.text rangeOfString:@"分钟"];//判断字符串是否包含
    if (range.length > 0)
    {
        //弹出分钟选项
        CGPoint point = CGPointMake(btn.frame.origin.x + btn.frame.size.width/2, btn.frame.origin.y + btn.frame.size.height);
        NSArray *titles = @[@"1分钟", @"5分钟", @"15分钟", @"30分钟", @"60分钟"];
        //NSArray *images = @[@"img1", @"img2", @"img3"];
        //if(!self.pop)
        self.pop = [[PopoverView alloc] initWithPoint:point titles:titles images:nil];
        
        __weak typeof(self) weakSelf = self;
        self.pop.selectRowAtIndex = ^(NSInteger index){
            //NSLog(@"select index:%ld", index);
            _subSelectedIndex = index;
            
            weakSelf.selectedBtn = btn;
            [weakSelf.selectedBtn setTitle:[NSString stringWithFormat:@"%@ ▼",[titles objectAtIndex:index]] forState:UIControlStateNormal];


            if(weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(y_StockChartSegmentView:clickSegmentButtonIndex:)])
            {
                [weakSelf.delegate y_StockChartSegmentView:weakSelf clickSegmentButtonIndex: btn.tag - Y_StockChartSegmentStartTag+index];
            }
        };
        [self.pop show];
        return;
    }
    else
    {
        NSRange range2 = [self.selectedBtn.titleLabel.text rangeOfString:@"分钟"];//判断字符串是否包含
        if (range2.length > 0)
        {
            [self.selectedBtn setTitle:@"分钟 ▼" forState:UIControlStateNormal];
        }
    }
    
    
    self.selectedBtn = btn;
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(y_StockChartSegmentView:clickSegmentButtonIndex:)]) {
        [self.delegate y_StockChartSegmentView:self clickSegmentButtonIndex: btn.tag-Y_StockChartSegmentStartTag];
    }
}

#pragma mark add

- (CGFloat )btnFontSize {
    return 13;
}

@end
