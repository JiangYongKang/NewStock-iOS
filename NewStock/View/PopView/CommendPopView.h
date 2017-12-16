//
//  CommendPopView.h
//  NewStock
//
//  Created by 王迪 on 2017/1/11.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CommendPopView;

@protocol CommendPopViewDelegate <NSObject>

- (void)commendPopViewDelegate:(NSInteger )index;

@end

@interface CommendPopView : UIView

@property (nonatomic, weak) id <CommendPopViewDelegate> delegate;

@end
