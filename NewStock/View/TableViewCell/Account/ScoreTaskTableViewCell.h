//
//  ScoreTaskTableViewCell.h
//  NewStock
//
//  Created by 王迪 on 2017/4/14.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScoreTaskTableViewCell : UITableViewCell

@property (nonatomic, copy) NSString *leftStr;

@property (nonatomic, copy) NSString *centerStr;

@property (nonatomic, copy) NSString *url;

@property (nonatomic, assign) BOOL isCompleted;

@end
