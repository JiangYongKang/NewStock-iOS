//
//  QingHuaiTopScrollView.h
//  NewStock
//
//  Created by 王迪 on 2017/3/13.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainPageModel.h"
@class QingHuaiTopScrollView;

@protocol QingHuaiScrollViewDelegate <NSObject>

- (void)qinHuaiTopScrollView:(NSString *)url;

@end

@interface QingHuaiTopScrollView : UIView

@property (nonatomic, strong) NSArray <ForumModel *> *dataArray;

@property (nonatomic, weak) id <QingHuaiScrollViewDelegate> delegate;

- (void)addTimerScroll ;
- (void)deleteTimer ;

@end


