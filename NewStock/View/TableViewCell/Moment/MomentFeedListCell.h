//
//  MomentFeedListCell.h
//  NewStock
//
//  Created by 王迪 on 2016/12/19.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FeedListModel.h"

@interface MomentFeedListCell : UITableViewCell

@property (nonatomic, strong) FeedListModel *model;

@property (nonatomic, strong) void (^pushBlock)(NSString *);

@property (nonatomic, copy) void (^pushStock)(FeedListSLModel *model);

@property (nonatomic, copy) void (^photoBlock)(NSInteger tag,NSArray *imags);

@property (nonatomic, copy) BOOL (^followBlock)(BOOL isFollow,NSString *uid,UIButton *saveBtn);

@property (nonatomic, copy) dispatch_block_t pushToLoginVC;

@property (nonatomic, strong) UIView *footerView;

@end
