//
//  TaoSearchPeopleViewController.m
//  NewStock
//
//  Created by 王迪 on 2017/3/6.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "TaoSearchPeopleViewController.h"
#import "TaoPPlViewController.h"

#import "TaoSearchPPlCoverView.h"
#import "TaoSearchHotPeopleAPI.h"
#import "TaoHotPeopleModel.h"

#import "StockCodesInstance.h"
#import "ILRemoteSearchBar.h"
#import "StockHistoryUtil.h"

@interface TaoSearchPeopleViewController ()<ILRemoteSearchBarDelegate, UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) TaoSearchHotPeopleAPI *searchPPlAPI;

@property (nonatomic, strong) NSArray *hotPeopleArray;

@property (nonatomic, strong) NSMutableArray *resultArray;

@property (nonatomic, strong) NSMutableArray *userResultArray;

@property (nonatomic, strong) ILRemoteSearchBar *searchBar;

@property (nonatomic, assign) BOOL bStartSearch;

@property (nonatomic, strong) TaoSearchPPlCoverView *hotCoverView;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIView *searchBorderView;

@property (nonatomic, strong) UIButton *cancleBtn;

@property (nonatomic, strong) UILabel *dscLb;
@property (nonatomic, assign) CGFloat dscLb_height;
@property (nonatomic, strong) UIView *dscCoverView;

@property (nonatomic, strong) UIImageView *topBgImageView;
@property (nonatomic, strong) UIButton *rightBtn;
@property (nonatomic, strong) UILabel *noResultLb;

@end

@implementation TaoSearchPeopleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(noti:) name:@"allUserArrayFinished" object:nil];

    self.title = @"牛散名单";
    
    [_scrollView removeFromSuperview];
    _navBar.line_view.hidden = YES;

    UILabel *titleLb = [_navBar valueForKeyPath:@"_titleLb"];
    titleLb.text = @"牛散名单";
    titleLb.textColor = kUIColorFromRGB(0xffffff);
    [_navBar setLeftBtnImg:[UIImage imageNamed:@"ic_back1_nor"]];
//    [_navBar addSubview:self.rightBtn];
    
    _resultArray = [NSMutableArray array];
    _userResultArray = [NSMutableArray array];
    
    [self setupUI];
    [self getHotWords];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

- (void)setupUI {
    __weak typeof(self)weakSelf = self;
    
    [self.view addSubview:self.topBgImageView];
    [self.view addSubview:self.dscCoverView];
    
    _navBar.backgroundColor = [UIColor clearColor];
    [self.view bringSubviewToFront:_navBar];
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.hotCoverView];
    [self.view addSubview:self.searchBorderView];
    
    [self.topBgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.equalTo(@64);
    }];
    
    [self.dscCoverView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view).offset(0 * kScale);
        make.top.equalTo(_navBar.mas_bottom);
        make.height.equalTo(@(0));
    }];
    
    [self.searchBorderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_dscCoverView.mas_bottom);
        make.right.left.equalTo(self.view);
        make.height.equalTo(@(54 * kScale));
    }];
    
    [self.hotCoverView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.searchBar.mas_bottom).offset(12 * kScale);
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.hotCoverView);
        make.bottom.equalTo(self.view).offset(-200);
    }];
    
    [self.tableView addSubview:self.noResultLb];
    [self.noResultLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.tableView);
    }];
    
    self.hotCoverView.endEditingBlock = ^{
        [weakSelf closeSearchView];
    };
    
    self.hotCoverView.pushBlock = ^(TaoHotPeopleModel *model){
        TaoPPlViewController *vc = [TaoPPlViewController new];
        vc.n = model.n;
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
}

- (void)getHotWords {
    
    [self.searchPPlAPI startWithCompletionBlockWithSuccess:^(__kindof APIBaseRequest *request) {
//        NSLog(@"%@",request.responseJSONObject);
        
        self.hotCoverView.hotNameArray = [MTLJSONAdapter modelsOfClass:[TaoHotPeopleModel class] fromJSONArray:[request.responseJSONObject objectForKey:@"user"] error:nil];
        
        NSString *dsc = request.responseJSONObject[@"dsc"];
        
        
        NSMutableParagraphStyle *para = [[NSMutableParagraphStyle alloc] init];
        para.lineSpacing = 4 * kScale;
        
        NSMutableAttributedString *nmAttrS = [[NSMutableAttributedString alloc]
                                              initWithString:dsc attributes:@{
                                NSFontAttributeName : [UIFont systemFontOfSize:14 * kScale],
                                NSForegroundColorAttributeName : [UIColor whiteColor],
                                NSParagraphStyleAttributeName : para,
                                                                              }];
        self.dscLb.attributedText = nmAttrS;
        CGRect rect = [nmAttrS boundingRectWithSize:CGSizeMake(MAIN_SCREEN_WIDTH - 30 * kScale, 10000) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];

        self.dscLb_height = rect.size.height + 5 * kScale + 15 * kScale;

        [self.dscCoverView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(_dscLb_height));
        }];
        [self.topBgImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(_dscLb_height + 64));
        }];
    } failure:^(__kindof APIBaseRequest *request) {
        NSLog(@"%@ failed",self.class);
    }];
    
}


# pragma mark - ILRemoteSearchBarDelegate
- (void)remoteSearchBar:(ILRemoteSearchBar *)searchBar textDidChange:(NSString *)searchText {
    NSLog(@"search text: %@",searchText);
    
    [self search:searchText];
    [self searchUser:searchText];
    [_tableView reloadData];
}

#pragma mark - UISearchBarDelegate

- (void)search:(NSString *)searchText {
    if (searchText.length > 0) {
        _bStartSearch = YES;
        self.hotCoverView.hidden = YES;
    } else {
        _bStartSearch = NO;
        self.hotCoverView.hidden = NO;
    }
    
    [_resultArray removeAllObjects];
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
    dispatch_async(queue, ^{
        NSArray *array = [StockCodesInstance sharedStockCodesInstance].stockCodesArray;
        //NSArray *array = appDelegate.stockCodesModel.gxCodeList;
        
        NSString *text = [searchText lowercaseString];
        for (int i = 0; i < [array count]; i++) {
            StockCodeInfo* item = [array objectAtIndex:i];
            
            NSString *code = item.s;
            NSString *name = item.n;
            NSString *pin = item.p;
            if([code containsString:searchText])//hasPrefix
            {
                [_resultArray addObject:item];
            }
            else if([name containsString:searchText])
            {
                [_resultArray addObject:item];
            }
            else if([pin containsString:text])
            {
                [_resultArray addObject:item];
            }
            
            if([_resultArray count] > 5)
            {
                break;
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [_tableView reloadData];
        });
    });
    
}

- (void)searchUser:(NSString *)searchText {
    if (searchText.length > 0) {
        _bStartSearch = YES;
        self.hotCoverView.hidden = YES;
    } else {
        _bStartSearch = NO;
        self.hotCoverView.hidden = NO;
    }
    
    [_userResultArray removeAllObjects];
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
    dispatch_async(queue, ^{
        NSArray *array = [StockCodesInstance sharedStockCodesInstance].userArray;
        
        NSString *text = [searchText lowercaseString];
        for (int i = 0; i < [array count]; i++) {
            TaoHotPeopleModel* item = [array objectAtIndex:i];
            
            NSString *name = item.n;
            NSString *pin = item.p;
            
            if([name containsString:searchText])
            {
                [_userResultArray addObject:item];
            }
            else if([pin containsString:text])
            {
                [_userResultArray addObject:item];
            }
            
            if([_userResultArray count] > 20)
            {
                break;
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [_tableView reloadData];
        });
    });
    
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar {
    NSLog(@"end");

    _navBar.frame = CGRectMake(0, 0, MAIN_SCREEN_WIDTH, NAV_BAR_HEIGHT);
    [self.searchBar mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_searchBorderView).offset(105 * kScale);
        make.right.equalTo(_searchBorderView).offset(-15 * kScale);
    }];
    self.rightBtn.hidden = NO;
    self.cancleBtn.hidden = YES;
    [self.dscCoverView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(_dscLb_height));
    }];
    [UIView animateWithDuration:0.3 animations:^{
        [self.view layoutIfNeeded];
        _navBar.backgroundColor = [UIColor clearColor];
    }];
    self.hotCoverView.isUp = NO;
    return YES;
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    NSLog(@"begin");
    _navBar.frame = CGRectMake(0, 0, MAIN_SCREEN_WIDTH, 20);
    [self.searchBar mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_searchBorderView).offset(-55 * kScale);
        make.left.equalTo(_searchBorderView).offset(15 * kScale);
    }];

    self.rightBtn.hidden = YES;
    self.cancleBtn.hidden = NO;
    [self.dscCoverView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(0));
    }];
    [UIView animateWithDuration:0.1 animations:^{
        [self.view layoutIfNeeded];
        _navBar.backgroundColor = kUIColorFromRGB(0xf1f1f1);
    }];
    self.hotCoverView.isUp = YES;
    return YES;
}

#pragma mark action 

- (void)noti:(NSNotification *)noti {
    [self.hotCoverView dealWithArray:NO];
}

- (void)addAction:(UIButton *)sender {
    
    NSArray *array = _resultArray;
    
    StockCodeInfo* item = [array objectAtIndex:sender.tag];
    ADD_STOCK_STATU status = [StockHistoryUtil addStockToMyStock:item];
    
    switch (status) {
        case ADD_STOCK_FALSE: {
            
            break;
        }
        case ADD_STOCK_SUC: {
            [_tableView reloadData];
            
            break;
        }
        case ADD_STOCK_FULL: {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                                message:@"自选股超过了100个！"
                                                               delegate:self
                                                      cancelButtonTitle:@"确定"
                                                      otherButtonTitles:nil];
            [alertView show];
            
            break;
        }
        case ADD_STOCK_EXIST: {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                                message:@"该自选股已经存在！"
                                                               delegate:self
                                                      cancelButtonTitle:@"确定"
                                                      otherButtonTitles:nil];
            [alertView show];
            break;
        }
    }
    
}

- (void)tapClose:(UITapGestureRecognizer *)tap {
    [self closeSearchView];
}

- (void)cancleBtnClick {
    [self closeSearchView];
}

- (void)closeSearchView {
    _searchBar.text = @"";
    [self search:_searchBar.text];
    [self searchUser:_searchBar.text];
    [_tableView reloadData];
    [self.view endEditing:YES];
}

- (void)rightBtnAction:(UIButton *)btn {
    [self.hotCoverView dealWithArray:!btn.isSelected];
    self.rightBtn.selected = !self.rightBtn.isSelected;
}

#pragma mark tableView delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_resultArray.count == 0 && _userResultArray.count == 0) {
        self.noResultLb.hidden = NO;
    } else {
        self.noResultLb.hidden = YES;
    }
    if (section == 0) {
        return _resultArray.count;
    } else {
        return _userResultArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        static NSString *cellid = @"stockListViewCell";
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellid];
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            
            [btn setImage:[UIImage imageNamed:@"self_add_stock"] forState:UIControlStateNormal];
            btn.frame = CGRectMake(0, 0, 30, 30);
            [btn addTarget:self action:@selector(addAction:) forControlEvents:UIControlEventTouchUpInside];
            cell.accessoryView = btn;
        }
        NSArray *array = _resultArray;
        
        StockCodeInfo* item = [array objectAtIndex:indexPath.row];
        
        if ([item.n isEqualToString:@""])
        {
            NSString *name = [[StockCodesInstance sharedStockCodesInstance] getStockNameWithSymbol:item.s type:item.t market:item.m];
            cell.textLabel.text = name;
        }
        else
        {
            cell.textLabel.text = item.n;
        }
        
        cell.textLabel.textColor = kUIColorFromRGB(0x333333);
        cell.detailTextLabel.textColor = kUIColorFromRGB(0x808080);
        
        if ([item.m intValue] == 1)
        {
            cell.detailTextLabel.text = [NSString stringWithFormat:@"SH%@",item.s];
        }
        else if ([item.m intValue] == 2)
        {
            cell.detailTextLabel.text = [NSString stringWithFormat:@"SZ%@",item.s];
        }
        else
        {
            cell.detailTextLabel.text = item.s;
        }
        cell.accessoryView.tag = indexPath.row;
        
        UIButton *btn = (UIButton *)cell.accessoryView;
        if ([StockHistoryUtil searchStockFromMyStock:item]) {
            [btn setImage:[UIImage imageNamed:@"self_suc_add"] forState:UIControlStateNormal];
        } else {
            [btn setImage:[UIImage imageNamed:@"self_add_stock"] forState:UIControlStateNormal];
        }
        
        return cell;
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"userCell" forIndexPath:indexPath];
    
    TaoHotPeopleModel *model = _userResultArray[indexPath.row];
    cell.textLabel.text = model.n;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TaoPPlViewController *vc = [TaoPPlViewController new];
    if (indexPath.section == 0) {
        StockCodeInfo* item = _resultArray[indexPath.row];
        vc.t = item.t;
        vc.s = item.s;
        vc.m = item.m;
        vc.stockName = item.n;
    } else {
        TaoHotPeopleModel *model = _userResultArray[indexPath.row];
        vc.n = model.n;
    }
    
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark lazy loading

- (TaoSearchPPlCoverView *)hotCoverView {
    if (_hotCoverView == nil) {
        _hotCoverView = [[TaoSearchPPlCoverView alloc] init];
        _hotCoverView.backgroundColor = [UIColor whiteColor];
    }
    return _hotCoverView;
}

- (TaoSearchHotPeopleAPI *)searchPPlAPI {
    if (_searchPPlAPI == nil) {
        _searchPPlAPI = [TaoSearchHotPeopleAPI new];
        _searchPPlAPI.code = @"";
    }
    return _searchPPlAPI;
}

- (ILRemoteSearchBar *)searchBar {
    if (_searchBar == nil) {
        _searchBar = [[ILRemoteSearchBar alloc] init];
        _searchBar.delegate = self;
//        _searchBar.placeholder = @"请输入牛散姓名或股票代码追踪牛散";
        [_navBar addSubview:_searchBar];
        
        UIImage* tfBgImg = [SystemUtil imageWithColor:kUIColorFromRGB(0xffffff) andHeight:30.0f * kScale];
        [_searchBar setBackgroundImage:tfBgImg];

        //searchbar背景
        UIImage* clearImg = [SystemUtil imageWithColor:kUIColorFromRGB(0xffffff) andHeight:30.0f * kScale];
        [_searchBar setSearchFieldBackgroundImage:clearImg forState:UIControlStateNormal];
        [_searchBar setBackgroundColor:[UIColor clearColor]];
        
        //placeholder
        UITextField * searchField = [_searchBar valueForKey:@"_searchField"];
        UILabel *placeHolderLb = [searchField valueForKeyPath:@"_placeholderLabel"];
        
        placeHolderLb.backgroundColor = [UIColor redColor];
        [searchField setValue:kUIColorFromRGB(0x999999) forKeyPath:@"_placeholderLabel.textColor"];
        [searchField setValue:[UIFont systemFontOfSize:12 * kScale] forKeyPath:@"_placeholderLabel.font"];

        [_searchBar setImage:[UIImage imageNamed:@"ic_search_nor"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
        _searchBar.layer.cornerRadius = 15 * kScale;
        _searchBar.layer.masksToBounds = YES;
        

        CGFloat offset = -0.8 * kScale;
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"请输入牛散姓名或股票代码追踪牛散" attributes:@{
                                                                                                              NSFontAttributeName : [UIFont systemFontOfSize:12 * kScale],
                                                                                                          NSBaselineOffsetAttributeName : @(offset),
                                                                                                          }];
        [searchField setAttributedPlaceholder:attributedString];
    }
    return _searchBar;
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorInset = UIEdgeInsetsMake(0, 15, 0, 15);
        _tableView.tableFooterView = [UIView new];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"userCell"];
    }
    return _tableView;
}

- (UIView *)searchBorderView {
    if (_searchBorderView == nil) {
        _searchBorderView = [UIView new];
        _searchBorderView.backgroundColor = kUIColorFromRGB(0xf1f1f1);
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClose:)];
        [_searchBorderView addGestureRecognizer:tap];
        
        [_searchBorderView addSubview:self.searchBar];
        
        [_searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_searchBorderView);
            make.top.equalTo(_searchBorderView).offset(12 * kScale);
            make.height.equalTo(@(30 * kScale));
            make.left.equalTo(_searchBorderView).offset(105 * kScale);
            make.right.equalTo(_searchBorderView).offset(-15 * kScale);
        }];
        
        [_searchBorderView addSubview:self.cancleBtn];
        [self.cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(_searchBorderView);
            make.width.equalTo(@(40 * kScale));
            make.left.equalTo(_searchBar.mas_right).offset(10 * kScale);
        }];
        
        [_searchBorderView addSubview:self.rightBtn];
        [self.rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_searchBorderView);
            make.left.equalTo(_searchBorderView).offset(12 * kScale);
        }];
    }
    return _searchBorderView;
}

- (UIButton *)cancleBtn {
    if (_cancleBtn == nil) {
        _cancleBtn = [[UIButton alloc] init];
        [_cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancleBtn setTitleColor:kUIColorFromRGB(0x358ee7) forState:UIControlStateNormal];
        [_cancleBtn.titleLabel setFont:[UIFont systemFontOfSize:14 * kScale]];
        [_cancleBtn addTarget:self action:@selector(cancleBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _cancleBtn.hidden = YES;
    }
    return _cancleBtn;
}

- (UILabel *)dscLb {
    if (_dscLb == nil) {
        _dscLb = [UILabel new];
        _dscLb.backgroundColor = [UIColor clearColor];
        _dscLb.textColor = kUIColorFromRGB(0xffffff);
        _dscLb.font = [UIFont systemFontOfSize:14 * kScale];
        _dscLb.numberOfLines = 0;
        _dscLb.preferredMaxLayoutWidth = MAIN_SCREEN_WIDTH - 30 * kScale;
    }
    return _dscLb;
}

- (UIView *)dscCoverView {
    if (_dscCoverView == nil) {
        _dscCoverView = [UIView new];
        _dscCoverView.backgroundColor = [UIColor clearColor];
        [_dscCoverView addSubview:self.dscLb];
        [self.dscLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_dscCoverView).offset(15 * kScale);
            make.right.equalTo(_dscCoverView).offset(-15 * kScale);
            make.bottom.equalTo(_dscCoverView).offset(-15 * kScale);
        }];
    }
    return _dscCoverView;
}

- (UIButton *)rightBtn {
    if (_rightBtn == nil) {
        _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rightBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -3, 0, 3)];
        [_rightBtn setTitle:@"只看个人股东" forState:UIControlStateNormal];
        _rightBtn.titleLabel.font = [UIFont systemFontOfSize:12 * kScale];
        [_rightBtn setTitleColor:kUIColorFromRGB(0x666666) forState:UIControlStateNormal];
        [_rightBtn setImage:[UIImage imageNamed:@"ic_pplsee_nor"] forState:UIControlStateNormal];
        [_rightBtn setImage:[UIImage imageNamed:@"ic_pplsee_selected"] forState:UIControlStateSelected];
        [_rightBtn addTarget:self action:@selector(rightBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightBtn;
}

- (UIImageView *)topBgImageView {
    if (_topBgImageView == nil) {
        _topBgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_genmai_nor"]];
    }
    return _topBgImageView;
}

- (UILabel *)noResultLb {
    if (_noResultLb == nil) {
        _noResultLb = [UILabel new];
        _noResultLb.textColor = kUIColorFromRGB(0x666666);
        _noResultLb.hidden = YES;
        _noResultLb.font = [UIFont systemFontOfSize:13 * kScale];
        _noResultLb.text = @"没有搜索到相关结果...";
    }
    return _noResultLb;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
