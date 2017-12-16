//
//  UserInfoTopView.h
//  NewStock
//
//  Created by 王迪 on 2017/1/9.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UserInfoTopViewDelegate <NSObject>

- (void)userInfoTopViewDelegateClick:(NSInteger )tag;

@end

@interface UserInfoTopView : UIView

@property (nonatomic, weak) id <UserInfoTopViewDelegate> delegate;

- (void)setFollowNum:(NSString *)num1 fs:(NSString *)fs feeds:(NSString *)feeds coms:(NSString *)coms collections:(NSString *)colls secret:(NSString *)secret tsc:(NSString *)tsc isBigV:(BOOL)isBigV;

@end
