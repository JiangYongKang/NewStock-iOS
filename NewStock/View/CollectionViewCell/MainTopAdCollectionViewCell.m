//
//  MainTopAdCollectionViewCell.m
//  NewStock
//
//  Created by 王迪 on 2017/3/17.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "MainTopAdCollectionViewCell.h"
#import <UIImageView+WebCache.h>
#import "Defination.h"
#import <Masonry.h>

@interface MainTopAdCollectionViewCell ()

@property (nonatomic, strong) UIImageView *img ;

@end

@implementation MainTopAdCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setImgUrl:(NSString *)imgUrl {
    _imgUrl = imgUrl;
    
    [self.img sd_setImageWithURL:[NSURL URLWithString:self.imgUrl]];
}

- (void)setupUI {
    [self.contentView addSubview:self.img];
    [self.img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
}

- (UIImageView *)img {
    if (_img == nil) {
        _img = [[UIImageView alloc] init];
    }
    return _img;
}

@end
