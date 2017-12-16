//
//  MessageCell.h
//  NewStock
//
//  Created by Willey on 16/10/28.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageCell : UITableViewCell
{
    UIImageView *_headerImg;
    UILabel *_stockNameLb;
    UILabel *_timeLb;
    UILabel *_contentLb;
    
   
}
- (void)setName:(NSString *)name time:(NSString *)time content:(NSString *)content;

- (void)setHeader:(NSString *)str;

@end
