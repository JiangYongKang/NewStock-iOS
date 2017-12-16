//
//  TigerStockSearchController.m
//  NewStock
//
//  Created by 王迪 on 2017/2/27.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "TigerStockSearchController.h"
#import "TaoSearchStockViewController.h"
#import "TaoSearchHotWordAPI.h"
#import "ILRemoteSearchBar.h"
#import "StockHistoryUtil.h"
#import "TaoHotStockModel.h"
#import "AppDelegate.h"

@interface TigerStockSearchController ()<ILRemoteSearchBarDelegate, UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) TaoSearchHotWordAPI *hotWordAPI;

@property (nonatomic, strong) NSArray <TaoHotStockModel *> *hotWordArray;

@property (nonatomic, strong) NSMutableArray *resultArray;

@property (nonatomic, strong) ILRemoteSearchBar *searchBar;

@property (nonatomic, assign) BOOL bStartSearch;

@property (nonatomic, strong) UIView *hotCoverView;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UILabel *noResultLb;

@end

@implementation TigerStockSearchController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"搜个股";
    [_scrollView removeFromSuperview];
    _navBar.hidden = YES;
    
    _resultArray = [NSMutableArray array];
    
    [self setupUI];
    
    [self getHotWords];
}

- (void)setupUI {
    UIView *borderView = [[UIView alloc] init];
    [self.view addSubview:borderView];
    borderView.backgroundColor = kUIColorFromRGB(0xf1f1f1);
    [borderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.right.equalTo(self.view);
        make.height.equalTo(@(52 * kScale));
    }];
    
    [borderView addSubview:self.searchBar];
    [self.searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(borderView);
        make.width.equalTo(borderView).offset(-30 * kScale);
        make.height.equalTo(@(32 * kScale));
    }];
    [self.view addSubview:self.tableView];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(borderView.mas_bottom).offset(0 * kScale);
    }];
    
    [_tableView addSubview:self.noResultLb];
    [self.noResultLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(_tableView);
    }];

    [self.view addSubview:self.hotCoverView];
    [self.hotCoverView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(borderView.mas_bottom).offset(0 * kScale);
    }];
}

#pragma loadData

- (void)getHotWords {
    [self.hotWordAPI start];
}

- (void)requestFailed:(APIBaseRequest *)request {
    
}

- (void)requestFinished:(APIBaseRequest *)request {
    self.hotWordArray = [MTLJSONAdapter modelsOfClass:[TaoHotStockModel class] fromJSONArray:[request.responseJSONObject objectForKey:@"stock"] error:nil];
    NSLog(@"%@",self.hotWordArray);
}

#pragma mark analyise data 

- (void)setHotWordArray:(NSArray<TaoHotStockModel *> *)hotWordArray {
    _hotWordArray = hotWordArray;
    for (int i = 0; i < hotWordArray.count; i ++) {
        TaoHotStockModel *model = hotWordArray[i];
        
        UILabel *lb = [UILabel new];
        lb.tag = i;
        lb.text = model.n;
        lb.textColor = kUIColorFromRGB(0x358ee7);
        lb.font = [UIFont systemFontOfSize:15 * kScale];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        lb.userInteractionEnabled = YES;
        [lb addGestureRecognizer:tap];
        NSInteger row = i / 4;
        NSInteger col = i % 4;
        CGFloat x = 15 + 90 * col;
        CGFloat y = 42 + 34 * row;
        [self.hotCoverView addSubview:lb];
        [lb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.hotCoverView).offset(x * kScale);
            make.top.equalTo(self.hotCoverView).offset(y * kScale);
        }];
    }
}

# pragma mark - ILRemoteSearchBarDelegate
- (void)remoteSearchBar:(ILRemoteSearchBar *)searchBar textDidChange:(NSString *)searchText {
    NSLog(@"search text: %@",searchText);
    
    [self search:searchText];
    [_tableView reloadData];
}

#pragma mark - UISearchBarDelegate
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    NSLog(@"search bar text did begin editing");
}

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
            
            if([_resultArray count] > 20)
            {
                break;
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [_tableView reloadData];
        });
    });
    
}

#pragma mark tableview delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 45;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.resultArray.count == 0) {
        self.noResultLb.hidden = NO;
    } else {
        self.noResultLb.hidden = YES;
    }
    return self.resultArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellid = @"stockListViewCell";
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    StockCodeInfo* item = _resultArray[indexPath.row];
    TaoSearchStockViewController *vc = [TaoSearchStockViewController new];
    vc.n = item.n;
    vc.s = item.s;
    vc.t = item.t;
    vc.m = item.m;
    vc.d = @"";
    [self.view endEditing:YES];
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [delegate.navigationController pushViewController:vc animated:YES];
}

#pragma mark - action

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [_searchBar resignFirstResponder];
}

- (void)tap:(UITapGestureRecognizer *)tap {
    TaoHotStockModel *model = self.hotWordArray[tap.view.tag];
    TaoSearchStockViewController *vc = [TaoSearchStockViewController new];
    vc.t = model.t;
    vc.s = model.s;
    vc.n = model.n;
    vc.m = model.m;
    vc.d = @"";
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [self.view endEditing:YES];
    [delegate.navigationController pushViewController:vc animated:YES];
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

#pragma mark ------

- (ILRemoteSearchBar *)searchBar {
    if (_searchBar == nil) {
        _searchBar = [[ILRemoteSearchBar alloc] init];
        _searchBar.delegate = self;
        _searchBar.placeholder = @"请输入要查询的股票代码 / 名称";
        [_navBar addSubview:_searchBar];
        
        [_searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_searchBar.superview).offset(27);
            make.left.equalTo(_searchBar.superview).offset(15);
            make.width.equalTo(_searchBar.superview).multipliedBy(0.8);
            make.height.mas_equalTo(30);
        }];
        UIImage* tfBgImg = [SystemUtil imageWithColor:[UIColor whiteColor] andHeight:30.0f];
        [_searchBar setBackgroundImage:tfBgImg];
        
        //searchbar背景
        UIImage* clearImg = [SystemUtil imageWithColor:kUIColorFromRGB(0xffffff) andHeight:30.0f];
        [_searchBar setSearchFieldBackgroundImage:clearImg forState:UIControlStateNormal];
        [_searchBar setBackgroundColor:[UIColor clearColor]];
        
        //placeholder
        UITextField * searchField = [_searchBar valueForKey:@"_searchField"];
        [searchField setValue:kUIColorFromRGB(0x999999) forKeyPath:@"_placeholderLabel.textColor"];
        [searchField setValue:[UIFont systemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
        [_searchBar setImage:[UIImage imageNamed:@"ic_search_nor"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
    }
    return _searchBar;
}

- (TaoSearchHotWordAPI *)hotWordAPI {
    if (_hotWordAPI == nil) {
        _hotWordAPI = [TaoSearchHotWordAPI new];
        _hotWordAPI.delegate = self;
        _hotWordAPI.code = @"stock";
    }
    return _hotWordAPI;
}

- (UIView *)hotCoverView {
    if (_hotCoverView == nil) {
        _hotCoverView = [[UIView alloc] init];
        _hotCoverView.backgroundColor = [UIColor whiteColor];
        UILabel *lb = [UILabel new];
        lb.textColor = kUIColorFromRGB(0x333333);
        lb.font = [UIFont systemFontOfSize:12 * kScale];
        lb.text = @"热门股票";
        
        [_hotCoverView addSubview:lb];
        [lb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(_hotCoverView).offset(15 * kScale);
        }];
    }
    return _hotCoverView;
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorInset = UIEdgeInsetsMake(0, 15, 0, 15);
        _tableView.tableFooterView = [UIView new];
        _tableView.bounces = NO;
        [_mainView addSubview:_tableView];
    
    }
    return _tableView;
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

@end
