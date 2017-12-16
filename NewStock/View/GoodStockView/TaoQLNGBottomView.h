//
//  TaoQLNGBottomView.h
//  NewStock
//
//  Created by 王迪 on 2017/6/26.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TaoQLNGBottomViewDelegate <NSObject>

- (void)taoQLNGBottomViewDelegatePushTo:(NSString *)url;

@end

@interface TaoQLNGBottomView : UIView

@property (nonatomic, weak) id <TaoQLNGBottomViewDelegate> delegate;

@end
