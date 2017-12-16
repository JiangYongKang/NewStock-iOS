//
//  TaoIndexSmartView.h
//  NewStock
//
//  Created by 王迪 on 2017/6/19.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TaoIndexSmartViewDelegate <NSObject>

- (void)taoIndexSmartViewDelegatePushTo:(NSString *)url title:(NSString *)title;

@end

@interface TaoIndexSmartView : UIView

@property (nonatomic, strong) NSArray *dataArray;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, weak) id <TaoIndexSmartViewDelegate> delegate;

@end
