//
//  JSGCommentView.h
//  blur_comment
//
//  Created by dai.fengyi on 15/5/15.
//  Copyright (c) 2015年 childrenOurFuture. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol BlurCommentViewDelegate <NSObject>
@optional
- (void)commentDidFinished:(NSString *)commentText;
@end
typedef void(^SuccessBlock)(NSString *commentText);
@interface BlurCommentView : UIImageView
//
@property (nonatomic, copy) NSAttributedString *saveText;
@property (nonatomic, copy) void (^sendSaveText)(NSAttributedString *text);
@property (nonatomic, strong) UIButton *btn;

+ (void)commentshowInView:(UIView *)view success:(SuccessBlock)success;
+ (void)commentshowInView:(UIView *)view delegate:(id <BlurCommentViewDelegate>)delegate;

//default is in [UIApplication sharedApplication].keyWindow
+ (void)commentshowSuccess:(SuccessBlock)success;
+ (void)commentshowDelegate:(id <BlurCommentViewDelegate>)delegate;

- (void)commentshowInView:(UIView *)view andView:(BlurCommentView *)commentView success:(SuccessBlock)success delegate:(id <BlurCommentViewDelegate>)delegate ;

@end
