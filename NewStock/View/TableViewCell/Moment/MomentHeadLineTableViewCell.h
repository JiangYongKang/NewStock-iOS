//
//  MomentHeadLineTableViewCell.h
//  NewStock
//
//  Created by 王迪 on 2017/5/12.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FeedListModel.h"

@class MomentHeadLineTableViewCell;

@protocol MomentHeadLineTableViewCellPhotoDelegate <NSObject>

- (void)MomentHeadLineTableViewCellPhotoDelegate:(NSArray *)array andIndex:(NSInteger)index;

@end

@interface MomentHeadLineTableViewCell : UITableViewCell

@property (nonatomic, strong) FeedListModel *model;

@property (nonatomic, weak) id <MomentHeadLineTableViewCellPhotoDelegate> delegate;

@end
