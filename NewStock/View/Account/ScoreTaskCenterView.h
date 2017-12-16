//
//  ScoreTaskCenterView.h
//  NewStock
//
//  Created by 王迪 on 2017/4/17.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyScoreModel.h"

@protocol ScoreTaskCenterViewBtnClick <NSObject>

- (void)ScoreTaskCenterViewBtnClick:(NSString *)str;

@end

@interface ScoreTaskCenterView : UIView

@property (nonatomic, strong) NSArray <MyScoreDayModel *> *array;

@property (nonatomic, weak) id <ScoreTaskCenterViewBtnClick> delegate;

@end
