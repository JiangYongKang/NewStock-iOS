//
//  TipicView.m
//  NewStock
//
//  Created by Willey on 16/8/16.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "TipicView.h"
#import "Masonry.h"

@implementation TopicView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // Initialization code
        
        _titleLb = [[UILabel alloc] init];
        _titleLb.backgroundColor = [UIColor clearColor];
        _titleLb.textAlignment = NSTextAlignmentLeft;
        _titleLb.textColor = [UIColor blackColor];
        _titleLb.font = [UIFont boldSystemFontOfSize:13];
        _titleLb.text = @"";
        _titleLb.numberOfLines = 0;
        [self addSubview:_titleLb];
        [_titleLb mas_remakeConstraints:^(MASConstraintMaker *make) {
            //            make.top.equalTo(_titleLb.superview).offset(0);
            //            make.left.equalTo(_titleLb.superview).offset(0);
            //            make.right.equalTo(_titleLb.superview).offset(0);
            //            make.height.equalTo(_titleLb.superview).multipliedBy(0.4);
            make.edges.equalTo(_titleLb.superview).with.insets(UIEdgeInsetsMake(0,10,20,-10));
            
        }];
        
        _descLb = [[UILabel alloc] init];
        _descLb.backgroundColor = [UIColor clearColor];
        _descLb.textColor = [UIColor lightGrayColor];
        _descLb.font = [UIFont systemFontOfSize:12.0f];
        _descLb.numberOfLines = 0;
        _descLb.textAlignment = NSTextAlignmentRight;
        _descLb.text = @"";
        [self addSubview:_descLb];
        [_descLb mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_titleLb.mas_bottom).offset(0);
            make.right.equalTo(_descLb.superview).offset(-10);
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(20);
        }];
    }
    return self;
}

-(void)setTitle:(NSString *)title content:(NSString *)content
{
    _titleLb.text = [NSString stringWithFormat:@"#%@#",title];
    _descLb.text = [NSString stringWithFormat:@"%@人参与",content];
}


@end
