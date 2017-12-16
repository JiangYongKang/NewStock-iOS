//
//  StockIndexViewController.m
//  NewStock
//
//  Created by Willey on 16/7/23.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "StockIndexViewController.h"
#import "UIView+Masonry_Arrange.h"
#import "Masonry.h"
#import "MarketConfig.h"
#import "IndexInfoAPI.h"
#import "IndexInfoModel.h"
#import "IndexChartViewController.h"
#import "AppDelegate.h"
#import "IndexListViewController.h"

#import "MJChiBaoZiHeader.h"


@interface StockIndexViewController ()
{
    IndexInfoAPI *_indexInfoAPI;

    IndexInfoModel *_shIndexModel;
    IndexInfoModel *_szIndexModel;
    IndexInfoModel *_cybIndexModel;
    
    IndexInfoModel *_hs300IndexModel;
    IndexInfoModel *_sh50IndexModel;
    IndexInfoModel *_zz500IndexModel;
}
@end

@implementation StockIndexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    int padding1 = 3;
    int blockHeight = 90;
    int blockWidth = (MAIN_SCREEN_WIDTH-padding1*4)/3;
    int titleHeight = 30;
    
    //[self.view showPlaceHolderWithAllSubviews];
    [_mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_scrollView);
        make.width.equalTo(_scrollView);
        make.height.mas_equalTo(titleHeight*2+blockHeight*4+padding1*8);
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
    titleLb1.text = @"国内指数";
    titleLb1.font = [UIFont systemFontOfSize:12];
    titleLb1.textColor = kUIColorFromRGB(0x666666);
    [titleBarBg1 addSubview:titleLb1];
    [titleLb1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(titleLb1.superview).with.insets(UIEdgeInsetsMake(0,10,0,100));
    }];
    
    UIButton *moreBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    moreBtn1.frame = CGRectMake(MAIN_SCREEN_WIDTH-50, 0, 50, 30);
    [moreBtn1 setImage:[UIImage imageNamed:@"more_icon"] forState:UIControlStateNormal];
    [moreBtn1 addTarget:self action:@selector(moreBtnAction1:) forControlEvents:UIControlEventTouchUpInside];
    [titleBarBg1 addSubview:moreBtn1];
    
    
    UIView *indexBg1 = [[UIView alloc] init];
    indexBg1.backgroundColor = [UIColor whiteColor];
    [_mainView addSubview:indexBg1];
    [indexBg1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleBarBg1.mas_bottom).offset(-0.5);
        make.right.equalTo(_mainView);
        make.left.equalTo(_mainView);
        make.height.mas_equalTo(blockHeight*2+padding1*3);
    }];
//    [[indexBg1 layer] setBorderWidth:0.5];
//    [[indexBg1 layer] setBorderColor:SEP_LINE_COLOR.CGColor];
    
    
    _shIndex = [[IndexBlock alloc] initWithDelegate:self tag:0];
    _szIndex = [[IndexBlock alloc] initWithDelegate:self tag:1];
    _cybIndex = [[IndexBlock alloc] initWithDelegate:self tag:2];
    
    _hs300Index = [[IndexBlock alloc] initWithDelegate:self tag:3];
    _sz50Index = [[IndexBlock alloc] initWithDelegate:self tag:4];
    _zz500bIndex = [[IndexBlock alloc] initWithDelegate:self tag:5];
    
    [indexBg1 addSubview:_shIndex];
    [indexBg1 addSubview:_szIndex];
    [indexBg1 addSubview:_cybIndex];
    
    [indexBg1 addSubview:_hs300Index];
    [indexBg1 addSubview:_sz50Index];
    [indexBg1 addSubview:_zz500bIndex];
    
    [_shIndex mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(indexBg1).offset(padding1);
        make.centerY.equalTo(@[_szIndex,_cybIndex]);
        make.size.mas_equalTo(CGSizeMake(blockWidth, blockHeight));
    }];
    [_szIndex mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(blockWidth, blockHeight));
    }];
    [_cybIndex mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(blockWidth, blockHeight));
    }];
    [self.view distributeSpacingHorizontallyWith:@[_shIndex,_szIndex,_cybIndex]];
    
    [_hs300Index mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(indexBg1).offset(blockHeight+padding1*2);
        make.centerY.equalTo(@[_sz50Index,_zz500bIndex]);
        make.size.mas_equalTo(CGSizeMake(blockWidth, blockHeight));
    }];
    [_sz50Index mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(blockWidth, blockHeight));
    }];
    [_zz500bIndex mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(blockWidth, blockHeight));
    }];
    [self.view distributeSpacingHorizontallyWith:@[_hs300Index,_sz50Index,_zz500bIndex]];
    
    UIView *line11 = [[UIView alloc] init];
    line11.backgroundColor = SEP_LINE_COLOR;
    [indexBg1 addSubview:line11];
    [line11 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_shIndex.mas_top).offset(10);
        make.left.equalTo(_shIndex.mas_right);
        make.bottom.equalTo(_shIndex.mas_bottom).offset(-10);
        make.width.mas_equalTo(0.5);
    }];
    UIView *line12 = [[UIView alloc] init];
    line12.backgroundColor = SEP_LINE_COLOR;
    [indexBg1 addSubview:line12];
    [line12 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_shIndex.mas_top).offset(10);
        make.left.equalTo(_szIndex.mas_right);
        make.bottom.equalTo(_shIndex.mas_bottom).offset(-10);
        make.width.mas_equalTo(0.5);
    }];
    
    UIView *sepLine1 = [[UIView alloc] init];
    sepLine1.backgroundColor = SEP_LINE_COLOR;
    [indexBg1 addSubview:sepLine1];
    [sepLine1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_shIndex.mas_bottom).offset(padding1);
        make.left.equalTo(indexBg1);
        make.right.equalTo(indexBg1);
        make.height.mas_equalTo(0.5);
    }];
    
    UIView *line21 = [[UIView alloc] init];
    line21.backgroundColor = SEP_LINE_COLOR;
    [indexBg1 addSubview:line21];
    [line21 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_hs300Index.mas_top).offset(10);
        make.left.equalTo(_hs300Index.mas_right);
        make.bottom.equalTo(_hs300Index.mas_bottom).offset(-10);
        make.width.mas_equalTo(0.5);
    }];
    UIView *line22 = [[UIView alloc] init];
    line22.backgroundColor = SEP_LINE_COLOR;
    [indexBg1 addSubview:line22];
    [line22 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_hs300Index.mas_top).offset(10);
        make.left.equalTo(_sz50Index.mas_right);
        make.bottom.equalTo(_hs300Index.mas_bottom).offset(-10);
        make.width.mas_equalTo(0.5);
    }];
    
    //
    //其他指数
    UIView *titleBarBg2 = [[UIView alloc] init];
    titleBarBg2.backgroundColor = kUIColorFromRGB(0xf1f1f1);
    [_mainView addSubview:titleBarBg2];
    [titleBarBg2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(indexBg1.mas_bottom);
        make.left.equalTo(titleBarBg2.superview).with.offset(0);
        make.right.equalTo(titleBarBg2.superview).with.offset(0);
        make.height.mas_equalTo(titleHeight);
    }];
    
    UILabel *titleLb2 = [[UILabel alloc] init];
    titleLb2.text = @"其他指数";
    titleLb2.font = [UIFont systemFontOfSize:12];
    titleLb2.textColor = kUIColorFromRGB(0x666666);
    [titleBarBg2 addSubview:titleLb2];
    [titleLb2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(titleLb2.superview).with.insets(UIEdgeInsetsMake(0,10,0,100));
    }];
    
    UIButton *moreBtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    moreBtn2.frame = CGRectMake(MAIN_SCREEN_WIDTH-50, 0, 50, 30);
    [moreBtn2 setImage:[UIImage imageNamed:@"more_icon"] forState:UIControlStateNormal];
    [moreBtn2 addTarget:self action:@selector(moreBtnAction2:) forControlEvents:UIControlEventTouchUpInside];
    [titleBarBg2 addSubview:moreBtn2];
    moreBtn2.hidden = YES;
    
    UIView *indexBg2 = [[UIView alloc] init];
    indexBg2.backgroundColor = [UIColor whiteColor];
    [_mainView addSubview:indexBg2];
    [indexBg2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleBarBg2.mas_bottom).offset(-0.5);
        make.right.equalTo(_mainView);
        make.left.equalTo(_mainView);
        make.height.mas_equalTo(blockHeight*2+padding1*4);
    }];
//    [[indexBg2 layer] setBorderWidth:0.5];
//    [[indexBg2 layer] setBorderColor:SEP_LINE_COLOR.CGColor];

    
    _hsIndex = [[IndexBlock alloc] initWithDelegate:self tag:10];
    _nasdaqIndex = [[IndexBlock alloc] initWithDelegate:self tag:11];
    _dowIndex = [[IndexBlock alloc] initWithDelegate:self tag:12];
    
    _bpIndex = [[IndexBlock alloc] initWithDelegate:self tag:13];
    _rjIndex = [[IndexBlock alloc] initWithDelegate:self tag:14];
    _ygfsIndex = [[IndexBlock alloc] initWithDelegate:self tag:15];
    
    [indexBg2 addSubview:_hsIndex];
    [indexBg2 addSubview:_nasdaqIndex];
    [indexBg2 addSubview:_dowIndex];
    
    [indexBg2 addSubview:_bpIndex];
    [indexBg2 addSubview:_rjIndex];
    [indexBg2 addSubview:_ygfsIndex];
    
    [_hsIndex mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(indexBg2).offset(padding1);
        make.centerY.equalTo(@[_nasdaqIndex,_dowIndex]);
        make.size.mas_equalTo(CGSizeMake(blockWidth, blockHeight));
    }];
    [_nasdaqIndex mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(blockWidth, blockHeight));
    }];
    [_dowIndex mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(blockWidth, blockHeight));
    }];
    [self.view distributeSpacingHorizontallyWith:@[_hsIndex,_nasdaqIndex,_dowIndex]];
    
    [_bpIndex mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(indexBg2).offset(blockHeight+padding1*2);
        make.centerY.equalTo(@[_rjIndex,_ygfsIndex]);
        make.size.mas_equalTo(CGSizeMake(blockWidth, blockHeight));
    }];
    [_rjIndex mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(blockWidth, blockHeight));
    }];
    [_ygfsIndex mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(blockWidth, blockHeight));
    }];
    [self.view distributeSpacingHorizontallyWith:@[_bpIndex,_rjIndex,_ygfsIndex]];
    
    
    UIView *line31 = [[UIView alloc] init];
    line31.backgroundColor = SEP_LINE_COLOR;
    [indexBg2 addSubview:line31];
    [line31 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_hsIndex.mas_top).offset(10);
        make.left.equalTo(_hsIndex.mas_right);
        make.bottom.equalTo(_hsIndex.mas_bottom).offset(-10);
        make.width.mas_equalTo(0.5);
    }];
    UIView *line32 = [[UIView alloc] init];
    line32.backgroundColor = SEP_LINE_COLOR;
    [indexBg2 addSubview:line32];
    [line32 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_hsIndex.mas_top).offset(10);
        make.left.equalTo(_nasdaqIndex.mas_right);
        make.bottom.equalTo(_hsIndex.mas_bottom).offset(-10);
        make.width.mas_equalTo(0.5);
    }];
    
    UIView *sepLine2 = [[UIView alloc] init];
    sepLine2.backgroundColor = SEP_LINE_COLOR;
    [indexBg2 addSubview:sepLine2];
    [sepLine2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_hsIndex.mas_bottom).offset(padding1);
        make.left.equalTo(indexBg1);
        make.right.equalTo(indexBg1);
        make.height.mas_equalTo(0.5);
    }];
    
    UIView *line41 = [[UIView alloc] init];
    line41.backgroundColor = SEP_LINE_COLOR;
    [indexBg2 addSubview:line41];
    [line41 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_bpIndex.mas_top).offset(10);
        make.left.equalTo(_bpIndex.mas_right);
        make.bottom.equalTo(_bpIndex.mas_bottom).offset(-10);
        make.width.mas_equalTo(0.5);
    }];
    UIView *line42 = [[UIView alloc] init];
    line42.backgroundColor = SEP_LINE_COLOR;
    [indexBg2 addSubview:line42];
    [line42 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_bpIndex.mas_top).offset(10);
        make.left.equalTo(_rjIndex.mas_right);
        make.bottom.equalTo(_bpIndex.mas_bottom).offset(-10);
        make.width.mas_equalTo(0.5);
    }];
    
    //
    _indexInfoAPI = [[IndexInfoAPI alloc] initWithSymbolTyp:@"" symbol:@"" marketCd:@""];
    
    
    _scrollView.mj_header = [MJChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];


}
- (void)moreBtnAction1:(UIButton *)sender{
    IndexListViewController *viewController = [[IndexListViewController alloc] init];
    viewController.title = @"国内指数";
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate.navigationController pushViewController:viewController animated:YES];
}
- (void)moreBtnAction2:(UIButton *)sender {
    
}

- (void)loadNewData {
    [self loadData];
}
- (void)loadData {
    [_indexInfoAPI startWithCompletionBlockWithSuccess:^(APIBaseRequest *request) {
        NSLog(@"%@",_indexInfoAPI.responseJSONObject);
        
        NSArray * array = [MTLJSONAdapter modelsOfClass:[IndexInfoModel class] fromJSONArray:_indexInfoAPI.responseJSONObject error:nil];
        
        for (int i=0; i<[array count]; i++)
        {
            IndexInfoModel *model = [array objectAtIndex:i];
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
            
            //
            else if([model.symbol isEqualToString:@"000300"])
            {
                _hs300IndexModel = model;
                [_hs300Index setCode:@"" title:model.symbolName value:[SystemUtil getPrecisionPrice:[model.consecutivePresentPrice doubleValue] precision:[model.pricePrecision intValue]] change:[NSString stringWithFormat:@"%.2f",[model.stockUD doubleValue]] changeRate:[SystemUtil getPercentage:[model.tradeIncrease doubleValue]]];
            }
            else if([model.symbol isEqualToString:@"000016"])
            {
                _sh50IndexModel = model;
                [_sz50Index setCode:@"" title:model.symbolName value:[SystemUtil getPrecisionPrice:[model.consecutivePresentPrice doubleValue] precision:[model.pricePrecision intValue]] change:[NSString stringWithFormat:@"%.2f",[model.stockUD doubleValue]] changeRate:[SystemUtil getPercentage:[model.tradeIncrease doubleValue]]];
            }
            else if([model.symbol isEqualToString:@"000905"])
            {
                _zz500IndexModel = model;
                [_zz500bIndex setCode:@"" title:model.symbolName value:[SystemUtil getPrecisionPrice:[model.consecutivePresentPrice doubleValue] precision:[model.pricePrecision intValue]] change:[NSString stringWithFormat:@"%.2f",[model.stockUD doubleValue]] changeRate:[SystemUtil getPercentage:[model.tradeIncrease doubleValue]]];
            }
            
            
            //其他
            else if([model.symbol isEqualToString:@"HSI"])
            {
                [_hsIndex setCode:@"" title:model.symbolName value:[SystemUtil getPrecisionPrice:[model.consecutivePresentPrice doubleValue] precision:[model.pricePrecision intValue]] change:[NSString stringWithFormat:@"%.2f",[model.stockUD doubleValue]] changeRate:[SystemUtil getPercentage:[model.tradeIncrease doubleValue]]];
            }
            else if([model.symbol isEqualToString:@"IXIC"])
            {
                [_nasdaqIndex setCode:@"" title:model.symbolName value:[SystemUtil getPrecisionPrice:[model.consecutivePresentPrice doubleValue] precision:[model.pricePrecision intValue]] change:[NSString stringWithFormat:@"%.2f",[model.stockUD doubleValue]] changeRate:[SystemUtil getPercentage:[model.tradeIncrease doubleValue]]];
            }
            else if([model.symbol isEqualToString:@"DJI"])
            {
                [_dowIndex setCode:@"" title:model.symbolName value:[SystemUtil getPrecisionPrice:[model.consecutivePresentPrice doubleValue] precision:[model.pricePrecision intValue]] change:[NSString stringWithFormat:@"%.2f",[model.stockUD doubleValue]] changeRate:[SystemUtil getPercentage:[model.tradeIncrease doubleValue]]];
            }
            
            //
            else if([model.symbol isEqualToString:@"SPX500"])
            {
                [_bpIndex setCode:@"" title:model.symbolName value:[SystemUtil getPrecisionPrice:[model.consecutivePresentPrice doubleValue] precision:[model.pricePrecision intValue]] change:[NSString stringWithFormat:@"%.2f",[model.stockUD doubleValue]] changeRate:[SystemUtil getPercentage:[model.tradeIncrease doubleValue]]];
            }
            else if([model.symbol isEqualToString:@"N225"])
            {
                [_rjIndex setCode:@"" title:model.symbolName value:[SystemUtil getPrecisionPrice:[model.consecutivePresentPrice doubleValue] precision:[model.pricePrecision intValue]] change:[NSString stringWithFormat:@"%.2f",[model.stockUD doubleValue]] changeRate:[SystemUtil getPercentage:[model.tradeIncrease doubleValue]]];
            }
            else if([model.symbol isEqualToString:@"FTSE100"])
            {
                [_ygfsIndex setCode:@"" title:model.symbolName value:[SystemUtil getPrecisionPrice:[model.consecutivePresentPrice doubleValue] precision:[model.pricePrecision intValue]] change:[NSString stringWithFormat:@"%.2f",[model.stockUD doubleValue]] changeRate:[SystemUtil getPercentage:[model.tradeIncrease doubleValue]]];
            }
            //其他指数
//            [_hsIndex setCode:@"" title:@"恒生指数" value:@"3018.82" change:@"15.06" changeRate:@"0.06%"];
//            [_nasdaqIndex setCode:@"" title:@"纳斯达克" value:@"2255.67" change:@"-10.06" changeRate:@"-0.13%"];
//            [_dowIndex setCode:@"" title:@"道琼斯" value:@"10907.67" change:@"-10.06" changeRate:@"-0.13%"];
//            //
//            [_bpIndex setCode:@"" title:@"标普500" value:@"3018.82" change:@"15.06" changeRate:@"0.06%"];
//            [_rjIndex setCode:@"" title:@"日经225" value:@"2255.67" change:@"-10.06" changeRate:@"-0.13%"];
//            [_ygfsIndex setCode:@"" title:@"英国富时100" value:@"10907.67" change:@"-10.06" changeRate:@"-0.13%"];
            /**
             *  道琼斯,纳斯达克,标普500,日经225,恒生指数,A50,英国富时100,德国DAX,法国CAC
             */
        }
        
        [_scrollView.mj_header endRefreshing];

        
    } failure:^(APIBaseRequest *request) {
        NSLog(@"failed");
        
        [_scrollView.mj_header endRefreshing];

    }];

    
    
    
}


#pragma IndexBlockDelegate
- (void)indexBlock:(IndexBlock*)indexBlock code:(NSString *)code {
    IndexChartViewController *viewController = [[IndexChartViewController alloc] init];

    switch (indexBlock.tag) {
        case 0:
            viewController.indexModel = _shIndexModel;
            break;
            
        case 1:
            viewController.indexModel = _szIndexModel;
            break;
            
        case 2:
            viewController.indexModel = _cybIndexModel;
            break;
        case 3:
            viewController.indexModel = _hs300IndexModel;
            break;
        case 4:
            viewController.indexModel = _sh50IndexModel;
            break;
        case 5:
            viewController.indexModel = _zz500IndexModel;
            break;
            
//        case 10:
//            
//            break;
//        case 11:
//            
//            break;
//        case 12:
//            
//            
//            break;
//        case 13:
//            
//            break;
//        case 14:
//            
//            break;
//        case 15:
//            
//            break;

            
        default:
            return;
            break;
    }
    if (!viewController.indexModel) return;

    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate.navigationController pushViewController:viewController animated:YES];
}

@end
