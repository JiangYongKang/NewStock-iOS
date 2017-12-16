//
//  BlockTableViewCell.h
//  NewStock
//
//  Created by Willey on 16/7/27.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BlockTableViewCell : UITableViewCell
{
    UILabel *_blockNameLb;
    UILabel *_lbChangeRate;


    UILabel *_lbLeadingStockName;
    UILabel *_lbLeadingStockCode;
}
- (void)setName:(NSString *)name changeRate:(NSString *)changeRate;
- (void)setLeadingStockName:(NSString *)name LeadingStockCode:(NSString *)code;

@end
