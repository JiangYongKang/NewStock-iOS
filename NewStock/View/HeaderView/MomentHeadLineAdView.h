//
//  MomentHeadLineAdView.h
//  NewStock
//
//  Created by 王迪 on 2017/5/15.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MomentHeadLineAdView;

@protocol MomentHeadLineAdViewDelegate <NSObject>

- (void)momentHeadLineAdViewClick:(NSString *)url;

@end

@interface MomentHeadLineAdView : UIView

@property (nonatomic, strong) NSArray *dataArray;

@property (nonatomic, weak) id <MomentHeadLineAdViewDelegate> delegate;

- (void)addTimerScroll ;
- (void)deleteTimer ;


@end
