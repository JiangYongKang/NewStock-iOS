//
//  QingHuaiViewController.m
//  NewStock
//
//  Created by 王迪 on 2017/1/10.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "QingHuaiViewController.h"
#import "QingHuaiCollectionViewCell.h"

#import <Masonry.h>
#import <UMSocial.h>
#import "UIView+Masonry_Arrange.h"
#import "SystemUtil.h"

#import "QingHuaiTimeView.h"
#import "SharedInstance.h"
#import "QingHuaiBottomView.h"

#import "MainPageModel.h"
#import "RecommendListAPI.h"
#import "FeedLikeAPI.h"

static NSString * cellID = @"qingHuaiCellID";

@interface QingHuaiViewController ()<QingHuaiCollectionViewCellDelegate>

@property (nonatomic, strong) UICollectionView *centerCollectionView;

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) RecommendListAPI *qingHuaiAPI;

@property (nonatomic, strong) FeedLikeAPI *feenLikeAPI;

@property (nonatomic, strong) QingHuaiTimeView *timeView;

@property (nonatomic, strong) QingHuaiBottomView *bottomView;

@property (nonatomic, assign) NSInteger page;

@property (nonatomic, assign) BOOL isLoading;

@end

@implementation QingHuaiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"炒个情怀详情页";
    
    [_scrollView removeFromSuperview];;
    [_mainView removeFromSuperview];
    _navBar.line_view.hidden = YES;
    _navBar.backgroundColor = [UIColor clearColor];
    self.view.backgroundColor = kUIColorFromRGB(0xe16464);
    [_navBar setLeftBtnImg:[UIImage imageNamed:@"ic_back1_nor"]];
    [_navBar setRightBtnImg:[UIImage imageNamed:@"ic_share1_nor"]];
    UIButton *flyBtn = [_navBar valueForKey:@"_rightButton1"];
    [flyBtn setImage:[UIImage imageNamed:@"ic_feiji_nor"] forState:UIControlStateNormal];
    flyBtn.hidden = NO;
    
    [_navBar addSubview:self.timeView];
    
    [self.timeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_navBar).offset(22);
        make.bottom.equalTo(_navBar);
        make.left.equalTo(_navBar).offset(50);
        make.width.equalTo(@100);
    }];
    
    [self.view addSubview:self.centerCollectionView];
    [self.centerCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(70);
        make.left.equalTo(self.view).offset(0);
        make.right.equalTo(self.view).offset(0);
        make.height.equalTo(self.view).multipliedBy(0.77);
    }];
    
    [self.view addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
        make.height.equalTo(@(50 * kScale));
    }];
    self.bottomView.page = 0;
    self.page = 0;
    typeof(self)weakSelf = self;
    self.bottomView.colorBlock = ^(UIColor *color) {
    
        [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
            weakSelf.view.layer.backgroundColor = color.CGColor;
        } completion:nil];
    };
    
    self.bottomView.pageBlock = ^(NSInteger page) {
        NSInteger diff = self.page % 8 - page;
        if (weakSelf.dataArray.count > self.page - diff) {
            [weakSelf.centerCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:weakSelf.page - diff inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
        }
    };
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [self loadNewData];
}

- (void)navBar:(NavBar *)navBar rightButtonTapped:(UIButton *)sender {
    
    QingHuaiCollectionViewCell *cell = self.centerCollectionView.visibleCells[0];
    UIImage *image = [SystemUtil getQinghuaiImage:cell];
    NSString *url = @"http://www.guguaixia.com";
    NSString *title = [NSString stringWithFormat:@"股怪侠 - 炒个情怀"];
    
    ForumModel *model = self.dataArray[self.page];
    
    [SharedInstance sharedSharedInstance].image = image;
    [SharedInstance sharedSharedInstance].tt = title;
    [SharedInstance sharedSharedInstance].sid = model.fid;
    [SharedInstance sharedSharedInstance].c = @"";
    [SharedInstance sharedSharedInstance].url = url;
    [SharedInstance sharedSharedInstance].res_code = @"S_FEELING";
    [[SharedInstance sharedSharedInstance] shareWithImage:YES];
}

- (void)navBar:(NavBar *)navBar rightButton1Tapped:(UIButton *)sender {
    NSLog(@"fly");
    [self.centerCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
}

#pragma mark cell delegate

- (void)qingHuaiCollectionViewCellLikeBtnClick:(QingHuaiCollectionViewCell *)cell {
    
    NSString *fid = cell.model.fid;
    
    self.feenLikeAPI.fId = fid;
    [self.feenLikeAPI startWithCompletionBlockWithSuccess:^(APIBaseRequest *request) {
        NSLog(@"_feedLikeAPI success");
    } failure:^(APIBaseRequest *request) {
        NSLog(@"failed");
    }];
}

#pragma mark loadData

- (void)loadNewData {
    self.qingHuaiAPI.page = [NSString stringWithFormat:@"%zd",self.qingHuaiAPI.page.integerValue + 1];
    [self.qingHuaiAPI start];
}

- (void)requestFailed:(APIBaseRequest *)request {
    NSLog(@"加载情怀失败");
    self.isLoading = NO;
}

- (void)requestFinished:(APIBaseRequest *)request {
    NSLog(@"%@",request.responseJSONObject);
    
    NSArray *arr = [MTLJSONAdapter modelsOfClass:[ForumModel class] fromJSONArray:[request.responseJSONObject objectForKey:@"list"] error:nil];
    if (arr.count < self.qingHuaiAPI.count.integerValue) {
        self.isLoading = YES;
    }else {
        self.isLoading = NO;
    }
    
    if (self.dataArray.count == 0) {
        [self.dataArray addObjectsFromArray:arr];
//        [self changeTheTime];
    }else {
        [self.dataArray addObjectsFromArray:arr];
    }
    
    [self.centerCollectionView reloadData];
}

#pragma mark collectionView delagate dateSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    QingHuaiCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    cell.model = self.dataArray[indexPath.item];
    cell.delegate = self;
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView == self.centerCollectionView) {
        CGFloat mainW = MAIN_SCREEN_WIDTH - 20;
        self.page = scrollView.contentOffset.x / mainW;
        
        if (_page == self.dataArray.count - 1 && self.isLoading == NO) {
            [self loadNewData];
            self.isLoading = YES;
        }
    }
    
}

- (NSDate *)changeStrToDate:(NSString *)str {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    formatter.dateFormat = @"yyyy-MM-dd HH-mm-ss";
    
    return [formatter dateFromString:str];
}

- (void)changeTheTime {
    ForumModel *model = self.dataArray[_page];
    if (model.tm.length) {
        NSDate *date = [self changeStrToDate:model.tm];
        NSString *weekStr = [SystemUtil weekdayStringFromDate:date];
        NSString *dayStr = [model.tm substringWithRange:NSMakeRange(8, 2)];
        NSString *monStr = [model.tm substringWithRange:NSMakeRange(5, 2)];
        [self.timeView setDay:dayStr month:monStr week:weekStr];
    }
}

#pragma mark ----------------------------------------------------------------

- (void)setPage:(NSInteger)page {
    if (_page != page) {
        _page = page;
//        [self changeTheTime];
        self.bottomView.page = page;
    }
}

- (QingHuaiTimeView *)timeView {
    if (_timeView == nil) {
        _timeView = [[QingHuaiTimeView alloc] init];
        _timeView.hidden = YES;
    }
    return _timeView;
}

- (QingHuaiBottomView *)bottomView {
    if (_bottomView == nil) {
        _bottomView = [[QingHuaiBottomView alloc] init];
    }
    return _bottomView;
}

- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (FeedLikeAPI *)feenLikeAPI {
    if (_feenLikeAPI == nil) {
        _feenLikeAPI = [[FeedLikeAPI alloc] init];
    }
    return _feenLikeAPI;
}

- (RecommendListAPI *)qingHuaiAPI {
    if (_qingHuaiAPI == nil) {
        _qingHuaiAPI = [[RecommendListAPI alloc] initWithCount:@"8" res_code:@"S_FEELING" page:@"0"];
        _qingHuaiAPI.delegate = self;
        _qingHuaiAPI.flag = @"1";
    }
    return _qingHuaiAPI;
}

- (UICollectionViewFlowLayout *)flowLayout {
    if (_flowLayout == nil) {
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _flowLayout.itemSize = CGSizeMake(MAIN_SCREEN_WIDTH , MAIN_SCREEN_HEIGHT * 0.77);
        _flowLayout.minimumLineSpacing = 0;
        _flowLayout.minimumInteritemSpacing = 0;
    }
    return _flowLayout;
}

- (UICollectionView *)centerCollectionView {
    if (_centerCollectionView == nil) {
        _centerCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.flowLayout];
        _centerCollectionView.pagingEnabled = YES;
        _centerCollectionView.delegate = self;
        _centerCollectionView.dataSource = self;
        [_centerCollectionView registerClass:[QingHuaiCollectionViewCell class] forCellWithReuseIdentifier:cellID];
        _centerCollectionView.backgroundColor = [UIColor clearColor];
        _centerCollectionView.showsHorizontalScrollIndicator = NO;
        [_centerCollectionView.panGestureRecognizer requireGestureRecognizerToFail:self.navigationController.interactivePopGestureRecognizer];
    }
    return _centerCollectionView;
}





@end
