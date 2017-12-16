//
//  GoodStockIndexDataCenterView.m
//  NewStock
//
//  Created by 王迪 on 2017/6/19.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "GoodStockIndexDataCenterView.h"
#import "TaoIndexDataCenterCollectionViewCell.h"
#import "TaoIndexModel.h"

#import "MarketConfig.h"
#import "Defination.h"
#import <Masonry.h>

static NSString *cellID = @"GoodStockIndexDataCenterViewCell";

@interface GoodStockIndexDataCenterView () <UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UILabel *topLabel;
@property (nonatomic, strong) UILabel *topBlcokLabel;

@end

@implementation GoodStockIndexDataCenterView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
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
        make.bottom.left.right.equalTo(self);
        make.top.equalTo(self.topView.mas_bottom);
    }];
    
    
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

- (void)taoIndexDataCenterCollectionViewCellDelegatePushTo:(NSString *)url {
    if ([self.delegate respondsToSelector:@selector(goodStockIndexDataCenterViewDelegatePush:)]) {
        [self.delegate goodStockIndexDataCenterViewDelegatePush:url];
    }
}

#pragma mark datasource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    TaoIndexDataCenterCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    
    TaoIndexModelListClild *model = self.dataArray[indexPath.item];
    
    [cell setUrl:model.url ico:model.ico name:model.n];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    TaoIndexModelListClild *model = self.dataArray[indexPath.item];

    if ([self.delegate respondsToSelector:@selector(goodStockIndexDataCenterViewDelegatePush:)]) {
        [self.delegate goodStockIndexDataCenterViewDelegatePush:model.url];
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
        [_collectionView registerClass:[TaoIndexDataCenterCollectionViewCell class] forCellWithReuseIdentifier:cellID];
    }
    return _collectionView;
}

- (UICollectionViewFlowLayout *)flowLayout {
    if (_flowLayout == nil) {
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _flowLayout.itemSize = CGSizeMake(MAIN_SCREEN_WIDTH * 0.25, 80 * kScale);
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

@end
