//
//  QingHuaiBottomView.m
//  NewStock
//
//  Created by 王迪 on 2017/1/13.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "QingHuaiBottomView.h"
#import "Defination.h"
#import "UIView+Masonry_Arrange.h"
#import <Masonry.h>

@interface QingHuaiBottomView ()

@property (nonatomic, strong) UIImageView *imgView1;
@property (nonatomic, strong) UIImageView *imgView2;
@property (nonatomic, strong) UIImageView *imgView3;
@property (nonatomic, strong) UIImageView *imgView4;
@property (nonatomic, strong) UIImageView *imgView5;
@property (nonatomic, strong) UIImageView *imgView6;
@property (nonatomic, strong) UIImageView *imgView7;
@property (nonatomic, strong) UIImageView *imgView8;

@property (nonatomic, strong) UIView *border1;
@property (nonatomic, strong) UIView *border2;
@property (nonatomic, strong) UIView *border3;
@property (nonatomic, strong) UIView *border4;
@property (nonatomic, strong) UIView *border5;
@property (nonatomic, strong) UIView *border6;
@property (nonatomic, strong) UIView *border7;
@property (nonatomic, strong) UIView *border8;

@property (nonatomic, strong) NSArray *colorArray;
@property (nonatomic, strong) NSArray *borderArray;


@end

@implementation QingHuaiBottomView

- (void)setPage:(NSInteger)page {

    UIView *border_old = self.borderArray[_page % 8];
    [border_old mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(42 * kScale);
    }];
    
    UIView *border_new = self.borderArray[page % 8];
    [border_new mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(2 * kScale);
    }];
    
    _page = page;
    
    if (self.colorBlock) {
        self.colorBlock(self.colorArray[page % 8]);
    }
    
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:5 initialSpringVelocity:15 options:UIViewAnimationOptionCurveEaseOut animations:^{
        [self layoutIfNeeded];
    } completion:nil];
    
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        [self setupUI];
        
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
        longPress.minimumPressDuration = 0.01;
        [self addGestureRecognizer:longPress];
    }
    return self;
}

- (void)setupUI {
    [self addSubview:self.border1];
    [self addSubview:self.border2];
    [self addSubview:self.border3];
    [self addSubview:self.border4];
    [self addSubview:self.border5];
    [self addSubview:self.border6];
    [self addSubview:self.border7];
    [self addSubview:self.border8];
    
    [self.border1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(49 * kScale));
        make.width.equalTo(@(44 * kScale));
        make.top.equalTo(self).offset(42 * kScale);
    }];
    
    [self.border2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(49 * kScale));
        make.width.equalTo(@(44 * kScale));
        make.top.equalTo(self).offset(42 * kScale);
    }];
    
    [self.border3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(49 * kScale));
        make.width.equalTo(@(44 * kScale));
        make.top.equalTo(self).offset((42 * kScale));
    }];
    
    [self.border4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(49 * kScale));
        make.width.equalTo(@(44 * kScale));
        make.top.equalTo(self).offset(42 * kScale);
    }];
    
    [self.border5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(49 * kScale));
        make.width.equalTo(@(44 * kScale));
        make.top.equalTo(self).offset(42 * kScale);
    }];
    
    [self.border6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(49 * kScale));
        make.width.equalTo(@(44 * kScale));
        make.top.equalTo(self).offset(42 * kScale);
    }];
    
    [self.border7 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(49 * kScale));
        make.width.equalTo(@(44 * kScale));
        make.top.equalTo(self).offset(42 * kScale);
    }];
    
    [self.border8 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(49 * kScale));
        make.width.equalTo(@(44 * kScale));
        make.top.equalTo(self).offset(42 * kScale);
    }];
    
    [self distributeSpacingHorizontallyWith:@[self.border1,self.border2,self.border3,self.border4,self.border5,self.border6,self.border7,self.border8]];
    
    [self layoutIfNeeded];
    
    self.border1 = [self getCornerView:self.border1];
    self.imgView1 = [self getCornerImgView:self.imgView1];
    
    self.border2 = [self getCornerView:self.border2];
    self.imgView2 = [self getCornerImgView:self.imgView2];
    
    self.border3 = [self getCornerView:self.border3];
    self.imgView3 = [self getCornerImgView:self.imgView3];
    
    self.border4 = [self getCornerView:self.border4];
    self.imgView4 = [self getCornerImgView:self.imgView4];
    
    self.border5 = [self getCornerView:self.border5];
    self.imgView5 = [self getCornerImgView:self.imgView5];
    
    self.border6 = [self getCornerView:self.border6];
    self.imgView6 = [self getCornerImgView:self.imgView6];
    
    self.border7 = [self getCornerView:self.border7];
    self.imgView7 = [self getCornerImgView:self.imgView7];
    
    self.border8 = [self getCornerView:self.border8];
    self.imgView8 = [self getCornerImgView:self.imgView8];

}

- (void)longPress:(UILongPressGestureRecognizer *)longPress {
    
    CGPoint p = [longPress locationInView:self];
    CGFloat num = p.x / (375 * kScale / 8);
    
    [self numChangeAnimation:(NSInteger)num];
    
    if (longPress.state == 3) {
        for (UIView *border in self.borderArray) {
            [border mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self).offset(42 * kScale);
            }];

            [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:5 initialSpringVelocity:15 options:UIViewAnimationOptionCurveEaseOut animations:^{
                [self layoutIfNeeded];
            } completion:^(BOOL finished) {
                if (self.pageBlock) {
                    self.pageBlock(num);
                }
            }];
        }
    }
    
}

- (void)numChangeAnimation:(NSInteger)num {
    
    if (num - 1 >= 0 && num - 1 < 8) {
        UIView *border_left1 = self.borderArray[num - 1];
        [border_left1 mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset((42 - 8 * 4) * kScale);
        }];
    }
    
    if (num - 2 >= 0 && num - 2 < 8) {
        UIView *border_left2 = self.borderArray[num - 2];
        [border_left2 mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset((42 - 8 * 3) * kScale);
        }];
    }
    
    if (num - 3 >= 0 && num - 3 < 8) {
        UIView *border_left3 = self.borderArray[num - 3];
        [border_left3 mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset((42 - 8 * 2) * kScale);
        }];
    }
    
    if (num - 4 >= 0 && num - 4 < 8) {
        UIView *border_left4 = self.borderArray[num - 4];
        [border_left4 mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset((42 - 8 * 1) * kScale);
        }];
    }
    
    if (num - 5 >= 0 && num - 5 < 8) {
        UIView *border_left5 = self.borderArray[num - 5];
        [border_left5 mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset((42 - 8 * 0) * kScale);
        }];
    }
    
    if (num + 1 >= 0 && num + 1 < 8) {
        UIView *border_right1 = self.borderArray[num + 1];
        [border_right1 mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset((42 - 8 * 4) * kScale);
        }];
    }
    
    if (num + 2 >= 0 && num + 2 < 8) {
        UIView *border_right2 = self.borderArray[num + 2];
        [border_right2 mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset((42 - 8 * 3) * kScale);
        }];
    }
    
    if (num + 3 >= 0 && num + 3 < 8) {
        UIView *border_right3 = self.borderArray[num + 3];
        [border_right3 mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset((42 - 8 * 2) * kScale);
        }];
    }
    
    if (num + 4 >= 0 && num + 4 < 8) {
        UIView *border_right4 = self.borderArray[num + 4];
        [border_right4 mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset((42 - 8 * 1) * kScale);
        }];
    }
    
    if (num + 5 >= 0 && num + 5 < 8) {
        UIView *border_right5 = self.borderArray[num + 5];
        [border_right5 mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset((42 - 8 * 0) * kScale);
        }];
    }

//    self.page = num;
    
    UIView *border_old = self.borderArray[_page % 8];
    [border_old mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(42 * kScale);
    }];
    
    UIView *border_new = self.borderArray[num];
    [border_new mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(2 * kScale);
    }];
    
    _page = num;

    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:5 initialSpringVelocity:2 options:UIViewAnimationOptionCurveEaseOut animations:^{
        [self layoutIfNeeded];
    } completion:nil];

}


#pragma mark --------------lazy loading----------------

- (UIImageView *)imgView1 {
    if (_imgView1 == nil) {
        _imgView1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"word_wo"]];
        _imgView1.contentMode = UIViewContentModeScaleAspectFit;
        _imgView1.backgroundColor = self.colorArray[0];
    }
    return _imgView1;
}

- (UIImageView *)imgView2 {
    if (_imgView2 == nil) {
        _imgView2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"word_men"]];
        _imgView2.contentMode = UIViewContentModeScaleAspectFit;
        _imgView2.backgroundColor = self.colorArray[1];
    }
    return _imgView2;
}

- (UIImageView *)imgView3 {
    if (_imgView3 == nil) {
        _imgView3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"word_dou"]];
        _imgView3.contentMode = UIViewContentModeScaleAspectFit;
        _imgView3.backgroundColor = self.colorArray[2];
    }
    return _imgView3;
}

- (UIImageView *)imgView4 {
    if (_imgView4 == nil) {
        _imgView4 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"word_shi"]];
        _imgView4.contentMode = UIViewContentModeScaleAspectFit;
        _imgView4.backgroundColor = self.colorArray[3];
    }
    return _imgView4;
}

- (UIImageView *)imgView5 {
    if (_imgView5 == nil) {
        _imgView5 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"word_gu"]];
        _imgView5.contentMode = UIViewContentModeScaleAspectFit;
        _imgView5.backgroundColor = self.colorArray[4];
    }
    return _imgView5;
}

- (UIImageView *)imgView6 {
    if (_imgView6 == nil) {
        _imgView6 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"word_guai"]];
        _imgView6.contentMode = UIViewContentModeScaleAspectFit;
        _imgView6.backgroundColor = self.colorArray[5];
    }
    return _imgView6;
}

- (UIImageView *)imgView7 {
    if (_imgView7 == nil) {
        _imgView7 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"word_xia"]];
        _imgView7.contentMode = UIViewContentModeScaleAspectFit;
        _imgView7.backgroundColor = self.colorArray[6];
    }
    return _imgView7;
}

- (UIImageView *)imgView8 {
    if (_imgView8 == nil) {
        _imgView8 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"qingHuai_Logo"]];
        _imgView8.contentMode = UIViewContentModeScaleAspectFit;
        _imgView8.backgroundColor = self.colorArray[7];
    }
    return _imgView8;
}

- (NSArray *)colorArray {
    if (_colorArray == nil) {
        _colorArray = @[kUIColorFromRGB(0xe16464),kUIColorFromRGB(0xf09f37),kUIColorFromRGB(0xf0b637),kUIColorFromRGB(0x378bd4),kUIColorFromRGB(0x31a6b7),kUIColorFromRGB(0x47566d),kUIColorFromRGB(0xa38bba),kUIColorFromRGB(0x3580c0)];
    }
    return _colorArray;
}

- (UIView *)border1 {
    if (_border1 == nil) {
        _border1 = [[UIView alloc] init];
        _border1.backgroundColor = [UIColor whiteColor];
        [_border1 addSubview:self.imgView1];
        [_imgView1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(_border1).offset(2 * kScale);
            make.right.equalTo(_border1).offset(-2 * kScale);
            make.height.equalTo(@(40 * kScale));
        }];
    }
    return _border1;
}

- (UIView *)border2 {
    if (_border2 == nil) {
        _border2 = [[UIView alloc] init];
        _border2.backgroundColor = [UIColor whiteColor];
        [_border2 addSubview:self.imgView2];
        [_imgView2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(_border2).offset(2 * kScale);
            make.right.equalTo(_border2).offset(-2 * kScale);
            make.height.equalTo(@(40 * kScale));
        }];
    }
    return _border2;
}

- (UIView *)border3 {
    if (_border3 == nil) {
        _border3 = [[UIView alloc] init];
        _border3.backgroundColor = [UIColor whiteColor];
        [_border3 addSubview:self.imgView3];
        [_imgView3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(_border3).offset(2 * kScale);
            make.right.equalTo(_border3).offset(-2 * kScale);
            make.height.equalTo(@(40 * kScale));
        }];
    }
    return _border3;
}

- (UIView *)border4 {
    if (_border4 == nil) {
        _border4 = [[UIView alloc] init];
        _border4.backgroundColor = [UIColor whiteColor];
        [_border4 addSubview:self.imgView4];
        [_imgView4 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(_border4).offset(2 * kScale);
            make.right.equalTo(_border4).offset(-2 * kScale);
            make.height.equalTo(@(40 * kScale));
        }];
    }
    return _border4;
}

- (UIView *)border5 {
    if (_border5 == nil) {
        _border5 = [[UIView alloc] init];
        _border5.backgroundColor = [UIColor whiteColor];
        [_border5 addSubview:self.imgView5];
        [_imgView5 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(_border5).offset(2 * kScale);
            make.right.equalTo(_border5).offset(-2 * kScale);
            make.height.equalTo(@(40 * kScale));
        }];
    }
    return _border5;
}

- (UIView *)border6 {
    if (_border6 == nil) {
        _border6 = [[UIView alloc] init];
        _border6.backgroundColor = [UIColor whiteColor];
        [_border6 addSubview:self.imgView6];
        [_imgView6 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(_border6).offset(2 * kScale);
            make.right.equalTo(_border6).offset(-2 * kScale);
            make.height.equalTo(@(40 * kScale));
        }];
    }
    return _border6;
}

- (UIView *)border7 {
    if (_border7 == nil) {
        _border7 = [[UIView alloc] init];
        _border7.backgroundColor = [UIColor whiteColor];
        [_border7 addSubview:self.imgView7];
        [_imgView7 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(_border7).offset(2 * kScale);
            make.right.equalTo(_border7).offset(-2 * kScale);
            make.height.equalTo(@(40 * kScale));
        }];
    }
    return _border7;
}

- (UIView *)border8 {
    if (_border8 == nil) {
        _border8 = [[UIView alloc] init];
        _border8.backgroundColor = [UIColor whiteColor];
        [_border8 addSubview:self.imgView8];
        [_imgView8 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(_border8).offset(2 * kScale);
            make.right.equalTo(_border8).offset(-2 * kScale);
            make.height.equalTo(@(40 * kScale));
        }];
    }
    return _border8;
}

- (UIView *)getCornerView:(UIView *)view {
    
    UIBezierPath * maskPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 44 * kScale, 49 * kScale)
                                                    byRoundingCorners:(UIRectCornerTopLeft | UIRectCornerTopRight)
                                                          cornerRadii:CGSizeMake(11 * kScale, 11 * kScale)];
    CAShapeLayer * maskLayer = [CAShapeLayer layer];
    maskLayer.frame  = view.bounds;
    maskLayer.path   = maskPath.CGPath;
    view.layer.mask  = maskLayer;
    view.layer.masksToBounds = YES;
    return view;
}

- (UIImageView *)getCornerImgView:(UIImageView *)view {
    
    UIBezierPath * maskPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 40 * kScale, 40 * kScale)
                                                    byRoundingCorners:( UIRectCornerAllCorners)
                                                          cornerRadii:CGSizeMake(11 * kScale, 11 * kScale)];
    CAShapeLayer * maskLayer = [CAShapeLayer layer];
    maskLayer.frame  = CGRectMake(0, 0, 40 * kScale, 40 * kScale);
    maskLayer.path   = maskPath.CGPath;
    view.layer.mask  = maskLayer;
    view.layer.masksToBounds = YES;
    return view;
}

- (NSArray *)borderArray {
    if (_borderArray == nil) {
        _borderArray = @[self.border1,self.border2,self.border3,self.border4,self.border5,self.border6,self.border7,self.border8];
    }
    return _borderArray;
}



@end
