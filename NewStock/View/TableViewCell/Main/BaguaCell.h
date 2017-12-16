//
//  BaguaCell.h
//  NewStock
//
//  Created by 王迪 on 2017/1/6.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainPageModel.h"

@interface BaguaCell : UITableViewCell

@property (nonatomic, strong) ForumModel *model;

@property (nonatomic, assign) BOOL isForum;

@property (nonatomic, strong) void (^pushBlock)(NSString *);

@end
