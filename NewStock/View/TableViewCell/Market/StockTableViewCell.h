//
//  StockTableViewCell.h
//  NewStock
//
//  Created by Willey on 16/7/27.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StockTableViewCell : UITableViewCell
{
    UILabel *_stockNameLb;
    UILabel *_stockCodeLb;
    UILabel *_valueLb;
    UILabel *_lbChangeRate;
}

- (void)setCode:(NSString *)code name:(NSString *)name value:(NSString *)value changeRate:(NSString *)changeRate marketCd:(NSString *)marketCd;
- (void)setVoluem:(NSString *)voluem;
- (void)setTurnover:(NSString *)turnover;
- (void)setMin5UpDown:(NSString *)min5UpDown;

- (void)setCode:(NSString *)code name:(NSString *)name marketCd:(NSString *)marketCd;

@end
