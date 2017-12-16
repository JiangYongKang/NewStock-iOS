//
//  FinanceTableViewCell.h
//  NewStock
//
//  Created by Willey on 16/8/5.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FinanceTableViewCell : UITableViewCell
{
    UIView *_bgView;
    UILabel *_titleLb;
    UILabel *_titleLb2;
    UILabel *_contentLb;
}
- (void)setTitle:(NSString *)title title2:(NSString *)title2 content:(NSDictionary *)contentDic;

@end
