//
//  BoardDetailTitleCell.m
//  NewStock
//
//  Created by Willey on 16/8/3.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "BoardDetailTitleCell.h"
#import "Defination.h"
#import <Masonry.h>
#import "MarketConfig.h"

@implementation BoardDetailTitleCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        //int Xcenter = MAIN_SCREEN_WIDTH/2;
        
        UILabel *titleLb = [[UILabel alloc] init];
        titleLb.backgroundColor = [UIColor clearColor];
        titleLb.textColor = [UIColor darkGrayColor];
        titleLb.font = [UIFont systemFontOfSize:15 * kScale];
        titleLb.text = @"板块成分股";
        titleLb.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:titleLb];
        [titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.equalTo(self).offset(12 * kScale);
        }];
        
        _upLb = [[UILabel alloc] init];
        _upLb.backgroundColor = [UIColor clearColor];
        _upLb.textColor = RISE_COLOR;
        _upLb.font = [UIFont systemFontOfSize:12 * kScale];
        _upLb.text = @"";
        _upLb.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_upLb];
        [_upLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.equalTo(self).offset(120 * kScale);
        }];
        
        _planLb = [[UILabel alloc] init];
        _planLb.backgroundColor = [UIColor clearColor];
        _planLb.textColor = PLAN_COLOR;
        _planLb.font = [UIFont systemFontOfSize:12 * kScale];
        _planLb.text = @"";
        _planLb.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_planLb];
        [_planLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.equalTo(_upLb.mas_right).offset(12 * kScale);
        }];
        
        _downeLb = [[UILabel alloc] init];
        _downeLb.backgroundColor = [UIColor clearColor];
        _downeLb.textColor = FALL_COLOR;
        _downeLb.font = [UIFont systemFontOfSize:12 * kScale];
        _downeLb.text = @"";
        _downeLb.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_downeLb];
        [_downeLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.equalTo(_planLb.mas_right).offset(12 * kScale);
        }];
       
        
        self.contentView.backgroundColor = TITLE_BAR_BG_COLOR;
    }
    return self;
}



- (void)setUp:(NSString *)up down:(NSString *)down plan:(NSString *)plan;
{
    //多种颜色
//    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"Using NSAttributed String"];
//    [str addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(0,5)];
//    [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(6,12)];

    _upLb.text = [NSString stringWithFormat:@"上涨%@家",up];
    _downeLb.text = [NSString stringWithFormat:@"下跌%@家",down];
    _planLb.text = [NSString stringWithFormat:@"平盘%@家",plan];
    
}

@end
