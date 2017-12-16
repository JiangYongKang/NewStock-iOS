//
//  TaoSearchStockViewController.m
//  NewStock
//
//  Created by 王迪 on 2017/2/22.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "TaoSearchStockViewController.h"
#import "IndexChartViewController.h"
#import "StockChartViewController.h"
#import "TaosSearchDepartmentViewController.h"

#import "TaoSearchStockAPI.h"
#import "TaoSearchStockModel.h"
#import "TaoDateList.h"
#import "YearModel.h"
#import "WDHorButton.h"

#import "TaoSearchStockCell.h"

static NSString *cellID = @"taoSearchCellID";

@interface TaoSearchStockViewController ()<UITableViewDelegate,UITableViewDataSource,UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic, strong) TaoSearchStockAPI *searchAPI;

@property (nonatomic, strong) UILabel *topLabel1;
@property (nonatomic, strong) UILabel *topLabel2;
@property (nonatomic, strong) WDHorButton *calenderBtn;

@property (nonatomic, strong) TaoDateList *taoDateListAPI;
@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, strong) NSArray *yearArray;
@property (nonatomic, strong) NSArray *dataYearArr;
@property (nonatomic, strong) NSArray *dataMonthArr;
@property (nonatomic, strong) NSArray *dataDayArr;
@property (nonatomic, strong) UIView *coverView;
@property (nonatomic, strong) UIView *pickerTopView;

@property (nonatomic, strong) UILabel *line1;
@property (nonatomic, strong) UILabel *line2;
@property (nonatomic, strong) UILabel *line3;
@property (nonatomic, strong) UILabel *line4;
@property (nonatomic, strong) UILabel *line5;

@property (nonatomic, strong) UILabel *closeLb;
@property (nonatomic, strong) UILabel *rateLb;
@property (nonatomic, strong) UILabel *totalBuyLb;
@property (nonatomic, strong) UILabel *totalSaleLb;
@property (nonatomic, strong) UILabel *pureBuyLb;

@property (nonatomic, strong) UITableView *tableView1;
@property (nonatomic, strong) UITableView *tableView2;
@property (nonatomic, strong) UITableView *tableView3;
@property (nonatomic, strong) UITableView *tableView4;

@property (nonatomic, strong) TaoSearchStockModelList *listModel1;
@property (nonatomic, strong) TaoSearchStockModelList *listModel2;
@property (nonatomic, strong) TaoSearchStockModelList *listModel3;
@property (nonatomic, strong) TaoSearchStockModelList *listModel4;

@end

@implementation TaoSearchStockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_navBar setTitle:self.n];
    [_navBar setRightBtnTitle:@"行情"];

    self.title = [NSString stringWithFormat:@"龙虎榜个股:%@",self.n];
    
    [_scrollView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(64 + 99 * kScale);
        make.left.right.bottom.equalTo(self.view);
    }];
    
    [_mainView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_scrollView);
        make.width.equalTo(_scrollView);
        make.height.equalTo(@(MAIN_SCREEN_HEIGHT));
    }];

    self.view.backgroundColor = kUIColorFromRGB(0xf1f1f1);

    [_mainView addSubview:self.tableView1];
    [_mainView addSubview:self.tableView2];
    [_mainView addSubview:self.tableView3];
    [_mainView addSubview:self.tableView4];

    
    [self.tableView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(_mainView);
        make.height.equalTo(@0);
    }];
    
    [self.tableView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(_mainView);
        make.top.equalTo(self.tableView1.mas_bottom).offset(10 * kScale);
        make.height.equalTo(@0);
    }];
    
    [self.tableView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(_mainView);
        make.height.equalTo(@0);
        make.top.equalTo(self.tableView2.mas_bottom).offset(10 * kScale);
    }];
    
    [self.tableView4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(_mainView);
        make.height.equalTo(@0);
        make.top.equalTo(self.tableView3.mas_bottom).offset(10 * kScale);
    }];
    
    [self setupUI];
    
    [self.taoDateListAPI startWithCompletionBlockWithSuccess:^(__kindof APIBaseRequest *request) {
        NSArray *arr = request.responseJSONObject;
        if (arr.count == 0) {
            [self showNoView];
            return ;
        }
        self.searchAPI.d = arr.firstObject;
        self.yearArray = [YearModel anayliesDate:arr];
        [self setupPickerView];
    } failure:^(__kindof APIBaseRequest *request) {
        NSLog(@"failed");
    }];
}


- (void)showNoView {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"该股票三年内没有龙虎榜信息!" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"好" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [alertVC addAction:action];
    [self presentViewController:alertVC animated:YES completion:nil];
}

- (void)setupUI {
    UIView *topView = [[UIView alloc] init];
    topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(64);
        make.height.equalTo(@(42 * kScale));
    }];
    
    
    [topView addSubview:self.topLabel1];
    [topView addSubview:self.topLabel2];
    [self.topLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(topView);
        make.right.equalTo(topView.mas_centerX).offset(-25 * kScale);
    }];
    
    [self.topLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(topView);
        make.left.equalTo(self.topLabel1.mas_right).offset(30 * kScale);
    }];
    
    UIView *bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topView.mas_bottom).offset(10 * kScale);
        make.left.right.equalTo(topView);
        make.height.equalTo(@(47 * kScale));
    }];
    
    
    [bottomView addSubview:self.line1];
    
    [self.line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bottomView).offset(0 * kScale);
        make.right.equalTo(bottomView).offset(0 * kScale);
        make.height.equalTo(@(0.5 * kScale));
        make.top.equalTo(bottomView).offset(47 * kScale);
    }];
    
    [bottomView addSubview:self.calenderBtn];
    [bottomView addSubview:self.closeLb];
    [bottomView addSubview:self.rateLb];
    
    [self.closeLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bottomView).offset(13 * kScale);
        make.top.equalTo(bottomView).offset(16.5 * kScale);
    }];
    
    [self.rateLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.closeLb.mas_right).offset(10 * kScale);
        make.top.equalTo(bottomView).offset(16.5 * kScale);
    }];
    
    [self.calenderBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(bottomView).offset(-11 * kScale);
        make.centerY.equalTo(self.closeLb);
        make.width.equalTo(@(101 * kScale));
        make.height.equalTo(@(27 * kScale));
    }];
    

    
}

- (void)setupPickerView {
    
    [self loadData];
    
    [self.view addSubview:self.coverView];
    
    [self.view addSubview:self.pickerView];
    [self.pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(self.view);
        make.height.equalTo(@(200 * kScale));
    }];
    
    [self.view addSubview:self.pickerTopView];
    [self.pickerTopView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.pickerView.mas_top);
        make.height.equalTo(@(50 * kScale));
    }];
    
    [self closePickerView];
}

#pragma mark loadData 

- (void)loadData {
    [self.searchAPI start];
}

- (void)requestFailed:(APIBaseRequest *)request {
    NSLog(@"failed");
}

- (void)requestFinished:(APIBaseRequest *)request {
//    NSLog(@"%@",request.responseJSONObject);
    
    TaoSearchStockModel *model = [TaoSearchStockModel new];
    model = [MTLJSONAdapter modelOfClass:[TaoSearchStockModel class] fromJSONDictionary:request.responseJSONObject error:nil];
    [self dealWithTopView:model];
    [self dealWithTableView:model];
}

- (void)dealWithTableView:(TaoSearchStockModel *)model {
    if (model.list.count == 1) {
        self.listModel1 = model.list[0];
        [self.tableView1 reloadData];
        CGFloat h = self.tableView1.contentSize.height;
        [self.tableView1 mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(h));
        }];
        [self.tableView2 mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(0));
        }];
        [self.tableView3 mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(0));
        }];
        [self.tableView4 mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(0));
        }];
        _scrollView.contentSize = CGSizeMake(0, h);
    } else if (model.list.count == 2) {
        self.listModel1 = model.list[0];
        self.listModel2 = model.list[1];
        [self.tableView1 reloadData];
        [self.tableView2 reloadData];
        
        CGFloat h1 = self.tableView1.contentSize.height;
        [self.tableView1 mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(h1));
        }];
        CGFloat h2 = self.tableView2.contentSize.height;
        [self.tableView2 mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(h2));
        }];

        [self.tableView3 mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(0));
        }];
        [self.tableView4 mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(0));
        }];
        _scrollView.contentSize = CGSizeMake(0, h1 + h2);
    } else if (model.list.count == 3) {
        self.listModel1 = model.list[0];
        self.listModel2 = model.list[1];
        self.listModel3 = model.list[2];
        
        [self.tableView1 reloadData];
        [self.tableView2 reloadData];
        [self.tableView3 reloadData];
        
        CGFloat h1 = self.tableView1.contentSize.height;
        CGFloat h2 = self.tableView2.contentSize.height;
        CGFloat h3 = self.tableView3.contentSize.height;
        
        [self.tableView1 mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(h1));
        }];
        
        [self.tableView2 mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(h2));
        }];
        
        [self.tableView3 mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(h3));
        }];

        [self.tableView4 mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(0));
        }];
        _scrollView.contentSize = CGSizeMake(0, h1 + h2 + h3);
        
    } else if (model.list.count == 4) {
        self.listModel1 = model.list[0];
        self.listModel2 = model.list[1];
        self.listModel3 = model.list[2];
        self.listModel4 = model.list[3];
        
        [self.tableView1 reloadData];
        [self.tableView2 reloadData];
        [self.tableView3 reloadData];
        [self.tableView4 reloadData];
        
        CGFloat h1 = self.tableView1.contentSize.height;
        CGFloat h2 = self.tableView2.contentSize.height;
        CGFloat h3 = self.tableView3.contentSize.height;
        CGFloat h4 = self.tableView4.contentSize.height;
        
        [self.tableView1 mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(h1));
        }];
        
        [self.tableView2 mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(h2));
        }];
        
        [self.tableView3 mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(h3));
        }];
        
        [self.tableView4 mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(h4));
        }];
        
        _scrollView.contentSize = CGSizeMake(0, h1 + h2 + h3 + h4);
    }
    
    [_mainView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(_scrollView.contentSize.height));
    }];
    
    [self.view layoutIfNeeded];
}

- (void)dealWithTopView:(TaoSearchStockModel *)model {
    
    self.calenderBtn.title = model.tm;
    
    NSString *zx = @"--";
    if (model.zx != nil) {
        zx = [NSString stringWithFormat:@"%.2lf",model.zx.floatValue];
    }

    NSString *zxzdf = @"--";
    if (model.zxzdf != nil) {
        zxzdf = [NSString stringWithFormat:@"%.2lf%%",model.zxzdf.floatValue];
    }
    
    UIColor *zxColor;
    
    if (zxzdf.floatValue > 0) {
        zxColor = kUIColorFromRGB(0xff1919);
    } else if (zxzdf.floatValue < 0) {
        zxColor = kUIColorFromRGB(0x009d00);
    } else {
        zxColor = kUIColorFromRGB(0x333333);
    }
    
    NSAttributedString *attZx = [[NSAttributedString alloc] initWithString:zx attributes:@{
                                                                                           NSForegroundColorAttributeName : zxColor,
                                                                                           NSFontAttributeName : [UIFont systemFontOfSize:14 * kScale],
                                                                                           }];
    NSAttributedString *attZxzdf = [[NSAttributedString alloc] initWithString:zxzdf attributes:@{
                                                                                           NSForegroundColorAttributeName : zxColor,
                                                                                           NSFontAttributeName : [UIFont systemFontOfSize:14 * kScale],
                                                                                           }];
    
    NSMutableAttributedString *naZx = [[NSMutableAttributedString alloc] initWithString:@"最新价: " attributes:@{
                                                                                                         NSFontAttributeName : [UIFont systemFontOfSize:13 * kScale],
                                                                                                         NSForegroundColorAttributeName : kUIColorFromRGB(0x333333),
                                                                                                         }];
    
    NSMutableAttributedString *naZxzdf = [[NSMutableAttributedString alloc] initWithString:@"最新涨跌幅: " attributes:@{
                                                                                                            NSFontAttributeName : [UIFont systemFontOfSize:13 * kScale],
                                                                                                            NSForegroundColorAttributeName : kUIColorFromRGB(0x333333),
                                                                                                            }];
    [naZx appendAttributedString:attZx];
    [naZxzdf appendAttributedString:attZxzdf];
    self.topLabel1.attributedText = naZx;
    self.topLabel2.attributedText = naZxzdf;
    
    
    
    
    NSString *close = @"--";
    if (model.close != nil) {
        close = [NSString stringWithFormat:@"%.2lf",model.close.floatValue];
    }
    
    NSString *rate = @"--";
    if (model.zdf != nil) {
        rate = [NSString stringWithFormat:@"%.2lf%%",model.zdf.floatValue];
    }
    
    if (rate.floatValue > 0) {
        zxColor = kUIColorFromRGB(0xff1919);
    } else if (rate.floatValue < 0) {
        zxColor = kUIColorFromRGB(0x009d00);
    } else {
        zxColor = kUIColorFromRGB(0x333333);
    }
    
    NSAttributedString *attClose = [[NSAttributedString alloc] initWithString:close attributes:@{
                                                                                                 NSForegroundColorAttributeName : zxColor,
                                                                                                 NSFontAttributeName : [UIFont systemFontOfSize:14 * kScale],
                                                                                                 }];
    
    NSAttributedString *attRate = [[NSAttributedString alloc] initWithString:rate attributes:@{
                                                                                                 NSForegroundColorAttributeName : zxColor,
                                                                                                 NSFontAttributeName : [UIFont systemFontOfSize:14 * kScale],
                                                                                                 }];
    
    NSMutableAttributedString *naClose = [[NSMutableAttributedString alloc] initWithString:@"当日收盘价: " attributes:@{
                                                                                                            NSFontAttributeName : [UIFont systemFontOfSize:13 * kScale],
                                                                                                            NSForegroundColorAttributeName : kUIColorFromRGB(0x333333),
                                                                                                            }];
    
    
    NSMutableAttributedString *naZdf = [[NSMutableAttributedString alloc] initWithString:@"当日涨跌幅: " attributes:@{
                                                                                                          NSFontAttributeName : [UIFont systemFontOfSize:13 * kScale],
                                                                                                          NSForegroundColorAttributeName : kUIColorFromRGB(0x333333),
                                                                                                          }];
    [naClose appendAttributedString:attClose];
    [naZdf appendAttributedString:attRate];
    self.closeLb.attributedText = naClose;
    self.rateLb.attributedText = naZdf;

    

    
    
}

#pragma mark aciton

- (void)navBar:(NavBar *)navBar rightButtonTapped:(UIButton *)sender {
    
    if (([self.t intValue] == 1) || ([self.t intValue] == 2)) {
        IndexChartViewController *viewController = [[IndexChartViewController alloc] init];
        
        IndexInfoModel *model = [[IndexInfoModel alloc] init];
        model.marketCd = self.m;
        model.symbol = self.s;
        model.symbolName = self.n;
        model.symbolTyp = self.t;
        
        viewController.indexModel = model;
        [self.navigationController pushViewController:viewController animated:YES];
    } else {
        StockChartViewController *viewController = [[StockChartViewController alloc] init];
        StockListModel *model = [[StockListModel alloc] init];
        model.marketCd = self.m;
        model.symbol = self.s;
        model.symbolName = self.n;
        model.symbolTyp = self.t;
        
        viewController.stockListModel = model;
        [self.navigationController pushViewController:viewController animated:YES];
    }
}

- (void)calenderBtnClick:(UIButton *)btn {
    self.pickerView.hidden = NO;
    self.coverView.hidden = NO;
    self.pickerTopView.hidden = NO;
}

- (void)tap:(UITapGestureRecognizer *)tap {
    [self closePickerView];
}

- (void)sureBtnClick:(UIButton *)btn {
    [self closePickerView];
    
    NSInteger row0 = [self.pickerView selectedRowInComponent:0];
    NSInteger row1 = [self.pickerView selectedRowInComponent:1];
    NSInteger row2 = [self.pickerView selectedRowInComponent:2];
    
    YearModel *yearS = self.dataYearArr[row0];
    MonthModel *monthS = self.dataMonthArr[row1];
    DayModel *dayS = self.dataDayArr[row2];
    
    NSString *sendS = [NSString stringWithFormat:@"%@-%@-%@",yearS.yearStr,monthS.monthStr,dayS.dayStr];
    self.searchAPI.d = sendS;
    [self loadData];
}

- (void)cancelBtnClick:(UIButton *)btn {
    [self closePickerView];
}

- (void)closePickerView {
    self.coverView.hidden = YES;
    self.pickerView.hidden = YES;
    self.pickerTopView.hidden = YES;
}

#pragma mark tableView delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 59 * kScale;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        NSString *reaS = @"";
        if (tableView.tag == 1) {
            reaS = self.listModel1.n;
        } else if (tableView.tag == 2) {
            reaS = self.listModel2.n;
        } else if (tableView.tag == 3) {
            reaS = self.listModel3.n;
        } else if (tableView.tag == 4) {
            reaS = self.listModel4.n;
        }
        CGRect rect = [reaS boundingRectWithSize:CGSizeMake(265 * kScale, 20000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14 * kScale]} context:nil];
        return rect.size.height + 148 * kScale;
    } else {
        return 32 * kScale;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *headerView = [UIView new];
    if (section == 0) {
        NSString *reaS = @"";
        if (tableView.tag == 1) {
            reaS = self.listModel1.n;
        } else if (tableView.tag == 2) {
            reaS = self.listModel2.n;
        } else if (tableView.tag == 3) {
            reaS = self.listModel3.n;
        } else if (tableView.tag == 4) {
            reaS = self.listModel4.n;
        }
        
        TaoSearchStockModelList *model = nil;
        
        if (tableView.tag == 1) {
            model = self.listModel1;
        } else if (tableView.tag == 2) {
            model = self.listModel2;
        } else if (tableView.tag == 3) {
            model = self.listModel3;
        } else if (tableView.tag == 4) {
            model = self.listModel4;
        }
        
        UILabel *blockLb = [UILabel new];
        blockLb.backgroundColor = kButtonBGColor;
        UILabel *nameLb = [UILabel new];
        nameLb.textColor = kUIColorFromRGB(0x333333);
        nameLb.font = [UIFont boldSystemFontOfSize:14 * kScale];
        nameLb.text = @"上榜理由:  ";
        
        UILabel *reasonLb = [UILabel new];
        reasonLb.textColor = kTitleColor;
        reasonLb.numberOfLines = 0;
        reasonLb.preferredMaxLayoutWidth = 265 * kScale;
        reasonLb.font = [UIFont systemFontOfSize:14 * kScale];
        reasonLb.text = reaS;
        
        UILabel *line1 = [UILabel new];
        line1.backgroundColor = kUIColorFromRGB(0xe4e4e4);
        UILabel *line2 = [UILabel new];
        line2.backgroundColor = kUIColorFromRGB(0xe4e4e4);
        
        UILabel *yybLb = [UILabel new];
        yybLb.textColor = kUIColorFromRGB(0x333333);
        yybLb.text = @"买入营业部(前五)";
        yybLb.font = [UIFont systemFontOfSize:12 * kScale];
        UILabel *buyLb = [UILabel new];
        buyLb.text = @"买入金额(万)";
        buyLb.textColor = kUIColorFromRGB(0x333333);
        buyLb.font = [UIFont systemFontOfSize:12 * kScale];
        UILabel *saleLb = [UILabel new];
        saleLb.text = @"卖出金额(万)";
        saleLb.textColor = kUIColorFromRGB(0x333333);
        saleLb.font = [UIFont systemFontOfSize:12 * kScale];
        
        [headerView addSubview:blockLb];
        [headerView addSubview:nameLb];
        [headerView addSubview:line1];
        [headerView addSubview:line2];

        [headerView addSubview:reasonLb];
        
        [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(headerView).offset(15 * kScale);
            make.right.equalTo(headerView).offset(-15 * kScale);
            make.height.equalTo(@(0.5 * kScale));
//            make.top.equalTo(headerView).offset(44 * kScale);
        }];
        
        [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(headerView).offset(15 * kScale);
            make.right.equalTo(headerView).offset(-15 * kScale);
            make.height.equalTo(@(0.5 * kScale));
            make.bottom.equalTo(headerView);
        }];
        
        UILabel *line3 = [UILabel new];
        line3.backgroundColor = kUIColorFromRGB(0xe4e4e4);
        UILabel *line4 = [UILabel new];
        line4.backgroundColor = kUIColorFromRGB(0xe4e4e4);
        UILabel *line5 = [UILabel new];
        line5.backgroundColor = kUIColorFromRGB(0xe4e4e4);
        
        [headerView addSubview:line3];
        [headerView addSubview:line4];
        [headerView addSubview:line5];
        
        [line3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(headerView).offset(15 * kScale);
            make.right.equalTo(headerView).offset(-15 * kScale);
            make.height.equalTo(@(0.5 * kScale));
            make.top.equalTo(line1).offset(0 * kScale);
        }];
        
        [line4 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(headerView).offset(125 * kScale);
            make.top.equalTo(line3).offset(23 * kScale);
            make.height.equalTo(@(36 * kScale));
            make.width.equalTo(@(0.5 * kScale));
        }];
        
        [line5 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(headerView).offset(-125 * kScale);
            make.top.equalTo(line3).offset(23 * kScale);
            make.height.equalTo(line4);
            make.width.equalTo(@(0.5 * kScale));
        }];
        
        
        UILabel *buyLbTop = [UILabel new];
        buyLbTop.text = @"买入总计(万)";
        buyLbTop.textColor = kUIColorFromRGB(0x333333);
        buyLbTop.font = [UIFont systemFontOfSize:12 * kScale];
        
        UILabel *saleLbTop = [UILabel new];
        saleLbTop.text = @"卖出总计(万)";
        saleLbTop.textColor = kUIColorFromRGB(0x333333);
        saleLbTop.font = [UIFont systemFontOfSize:12 * kScale];
        
        UILabel *pureLb = [UILabel new];
        pureLb.text = @"买卖净差(万)";
        pureLb.textColor = kUIColorFromRGB(0x333333);
        pureLb.font = [UIFont systemFontOfSize:12 * kScale];
        
        [headerView addSubview:buyLbTop];
        [buyLbTop mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(line3).offset(20 * kScale);
            make.left.equalTo(headerView).offset(25 * kScale);
        }];
        
        [headerView addSubview:saleLbTop];
        [saleLbTop mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(line3).offset(20 * kScale);
            make.centerX.equalTo(headerView);
        }];
        
        [headerView addSubview:pureLb];
        [pureLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(buyLbTop);
            make.right.equalTo(headerView).offset(-25 * kScale);
        }];
        
        UILabel *totalBuyLb = [UILabel new];
        totalBuyLb.font = [UIFont boldSystemFontOfSize:18 * kScale];
        totalBuyLb.textColor = kUIColorFromRGB(0xff1919);
        
        UILabel *totalSaleLb = [UILabel new];
        totalSaleLb.font = [UIFont boldSystemFontOfSize:18 * kScale];
        totalSaleLb.textColor = kUIColorFromRGB(0x009d00);
        
        UILabel *pureBuyLb = [UILabel new];
        pureBuyLb.font = [UIFont boldSystemFontOfSize:18 * kScale];
        
        [headerView addSubview:totalBuyLb];
        [headerView addSubview:totalSaleLb];
        [headerView addSubview:pureBuyLb];
        
        NSString *bt = @"--";
        if (model.bt != nil) {
            bt = [NSString stringWithFormat:@"%.2lf",model.bt.floatValue];
        }
        
        NSString *st = @"--";
        if (model.st != nil) {
            st = [NSString stringWithFormat:@"%.2lf",model.st.floatValue];
        }
        
        NSString *nbuy = @"--";
        if (model.nbuy != nil) {
            nbuy = [NSString stringWithFormat:@"%.2lf",model.nbuy.floatValue];
        }
        
        totalBuyLb.text = bt;
        totalSaleLb.text = st;
        pureBuyLb.text = nbuy;
        if (nbuy.floatValue > 0) {
            pureBuyLb.textColor = kUIColorFromRGB(0xff1919);
        } else if (nbuy.floatValue < 0) {
            pureBuyLb.textColor = kUIColorFromRGB(0x009d00);
        } else {
            pureBuyLb.textColor = kUIColorFromRGB(0x333333);
        }
        
        [totalBuyLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(buyLbTop);
            make.top.equalTo(buyLbTop.mas_bottom).offset(12 * kScale);
        }];
        
        [totalSaleLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(saleLbTop);
            make.top.equalTo(saleLbTop.mas_bottom).offset(12 * kScale);
        }];
        
        [pureBuyLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(pureLb);
            make.top.equalTo(pureLb.mas_bottom).offset(12 * kScale);
        }];
        
        [reasonLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(headerView).offset(90 * kScale);
            make.top.equalTo(headerView).offset(15 * kScale);
            make.bottom.equalTo(line1).offset(-15 * kScale);
        }];
        
        [blockLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(headerView).offset(15 * kScale);
            make.height.equalTo(@(14 * kScale));
            make.width.equalTo(@(4 * kScale));
            make.centerY.equalTo(reasonLb);
        }];
        
        [nameLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(blockLb);
            make.left.equalTo(blockLb.mas_right).offset(3 * kScale);
        }];
        
        
        
        UIView *bottomView = [UIView new];
        [headerView addSubview:bottomView];
        bottomView.backgroundColor = kUIColorFromRGB(0xf1f1f1);
        [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(headerView);
            make.height.equalTo(@(32 * kScale));
        }];
        
        [bottomView addSubview:yybLb];
        [bottomView addSubview:buyLb];
        [bottomView addSubview:saleLb];

        [yybLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(bottomView).offset(15 * kScale);
            make.centerY.equalTo(bottomView);
        }];
        
        [buyLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(yybLb);
            make.right.equalTo(bottomView).offset(-125 * kScale);
        }];
        
        [saleLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(yybLb);
            make.right.equalTo(bottomView).offset(-15 * kScale);
        }];
        
        
        
        return headerView;
    } else {
        
        headerView.backgroundColor = kUIColorFromRGB(0xf1f1f1);
        
        UILabel *yybLb = [UILabel new];
        yybLb.textColor = kUIColorFromRGB(0x333333);
        yybLb.text = @"卖出营业部(前五)";
        yybLb.font = [UIFont systemFontOfSize:12 * kScale];
        UILabel *buyLb = [UILabel new];
        buyLb.text = @"买入金额(万)";
        buyLb.textColor = kUIColorFromRGB(0x333333);
        buyLb.font = [UIFont systemFontOfSize:12 * kScale];
        UILabel *saleLb = [UILabel new];
        saleLb.text = @"卖出金额(万)";
        saleLb.textColor = kUIColorFromRGB(0x333333);
        saleLb.font = [UIFont systemFontOfSize:12 * kScale];
        
        [headerView addSubview:yybLb];
        [headerView addSubview:buyLb];
        [headerView addSubview:saleLb];
        
        [yybLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(headerView).offset(15 * kScale);
            make.centerY.equalTo(headerView);
        }];
        
        [buyLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(yybLb);
            make.right.equalTo(headerView).offset(-125 * kScale);
        }];
        
        [saleLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(yybLb);
            make.right.equalTo(headerView).offset(-15 * kScale);
        }];
        
    
    }
    return headerView;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView.tag == 1) {
        if (section == 0) {
            return self.listModel1.buy.count;
        } else {
            return self.listModel1.sale.count;
        }
    } else if (tableView.tag == 2) {
        if (section == 0) {
            return self.listModel2.buy.count;
        } else {
            return self.listModel2.sale.count;
        }
    } else if (tableView.tag == 3) {
        if (section == 0) {
            return self.listModel3.buy.count;
        } else {
            return self.listModel3.sale.count;
        }
    } else {
        if (section == 0) {
            return self.listModel4.buy.count;
        } else {
            return self.listModel4.sale.count;
        }
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TaoSearchStockCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    TaoSearchStockBSModel *model = nil;
    if (tableView.tag == 1) {
        if (indexPath.section == 0) {
            model = self.listModel1.buy[indexPath.row];
        } else {
            model = self.listModel1.sale[indexPath.row];
        }
    } else if (tableView.tag == 2) {
        if (indexPath.section == 0) {
            model = self.listModel2.buy[indexPath.row];
        } else {
            model = self.listModel2.sale[indexPath.row];
        }
    } else if (tableView.tag == 3) {
        if (indexPath.section == 0) {
            model = self.listModel3.buy[indexPath.row];
        } else {
            model = self.listModel3.sale[indexPath.row];
        }
    } else {
        if (indexPath.section == 0) {
            model = self.listModel4.buy[indexPath.row];
        } else {
            model = self.listModel4.sale[indexPath.row];
        }
    }
    
    cell.model = model;
    
    cell.pushBlock = ^(NSString *name) {
        
        TaosSearchDepartmentViewController *departmentVC = [TaosSearchDepartmentViewController new];
        departmentVC.name = name;
        departmentVC.startDate = @"";
        departmentVC.endDate = @"";
        [self.navigationController pushViewController:departmentVC animated:YES];
    };
    
    return cell;
}


#pragma mark pickerView delegate

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return self.dataYearArr.count;
    } else if (component == 1) {
        return self.dataMonthArr.count;
    } else {
        return self.dataDayArr.count;
    }
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (component == 0) {
        YearModel *m = self.dataYearArr[row];
        return [NSString stringWithFormat:@"%@年",m.yearStr];
    } else if (component == 1) {
        MonthModel *m = self.dataMonthArr[row];
        return [NSString stringWithFormat:@"%@月",m.monthStr];
    } else {
        DayModel *m = self.dataDayArr[row];
        return [NSString stringWithFormat:@"%@日",m.dayStr];
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    if (component == 0) {
        YearModel *m = self.dataYearArr[row];
        self.dataMonthArr = m.monthArray;
        [pickerView reloadComponent:1];
        
        MonthModel *m1 = self.dataMonthArr[0];
        self.dataDayArr = m1.dayArray;
        [pickerView reloadComponent:2];
        
    } else if (component == 1) {
        MonthModel *m = self.dataMonthArr[row];
        self.dataDayArr = m.dayArray;
        [pickerView reloadComponent:2];
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 40 * kScale;
}

#pragma mark calender --------------
- (WDHorButton *)calenderBtn {
    if (_calenderBtn == nil) {
        _calenderBtn = [[WDHorButton alloc] init];
        _calenderBtn.imgStr = @"calender_nor";
        [_calenderBtn addTarget:self action:@selector(calenderBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        _calenderBtn.layer.borderColor = kUIColorFromRGB(0xe4e4e4).CGColor;
        _calenderBtn.layer.borderWidth = 0.5 * kScale;
    }
    return _calenderBtn;
}

- (TaoDateList *)taoDateListAPI {
    if (_taoDateListAPI == nil) {
        _taoDateListAPI = [[TaoDateList alloc] init];
        _taoDateListAPI.animatingView = self.view;
        _taoDateListAPI.s = self.s;
        _taoDateListAPI.t = [NSNumber numberWithInteger:self.t.integerValue];
        _taoDateListAPI.m = [NSNumber numberWithInteger:self.m.integerValue];
        _taoDateListAPI.count = @1000;
    }
    return _taoDateListAPI;
}

- (UIPickerView *)pickerView {
    if (_pickerView == nil) {
        _pickerView = [[UIPickerView alloc] init];
        _pickerView.showsSelectionIndicator = YES;
        _pickerView.dataSource = self;
        _pickerView.delegate = self;
        _pickerView.backgroundColor = kUIColorFromRGB(0xffffff);
    }
    return _pickerView;
}

- (NSArray *)dataYearArr {
    if (_dataYearArr == nil) {
        _dataYearArr = self.yearArray;
    }
    return _dataYearArr;
}

- (NSArray *)dataMonthArr {
    if (_dataMonthArr == nil) {
        YearModel *model = self.yearArray[0];
        _dataMonthArr = model.monthArray;
    }
    return _dataMonthArr;
}

- (NSArray *)dataDayArr {
    if (_dataDayArr == nil) {
        MonthModel *m = self.dataMonthArr[0];
        _dataDayArr = m.dayArray;
    }
    return _dataDayArr;
}

- (UIView *)coverView {
    if (_coverView == nil) {
        _coverView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _coverView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [_coverView addGestureRecognizer:tap];
    }
    return _coverView;
}

- (UIView *)pickerTopView {
    if (_pickerTopView == nil) {
        _pickerTopView = [UIView new];
        _pickerTopView.backgroundColor = kUIColorFromRGB(0xf1f1f1);
        
        UIButton *sureBtn = [[UIButton alloc] init];
        UIButton *cancelBtn = [[UIButton alloc] init];
        
        [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        
        [sureBtn setTitleColor:kTitleColor forState:UIControlStateNormal];
        [cancelBtn setTitleColor:kTitleColor forState:UIControlStateNormal];
        
        [_pickerTopView addSubview:sureBtn];
        [_pickerTopView addSubview:cancelBtn];
        
        [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_pickerTopView);
            make.right.equalTo(_pickerTopView).offset(-15 * kScale);
        }];
        
        [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_pickerTopView);
            make.left.equalTo(_pickerTopView).offset(15 * kScale);
        }];
        
        [sureBtn addTarget:self action:@selector(sureBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [cancelBtn addTarget:self action:@selector(cancelBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _pickerTopView;
}

#pragma mark lazy loading

- (TaoSearchStockAPI *)searchAPI {
    if (_searchAPI == nil) {
        _searchAPI = [[TaoSearchStockAPI alloc] init];
        _searchAPI.s = self.s;
        _searchAPI.d = self.d;
        _searchAPI.t = [NSNumber numberWithInteger:self.t.integerValue];
        _searchAPI.m = [NSNumber numberWithInteger:self.m.integerValue];
        _searchAPI.delegate = self;
    }
    return _searchAPI;
}

- (UILabel *)topLabel1 {
    if (_topLabel1 == nil) {
        _topLabel1 = [[UILabel alloc] init];
    }
    return _topLabel1;
}

- (UILabel *)topLabel2 {
    if (_topLabel2 == nil) {
        _topLabel2 = [[UILabel alloc] init];
    }
    return _topLabel2;
}

- (UILabel *)line1 {
    if (_line1 == nil) {
        _line1 = [UILabel new];
        _line1.backgroundColor = kUIColorFromRGB(0xe4e4e4);
    }
    return _line1;
}

- (UILabel *)line2 {
    if (_line2 == nil) {
        _line2 = [UILabel new];
        _line2.backgroundColor = kUIColorFromRGB(0xe4e4e4);
    }
    return _line2;
}

- (UILabel *)line3 {
    if (_line3 == nil) {
        _line3 = [UILabel new];
        _line3.backgroundColor = kUIColorFromRGB(0xe4e4e4);
    }
    return _line3;
}

- (UILabel *)line4 {
    if (_line4 == nil) {
        _line4 = [UILabel new];
        _line4.backgroundColor = kUIColorFromRGB(0xe4e4e4);
    }
    return _line4;
}

- (UILabel *)line5 {
    if (_line5 == nil) {
        _line5 = [UILabel new];
        _line5.backgroundColor = kUIColorFromRGB(0xe4e4e4);
    }
    return _line5;
}

- (UILabel *)closeLb {
    if (_closeLb == nil) {
        _closeLb = [UILabel new];
    }
    return _closeLb;
}

- (UILabel *)rateLb {
    if (_rateLb == nil) {
        _rateLb = [UILabel new];
    }
    return _rateLb;
}

- (UILabel *)totalBuyLb {
    if (_totalBuyLb == nil) {
        _totalBuyLb = [UILabel new];
        _totalBuyLb.font = [UIFont boldSystemFontOfSize:18 * kScale];
        _totalBuyLb.textColor = kUIColorFromRGB(0xff1919);
    }
    return _totalBuyLb;
}

- (UILabel *)totalSaleLb {
    if (_totalSaleLb == nil) {
        _totalSaleLb = [UILabel new];
        _totalSaleLb.font = [UIFont boldSystemFontOfSize:18 * kScale];
        _totalSaleLb.textColor = kUIColorFromRGB(0x009d00);
    }
    return _totalSaleLb;
}

- (UILabel *)pureBuyLb {
    if (_pureBuyLb == nil) {
        _pureBuyLb = [UILabel new];
        _pureBuyLb.font = [UIFont boldSystemFontOfSize:18 * kScale];
    }
    return _pureBuyLb;
}

- (UITableView *)tableView1 {
    if (_tableView1 == nil) {
        _tableView1 = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView1.tag = 1;
        _tableView1.showsVerticalScrollIndicator = NO;
        _tableView1.scrollEnabled = NO;
        _tableView1.delegate = self;
        _tableView1.dataSource = self;
        _tableView1.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView1 registerClass:[TaoSearchStockCell class] forCellReuseIdentifier:cellID];
    }
    return _tableView1;
}

- (UITableView *)tableView2 {
    if (_tableView2 == nil) {
        _tableView2 = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView2.tag = 2;
        _tableView2.showsVerticalScrollIndicator = NO;
        _tableView2.scrollEnabled = NO;
        _tableView2.delegate = self;
        _tableView2.dataSource = self;
        _tableView2.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView2 registerClass:[TaoSearchStockCell class] forCellReuseIdentifier:cellID];
    }
    return _tableView2;
}

- (UITableView *)tableView3 {
    if (_tableView3 == nil) {
        _tableView3 = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView3.tag = 3;
        _tableView3.showsVerticalScrollIndicator = NO;
        _tableView3.scrollEnabled = NO;
        _tableView3.delegate = self;
        _tableView3.dataSource = self;
        _tableView3.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView3 registerClass:[TaoSearchStockCell class] forCellReuseIdentifier:cellID];
    }
    return _tableView3;
}

- (UITableView *)tableView4 {
    if (_tableView4 == nil) {
        _tableView4 = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView4.tag = 4;
        _tableView4.showsVerticalScrollIndicator = NO;
        _tableView4.scrollEnabled = NO;
        _tableView4.delegate = self;
        _tableView4.dataSource = self;
        _tableView4.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView4 registerClass:[TaoSearchStockCell class] forCellReuseIdentifier:cellID];
    }
    return _tableView4;
}


@end
