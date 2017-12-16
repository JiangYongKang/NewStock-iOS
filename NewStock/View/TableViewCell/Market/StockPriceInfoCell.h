//
//  StockPriceInfoCell.h
//  NewStock
//
//  Created by Willey on 16/8/13.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StockPriceInfoCell : UITableViewCell
{
    UILabel *_valueLb;
    UILabel *_increaceValue;
    UILabel *_increace;

    UILabel *_upDownLb;
}

- (void)setValue:(NSString *)value increaceValue:(NSString *)increaceValue increace:(NSString *)increace;
-(void)setUp:(NSString *)upStr plan:(NSString *)planStr down:(NSString *)downStr;

@end
