//
//  QuotationViewController.m
//  NewStock
//
//  Created by Willey on 16/7/23.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "QuotationViewController.h"
#import "StockTableViewCell.h"
#import "StockListViewController.h"
#import "AppDelegate.h"
#import "MarketConfig.h"
#import "StockChartViewController.h"
#import "IndexChartViewController.h"
#import "RankListAPI.h"
#import "NetWorking.h"
#import "UIView+Masonry_Arrange.h"
#import "IndexInfoAPI.h"
#import "Mantle.h"
#import "IndexInfoModel.h"
#import "SystemUtil.h"
#import "StockListModel.h"
#import "PlateRankView.h"

#import "MJChiBaoZiHeader.h"

#import "BoardListAPI.h"
#import "BoardListModel.h"

#import "IndexViewController.h"
#import "BoardViewController.h"
#import "BoardDetailListViewController.h"

@interface QuotationViewController ()<PlateRankViewDelegate>
{
    IndexInfoAPI *_indexInfoAPI;
    
    IndexInfoModel *_shIndexModel;
    IndexInfoModel *_szIndexModel;
    IndexInfoModel *_cybIndexModel;
    
    
    PlateRankView *_plateRankView;
    BoardListAPI *_boardListAPI;
    BoardListAPI *_boardListAPI2;
    NSMutableArray *_boardListArray;
    NSMutableArray *_boardListArray2;
    
    RankListAPI *_zfRankListAPI;
    RankListAPI *_dfRankListAPI;
    RankListAPI *_5minRankListAPI;
    RankListAPI *_volumeRankListAPI;
    RankListAPI *_turnoverRankListAPI;
    
    
    NSMutableArray *_zfRankListArray;
    NSMutableArray *_dfRankListArray;
    NSMutableArray *_5minRankListArray;
    NSMutableArray *_volumeRankListArray;
    NSMutableArray *_turnoverRankListArray;
}
@end

@implementation QuotationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    int padding1 = 3;
    int blockHeight = 90 * kScale;
    int blockWidth = (MAIN_SCREEN_WIDTH - padding1 * 4) / 3;
    int plateHeight = 222;
    int titleHeight = 32;
    
    
    [_scrollView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    //[self.view showPlaceHolderWithAllSubviews];
    [_mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_scrollView);
        make.width.equalTo(_scrollView);
        make.height.mas_equalTo(titleHeight*2 + blockHeight + padding1 * 0 + plateHeight + MARKET_CELL_HEIGHT * 25 + 40 * 5);
        //make.height.equalTo(_scrollView).multipliedBy(2.5);
    }];
    [_scrollView layoutIfNeeded];//
    
    //国内指数
    UIView *titleBarBg1 = [[UIView alloc] init];
    titleBarBg1.backgroundColor = kUIColorFromRGB(0xf1f1f1);
    [_mainView addSubview:titleBarBg1];
    [titleBarBg1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.equalTo(titleBarBg1.superview).with.offset(0);
        make.right.equalTo(titleBarBg1.superview).with.offset(0);
        make.height.mas_equalTo(titleHeight);
    }];
    //    [[titleBarBg1 layer] setBorderWidth:0.5];
    //    [[titleBarBg1 layer] setBorderColor:SEP_LINE_COLOR.CGColor];
    
    UILabel *titleLb1 = [[UILabel alloc] init];
    titleLb1.text = @"指数";
    titleLb1.font = [UIFont boldSystemFontOfSize:14];
    titleLb1.textColor = kUIColorFromRGB(0x333333);
    [titleBarBg1 addSubview:titleLb1];
    [titleLb1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(titleLb1.superview).with.insets(UIEdgeInsetsMake(0,10,0,100));
    }];
    
    UIButton *moreBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    moreBtn1.frame = CGRectMake(MAIN_SCREEN_WIDTH - 50, 0, 50, 30);
    [moreBtn1 setImage:[UIImage imageNamed:@"more_icon"] forState:UIControlStateNormal];
    [moreBtn1 addTarget:self action:@selector(moreBtnAction1:) forControlEvents:UIControlEventTouchUpInside];
    [titleBarBg1 addSubview:moreBtn1];
    
    
    UIView *indexBg = [[UIView alloc] init];
    indexBg.backgroundColor = [UIColor whiteColor];
    [_mainView addSubview:indexBg];
    [indexBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleBarBg1.mas_bottom).offset(0);
        make.right.equalTo(_mainView);
        make.left.equalTo(_mainView);
        make.height.mas_equalTo(blockHeight);
    }];
    //    [[indexBg layer] setBorderWidth:0.5];
    //    [[indexBg layer] setBorderColor:SEP_LINE_COLOR.CGColor];
    
    
    _shIndex = [[IndexBlock alloc] initWithDelegate:self tag:0];
    _szIndex = [[IndexBlock alloc] initWithDelegate:self tag:1];
    _cybIndex = [[IndexBlock alloc] initWithDelegate:self tag:2];
    
    
    [indexBg addSubview:_shIndex];
    [indexBg addSubview:_szIndex];
    [indexBg addSubview:_cybIndex];
    
    [_shIndex mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleBarBg1.mas_bottom).offset(0);
        //make.centerY.equalTo(@[_szIndex,_cybIndex]);
        make.size.mas_equalTo(CGSizeMake(blockWidth, blockHeight));
    }];
    
    [_szIndex mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleBarBg1.mas_bottom).offset(0);
        make.size.mas_equalTo(CGSizeMake(blockWidth, blockHeight));
    }];
    
    [_cybIndex mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleBarBg1.mas_bottom).offset(0);
        make.size.mas_equalTo(CGSizeMake(blockWidth, blockHeight));
    }];
    
    [_mainView distributeSpacingHorizontallyWith:@[_shIndex,_szIndex,_cybIndex]];
    
    UIView *line1 = [[UIView alloc] init];
    line1.backgroundColor = SEP_LINE_COLOR;
    [indexBg addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_shIndex.mas_top).offset(10);
        make.left.equalTo(_shIndex.mas_right);
        make.bottom.equalTo(_shIndex.mas_bottom).offset(-10);
        make.width.mas_equalTo(0.5);
    }];
    UIView *line2 = [[UIView alloc] init];
    line2.backgroundColor = SEP_LINE_COLOR;
    [indexBg addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_shIndex.mas_top).offset(10);
        make.left.equalTo(_szIndex.mas_right);
        make.bottom.equalTo(_shIndex.mas_bottom).offset(-10);
        make.width.mas_equalTo(0.5);
    }];
    
    
    //plate
    UIView *titleBarBg2 = [[UIView alloc] init];
    titleBarBg2.backgroundColor = kUIColorFromRGB(0xf1f1f1);
    [_mainView addSubview:titleBarBg2];
    [titleBarBg2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(indexBg.mas_bottom).offset(0);
        make.left.equalTo(titleBarBg2.superview).with.offset(0);
        make.right.equalTo(titleBarBg2.superview).with.offset(0);
        make.height.mas_equalTo(titleHeight);
    }];
    //    [[titleBarBg2 layer] setBorderWidth:0.5];
    //    [[titleBarBg2 layer] setBorderColor:SEP_LINE_COLOR.CGColor];
    
    UILabel *titleLb2 = [[UILabel alloc] init];
    titleLb2.text = @"领涨板块";
    titleLb2.font = [UIFont boldSystemFontOfSize:14];
    titleLb2.textColor = kUIColorFromRGB(0x333333);
    [titleBarBg2 addSubview:titleLb2];
    [titleLb2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(titleLb2.superview).with.insets(UIEdgeInsetsMake(0,10,0,100));
    }];
    
    UIButton *moreBtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    moreBtn2.frame = CGRectMake(MAIN_SCREEN_WIDTH - 50, 0, 50, 30);
    [moreBtn2 setImage:[UIImage imageNamed:@"more_icon"] forState:UIControlStateNormal];
    [moreBtn2 addTarget:self action:@selector(moreBtnAction2:) forControlEvents:UIControlEventTouchUpInside];
    [titleBarBg2 addSubview:moreBtn2];
    
    
    _plateRankView = [[PlateRankView alloc] init];
    _plateRankView.backgroundColor = [UIColor whiteColor];
    _plateRankView.delegate = self;
    [_mainView addSubview:_plateRankView];
    [_plateRankView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleBarBg2.mas_bottom).offset(0);
        make.right.equalTo(_mainView);
        make.left.equalTo(_mainView);
        make.height.mas_equalTo(plateHeight);
    }];
    
    
    
    ///
    _tableview = [[SKSTableView alloc] init];

    _tableview.SKSTableViewDelegate = self;
    _tableview.separatorInset = UIEdgeInsetsMake(0, 15, 0, 15);
    _tableview.tableFooterView = [UIView new];
    [_mainView addSubview:_tableview];
    [_tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_tableview.superview).with.insets(UIEdgeInsetsMake(titleHeight * 2 + blockHeight + plateHeight + padding1 * 0, 0, 0, 0));
    }];
    _tableview.bounces = NO;
    _tableview.scrollEnabled = NO;
    //
    _indexInfoAPI = [[IndexInfoAPI alloc] initWithSymbolTyp:@"" symbol:@"" marketCd:@""];
    
    _zfRankListAPI = [[RankListAPI alloc] initWithRankName:@"03" upDown:@"0" fromNo:1 toNo:5];
    _dfRankListAPI = [[RankListAPI alloc] initWithRankName:@"03" upDown:@"1" fromNo:1 toNo:5];
    _5minRankListAPI = [[RankListAPI alloc] initWithRankName:@"02" upDown:@"0" fromNo:1 toNo:5];
    _volumeRankListAPI = [[RankListAPI alloc] initWithRankName:@"07" upDown:@"0" fromNo:1 toNo:5];
    _turnoverRankListAPI = [[RankListAPI alloc] initWithRankName:@"05" upDown:@"0" fromNo:1 toNo:5];
    
    
    //
    _boardListAPI = [[BoardListAPI alloc] initWithCategory:@"10" upDown:@"0" fromNo:1 toNo:5];
    _boardListAPI2 = [[BoardListAPI alloc] initWithCategory:@"30" upDown:@"0" fromNo:1 toNo:5];
    _boardListArray = [[NSMutableArray alloc] init];
    _boardListArray2 = [[NSMutableArray alloc] init];
    
    //
    _zfRankListArray = [[NSMutableArray alloc] init];
    _dfRankListArray = [[NSMutableArray alloc] init];
    _5minRankListArray = [[NSMutableArray alloc] init];
    _volumeRankListArray = [[NSMutableArray alloc] init];
    _turnoverRankListArray = [[NSMutableArray alloc] init];
    
    
    //    [_shIndex setCode:@"" title:@"上证指数" value:@"--.--" change:@"--.--" changeRate:@"--.--"];
    //    [_szIndex setCode:@"" title:@"创业板指" value:@"--.--" change:@"--.--" changeRate:@"--.--"];
    //    [_cybIndex setCode:@"" title:@"深证指数" value:@"--.--" change:@"--.--" changeRate:@"--.--"];
    
    _scrollView.mj_header = [MJChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    _scrollView.backgroundColor = REFRESH_BG_COLOR;
    _mainView.backgroundColor = REFRESH_BG_COLOR;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self loadData];
    });
}

- (void)moreBtnAction1:(UIButton *)sender {
    
    IndexViewController *viewController = [[IndexViewController alloc] init];
    viewController.title = @"指数";
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate.navigationController pushViewController:viewController animated:YES];
}
- (void)moreBtnAction2:(UIButton *)sender {
    BoardViewController *viewController = [[BoardViewController alloc] init];
    viewController.title = @"板块";
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate.navigationController pushViewController:viewController animated:YES];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (NSInteger)tableView:(SKSTableView *)tableView numberOfSubRowsAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0)
    {
        return 5;
        //return [_zfRankListArray count];
    }
    else if(indexPath.row == 1)
    {
        return 5;
        //return [_dfRankListArray count];
    }
    else if(indexPath.row == 2)
    {
        return 5;
        //return [_5minRankListArray count];
    }
    else if(indexPath.row == 3)
    {
        return 5;
        //return [_volumeRankListArray count];
    }
    else if(indexPath.row == 4)
    {
        return 5;
        //return [_turnoverRankListArray count];
    }
    
    return 0;
}

- (BOOL)tableView:(SKSTableView *)tableView shouldExpandSubRowsOfCellAtIndexPath:(NSIndexPath *)indexPath {
    
    return YES;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"StockTitleTableViewCell";
    
    StockTitleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell)
    {
        cell = [[StockTitleTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.delegate = self;
    }
    
    switch (indexPath.row)
    {
        case 0:
            cell.textLabel.text = @"涨幅榜";
            break;
        case 1:
            cell.textLabel.text = @"跌幅榜";
            break;
        case 2:
            cell.textLabel.text = @"5分钟涨幅榜";
            break;
        case 3:
            cell.textLabel.text = @"换手率榜";
            break;
        case 4:
            cell.textLabel.text = @"成交额榜";
            break;
            
        default:
            cell.textLabel.text = @"";
            
            break;
    }
    //cell.expandable = YES;
    cell.tag = indexPath.row;
    cell.textLabel.font = [UIFont systemFontOfSize:12];
    cell.textLabel.textColor = [UIColor darkGrayColor];
    
    //    if ((indexPath.section == 0 && (indexPath.row == 1 || indexPath.row == 0)) || (indexPath.section == 1 && (indexPath.row == 0 || indexPath.row == 2)))
    //        cell.expandable = YES;
    //    else
    //        cell.expandable = NO;
    
    cell.expandedColor = kUIColorFromRGB(0x358ee7);
    cell.planColor = kUIColorFromRGB(0x666666);
    
    //    [[cell layer] setBorderWidth:0.5];
    //    [[cell layer] setBorderColor:SEP_LINE_COLOR.CGColor];
    return cell;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForSubRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"UITableViewCell";
    
    StockTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell)
        cell = [[StockTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
    //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    long index = indexPath.subRow-1;
    StockListModel *model;
    if (indexPath.row == 0)
    {
        if ([_zfRankListArray count]<5)
        {
            model = nil;
        }
        else
        {
            model = [_zfRankListArray objectAtIndex:index];
        }
    }
    else if (indexPath.row == 1)
    {
        if ([_dfRankListArray count]<5)
        {
            model = nil;
        }
        else
        {
            model = [_dfRankListArray objectAtIndex:index];
        }
    }
    else if (indexPath.row == 2)
    {
        if ([_5minRankListArray count]<5)
        {
            model = nil;
        }
        else
        {
            model = [_5minRankListArray objectAtIndex:index];
        }
    }
    else if (indexPath.row == 3)
    {
        if ([_turnoverRankListArray count]<5)
        {
            model = nil;
        }
        else
        {
            model = [_turnoverRankListArray objectAtIndex:index];
        }
    }
    else if (indexPath.row == 4)
    {
        if ([_volumeRankListArray count]<5)
        {
            model = nil;
        }
        else
        {
            model = [_volumeRankListArray objectAtIndex:index];
        }
    }
    
    if (model) {
        
        [cell setCode:model.symbol name:model.symbolName value:model.consecutivePresentPrice changeRate:[SystemUtil getPercentage:[model.tradeIncrease doubleValue]] marketCd:model.marketCd];
        
        if (indexPath.row == 3)
        {
            [cell setTurnover:model.turnover];
        }
        else if(indexPath.row == 4)
        {
            [cell setVoluem:model.volumePrice];
        }
        else if(indexPath.row == 2)
        {
            [cell setMin5UpDown:[SystemUtil getPercentage:[model.min5UpDown doubleValue]]];
        }
        
    }
    else
    {
        [cell setCode:@"--" name:@"--" value:@"--" changeRate:@"--" marketCd:@"--"];
    }
    
    return cell;
}

- (CGFloat)tableView:(SKSTableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 30 + 10;
}

- (CGFloat)tableView:(SKSTableView *)tableView heightForSubRowAtIndexPath:(NSIndexPath *)indexPath {
    return MARKET_CELL_HEIGHT;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    NSLog(@"Section: %ld, Row:%ld, Subrow:%ld", indexPath.section, indexPath.row, indexPath.subRow);
}

- (void)tableView:(SKSTableView *)tableView didSelectSubRowAtIndexPath:(NSIndexPath *)indexPath {
//    NSLog(@"Section: %ld, Row:%ld, Subrow:%ld", indexPath.section, indexPath.row, indexPath.subRow);
    
    StockChartViewController *viewController = [[StockChartViewController alloc] init];
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    StockListModel *model;
    long index = indexPath.subRow-1;
    if (indexPath.row == 0) {
        if ([_zfRankListArray count]<5)
        {
            model = nil;
        }
        else
        {
            model = [_zfRankListArray objectAtIndex:index];
        }
    }
    else if (indexPath.row == 1) {
        if ([_dfRankListArray count]<5)
        {
            model = nil;
        }
        else
        {
            model = [_dfRankListArray objectAtIndex:index];
        }
    }
    else if (indexPath.row == 2) {
        if ([_5minRankListArray count]<5)
        {
            model = nil;
        }
        else
        {
            model = [_5minRankListArray objectAtIndex:index];
        }
    }
    else if (indexPath.row == 3) {
        if ([_turnoverRankListArray count]<5)
        {
            model = nil;
        }
        else
        {
            model = [_turnoverRankListArray objectAtIndex:index];
        }
    }
    else if (indexPath.row == 4) {
        if ([_volumeRankListArray count]<5)
        {
            model = nil;
        }
        else
        {
            model = [_volumeRankListArray objectAtIndex:index];
        }
    }
    
    if(model) {
        if (!(model.symbol && model.symbolTyp && model.marketCd && model.symbolName)) {
            return;
        }
        viewController.stockListModel = model;
        [appDelegate.navigationController pushViewController:viewController animated:YES];
    }
    
}

#pragma mark - Actions
- (void)stockTitleTableViewCell:(StockTitleTableViewCell *)cell selectedIndex:(NSUInteger)index {
//    NSLog(@"more action:%ld",index);
    
    StockListViewController *viewController = [[StockListViewController alloc] init];
    
    switch (index) {
        case 0:
            viewController.title = @"涨幅榜";
            viewController.RankType = RankType_ZF;
            break;
        case 1:
            viewController.title = @"跌幅榜";
            viewController.RankType = RankType_DF;
            break;
        case 2:
            viewController.title = @"5分钟涨幅榜";
            viewController.RankType = RankType_5MIN;
            break;
        case 3:
            viewController.title = @"换手率榜";
            viewController.RankType = RankType_TURNOVER;
            break;
        case 4:
            viewController.title = @"成交额榜";
            viewController.RankType = RankType_VOLUME;
            break;
            
        default:
            viewController.title = @"";
            break;
    }
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate.navigationController pushViewController:viewController animated:YES];
}

- (void)loadNewData {
    [self loadData];
}

- (void)loadData {
    _zfRankListAPI.ignoreCache = YES;
//    NSLog(@"%@",_zfRankListAPI.requestHeaderFieldValueDictionary);
    [_zfRankListAPI startWithCompletionBlockWithSuccess:^(APIBaseRequest *request) {
        NSArray *array = [_zfRankListAPI.responseJSONObject objectForKey:@"rankingLst"];
        [_zfRankListArray removeAllObjects];
        NSArray *modelArray = [MTLJSONAdapter modelsOfClass:[StockListModel class] fromJSONArray:array error:nil];
        [_zfRankListArray addObjectsFromArray:modelArray];
        
        [_tableview reloadData];
    } failure:^(APIBaseRequest *request) {
        NSLog(@"failed");
    }];
    
    //跌幅
    _dfRankListAPI.ignoreCache = YES;
    [_dfRankListAPI startWithCompletionBlockWithSuccess:^(APIBaseRequest *request) {
        NSArray *array = [_dfRankListAPI.responseJSONObject objectForKey:@"rankingLst"];
        [_dfRankListArray removeAllObjects];
        NSArray *modelArray = [MTLJSONAdapter modelsOfClass:[StockListModel class] fromJSONArray:array error:nil];
        [_dfRankListArray addObjectsFromArray:modelArray];
        
        [_tableview reloadData];
        
    } failure:^(APIBaseRequest *request) {
        NSLog(@"failed");
    }];
    
    //5分钟涨幅
    _5minRankListAPI.ignoreCache = YES;
    [_5minRankListAPI startWithCompletionBlockWithSuccess:^(APIBaseRequest *request) {
        NSArray *array = [_5minRankListAPI.responseJSONObject objectForKey:@"rankingLst"];
        [_5minRankListArray removeAllObjects];
        NSArray *modelArray = [MTLJSONAdapter modelsOfClass:[StockListModel class] fromJSONArray:array error:nil];
        [_5minRankListArray addObjectsFromArray:modelArray];
        
        [_tableview reloadData];
        
    } failure:^(APIBaseRequest *request) {
        NSLog(@"failed");
    }];
    
    //成交额
    _volumeRankListAPI.ignoreCache = YES;
    [_volumeRankListAPI startWithCompletionBlockWithSuccess:^(APIBaseRequest *request) {
        NSArray *array = [_volumeRankListAPI.responseJSONObject objectForKey:@"rankingLst"];
        [_volumeRankListArray removeAllObjects];
        NSArray *modelArray = [MTLJSONAdapter modelsOfClass:[StockListModel class] fromJSONArray:array error:nil];
        [_volumeRankListArray addObjectsFromArray:modelArray];
        
        [_tableview reloadData];
        
    } failure:^(APIBaseRequest *request) {
        NSLog(@"failed");
    }];
    
    //换手率
    _turnoverRankListAPI.ignoreCache = YES;
    [_turnoverRankListAPI startWithCompletionBlockWithSuccess:^(APIBaseRequest *request) {
        NSArray *array = [_turnoverRankListAPI.responseJSONObject objectForKey:@"rankingLst"];
        [_turnoverRankListArray removeAllObjects];
        NSArray *modelArray = [MTLJSONAdapter modelsOfClass:[StockListModel class] fromJSONArray:array error:nil];
        [_turnoverRankListArray addObjectsFromArray:modelArray];
        
        [_tableview reloadData];
        
    } failure:^(APIBaseRequest *request) {
        NSLog(@"failed");
    }];
    
    
    [_indexInfoAPI startWithCompletionBlockWithSuccess:^(APIBaseRequest *request) {
        
        NSArray * array = [MTLJSONAdapter modelsOfClass:[IndexInfoModel class] fromJSONArray:_indexInfoAPI.responseJSONObject error:nil];
        
        for (int i=0; i<[array count]; i++)
        {
            IndexInfoModel *model = [array objectAtIndex:i];
//            NSLog(@"%@",model);
            if([model.symbol isEqualToString:@"000001"])
            {
                _shIndexModel = model;
                [_shIndex setCode:@"" title:model.symbolName value:[SystemUtil getPrecisionPrice:[model.consecutivePresentPrice doubleValue] precision:[model.pricePrecision intValue]] change:[NSString stringWithFormat:@"%.2f",[model.stockUD doubleValue]] changeRate:[SystemUtil getPercentage:[model.tradeIncrease doubleValue]]];
            }
            else if([model.symbol isEqualToString:@"399001"])
            {
                _szIndexModel = model;
                [_szIndex setCode:@"" title:model.symbolName value:[SystemUtil getPrecisionPrice:[model.consecutivePresentPrice doubleValue] precision:[model.pricePrecision intValue]] change:[NSString stringWithFormat:@"%.2f",[model.stockUD doubleValue]] changeRate:[SystemUtil getPercentage:[model.tradeIncrease doubleValue]]];
            }
            else if([model.symbol isEqualToString:@"399006"])
            {
                _cybIndexModel = model;
                [_cybIndex setCode:@"" title:model.symbolName value:[SystemUtil getPrecisionPrice:[model.consecutivePresentPrice doubleValue] precision:[model.pricePrecision intValue]] change:[NSString stringWithFormat:@"%.2f",[model.stockUD doubleValue]] changeRate:[SystemUtil getPercentage:[model.tradeIncrease doubleValue]]];
            }
        }
        [_scrollView.mj_header endRefreshing];
        
    } failure:^(APIBaseRequest *request) {
        NSLog(@"failed");
        [_scrollView.mj_header endRefreshing];
        
    }];
    
    
    
    
    
    _boardListAPI.ignoreCache = YES;
    [_boardListAPI startWithCompletionBlockWithSuccess:^(APIBaseRequest *request) {
        NSArray *array = [_boardListAPI.responseJSONObject objectForKey:@"rankingLst"];
        [_boardListArray removeAllObjects];
        NSArray *modelArray = [MTLJSONAdapter modelsOfClass:[BoardListModel class] fromJSONArray:array error:nil];
        [_boardListArray addObjectsFromArray:modelArray];
        
        [_plateRankView setConceptModels:_boardListArray];
        
    } failure:^(APIBaseRequest *request) {
        NSLog(@"failed");
        [_scrollView.mj_header endRefreshing];
        
    }];
    
    //2
    [_boardListAPI2 startWithCompletionBlockWithSuccess:^(APIBaseRequest *request) {
        NSArray *array = [_boardListAPI2.responseJSONObject objectForKey:@"rankingLst"];
        [_boardListArray2 removeAllObjects];
        NSArray *modelArray = [MTLJSONAdapter modelsOfClass:[BoardListModel class] fromJSONArray:array error:nil];
        [_boardListArray2 addObjectsFromArray:modelArray];
        
        [_plateRankView setIndustryModels:_boardListArray2];
        
    } failure:^(APIBaseRequest *request) {
        NSLog(@"failed");
    }];
}

#pragma IndexBlockDelegate
- (void)indexBlock:(IndexBlock*)indexBlock code:(NSString *)code {
    
    IndexChartViewController *viewController = [[IndexChartViewController alloc] init];
    
    switch (indexBlock.tag) {
        case 0:
        {
            //viewController.title = @"上证指数";
            viewController.indexModel = _shIndexModel;
            break;
        }
        case 1:
        {
            //viewController.title = @"深证指数";
            viewController.indexModel = _szIndexModel;
            break;
        }
        case 2:
        {
            //viewController.title = @"创业板指";
            viewController.indexModel = _cybIndexModel;
            break;
        }
        default:
            break;
    }
    if (!viewController.indexModel) return;
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate.navigationController pushViewController:viewController animated:YES];
}

#pragma PlateRankViewDelegate
- (void)plateRankView:(PlateRankView*)plateRankView selectModel:(BoardListModel *)model {
    if (model.industryName.length == 0) {
        return;
    }
    BoardDetailListViewController *viewController = [[BoardDetailListViewController alloc] init];
    viewController.title = model.industryName;
    viewController.boardListModel = model;
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate.navigationController pushViewController:viewController animated:YES];
}


@end
