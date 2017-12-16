//
//  ZhuangGuViewController.m
//  NewStock
//
//  Created by 王迪 on 2017/3/8.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "ZhuangGuViewController.h"
#import "TigerSearchViewController.h"
#import "IdleFundListViewController.h"
#import "TaoSearchStockViewController.h"
#import "IdleFundClassifyAPI.h"
#import "IdleFundClassifyModel.h"
#import "SharedInstance.h"

@interface ZhuangGuViewController () <IdleFundListViewControllerDelegate>

@property (nonatomic, strong) NSArray <IdleFundClassifyModel *> *classifyArray;
@property (nonatomic, strong) IdleFundClassifyAPI *classifyAPI;

@property (nonatomic, strong) UILabel *topLb;
@property (nonatomic, strong) UIImageView *headerIv;

@end

@implementation ZhuangGuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [_navBar setLeftBtnImg:[UIImage imageNamed:@"ic_back1_nor"]];
    [_navBar setRightBtnImg:[UIImage imageNamed:@"ic_share1_nor"]];
    _navBar.backgroundColor = [UIColor clearColor];
    _navBar.line_view.hidden = YES;
    [_mainView removeFromSuperview];
    [_scrollView removeFromSuperview];
    
    self.title = @"主力股票池";
    
    [self.classifyAPI startWithCompletionBlockWithSuccess:^(__kindof APIBaseRequest *request) {
        self.classifyArray = [MTLJSONAdapter modelsOfClass:[IdleFundClassifyModel class] fromJSONArray:request.responseJSONObject error:nil];
        [self setupSegment];
    } failure:^(__kindof APIBaseRequest *request) {
        NSLog(@"%@ fialed",[request class]);
    }];
    
    [self setupUI];
    
    [self.view bringSubviewToFront:_navBar];
}

- (void)setupSegment {
    NSMutableArray *nmA = [NSMutableArray array];
    for (IdleFundClassifyModel *model in self.classifyArray) {
        [nmA addObject:model.n];
    }
    _segmentedControl = [[HMSegmentedControl alloc] initWithSectionTitles:nmA];
    _segmentedControl.titleTextAttributes = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:16.0f],NSForegroundColorAttributeName : [UIColor colorWithWhite:1 alpha:0.8]};
    _segmentedControl.selectedTitleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:18.0f]};
    
    _segmentedControl.backgroundColor = [UIColor clearColor];
    _segmentedControl.selectionStyle = HMSegmentedControlSelectionStyleTextWidthStripe;
    _segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    _segmentedControl.selectionIndicatorColor = kUIColorFromRGB(0xffffff);
    _segmentedControl.selectionIndicatorHeight = 2;
    [_segmentedControl addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventValueChanged];
    [_navBar addSubview:_segmentedControl];
    [_segmentedControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_segmentedControl.superview).offset(-1);
        make.height.mas_equalTo(44);
        make.width.mas_equalTo(240 * kScale);
        make.centerX.equalTo(_segmentedControl.superview.mas_centerX);
    }];
    
    NSUInteger numberOfPages = self.classifyArray.count;
    _viewControllerArray = [[NSMutableArray alloc] initWithCapacity:numberOfPages];
    for (NSUInteger k = 0; k < numberOfPages; ++k) {
        [_viewControllerArray addObject:[NSNull null]];
    }
    
    _lazyScrollView = [[DMLazyScrollView alloc] initWithFrame:CGRectMake(0, 0, _nMainViewWidth, _nMainViewHeight)];
    [_lazyScrollView.panGestureRecognizer requireGestureRecognizerToFail:self.navigationController.interactivePopGestureRecognizer];
    [_lazyScrollView setEnableCircularScroll:NO];
    [_lazyScrollView setAutoPlay:NO];
    __weak __typeof(&*self)weakSelf = self;
    _lazyScrollView.dataSource = ^(NSUInteger index) {
        return [weakSelf controllerAtIndex:index];
    };
    _lazyScrollView.numberOfPages = numberOfPages;
    _lazyScrollView.controlDelegate = self;
    [self.view addSubview:_lazyScrollView];
    [_lazyScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headerIv.mas_bottom).offset(0 * kScale);
        make.left.equalTo(_lazyScrollView.superview).offset(0);
        make.right.equalTo(_lazyScrollView.superview).offset(0);
        make.bottom.equalTo(_lazyScrollView.superview).offset(0);
    }];
    
    BaseViewController *contr = [_viewControllerArray objectAtIndex:(long)_segmentedControl.selectedSegmentIndex];
    [contr loadData];
}

- (void)setupUI {
    self.headerIv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tao_zg_placeholder"]];
    self.headerIv.contentMode = UIViewContentModeScaleAspectFill;
    self.headerIv.clipsToBounds = YES;
    [self.view addSubview:self.headerIv];
    [self.headerIv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.equalTo(@(180 * kScale));
    }];
    
    [self.headerIv addSubview:self.topLb];
    
    [self.topLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(12 * kScale);
        make.right.equalTo(self.view).offset(-12 * kScale);
        make.centerY.equalTo(_navBar.mas_bottom).offset(60 * kScale);
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

- (void)navBar:(NavBar *)navBar rightButtonTapped:(UIButton *)sender {
    [self share];
}

- (void)share {
    NSString *url = [NSString stringWithFormat:@"%@%@",API_URL,H5_MF0101];
    
    IdleFundClassifyModel *model = self.classifyArray[_segmentedControl.selectedSegmentIndex];
    [SharedInstance sharedSharedInstance].image = [UIImage imageNamed:@"shareLogo"];
    [SharedInstance sharedSharedInstance].tt = model.n;
    [SharedInstance sharedSharedInstance].c = self.topLb.text;
    [SharedInstance sharedSharedInstance].url = url;
    [SharedInstance sharedSharedInstance].res_code = @"S_ZLGPC";
    [SharedInstance sharedSharedInstance].sid = model.s;
    [[SharedInstance sharedSharedInstance] shareWithImage:NO];
}

#pragma mark - DMLazyScrollViewDelegate

- (void)idleFundListViewControllerDelegateDsc:(NSString *)dsc icon:(NSString *)icon {
    [_headerIv sd_setImageWithURL:[NSURL URLWithString:icon]];
    NSMutableParagraphStyle *para = [NSMutableParagraphStyle new];
    para.lineSpacing = 4 * kScale;
    
    _topLb.attributedText = [[NSAttributedString alloc] initWithString:dsc attributes:@{NSParagraphStyleAttributeName : para}];;
}

- (UIViewController *)controllerAtIndex:(NSInteger) index {
    if (index > _viewControllerArray.count || index < 0) return nil;
    id res = [_viewControllerArray objectAtIndex:index];
    if (res == [NSNull null]) {
        IdleFundListViewController *contr = [[IdleFundListViewController alloc]init];
        IdleFundClassifyModel *model = self.classifyArray[index];
        contr.code = model.s;
        contr.delegate = self;
        __weak typeof(self)weakSelf = self;
        contr.tigerVCPushBlock = ^{
            TigerSearchViewController *tiger = [TigerSearchViewController new];
            [weakSelf.navigationController pushViewController:tiger animated:YES];
        };
        contr.pushBlock = ^(IdleFundStockListModel *model){
            TaoSearchStockViewController *vc = [TaoSearchStockViewController new];
            vc.t = model.t;
            vc.s = model.s;
            vc.m = model.m;
            vc.n = model.n;
            [weakSelf.navigationController pushViewController:vc animated:YES];
        };
        [_viewControllerArray replaceObjectAtIndex:index withObject:contr];
        return contr;
    }
    return res;
}

- (void)segmentedControlChangedValue:(HMSegmentedControl *)segmentedControl {
    [_lazyScrollView moveByPages:segmentedControl.selectedSegmentIndex-_lazyScrollView.currentPage animated:YES];
    
    IdleFundListViewController *contr = [_viewControllerArray objectAtIndex:(long)segmentedControl.selectedSegmentIndex];
    [contr loadData];
}

- (void)lazyScrollViewDidEndDecelerating:(DMLazyScrollView *)pagingView atPageIndex:(NSInteger)pageIndex {
    [_segmentedControl setSelectedSegmentIndex:pageIndex];
    [self segmentedControlChangedValue:_segmentedControl];
}

#pragma mark lazy loading

- (IdleFundClassifyAPI *)classifyAPI {
    if (_classifyAPI == nil) {
        _classifyAPI = [[IdleFundClassifyAPI alloc] init];
        _classifyAPI.pcode = @"zlgpc";
    }
    return _classifyAPI;
}

- (UILabel *)topLb {
    if (_topLb == nil) {
        _topLb = [UILabel new];
        _topLb.font = [UIFont systemFontOfSize:11 * kScale];
        _topLb.numberOfLines = 0;
        _topLb.preferredMaxLayoutWidth = MAIN_SCREEN_WIDTH - 24 * kScale;
        _topLb.textColor = [UIColor whiteColor];
    }
    return _topLb;
}

@end
