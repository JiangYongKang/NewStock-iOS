//
//  SquareCashStyleBar.h
//  BLKFlexibleHeightBar Demo
//
//  Created by Bryan Keller on 2/19/15.
//  Copyright (c) 2015 Bryan Keller. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BLKFlexibleHeightBar.h"

@protocol SquareCashStyleBarDelegate;

@interface SquareCashStyleBar : BLKFlexibleHeightBar<UIGestureRecognizerDelegate>
{
    UILabel *_nameLabel;
    UILabel *_gradeLabel;
    UIImageView *_profileImageView;
    UIImageView *_bigV;
}
@property (weak, nonatomic) id<SquareCashStyleBarDelegate> delegate;

@property (copy, nonatomic) void(^sendImgBlock)(UIImage *,BOOL isClear);

- (void)setUserName:(NSString *)name gradeName:(NSString*)grade headImgUrl:(NSString *)imgUrl score:(NSString *)sc isBigV:(BOOL)isBigV ;
@end



@protocol SquareCashStyleBarDelegate <NSObject>
@optional
- (void)SquareCashStyleBar:(SquareCashStyleBar *)squareCashStyleBar;
- (void)SquareCashStyleBarScoreLableClicked:(SquareCashStyleBar *)squareCashStyleBar;
@end
