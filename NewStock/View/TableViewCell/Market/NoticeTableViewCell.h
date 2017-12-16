//
//  NoticeTableViewCell.h
//  NewStock
//
//  Created by Willey on 16/8/5.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NoticeTableViewCell : UITableViewCell
{
    UILabel *_timeLb;
    UILabel *_contentLb;
}
- (void)setContent:(NSString *)content time:(NSString *)time;

-(void)setModel:(id)model;
@end
