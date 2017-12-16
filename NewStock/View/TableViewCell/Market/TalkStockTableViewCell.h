//
//  TalkStockTableViewCell.h
//  NewStock
//
//  Created by Willey on 16/8/5.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TalkStockTableViewCell : UITableViewCell
{
    UIImageView *_headerImg;
    UILabel *_stockNameLb;
    UILabel *_timeLb;
    UILabel *_contentLb;
    
    
    UIButton *_btn1;
    UIButton *_btn2;
    UIButton *_btn3;
}
- (void)setName:(NSString *)name time:(NSString *)time content:(NSString *)content;

-(void)setModel:(id)model;
@end
