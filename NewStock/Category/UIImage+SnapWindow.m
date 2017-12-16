//
//  UIImage+SnapWindow.m
//  text
//
//  Created by 王迪 on 2016/12/4.
//  Copyright © 2016年 JiaBei. All rights reserved.
//

#import "UIImage+SnapWindow.h"

@implementation UIImage (SnapWindow)

+ (UIImage *)snapTheCurrentWindow {

    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    UIGraphicsBeginImageContextWithOptions(window.bounds.size, NO, 0);
    
    [window drawViewHierarchyInRect:window.bounds afterScreenUpdates:YES];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}

@end
