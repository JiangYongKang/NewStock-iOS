//
//  PlateRankView.m
//  NewStock
//
//  Created by Willey on 16/11/24.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "PlateRankView.h"
#import "PlateBlock.h"
#import "Defination.h"
#import "Masonry.h"
#import "UIView+Masonry_Arrange.h"
#import "MarketConfig.h"
#import "SystemUtil.h"

@interface PlateRankView ()<PlateBlockDelegate>
{
    PlateBlock *_plateBlock1;
    PlateBlock *_plateBlock2;
    PlateBlock *_plateBlock3;
    
    
    PlateBlock *_plateBlock4;
    PlateBlock *_plateBlock5;
    PlateBlock *_plateBlock6;
}
@end


@implementation PlateRankView

- (id)init {
    self = [super init];
    if (self)
    {
        self.backgroundColor = [UIColor whiteColor];
        
        int padding1 = 3;
        int blockHeight = 105;
        int blockWidth = (MAIN_SCREEN_WIDTH-padding1*4)/3;
        
        _plateBlock1 = [[PlateBlock alloc] initWithDelegate:self tag:0];
        _plateBlock2 = [[PlateBlock alloc] initWithDelegate:self tag:1];
        _plateBlock3 = [[PlateBlock alloc] initWithDelegate:self tag:2];
        
        _plateBlock4 = [[PlateBlock alloc] initWithDelegate:self tag:3];
        _plateBlock5 = [[PlateBlock alloc] initWithDelegate:self tag:4];
        _plateBlock6 = [[PlateBlock alloc] initWithDelegate:self tag:5];
        
        [self addSubview:_plateBlock1];
        [self addSubview:_plateBlock2];
        [self addSubview:_plateBlock3];
        
        [self addSubview:_plateBlock4];
        [self addSubview:_plateBlock5];
        [self addSubview:_plateBlock6];
        
        [_plateBlock1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(padding1);
            make.centerY.equalTo(@[_plateBlock2,_plateBlock3]);
            make.size.mas_equalTo(CGSizeMake(blockWidth, blockHeight));
        }];
        [_plateBlock2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(blockWidth, blockHeight));
        }];
        [_plateBlock3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(blockWidth, blockHeight));
        }];
        [self distributeSpacingHorizontallyWith:@[_plateBlock1,_plateBlock2,_plateBlock3]];
        
        UIImageView *tag_bg1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tag_bg"]];
        [_plateBlock1 addSubview:tag_bg1];
        [tag_bg1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_plateBlock1.mas_top).offset(-3);
            make.left.equalTo(_plateBlock1.mas_left).offset(5);
            make.width.mas_equalTo(16);
            make.height.mas_equalTo(29);
        }];
        UILabel *tag_lb1 = [[UILabel alloc] init];
        tag_lb1.text = @"概念";
        tag_lb1.textColor = [UIColor whiteColor];
        tag_lb1.font = [UIFont systemFontOfSize:10];
        tag_lb1.numberOfLines = 2;
        tag_lb1.textAlignment = NSTextAlignmentCenter;
        [tag_bg1 addSubview:tag_lb1];
        [tag_lb1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(tag_lb1.superview).with.insets(UIEdgeInsetsMake(0, 0, 5, 0));
        }];
        
        [_plateBlock4 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(blockHeight+padding1*3);
            make.centerY.equalTo(@[_plateBlock5,_plateBlock6]);
            make.size.mas_equalTo(CGSizeMake(blockWidth, blockHeight));
        }];
        [_plateBlock5 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(blockWidth, blockHeight));
        }];
        [_plateBlock6 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(blockWidth, blockHeight));
        }];
        [self distributeSpacingHorizontallyWith:@[_plateBlock4,_plateBlock5,_plateBlock6]];
        
        UIImageView *tag_bg2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tag_bg"]];
        [_plateBlock4 addSubview:tag_bg2];
        [tag_bg2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_plateBlock4.mas_top).offset(-3);
            make.left.equalTo(_plateBlock4.mas_left).offset(5);
            make.width.mas_equalTo(16);
            make.height.mas_equalTo(29);
        }];
        UILabel *tag_lb2 = [[UILabel alloc] init];
        tag_lb2.text = @"行业";
        tag_lb2.textColor = [UIColor whiteColor];
        tag_lb2.font = [UIFont systemFontOfSize:10];
        tag_lb2.numberOfLines = 2;
        tag_lb2.textAlignment = NSTextAlignmentCenter;
        [tag_bg2 addSubview:tag_lb2];
        [tag_lb2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(tag_lb2.superview).with.insets(UIEdgeInsetsMake(0, 0, 5, 0));
        }];
        
        
        UIView *line11 = [[UIView alloc] init];
        line11.backgroundColor = SEP_LINE_COLOR;
        [self addSubview:line11];
        [line11 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_plateBlock1.mas_top).offset(10);
            make.left.equalTo(_plateBlock1.mas_right);
            make.bottom.equalTo(_plateBlock1.mas_bottom).offset(-10);
            make.width.mas_equalTo(0.5);
        }];
        UIView *line12 = [[UIView alloc] init];
        line12.backgroundColor = SEP_LINE_COLOR;
        [self addSubview:line12];
        [line12 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_plateBlock1.mas_top).offset(10);
            make.left.equalTo(_plateBlock2.mas_right);
            make.bottom.equalTo(_plateBlock1.mas_bottom).offset(-10);
            make.width.mas_equalTo(0.5);
        }];
        
        UIView *sepLine1 = [[UIView alloc] init];
        sepLine1.backgroundColor = SEP_LINE_COLOR;
        [self addSubview:sepLine1];
        [sepLine1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_plateBlock1.mas_bottom).offset(padding1);
            make.left.equalTo(self);
            make.right.equalTo(self);
            make.height.mas_equalTo(0.5);
        }];
        
        UIView *line21 = [[UIView alloc] init];
        line21.backgroundColor = SEP_LINE_COLOR;
        [self addSubview:line21];
        [line21 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_plateBlock4.mas_top).offset(10);
            make.left.equalTo(_plateBlock4.mas_right);
            make.bottom.equalTo(_plateBlock4.mas_bottom).offset(-10);
            make.width.mas_equalTo(0.5);
        }];
        UIView *line22 = [[UIView alloc] init];
        line22.backgroundColor = SEP_LINE_COLOR;
        [self addSubview:line22];
        [line22 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_plateBlock4.mas_top).offset(10);
            make.left.equalTo(_plateBlock5.mas_right);
            make.bottom.equalTo(_plateBlock4.mas_bottom).offset(-10);
            make.width.mas_equalTo(0.5);
        }];
        

        
    }
    return self;
}

- (void)setConceptModels:(NSArray *)array {
    if ([array count] > 2) {
        BoardListModel *model1 = [array objectAtIndex:0];
        NSString *leadingStock1 = model1.leadingStock;
        if (leadingStock1.length == 0) {
            return;
        }
        NSArray *leadingStockArray1 = [model1.leadingStockName componentsSeparatedByString:@":"];;
        NSArray *array1 = [leadingStock1 componentsSeparatedByString:@":"];
        NSString *increase1 = @"";
        if ([array1 count]>3)
        {
            NSString *tempStr = [array1 objectAtIndex:3];
            increase1 = [NSString stringWithFormat:@"%@%%",[NSString stringWithFormat:@"%.2f",tempStr.doubleValue]];
        }
        if (leadingStockArray1.count >= 2) {
            NSString *str1 = [leadingStockArray1 objectAtIndex:1];
            _plateBlock1.model = model1;
            [_plateBlock1 setCode:model1.symbol title:model1.industryName value:[SystemUtil getPercentage:[model1.industryUp doubleValue]] name:[leadingStockArray1 objectAtIndex:0] change:[NSString stringWithFormat:@"%.2f",str1.doubleValue] changeRate:increase1];
            
        }

        
        //
        BoardListModel *model2 = [array objectAtIndex:1];
        NSString *leadingStock2 = model2.leadingStock;
        NSArray *leadingStockArray2 = [model2.leadingStockName componentsSeparatedByString:@":"];;
        NSArray *array2 = [leadingStock2 componentsSeparatedByString:@":"];
        NSString *increase2 = @"";
        if ([array2 count]>3)
        {
            NSString *tempStr = [array2 objectAtIndex:3];
            increase2 = [NSString stringWithFormat:@"%@%%",[NSString stringWithFormat:@"%.2f",tempStr.doubleValue]];
        }
        NSString *str2 = [leadingStockArray2 objectAtIndex:1];
        _plateBlock2.model = model2;
        [_plateBlock2 setCode:model2.symbol title:model2.industryName value:[SystemUtil getPercentage:[model2.industryUp doubleValue]] name:[leadingStockArray2 objectAtIndex:0] change:[NSString stringWithFormat:@"%.2f",str2.doubleValue] changeRate:increase2];
        
        
        //
        BoardListModel *model3 = [array objectAtIndex:2];
        NSString *leadingStock3 = model3.leadingStock;
        NSArray *leadingStockArray3 = [model3.leadingStockName componentsSeparatedByString:@":"];;
        NSArray *array3 = [leadingStock3 componentsSeparatedByString:@":"];
        NSString *increase3 = @"";
        if ([array3 count]>3)
        {
            NSString *tempStr = [array3 objectAtIndex:3];
            increase3 = [NSString stringWithFormat:@"%@%%",[NSString stringWithFormat:@"%.2f",tempStr.doubleValue]];
        }
        NSString *str3 = [leadingStockArray3 objectAtIndex:1];
        _plateBlock3.model = model3;
        [_plateBlock3 setCode:model3.symbol title:model3.industryName value:[SystemUtil getPercentage:[model3.industryUp doubleValue]] name:[leadingStockArray3 objectAtIndex:0] change:[NSString stringWithFormat:@"%.2f",str3.doubleValue] changeRate:increase3];
    }

}

- (void)setIndustryModels:(NSArray *)array {
    if ([array count]>2)
    {
        BoardListModel *model1 = [array objectAtIndex:0];
        NSString *leadingStock1 = model1.leadingStock;
        NSArray *leadingStockArray1 = [model1.leadingStockName componentsSeparatedByString:@":"];;
        NSArray *array1 = [leadingStock1 componentsSeparatedByString:@":"];
        NSString *increase1 = @"";
        if ([array1 count]>3)
        {
            NSString *tempStr = [array1 objectAtIndex:3];
            increase1 = [NSString stringWithFormat:@"%@%%",[NSString stringWithFormat:@"%.2f",tempStr.doubleValue]];
        }
        
        if (leadingStockArray1.count >= 2) {
            NSString *str1 = [leadingStockArray1 objectAtIndex:1];
            _plateBlock4.model = model1;
            [_plateBlock4 setCode:model1.symbol title:model1.industryName value:[SystemUtil getPercentage:[model1.industryUp doubleValue]] name:[leadingStockArray1 objectAtIndex:0] change:[NSString stringWithFormat:@"%.2f",str1.doubleValue] changeRate:increase1];
        }

        
        
        //
        BoardListModel *model2 = [array objectAtIndex:1];
        NSString *leadingStock2 = model2.leadingStock;
        NSArray *leadingStockArray2 = [model2.leadingStockName componentsSeparatedByString:@":"];;
        NSArray *array2 = [leadingStock2 componentsSeparatedByString:@":"];
        NSString *increase2 = @"";
        if ([array2 count]>3)
        {
            NSString *tempStr = [array2 objectAtIndex:3];
            increase2 = [NSString stringWithFormat:@"%@%%",[NSString stringWithFormat:@"%.2f",tempStr.doubleValue]];
        }
        
        if (leadingStockArray2.count >= 2) {
            NSString *str2 = [leadingStockArray2 objectAtIndex:1];
            _plateBlock5.model = model2;
            [_plateBlock5 setCode:model2.symbol title:model2.industryName value:[SystemUtil getPercentage:[model2.industryUp doubleValue]] name:[leadingStockArray2 objectAtIndex:0] change:[NSString stringWithFormat:@"%.2f",str2.doubleValue] changeRate:increase2];
        }

        
        //
        BoardListModel *model3 = [array objectAtIndex:2];
        NSString *leadingStock3 = model3.leadingStock;
        NSArray *leadingStockArray3 = [model3.leadingStockName componentsSeparatedByString:@":"];;
        NSArray *array3 = [leadingStock3 componentsSeparatedByString:@":"];
        NSString *increase3 = @"";
        if ([array3 count]>3)
        {
            NSString *tempStr = [array3 objectAtIndex:3];
            increase3 = [NSString stringWithFormat:@"%@%%",[NSString stringWithFormat:@"%.2f",tempStr.doubleValue]];
        }
        if (leadingStockArray3.count >= 2) {
            NSString *str3 = [leadingStockArray3 objectAtIndex:1];
            _plateBlock6.model = model3;
            [_plateBlock6 setCode:model3.symbol title:model3.industryName value:[SystemUtil getPercentage:[model3.industryUp doubleValue]] name:[leadingStockArray3 objectAtIndex:0] change:[NSString stringWithFormat:@"%.2f",str3.doubleValue] changeRate:increase3];
        }
    }

}

- (void)plateBlock:(PlateBlock*)plateBlock code:(NSString *)code {
    if([self.delegate respondsToSelector:@selector(plateRankView:selectModel:)]) {
        [self.delegate plateRankView:self selectModel:plateBlock.model];
    }
}



@end
