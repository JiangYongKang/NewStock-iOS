//
//  VPImageCropperViewController.h
//  VPolor
//
//  Created by Vinson.D.Warm on 12/30/13.
//  Copyright (c) 2013 Huang Vinson. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TKVPImageCropperViewController;

@protocol TKVPImageCropperDelegate <NSObject>

- (void)imageCropper:(TKVPImageCropperViewController *)cropperViewController didFinished:(UIImage *)editedImage;

- (void)imageCropperDidCancel:(TKVPImageCropperViewController *)cropperViewController;

@end

@interface TKVPImageCropperViewController : UIViewController

@property (nonatomic, assign) NSInteger tag;
@property (nonatomic, weak) id<TKVPImageCropperDelegate> delegate;
@property (nonatomic, assign) CGRect cropFrame;

- (id)initWithImage:(UIImage *)originalImage cropFrame:(CGRect)cropFrame limitScaleRatio:(NSInteger)limitRatio;

@end
