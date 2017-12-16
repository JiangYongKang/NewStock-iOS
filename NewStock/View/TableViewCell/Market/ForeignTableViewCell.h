//
//  ForeignTableViewCell.h
//  NewStock
//
//  Created by 王迪 on 2016/12/8.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ForeignTableViewCell : UITableViewCell
{
    UILabel *_stockNameLb;
    UILabel *_valueLb;
    UILabel *_lbChangeRate;
}

- (void)setName:(NSString *)name value:(NSString *)value changeRate:(NSString *)changeRate;


@end
