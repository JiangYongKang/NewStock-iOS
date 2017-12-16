//
//  UIImage+RoundRectImage.h
//  NewStock
//
//  Created by Willey on 16/9/27.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (RoundRectImage)
+ (id)createRoundedRectImage:(UIImage*)image size:(CGSize)size radius:(NSInteger)r;

@end
