//
//  NewsTableViewCell.h
//  NewStock
//
//  Created by Willey on 16/8/4.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NewsTableViewCellDelegate;

@interface NewsTableViewCell : UITableViewCell
{
    UIButton *_stockNameBtn;
    UILabel *_stockNameLb;
    UILabel *_timeLb;
    UILabel *_contentLb;
}
@property (nonatomic, assign) id<NewsTableViewCellDelegate> delegate;

- (void)setName:(NSString *)name time:(NSString *)time content:(NSString *)content;

@end



@protocol NewsTableViewCellDelegate <NSObject>
@optional
- (void)newsTableViewCell:(NewsTableViewCell*)cell selectedIndex:(NSUInteger)index;

@end
