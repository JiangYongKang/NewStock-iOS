//
//  SearchViewController.m
//  NewStock
//
//  Created by Willey on 16/7/28.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "SearchViewController.h"
#import "StockCodesInstance.h"
#import "AppDelegate.h"

#import "IndexChartViewController.h"
#import "StockChartViewController.h"

#import "StockHistoryUtil.h"
#import "MarketConfig.h"

#import "UIImage+RoundRectImage.h"

@interface SearchViewController ()

@property (nonatomic, strong) UILabel *noResultLb;

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"股票查询";
//    [_navBar setTitle:self.title];
    [_navBar setRightBtnTitle:@"取消"];
    [_navBar setLeftBtnImg:nil];
    
    [_scrollView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(NAV_BAR_HEIGHT, 0, 0, 0));
    }];
    [_scrollView layoutIfNeeded];
    
    _searchBar = [[ILRemoteSearchBar alloc] init];
    _searchBar.delegate = self;
    _searchBar.placeholder = @"请输入股票代码/字母";
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
    UIImage* clearImg = [SystemUtil imageWithColor:kUIColorFromRGB(0xf3f3f3) andHeight:30.0f];
    clearImg = [UIImage createRoundedRectImage:clearImg size:CGSizeMake(290, 30) radius:15];
    [_searchBar setSearchFieldBackgroundImage:clearImg forState:UIControlStateNormal];
    [_searchBar setBackgroundColor:[UIColor clearColor]];

    //placeholder
    UITextField * searchField = [_searchBar valueForKey:@"_searchField"];
    [searchField setValue:kUIColorFromRGB(0x999999) forKeyPath:@"_placeholderLabel.textColor"];
    [searchField setValue:[UIFont systemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    [_searchBar setImage:[UIImage imageNamed:@"black_search_nor"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];

    _bStartSearch = NO;
    _resultArray = [[NSMutableArray alloc] init];
    _historyArray = [[NSMutableArray alloc] init];
    
    _tableView = [[UITableView alloc] init];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorInset = UIEdgeInsetsMake(0, 15, 0, 15);
    _tableView.tableFooterView = [UIView new];
    _tableView.bounces = NO;
    [_mainView addSubview:_tableView];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_tableView.superview).with.insets(UIEdgeInsetsMake(10, 0, 0, 0));
    }];
    
    [_tableView addSubview:self.noResultLb];
    [self.noResultLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(_tableView);
    }];
    
    
    
    //_addMyStockAPI = [[AddMyStockAPI alloc] init];
    _mainView.backgroundColor = [UIColor whiteColor];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [_historyArray removeAllObjects];
    NSMutableArray *array = [StockHistoryUtil getStockHistory];
    [_historyArray addObjectsFromArray:array];
    
    [_tableView reloadData];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (![_searchBar isFirstResponder]) {
        [_searchBar becomeFirstResponder];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [_searchBar resignFirstResponder];
}

# pragma mark - ILRemoteSearchBarDelegate
- (void)remoteSearchBar:(ILRemoteSearchBar *)searchBar textDidChange:(NSString *)searchText {
    NSLog(@"search text: %@",searchText);
    
    //[self performSelectorOnMainThread:@selector(search:) withObject:@"searchText" waitUntilDone:NO];

    [self search:searchText];
    [_tableView reloadData];
}

#pragma mark - UISearchBarDelegate
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    NSLog(@"search bar text did begin editing");
}

- (void)search:(NSString *)searchText {
    if (searchText.length>0)
    {
        _bStartSearch = YES;
    }
    else
    {
        _bStartSearch = NO;
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

#pragma UITableView
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 45;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_bStartSearch) {
        if (_resultArray.count == 0) {
            _noResultLb.hidden = NO;
        } else {
            _noResultLb.hidden = YES;
        }
        return [_resultArray count];
    } else {
        return [_historyArray count];
    }
}
- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30.0;
}
- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (_bStartSearch)
    {
        return @"搜索结果";
    }
    else
    {
        return @"最近浏览";
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 24)];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, tableView.frame.size.width, 24)];
    label.font = [UIFont systemFontOfSize:12.0f];
    label.textColor = kUIColorFromRGB(0x666666);
    label.textAlignment = NSTextAlignmentLeft;  //文本对齐方式
    [label setBackgroundColor:[UIColor clearColor]];
    label.text = [self tableView:tableView titleForHeaderInSection:section];
    [headerView setBackgroundColor:[UIColor whiteColor]];
    [headerView addSubview:label];
    
    //上方线条
    UIView *lineView = [UIView new];
    lineView.backgroundColor = kUIColorFromRGB(0xd3d3d3);
    [headerView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@0.5);
        make.right.bottom.left.equalTo(headerView);
    }];
    
    return  headerView;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellid=@"stockListViewCell";
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellid];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];

        [btn setImage:[UIImage imageNamed:@"self_add_stock"] forState:UIControlStateNormal];
        btn.frame = CGRectMake(0, 0, 30, 30);
        [btn addTarget:self action:@selector(addAction:) forControlEvents:UIControlEventTouchUpInside];
        cell.accessoryView = btn;
    }
    NSArray *array;
    if (_bStartSearch)
    {
        array = _resultArray;
    }
    else
    {
        array = _historyArray;
    }
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
    
    if ([item.m intValue]==1)
    {
        cell.detailTextLabel.text = [NSString stringWithFormat:@"SH%@",item.s];
    }
    else if ([item.m intValue]==2)
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
    
    NSArray *array;
    if (_bStartSearch)
    {
        array = _resultArray;
    }
    else
    {
        array = _historyArray;
    }
    
    StockCodeInfo* item = [array objectAtIndex:indexPath.row];
    
    if (!(item.m && item.s && item.t && item.n)) {
        return;
    }
    
    if (([item.t intValue]==1)||([item.t intValue]==2))
    {
        IndexChartViewController *viewController = [[IndexChartViewController alloc] init];
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        
        IndexInfoModel *model = [[IndexInfoModel alloc] init];
        model.marketCd = item.m;
        model.symbol = item.s;
        model.symbolName = item.n;
        model.symbolTyp = item.t;
       
        viewController.indexModel = model;
        [appDelegate.navigationController pushViewController:viewController animated:YES];
    }
    else //if ([item.t intValue]==3)
    {
        StockChartViewController *viewController = [[StockChartViewController alloc] init];
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        
        StockListModel *model = [[StockListModel alloc] init];
        model.marketCd = item.m;
        model.symbol = item.s;
        model.symbolName = item.n;
        model.symbolTyp = item.t;
        
        viewController.stockListModel = model;
        [appDelegate.navigationController pushViewController:viewController animated:YES];
    }
}

- (void)addAction:(UIButton *)sender {
    
    NSArray *array;
    if (_bStartSearch)
    {
        array = _resultArray;
    }
    else
    {
        array = _historyArray;
    }
    
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

- (void)navBar:(NavBar *)navBar rightButtonTapped:(UIButton *)sender {

    [self.navigationController popViewControllerAnimated:YES];
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
