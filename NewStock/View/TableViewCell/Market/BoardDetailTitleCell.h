//
//  BoardDetailTitleCell.h
//  NewStock
//
//  Created by Willey on 16/8/3.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BoardDetailTitleCell : UITableViewCell
{
    UILabel *_upLb;
    UILabel *_downeLb;
    UILabel *_planLb;
}
- (void)setUp:(NSString *)up down:(NSString *)down plan:(NSString *)plan;

@end
