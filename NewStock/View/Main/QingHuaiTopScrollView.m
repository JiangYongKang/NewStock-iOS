//
//  QingHuaiTopScrollView.m
//  NewStock
//
//  Created by 王迪 on 2017/3/13.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "Defination.h"
#import <Masonry.h>
#import "QingHuaiTopScrollView.h"
#import "MainTopCollectionViewCell.h"
#import "MainTopAdCollectionViewCell.h"

static NSString *cellID = @"mainTopCollectionViewCell";
static NSString *cellImgID = @"mainTopImgCell";

@interface QingHuaiTopScrollView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@property (nonatomic, strong) UIPageControl *pageContr;

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation QingHuaiTopScrollView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    [self addSubview:self.collectionView];
    [self addSubview:self.pageContr];
//    self.backgroundColor = [UIColor redColor];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self).offset(0 * kScale);
        make.bottom.equalTo(self).offset(0 * kScale);
    }];
    
    [self.pageContr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.bottom.equalTo(self).offset(-5 * kScale);
        make.height.equalTo(@(15 * kScale));
    }];
    
    UILabel *line = [UILabel new];
    line.backgroundColor = kUIColorFromRGB(0xe4e4e4);
    [self addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.equalTo(@(0.5));
    }];
}

- (void)setDataArray:(NSArray<ForumModel *> *)dataArray {
    _dataArray = dataArray;
    self.pageContr.numberOfPages = self.dataArray.count;
    [self.collectionView reloadData];
}

- (void)aotuRoll {
    if ([self.collectionView visibleCells].count <= 0 || self.dataArray.count == 0) {
        return;
    }
    MainTopCollectionViewCell * cell = [self.collectionView visibleCells][0];
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

#pragma action

- (void)addTimerScroll {
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
}

- (void)deleteTimer {
    [self.timer invalidate];
    self.timer = nil;
}

#pragma mark collection delegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 100;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    ForumModel *model = self.dataArray[indexPath.item];
    NSDictionary *ctm = (NSDictionary *)model.ctm;
    NSString *res_code = ctm[@"res_code"];
    
    if ([res_code isEqualToString:@"S_FEELING"]) {
       MainTopCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
        cell.model = model;
        return cell;
    } else {
        MainTopAdCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellImgID forIndexPath:indexPath];
        if (model.imgs.count) {
            ImageListModel * imageItem = model.imgs.firstObject;
            cell.imgUrl = imageItem.origin;
        }
        return cell;
    }
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    ForumModel *model = self.dataArray[indexPath.item];
    NSDictionary *ctm = (NSDictionary *)model.ctm;
    NSString *res_code = ctm[@"res_code"];
    
    if ([res_code isEqualToString:@"S_FEELING"]) {
        if ([self.delegate respondsToSelector:@selector(qinHuaiTopScrollView:)]) {
            [self.delegate qinHuaiTopScrollView:@""];
        }
    } else {
        if ([self.delegate respondsToSelector:@selector(qinHuaiTopScrollView:)]) {
            [self.delegate qinHuaiTopScrollView:model.funcUrl];
        }
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat contentOffsetX = scrollView.contentOffset.x;
    NSInteger index = contentOffsetX / MAIN_SCREEN_WIDTH;
    
    self.pageContr.currentPage = index % self.dataArray.count;
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self deleteTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self addTimerScroll];
}

#pragma mark lazy loading

- (UICollectionView *)collectionView {
    if (_collectionView == nil) {
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:self.flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.pagingEnabled = YES;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[MainTopCollectionViewCell class] forCellWithReuseIdentifier:cellID];
        [_collectionView registerClass:[MainTopAdCollectionViewCell class] forCellWithReuseIdentifier:cellImgID];
    }
    return _collectionView;
}

- (UICollectionViewFlowLayout *)flowLayout {
    if (_flowLayout == nil) {
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _flowLayout.minimumLineSpacing = 0;
        _flowLayout.minimumInteritemSpacing = 0;
        _flowLayout.itemSize = CGSizeMake(MAIN_SCREEN_WIDTH, 150 * kScale);
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    return _flowLayout;
}

- (UIPageControl *)pageContr {
    if (_pageContr == nil) {
        _pageContr = [[UIPageControl alloc] init];
        _pageContr.numberOfPages = 3;
        _pageContr.pageIndicatorTintColor = kUIColorFromRGB(0xffffff);
        _pageContr.currentPageIndicatorTintColor = kTitleColor;
    }
    return _pageContr ;
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
