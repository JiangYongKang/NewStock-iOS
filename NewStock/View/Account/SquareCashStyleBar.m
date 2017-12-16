//
//  SquareCashStyleBar.m
//  BLKFlexibleHeightBar Demo
//
//  Created by Bryan Keller on 2/19/15.
//  Copyright (c) 2015 Bryan Keller. All rights reserved.
//

#import "SquareCashStyleBar.h"
#import "UIImageView+WebCache.h"
#import "SystemUtil.h"
#import "Masonry.h"
#import "Defination.h"
#import "UserInfoModel.h"
#import "UserInfoInstance.h"

@implementation SquareCashStyleBar

- (instancetype)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame]) {
        [self configureBar];
    }
    return self;
}

- (void)configureBar {
    self.maximumBarHeight = 180 * kScale;
    self.minimumBarHeight = 64.0;
    self.backgroundColor = [UIColor clearColor];

     _nameLabel = [[UILabel alloc] init];
     _nameLabel.font = [UIFont systemFontOfSize:18 * kScale];
     _nameLabel.textColor = [UIColor whiteColor];
     _nameLabel.textAlignment = NSTextAlignmentCenter;
     _nameLabel.text = @"游客";
    
    BLKFlexibleHeightBarSubviewLayoutAttributes *initialNameLabelLayoutAttributes = [[BLKFlexibleHeightBarSubviewLayoutAttributes alloc] init];
    initialNameLabelLayoutAttributes.size = CGSizeMake(180 * kScale, 30 * kScale);    initialNameLabelLayoutAttributes.center = CGPointMake(self.frame.size.width * 0.5, self.maximumBarHeight - 46 * kScale);
    [_nameLabel addLayoutAttributes:initialNameLabelLayoutAttributes forProgress:0.0];
    
    BLKFlexibleHeightBarSubviewLayoutAttributes *midwayNameLabelLayoutAttributes = [[BLKFlexibleHeightBarSubviewLayoutAttributes alloc] initWithExistingLayoutAttributes:initialNameLabelLayoutAttributes];
    midwayNameLabelLayoutAttributes.center = CGPointMake(self.frame.size.width * 0.5, self.maximumBarHeight - 30 * kScale);//-50.0
    [_nameLabel addLayoutAttributes:midwayNameLabelLayoutAttributes forProgress:0.6];
    
    BLKFlexibleHeightBarSubviewLayoutAttributes *finalNameLabelLayoutAttributes = [[BLKFlexibleHeightBarSubviewLayoutAttributes alloc] initWithExistingLayoutAttributes:midwayNameLabelLayoutAttributes];
    finalNameLabelLayoutAttributes.center = CGPointMake(self.frame.size.width * 0.5, self.maximumBarHeight - 16 * kScale);//-25.0
    [_nameLabel addLayoutAttributes:finalNameLabelLayoutAttributes forProgress:1.0];
    
    [self addSubview:_nameLabel];
    
    //
    _gradeLabel = [[UILabel alloc] init];
    _gradeLabel.font = [UIFont systemFontOfSize:12.0 * kScale];
    _gradeLabel.textColor = [UIColor whiteColor];
    _gradeLabel.textAlignment = NSTextAlignmentCenter;
//    _gradeLabel.text = @"积分:0";
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    _gradeLabel.userInteractionEnabled = YES;
    [_gradeLabel addGestureRecognizer:tap];
    
    BLKFlexibleHeightBarSubviewLayoutAttributes *initialGradeLabelLayoutAttributes = [[BLKFlexibleHeightBarSubviewLayoutAttributes alloc] init];
    initialGradeLabelLayoutAttributes.size = CGSizeMake(100 * kScale, 34 * kScale);//[_gradeLabel sizeThatFits:CGSizeZero];
    initialGradeLabelLayoutAttributes.center = CGPointMake(self.frame.size.width * 0.5, self.maximumBarHeight - 21 * kScale);
    [_gradeLabel addLayoutAttributes:initialGradeLabelLayoutAttributes forProgress:0.0];
    
    BLKFlexibleHeightBarSubviewLayoutAttributes *midwayGradeLabelLayoutAttributes = [[BLKFlexibleHeightBarSubviewLayoutAttributes alloc] initWithExistingLayoutAttributes:initialGradeLabelLayoutAttributes];
    midwayGradeLabelLayoutAttributes.center = CGPointMake(self.frame.size.width * 0.5, (self.maximumBarHeight - self.minimumBarHeight) * 0.4 + self.minimumBarHeight - 25.0 * kScale);
    [_gradeLabel addLayoutAttributes:midwayGradeLabelLayoutAttributes forProgress:0.6];
    
    BLKFlexibleHeightBarSubviewLayoutAttributes *finalGradeLabelLayoutAttributes = [[BLKFlexibleHeightBarSubviewLayoutAttributes alloc] initWithExistingLayoutAttributes:midwayGradeLabelLayoutAttributes];
    finalGradeLabelLayoutAttributes.center = CGPointMake(self.frame.size.width * 0.5, self.minimumBarHeight - 10.0 * kScale);
    finalGradeLabelLayoutAttributes.transform = CGAffineTransformMakeScale(0.5, 0.5);
    finalGradeLabelLayoutAttributes.alpha = 0.0;
    [_gradeLabel addLayoutAttributes:finalGradeLabelLayoutAttributes forProgress:1.0];
    
    
    [self addSubview:_gradeLabel];
    
    _profileImageView = [[UIImageView alloc] init];
    _profileImageView.contentMode = UIViewContentModeScaleAspectFill;
    _profileImageView.clipsToBounds = YES;
    _profileImageView.layer.cornerRadius = 30 * kScale;
    _profileImageView.layer.borderWidth = 0.1;
    _profileImageView.layer.borderColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.5].CGColor;
    
    BLKFlexibleHeightBarSubviewLayoutAttributes *initialProfileImageViewLayoutAttributes = [[BLKFlexibleHeightBarSubviewLayoutAttributes alloc] init];
    initialProfileImageViewLayoutAttributes.size = CGSizeMake(60 * kScale, 60 * kScale);
    initialProfileImageViewLayoutAttributes.center = CGPointMake(self.frame.size.width* 0.5, self.maximumBarHeight - 96 * kScale);
    [_profileImageView addLayoutAttributes:initialProfileImageViewLayoutAttributes forProgress:0.0];
    
    BLKFlexibleHeightBarSubviewLayoutAttributes *midwayProfileImageViewLayoutAttributes = [[BLKFlexibleHeightBarSubviewLayoutAttributes alloc] initWithExistingLayoutAttributes:initialProfileImageViewLayoutAttributes];
    midwayProfileImageViewLayoutAttributes.center = CGPointMake(self.frame.size.width*0.5, (self.maximumBarHeight - self.minimumBarHeight) * 0.8 + self.minimumBarHeight - 96 * kScale);
    [_profileImageView addLayoutAttributes:midwayProfileImageViewLayoutAttributes forProgress:0.2];
    
    BLKFlexibleHeightBarSubviewLayoutAttributes *finalProfileImageViewLayoutAttributes = [[BLKFlexibleHeightBarSubviewLayoutAttributes alloc] initWithExistingLayoutAttributes:midwayProfileImageViewLayoutAttributes];
    finalProfileImageViewLayoutAttributes.center = CGPointMake(self.frame.size.width*0.5, (self.maximumBarHeight - self.minimumBarHeight) * 0.64 + self.minimumBarHeight - 96 * kScale);
    finalProfileImageViewLayoutAttributes.transform = CGAffineTransformMakeScale(0.5, 0.5);
    finalProfileImageViewLayoutAttributes.alpha = 0.0;
    [_profileImageView addLayoutAttributes:finalProfileImageViewLayoutAttributes forProgress:0.5];
    
    [self addSubview:_profileImageView];
    
    UIView *bgView = [[UIView alloc] init];
    bgView.clipsToBounds = YES;
    bgView.layer.cornerRadius = 65 * kScale / 2;
    bgView.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.8];
    
    BLKFlexibleHeightBarSubviewLayoutAttributes *initialBgViewLayoutAttributes = [[BLKFlexibleHeightBarSubviewLayoutAttributes alloc] init];
    initialBgViewLayoutAttributes.size = CGSizeMake(65 * kScale, 65 * kScale);
    initialBgViewLayoutAttributes.center = CGPointMake(self.frame.size.width * 0.5, self.maximumBarHeight - 96 * kScale);
    [bgView addLayoutAttributes:initialBgViewLayoutAttributes forProgress:0.0];
    
    BLKFlexibleHeightBarSubviewLayoutAttributes *midwayBgViewLayoutAttributes = [[BLKFlexibleHeightBarSubviewLayoutAttributes alloc] initWithExistingLayoutAttributes:initialBgViewLayoutAttributes];
    midwayBgViewLayoutAttributes.center = CGPointMake(self.frame.size.width * 0.5, (self.maximumBarHeight - self.minimumBarHeight) * 0.8 + self.minimumBarHeight - 96 * kScale);
    [bgView addLayoutAttributes:midwayBgViewLayoutAttributes forProgress:0.2];
    
    BLKFlexibleHeightBarSubviewLayoutAttributes *finalBgViewLayoutAttributes = [[BLKFlexibleHeightBarSubviewLayoutAttributes alloc] initWithExistingLayoutAttributes:midwayBgViewLayoutAttributes];
    finalBgViewLayoutAttributes.center = CGPointMake(self.frame.size.width * 0.5, (self.maximumBarHeight - self.minimumBarHeight) * 0.64 + self.minimumBarHeight - 96 * kScale);
    finalBgViewLayoutAttributes.transform = CGAffineTransformMakeScale(0.5, 0.5);
    finalBgViewLayoutAttributes.alpha = 0.0;
    [bgView addLayoutAttributes:finalBgViewLayoutAttributes forProgress:0.5];
    
    [self addSubview:bgView];
    
    // bigV
    
    _bigV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bigV_account"]];
    [self addSubview:_bigV];
    [_bigV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.equalTo(_profileImageView).offset(0);
    }];
    
    [self bringSubviewToFront:_profileImageView];
    [self bringSubviewToFront:_bigV];
}

- (void)setUserName:(NSString *)name gradeName:(NSString*)grade headImgUrl:(NSString *)imgUrl score:(NSString *)sc isBigV:(BOOL)isBigV {
    
    _bigV.hidden = !isBigV;

    _nameLabel.text = name;

    _gradeLabel.text = [NSString stringWithFormat:@"积分:%zd",sc.integerValue];
    if ([[UserInfoInstance sharedUserInfoInstance].lastIcon isEqualToString:imgUrl]) {
        return;
    }
    
    NSString *defaultUrl = @"default1.png";
    __weak typeof(self) weakSelf = self;
    if (imgUrl.length) {
        [_profileImageView sd_setImageWithURL:[NSURL URLWithString:imgUrl]
                             placeholderImage:[UIImage imageNamed:@"header_placeholder"]options:0 completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                 if (self.sendImgBlock) {
                                     if (![imgUrl containsString:defaultUrl]) {
                                         weakSelf.sendImgBlock(image,NO);
                                     }else {
                                         weakSelf.sendImgBlock([UIImage imageNamed:@"account_bg1"],YES);
                                     }
                                 }
                             }];
    }else {
        _profileImageView.image = [UIImage imageNamed:@"header_placeholder"];
        if (self.sendImgBlock) {
            weakSelf.sendImgBlock([UIImage imageNamed:@"account_bg1"],YES);
        }
    }
    
}

- (void)headerClick:(UITapGestureRecognizer *)gestureRecognizer {
    if([self.delegate respondsToSelector:@selector(SquareCashStyleBar:)]) {
        [self.delegate SquareCashStyleBar:self];
    }
}

- (void)tap:(UITapGestureRecognizer *)tap {
    if ([self.delegate respondsToSelector:@selector(SquareCashStyleBarScoreLableClicked:)]) {
        [self.delegate SquareCashStyleBarScoreLableClicked:self];
    }
}

@end
