//
//  TalkNewsView.m
//  NewStock
//
//  Created by 王迪 on 2017/1/5.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "TalkNewsView.h"
#import "Defination.h"
#import "MainTalkNewsCell.h"
#import <Masonry.h>

static NSString *cellID = @"TalkNewsViewCellID";

@interface TalkNewsView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@end

@implementation TalkNewsView {
    CGFloat _marginLeft;
}

- (instancetype)init {
    if (self = [super init]) {
        [self setupUI];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)setupUI {
    
    _marginLeft = 5 * kScale;
    self.backgroundColor = [UIColor whiteColor];
    
    UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_newsTalk_img"]];
    [self addSubview:img];
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(12 * kScale);
    }];
    
    [self addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(img.mas_right).offset(_marginLeft);
        make.top.bottom.right.equalTo(self);
    }];
}

- (void)setDataArray:(NSArray *)dataArray {
    _dataArray = dataArray;
    
    [self.collectionView reloadData];
}

- (void)tap:(UITapGestureRecognizer *)tap {
    if (self.tapBlock) {
        self.tapBlock();
    }
}

- (void)aotuRoll {
    if ([self.collectionView visibleCells].count <= 0 || self.dataArray.count == 0) {
        return;
    }
    MainTalkNewsCell * cell = [self.collectionView visibleCells][0];
    NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];
    NSIndexPath *newIndex;
    
    NSInteger section = indexPath.section >= 90 ? 0 : indexPath.section;
    if (self.dataArray.count - 1 == indexPath.item) {
        newIndex = [NSIndexPath indexPathForItem:0 inSection:section + 1];
    } else {
        newIndex = [NSIndexPath indexPathForItem:indexPath.item + 1 inSection:section];
    }
    [self.collectionView scrollToItemAtIndexPath:newIndex atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
}

#pragma action


- (void)updateItemSize:(CGSize)size {
    UIImage *topicImg = [UIImage imageNamed:@"ic_newsTalk_img"];
    _flowLayout.itemSize = CGSizeMake(MAIN_SCREEN_WIDTH - _marginLeft - topicImg.size.width - 12, size.height);
}

- (void)addTimerScroll {
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
}

- (void)deleteTimer {
    [self.timer invalidate];
    self.timer = nil;
}

#pragma mark delegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 100;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MainTalkNewsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];

    cell.model = self.dataArray[indexPath.item];
    
    return cell;
}

#pragma mark lazyloading

- (UICollectionView *)collectionView {
    if (_collectionView == nil) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.flowLayout];
        _collectionView.pagingEnabled = YES;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.userInteractionEnabled = NO;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[MainTalkNewsCell class] forCellWithReuseIdentifier:cellID];
    }
    return _collectionView;
}

- (UICollectionViewFlowLayout *)flowLayout {
    if (_flowLayout == nil) {
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];//ic_newsTalk_img
        _flowLayout.minimumLineSpacing = 0;
        _flowLayout.minimumInteritemSpacing = 0;
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    }
    return _flowLayout;
}

- (NSTimer *)timer {
    if (_timer == nil) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:2.5 target:self selector:@selector(aotuRoll) userInfo:nil repeats:YES];
    }
    return _timer;
}

- (void)dealloc {
    [self deleteTimer];
}

@end
