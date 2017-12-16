//
//  StockBaseInfoCell.h
//  NewStock
//
//  Created by Willey on 16/8/13.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StockBaseInfoCell : UITableViewCell
{
    UILabel *_nameLb1;
    UILabel *_nameLb2;
    UILabel *_nameLb3;
    UILabel *_nameLb4;
    
    UILabel *_valueLb1;
    UILabel *_valueLb2;
    UILabel *_valueLb3;
    UILabel *_valueLb4;

    UIView *_sepLine;
}
- (void)setDic:(NSDictionary *)dic;
- (void)showSepLine:(BOOL)b;
@end
