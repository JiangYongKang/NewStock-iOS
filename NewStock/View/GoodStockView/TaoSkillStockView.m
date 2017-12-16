//
//  TaoSkillStockView.m
//  NewStock
//
//  Created by 王迪 on 2017/6/19.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "TaoSkillStockView.h"
#import "TaoSkillStockCollectionViewCell.h"
#import "MarketConfig.h"
#import "Defination.h"
#import <Masonry.h>
#import "TaoIndexModel.h"

static NSString *cellID = @"TaoSkillStockViewCell";

@interface TaoSkillStockView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UILabel *topLabel;
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UILabel *topBlcokLabel;

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@property (nonatomic, strong) UILabel *line1;
@property (nonatomic, strong) UILabel *line2;
@property (nonatomic, strong) UILabel *line3;
@property (nonatomic, strong) UILabel *line4;
@property (nonatomic, strong) UILabel *line5;

@end

@implementation TaoSkillStockView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
        self.backgroundColor = kUIColorFromRGB(0xffffff);
    }
    return self;
}

- (void)setupUI {
    [self addSubview:self.topView];
    [self addSubview:self.collectionView];
    
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self);
        make.height.equalTo(@(30 * kScale));
    }];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.left.equalTo(self);
        make.top.equalTo(self.topView.mas_bottom);
    }];
    
    [self.collectionView addSubview:self.line1];
    [self.collectionView addSubview:self.line2];
    [self.collectionView addSubview:self.line3];
    [self.collectionView addSubview:self.line4];
    [self.collectionView addSubview:self.line5];
    
    [self.line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.collectionView).offset(64 * kScale);
        make.left.equalTo(self).offset(12 * kScale);
        make.right.equalTo(self).offset(-12 * kScale);
        make.height.equalTo(@(0.5));
    }];
    
    [self.line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.collectionView).offset(10 * kScale);
        make.height.equalTo(@(44 * kScale));
        make.left.equalTo(self).offset(MAIN_SCREEN_WIDTH / 3);
        make.width.equalTo(@(0.5));
    }];
    
    [self.line3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.width.height.equalTo(self.line2);
        make.right.equalTo(self).offset(-MAIN_SCREEN_WIDTH / 3);
    }];
    
    [self.line4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.height.equalTo(self.line2);
        make.bottom.equalTo(self).offset(-10 * kScale);
    }];
    
    [self.line5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.right.equalTo(self.line3);
        make.bottom.equalTo(self.line4);
    }];
    
    self.collectionView.clipsToBounds = YES;
    
}

#pragma mark action

- (void)setDataArray:(NSArray *)dataArray {
    _dataArray = dataArray;
    [self.collectionView reloadData];
}

- (void)setTitle:(NSString *)title {
    _title = title;
    
    self.topLabel.text = title;
}

#pragma mark dataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    TaoSkillStockCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    
    TaoIndexModelListClild *model = self.dataArray[indexPath.item];
    
    [cell setName:model.n count:model.count stockN:model.stock.n zdf:model.stock.zdf];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    TaoIndexModelListClild *model = self.dataArray[indexPath.item];
    
    if ([self.delegate respondsToSelector:@selector(taoSkillStockViewDelegatePushTo:title:)]) {
        [self.delegate taoSkillStockViewDelegatePushTo:model.ids title:model.n];
    }
}

#pragma mark lazy loading

- (UICollectionView *)collectionView {
    if (_collectionView == nil) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.flowLayout];
        _collectionView.backgroundColor = kUIColorFromRGB(0xffffff);
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.scrollEnabled = NO;
        [_collectionView registerClass:[TaoSkillStockCollectionViewCell class] forCellWithReuseIdentifier:cellID];
    }
    return _collectionView;
}

- (UICollectionViewFlowLayout *)flowLayout {
    if (_flowLayout == nil) {
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _flowLayout.itemSize = CGSizeMake(MAIN_SCREEN_WIDTH / 3.0, 62 * kScale);
        _flowLayout.minimumLineSpacing = 0;
        _flowLayout.minimumInteritemSpacing = 0;
    }
    return _flowLayout;
}

- (UIView *)topView {
    if (_topView == nil) {
        _topView = [UIView new];
        _topView.backgroundColor = [UIColor whiteColor];
        
        [_topView addSubview:self.topBlcokLabel];
        [_topView addSubview:self.topLabel];
        
        [_topBlcokLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_topView).offset(12 * kScale);
            make.centerY.equalTo(_topView);
            make.width.equalTo(@(2 * kScale));
            make.height.equalTo(@(12 * kScale));
        }];
        
        [_topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_topView);
            make.left.equalTo(_topBlcokLabel.mas_right).offset(6 * kScale);
        }];
        
        UILabel *line = [UILabel new];
        line.backgroundColor = kUIColorFromRGB(0xe4e4e4);
        
        [_topView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(_topView);
            make.height.equalTo(@(0.5 * kScale));
        }];
        
    }
    return _topView;
}

- (UILabel *)topLabel {
    if (_topLabel == nil) {
        _topLabel = [UILabel new];
        _topLabel.textColor = kUIColorFromRGB(0x333333);
        _topLabel.font = [UIFont systemFontOfSize:14 * kScale];
    }
    return _topLabel;
}

- (UILabel *)topBlcokLabel {
    if (_topBlcokLabel == nil) {
        _topBlcokLabel = [UILabel new];
        _topBlcokLabel.backgroundColor = RISE_COLOR;
    }
    return _topBlcokLabel;
}

- (UILabel *)line1 {
    if (_line1 == nil) {
        _line1 = [UILabel new];
        _line1.backgroundColor = kUIColorFromRGB(0xf1f1f1);
    }
    return _line1;
}

- (UILabel *)line2 {
    if (_line2 == nil) {
        _line2 = [UILabel new];
        _line2.backgroundColor = kUIColorFromRGB(0xf1f1f1);
    }
    return _line2;
}

- (UILabel *)line3 {
    if (_line3 == nil) {
        _line3 = [UILabel new];
        _line3.backgroundColor = kUIColorFromRGB(0xf1f1f1);
    }
    return _line3;
}

- (UILabel *)line4 {
    if (_line4 == nil) {
        _line4 = [UILabel new];
        _line4.backgroundColor = kUIColorFromRGB(0xf1f1f1);
    }
    return _line4;
}

- (UILabel *)line5 {
    if (_line5 == nil) {
        _line5 = [UILabel new];
        _line5.backgroundColor = kUIColorFromRGB(0xf1f1f1);
    }
    return _line5;
}

@end
