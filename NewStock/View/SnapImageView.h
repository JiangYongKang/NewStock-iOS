//
//  SnapImageView.h
//  test2
//
//  Created by 王迪 on 2016/12/4.
//  Copyright © 2016年 JiaBei. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM (NSInteger,SHARE_VIEW_TYPE){

    SHARE_VIEW_TYPE_WEB,
    SHARE_VIEW_TYPE_IMAGE

};

@interface SnapImageView : UIImageView

- (void)startBtnAnimation ;

- (void)fuzhiBtnClickWithUrl:(NSString *)url ;

//+ (void)sharedMessageWithTitle:(NSString *)title type:(SHARE_VIEW_TYPE)type image:(UIImage *)image ;

@property (nonatomic, copy) void (^btnBlock)(NSInteger);

@end
