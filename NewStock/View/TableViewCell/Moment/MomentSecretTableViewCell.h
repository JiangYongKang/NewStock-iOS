//
//  MomentSecretTableViewCell.h
//  NewStock
//
//  Created by 王迪 on 2017/3/27.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FeedListModel.h"
@class FeedListModel;
@class MomentSecretTableViewCell;

@protocol MomentSecretTableViewCellDelegate <NSObject>

- (void)momentSecretTableViewCellTopicDelegate:(NSInteger)index andModel:(FeedListModel *)model;

@end

@interface MomentSecretTableViewCell : UITableViewCell

@property (nonatomic, strong) FeedListModel *model;

@property (nonatomic, copy) void (^photoBlock)(UIImageView *imags,CGRect rect);

@property (nonatomic, strong) void (^pushBlock)(NSString *);

@property (nonatomic, copy) void (^pushStock)(FeedListSLModel *model);

@property (nonatomic, weak) id <MomentSecretTableViewCellDelegate> delegate;

- (CGFloat)getRowHeight:(FeedListModel *)model;

@end
