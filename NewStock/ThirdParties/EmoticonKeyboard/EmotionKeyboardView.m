//
//  EmotionKeyboardView.m
//  oc-emotion
//
//  Created by 王迪 on 2017/2/8.
//  Copyright © 2017年 JiaBei. All rights reserved.
//

#import "EmotionKeyboardView.h"
#import "EmotionModel.h"
#import "EmotionCell.h"
#import <Masonry.h>

static NSString *cellID = @"emotionCell";

@interface EmotionKeyboardView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) NSArray *emojiDataArray;

@property (nonatomic, strong) UIPageControl *pageCon;

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation EmotionKeyboardView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    [self addSubview:self.collectionView];
    self.collectionView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 190);
    
    [self addSubview:self.pageCon];
    [self.pageCon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@30);
        make.left.right.equalTo(self);
        make.top.equalTo(self.collectionView.mas_bottom);
    }];

}



#pragma ------------------------- collectionView -----------------------

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.emojiDataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    EmotionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    
    cell.modelArray = self.emojiDataArray[indexPath.item];
    
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat x = scrollView.contentOffset.x + [UIScreen mainScreen].bounds.size.width * 0.5 ;
    CGPoint point = CGPointMake(x, 1);
    NSIndexPath *index = [self.collectionView indexPathForItemAtPoint:point];
    NSLog(@"%zd",index.row);
    self.pageCon.currentPage = index.row;
}

#pragma ------------------------- lazy loading --------------

- (UICollectionView *)collectionView {
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.itemSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 190);
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.pagingEnabled = YES;
        _collectionView.bounces = NO;
        [_collectionView registerClass:[EmotionCell class] forCellWithReuseIdentifier:cellID];
        _collectionView.backgroundColor = [UIColor whiteColor];
    }
    return _collectionView;
}

- (NSArray *)emojiDataArray {
    if (_emojiDataArray == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"Emoticons.bundle" ofType:nil];
        NSBundle *bundle = [[NSBundle alloc] initWithPath:path];
        _emojiDataArray = [NSArray arrayWithContentsOfFile:[bundle pathForResource:@"default/EmoInfo.plist" ofType:nil]];
        NSMutableArray *nmArr = [NSMutableArray array];
        for (NSDictionary *dic in _emojiDataArray) {
            EmotionModel *model = [EmotionModel new];
            [model setValuesForKeysWithDictionary:dic];
            [nmArr addObject:model];
        }
        _emojiDataArray = nmArr.copy;
        NSMutableArray *nmSubArr = [NSMutableArray array];
        for (int i = 0; i < 4; i ++) {
            NSInteger loc = 27 * i;
            NSInteger len = 27;
            if (loc + len > 105) {
                len = 105 - loc;
            }
            [nmSubArr addObject:[_emojiDataArray subarrayWithRange:NSMakeRange(loc, len)]];
        }
        _emojiDataArray = nmSubArr.copy;
    }
    return _emojiDataArray;
}

- (UIPageControl *)pageCon {
    if (_pageCon == nil) {
        _pageCon = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 15, 100, 30)];
        _pageCon.backgroundColor = [UIColor whiteColor];
        _pageCon.currentPageIndicatorTintColor = [UIColor grayColor];
        _pageCon.pageIndicatorTintColor = [UIColor blackColor];
        _pageCon.numberOfPages = 4;
        _pageCon.currentPage = 0;
    }
    return _pageCon;
}



@end
