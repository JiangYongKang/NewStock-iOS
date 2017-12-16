//
//  TaoIndexSmartStockCollectionViewCell.m
//  NewStock
//
//  Created by 王迪 on 2017/6/19.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "TaoIndexSmartStockCollectionViewCell.h"
#import "Defination.h"
#import <Masonry.h>

@interface TaoIndexSmartStockCollectionViewCell (){
    NSString *_url;
}

@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UIImageView *bacImage;

@end

@implementation TaoIndexSmartStockCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.bacImage];
        [self.contentView addSubview:self.nameLabel];
        
        [self.bacImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.contentView);
            make.width.equalTo(self.contentView);
            make.height.equalTo(@(80 * kScale));
        }];
        
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.contentView);
        }];
        
    }
    return self;
}

- (void)setUrl:(NSString *)url name:(NSString *)name ico:(NSString *)ico {
    _url = url;
    self.nameLabel.text = name;
    [self.bacImage sd_setImageWithURL:[NSURL URLWithString:ico]];
}

- (UILabel *)nameLabel {
    if (_nameLabel == nil) {
        _nameLabel = [UILabel new];
        _nameLabel.textColor = kUIColorFromRGB(0xffffff);
        _nameLabel.font = [UIFont boldSystemFontOfSize:15 * kScale];
    }
    return _nameLabel;
}

- (UIImageView *)bacImage {
    if (_bacImage == nil) {
        _bacImage = [UIImageView new];
        _bacImage.layer.masksToBounds = YES;
        _bacImage.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _bacImage;
}

@end
