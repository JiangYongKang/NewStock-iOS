//
//  TigerDepartmentSearchController.m
//  NewStock
//
//  Created by 王迪 on 2017/2/27.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "TigerDepartmentSearchController.h"
#import "TaosSearchDepartmentViewController.h"
#import "TaoSearchHotWordAPI.h"
#import "ILRemoteSearchBar.h"

#import "TaoDepartmentInfoModel.h"

#import "AppDelegate.h"

static NSString *coverCellID = @"TigerCoverDepartCell";

@interface TigerDepartmentSearchController ()<ILRemoteSearchBarDelegate, UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) ILRemoteSearchBar *searchBar;

@property (nonatomic, strong) TaoSearchHotWordAPI *hotWordAPI;

@property (nonatomic, strong) NSArray <TaoDepartmentInfoModel *> *hotWordArray;

@property (nonatomic, strong) UITableView *coverTableView;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *resultArray;

@property (nonatomic, assign) BOOL bStartSearch;

@property (nonatomic, strong) UILabel *noResultLb;

@end

@implementation TigerDepartmentSearchController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"搜营业部";
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
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(borderView.mas_bottom);
    }];
    
    [self.tableView addSubview:self.noResultLb];
    [self.noResultLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.tableView);
    }];
    
    [self.view addSubview:self.coverTableView];
    [self.coverTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(borderView.mas_bottom);
    }];
    
}

#pragma loadData

- (void)getHotWords {
    [self.hotWordAPI start];
}

- (void)requestFailed:(APIBaseRequest *)request {

}

- (void)requestFinished:(APIBaseRequest *)request {
    
    self.hotWordArray = [MTLJSONAdapter modelsOfClass:[TaoDepartmentInfoModel class] fromJSONArray:[request.responseJSONObject objectForKey:@"yyb"] error:nil];
    
    [self.coverTableView reloadData];
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
        self.coverTableView.hidden = YES;
    } else {
        _bStartSearch = NO;
        self.coverTableView.hidden = NO;
    }
    
    [_resultArray removeAllObjects];
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
    dispatch_async(queue, ^{
        NSArray *array = [StockCodesInstance sharedStockCodesInstance].departmentArray;
        
        NSString *text = [searchText lowercaseString];
        for (int i = 0; i < [array count]; i++) {
            TaoDepartmentInfoModel* item = [array objectAtIndex:i];
            
            NSString *code = item.s;
            NSString *name = item.n;
            
            if([code containsString:text])//hasPrefix
            {
                [_resultArray addObject:item];
            }
            else if([name containsString:searchText])
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

#pragma mark action

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [_searchBar resignFirstResponder];
}

#pragma mark tableview delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    TaoDepartmentInfoModel *model = nil;
    
    if (tableView.tag) {
        model = self.resultArray[indexPath.row];
    } else {
        model = self.hotWordArray[indexPath.row];
    }

    CGRect rect = [model.n boundingRectWithSize:CGSizeMake(MAIN_SCREEN_WIDTH - 30 * kScale, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{
                   NSFontAttributeName : [UIFont systemFontOfSize:14 * kScale]
                   } context:nil];
    return rect.size.height + 30 * kScale;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (tableView.tag) {
        if (self.resultArray.count == 0) {
            self.noResultLb.hidden = NO;
        } else {
            self.noResultLb.hidden = YES;
        }
        return self.resultArray.count;
    } else {
        return self.hotWordArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TaoDepartmentInfoModel *model = nil;
    
    if (tableView.tag) {
        model = self.resultArray[indexPath.row];
    } else {
        model = self.hotWordArray[indexPath.row];
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:coverCellID];
    cell.textLabel.textColor = kUIColorFromRGB(0x358ee7);
    cell.textLabel.text = model.n;
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.preferredMaxLayoutWidth = MAIN_SCREEN_WIDTH - 30 * kScale;
    cell.textLabel.font = [UIFont systemFontOfSize:14 * kScale];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = (indexPath.row % 2)? kUIColorFromRGB(0xffffff) : kUIColorFromRGB(0xf5f5f5);
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TaoDepartmentInfoModel *model = nil;
    
    if (tableView.tag) {
        model = self.resultArray[indexPath.row];
    } else {
        model = self.hotWordArray[indexPath.row];
    }

    TaosSearchDepartmentViewController *vc = [TaosSearchDepartmentViewController new];
    vc.name = model.n;
    vc.startDate = @"";
    vc.endDate = @"";
    [self.view endEditing:YES];
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [delegate.navigationController pushViewController:vc animated:YES];
}

#pragma mark lazy

- (ILRemoteSearchBar *)searchBar {
    if (_searchBar == nil) {
        _searchBar = [[ILRemoteSearchBar alloc] init];
        _searchBar.delegate = self;
        _searchBar.placeholder = @"请输入要查询的营业部代码 / 名称";
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
        _hotWordAPI.code = @"yyb";
    }
    return _hotWordAPI;
}

- (UITableView *)coverTableView {
    if (_coverTableView == nil) {
        _coverTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _coverTableView.delegate = self;
        _coverTableView.dataSource = self;
        _coverTableView.tableFooterView = [UIView new];
        _coverTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        UILabel *headerLb = [[UILabel alloc]initWithFrame:CGRectMake(15 * kScale, 0, MAIN_SCREEN_WIDTH, 42 * kScale)];
        headerLb.textColor = kUIColorFromRGB(0x333333);
        headerLb.text = @"     热门营业部";
        headerLb.font = [UIFont systemFontOfSize:12 * kScale];
        _coverTableView.tableHeaderView = headerLb;
        [_coverTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:coverCellID];
    }
    return _coverTableView;
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tag = 1;
        _tableView.separatorInset = UIEdgeInsetsMake(0, 15, 0, 15);
        _tableView.tableFooterView = [UIView new];
        _tableView.bounces = NO;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:coverCellID];
        
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
