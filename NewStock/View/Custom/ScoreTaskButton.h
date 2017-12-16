//
//  ScoreTaskButton.h
//  NewStock
//
//  Created by 王迪 on 2017/4/14.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScoreTaskButton : UIButton

@property (nonatomic, copy) NSString *imgStr;
@property (nonatomic, copy) NSString *imgUrl;
@property (nonatomic, copy) NSString *bottomLbStr;
@property (nonatomic, copy) NSString *centerStr;
@property (nonatomic, copy) NSString *url;

@property (nonatomic, assign) BOOL isCompleted;

@end
