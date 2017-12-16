//
//  TalkNewsView.h
//  NewStock
//
//  Created by 王迪 on 2017/1/5.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainPageModel.h"

@class TalkNewsView;


@interface TalkNewsView : UIView

@property (nonatomic, strong) NSArray <NewsModel *> *dataArray;

@property (nonatomic, copy) void(^tapBlock)();

- (void)updateItemSize:(CGSize)size;
- (void)addTimerScroll ;
- (void)deleteTimer ;


@end
