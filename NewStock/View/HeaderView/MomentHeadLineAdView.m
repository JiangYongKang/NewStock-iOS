//
//  MomentHeadLineAdView.m
//  NewStock
//
//  Created by 王迪 on 2017/5/15.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "MomentHeadLineAdView.h"
#import "MomentAdHeadCell.h"
#import "AdListItemModel.h"
#import "Defination.h"
#import <Masonry.h>

static NSString *cellID = @"MomentHeadLineAdViewCellID";

@interface MomentHeadLineAdView () <UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) UIPageControl *pageCon;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation MomentHeadLineAdView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    
    }
    return self;
}

- (void)setupUI {
    
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self.collectionView addSubview:self.pageCon];
    [self.pageCon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-12 * kScale);
        make.bottom.equalTo(self).offset(0 * kScale);
        make.height.equalTo(@(30 * kScale));
    }];
}

- (void)setDataArray:(NSArray<AdListItemModel *> *)dataArray {
    _dataArray = dataArray;
    [self.collectionView reloadData];
    self.pageCon.numberOfPages = _dataArray.count;
}

- (void)addTimerScroll {
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
}

- (void)deleteTimer {
    [self.timer invalidate];
    self.timer = nil;
}

- (void)aotuRoll {
    if ([self.collectionView visibleCells].count <= 0 || self.dataArray.count == 0) {
        return;
    }
    MomentAdHeadCell * cell = [self.collectionView visibleCells][0];
    NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];
    NSIndexPath *newIndex;
    NSInteger section = indexPath.section >= 90 ? 0 : indexPath.section;
    if (indexPath.item == self.dataArray.count - 1) {
        newIndex = [NSIndexPath indexPathForItem:0 inSection:section + 1];
    } else {
        newIndex = [NSIndexPath indexPathForItem:indexPath.item + 1 inSection:section];
    }
    
    [self.collectionView scrollToItemAtIndexPath:newIndex atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
}


#pragma mark

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 100;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MomentAdHeadCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    cell.model = self.dataArray[indexPath.item];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    AdListItemModel *model = self.dataArray[indexPath.item];
    if ([self.delegate respondsToSelector:@selector(momentHeadLineAdViewClick:)]) {
        [self.delegate momentHeadLineAdViewClick:model.url];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetX = scrollView.contentOffset.x;
    NSInteger index = offsetX / MAIN_SCREEN_WIDTH;
    self.pageCon.currentPage = index % self.dataArray.count;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self deleteTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self addTimerScroll];
}

#pragma mark

- (UICollectionViewFlowLayout *)flowLayout {
    if (_flowLayout == nil) {
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _flowLayout.minimumLineSpacing = 0;
        _flowLayout.minimumInteritemSpacing = 0;
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _flowLayout.itemSize = CGSizeMake(MAIN_SCREEN_WIDTH, 180 * kScale);
    }
    return _flowLayout;
}

- (UICollectionView *)collectionView {
    if (_collectionView == nil) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.flowLayout];
        [_collectionView registerClass:[MomentAdHeadCell class] forCellWithReuseIdentifier:cellID];
        _collectionView.pagingEnabled = YES;
        _collectionView.scrollsToTop = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
    }
    return _collectionView;
}

- (UIPageControl *)pageCon {
    if (_pageCon == nil) {
        _pageCon = [UIPageControl new];
    }
    return _pageCon;
}

- (NSTimer *)timer {
    if (_timer == nil) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(aotuRoll) userInfo:nil repeats:YES];
    }
    return _timer;
}

- (void)dealloc {
    [self deleteTimer];
}


@end
