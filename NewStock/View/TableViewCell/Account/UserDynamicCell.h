//
//  UserDynamicCell.h
//  NewStock
//
//  Created by 王迪 on 2017/1/10.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserDynamicModel.h"

@protocol UserDynamicCellDelegate <NSObject>

- (void)userDynamicCellDelegateClick:(NSInteger )index ids:(NSString *)ids index:(NSInteger )index;

@end

@interface UserDynamicCell : UITableViewCell

@property (nonatomic, strong) UserDynamicModel *model;

@property (nonatomic, weak) id <UserDynamicCellDelegate> delegate;

@property (nonatomic, assign) NSInteger index;

@end
