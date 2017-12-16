//
//  StockBaseInfoCell.m
//  NewStock
//
//  Created by Willey on 16/8/13.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "StockBaseInfoCell.h"
#import "Defination.h"
#import "MarketConfig.h"
#import "Masonry.h"

@implementation StockBaseInfoCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        /**
         *  1     3
         *  2     4
         */
        _nameLb1 = [self createNameLabel];
        _nameLb2 = [self createNameLabel];
        _nameLb3 = [self createNameLabel];
        _nameLb4 = [self createNameLabel];
 
        
        _valueLb1 = [self createValueLabel];
        _valueLb2 = [self createValueLabel];
        _valueLb3 = [self createValueLabel];
        _valueLb4 = [self createValueLabel];
        
        
        _sepLine = [[UIView alloc] init];
        _sepLine.backgroundColor = kUIColorFromRGB(0xf1f1f1);
        [self.contentView addSubview:_sepLine];
        
        //self.contentView.backgroundColor = TITLE_BAR_BG_COLOR;
    }
    return self;
}

- (UILabel *)createNameLabel {
    UILabel *lb = [[UILabel alloc] init];
    lb.backgroundColor = [UIColor clearColor];
    lb.textColor = [UIColor darkGrayColor];
    lb.font = [UIFont systemFontOfSize:12.0f];
    lb.text = @"";
    lb.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:lb];
    return lb;
}

- (UILabel *)createValueLabel {
    UILabel *lb = [[UILabel alloc] init];
    lb.backgroundColor = [UIColor clearColor];
    lb.textColor = [UIColor darkGrayColor];
    lb.font = [UIFont systemFontOfSize:12.0f];
    lb.text = @"--";
    lb.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:lb];
    return lb;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    int padding = 5;
    [_nameLb1 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(10);
        make.left.equalTo(self).offset(0);
        make.width.mas_equalTo(self).multipliedBy(0.25);
        make.height.mas_equalTo(self).multipliedBy(0.33);
    }];
    [_nameLb2 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(-10);
        make.left.equalTo(self).offset(0);
        make.width.mas_equalTo(self).multipliedBy(0.25);
        make.height.mas_equalTo(self).multipliedBy(0.33);
    }];
    
    [_valueLb1 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nameLb1);
        make.left.equalTo(_nameLb1.mas_right).offset(padding);
        make.width.mas_equalTo(self).multipliedBy(0.25);
        make.height.mas_equalTo(self).multipliedBy(0.33);
    }];
    [_valueLb2 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nameLb2);
        make.left.equalTo(_nameLb2.mas_right).offset(padding);
        make.width.mas_equalTo(self).multipliedBy(0.25);
        make.height.mas_equalTo(self).multipliedBy(0.33);
    }];
    
    
    
    //
    [_valueLb3 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(10);
        make.right.equalTo(self).offset(0);
        make.width.mas_equalTo(self).multipliedBy(0.25);
        make.height.mas_equalTo(self).multipliedBy(0.33);
    }];
    [_valueLb4 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(-10);
        make.right.equalTo(self).offset(0);
        make.width.mas_equalTo(self).multipliedBy(0.25);
        make.height.mas_equalTo(self).multipliedBy(0.33);
    }];
    
    [_nameLb3 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_valueLb3);
        make.right.equalTo(_valueLb3.mas_left).offset(-padding);
        make.width.mas_equalTo(self).multipliedBy(0.25);
        make.height.mas_equalTo(self).multipliedBy(0.33);
    }];
    [_nameLb4 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_valueLb4);
        make.right.equalTo(_valueLb4.mas_left).offset(-padding);
        make.width.mas_equalTo(self).multipliedBy(0.25);
        make.height.mas_equalTo(self).multipliedBy(0.33);
    }];
    
    
    [_sepLine mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
        make.right.equalTo(self).offset(-20);
        make.left.equalTo(self).offset(20);
        make.height.mas_equalTo(0.5);
    }];
}

- (void)setName1:(NSString *)name1 name2:(NSString *)name2 name3:(NSString *)name3 name4:(NSString *)name4 {
    _nameLb1.text = name1;
    _nameLb2.text = name2;
    _nameLb3.text = name3;
    _nameLb4.text = name4;

}
- (void)setValue1:(NSString *)value1 value2:(NSString *)value2 value3:(NSString *)value3 value4:(NSString *)value4 {
    _valueLb1.text = value1;
    _valueLb2.text = value2;
    _valueLb3.text = value3;
    _valueLb4.text = value4;

    
    //    UIColor *textColor;
    //    if ([value floatValue]-0.000001>0)
    //    {
    //        textColor = RISE_COLOR;
    //    }
    //    else
    //    {
    //        textColor = FALL_COLOR;
    //    }
    //    [_valueLb setTextColor:textColor];
}

- (void)setColor1:(UIColor *)color1 color2:(UIColor *)color2 color3:(UIColor *)color3 color4:(UIColor *)color4 {
    _valueLb1.textColor = color1;
    _valueLb2.textColor = color2;
    _valueLb3.textColor = color3;
    _valueLb4.textColor = color4;
}
- (void)setDic:(NSDictionary *)dic {
    NSString *name1;
    NSString *name2;
    NSString *name3;
    NSString *name4;
    
    NSString *value1;
    NSString *value2;
    NSString *value3;
    NSString *value4;

    UIColor *color1;
    UIColor *color2;
    UIColor *color3;
    UIColor *color4;
    
    NSArray *keyArray = [dic allKeys];
    for (int i=0; i<[keyArray count]; i++)
    {
        if (i==0)
        {
            name1 = [keyArray objectAtIndex:i];
            NSDictionary *dic1 = [dic objectForKey:name1];
            value1 = [dic1 objectForKey:@"value"];
            color1 = [dic1 objectForKey:@"color"];
        }
        else if (i==1)
        {
            name2 = [keyArray objectAtIndex:i];
            NSDictionary *dic2 = [dic objectForKey:name2];
            value2 = [dic2 objectForKey:@"value"];
            color2 = [dic2 objectForKey:@"color"];
        }
        else if (i==2)
        {
            name3 = [keyArray objectAtIndex:i];
            NSDictionary *dic3 = [dic objectForKey:name3];
            value3 = [dic3 objectForKey:@"value"];
            color3 = [dic3 objectForKey:@"color"];
        }
        else if (i==3)
        {
            name4 = [keyArray objectAtIndex:i];
            NSDictionary *dic4 = [dic objectForKey:name4];
            value4 = [dic4 objectForKey:@"value"];
            color4 = [dic4 objectForKey:@"color"];
        }
    }
    
    [self setName1:name1 name2:name2 name3:name3 name4:name4];
    [self setValue1:value1 value2:value2 value3:value3 value4:value4];
    [self setColor1:color1 color2:color2 color3:color3 color4:color4];
}

- (void)showSepLine:(BOOL)b {
    _sepLine.hidden = !b;
}

@end
