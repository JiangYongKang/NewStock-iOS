//
//  ForeignIndexListViewController.m
//  NewStock
//
//  Created by Willey on 16/11/28.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "ForeignIndexListViewController.h"
#import "UIView+Masonry_Arrange.h"
#import "Masonry.h"
#import "MarketConfig.h"
#import "IndexInfoAPI.h"
#import "IndexInfoModel.h"
#import "MJChiBaoZiHeader.h"

@interface ForeignIndexListViewController ()
{
    IndexInfoAPI *_indexInfoAPI;

}
@end

@implementation ForeignIndexListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _mainView.backgroundColor = REFRESH_BG_COLOR;
    _navBar.hidden = YES;
    [_scrollView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    
    int padding1 = 3;
    int blockHeight = 90;
    int blockWidth = (MAIN_SCREEN_WIDTH-padding1*4)/3;
    int titleHeight = 30;
    
    //[self.view showPlaceHolderWithAllSubviews];
    [_mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_scrollView);
        make.width.equalTo(_scrollView);
        make.height.mas_equalTo(titleHeight+blockHeight*2+padding1*4);
        //make.height.equalTo(_scrollView).multipliedBy(2.5);
        
    }];
    [_scrollView layoutIfNeeded];//
    
    
       //
    //其他指数
    UIView *titleBarBg2 = [[UIView alloc] init];
    titleBarBg2.backgroundColor = kUIColorFromRGB(0xf1f1f1);
    [_mainView addSubview:titleBarBg2];
    [titleBarBg2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
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
        make.left.equalTo(indexBg2);
        make.right.equalTo(indexBg2);
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
            
            
            //其他
            if([model.symbol isEqualToString:@"HSI"])
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

@end
