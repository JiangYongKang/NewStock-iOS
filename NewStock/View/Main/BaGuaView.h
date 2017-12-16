//
//  BaGuaView.h
//  NewStock
//
//  Created by Willey on 16/11/10.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainPageModel.h"

@protocol BaGuaViewDelegate;

@interface BaGuaView : UIView<UIGestureRecognizerDelegate>
{
    UIImageView *_headerView;
    
    UILabel *_titleLb;
    UILabel *_descLb;
    
//    UILabel *_statusLb;
    UILabel *_readCountLb;
    UILabel *_timeLb;
    UIImageView *_eyeImg;
    
    UIImageView *_imgView1;
    UIImageView *_imgView2;
    UIImageView *_imgView3;
    
}
@property (weak, nonatomic) id<BaGuaViewDelegate> delegate;
@property (nonatomic, strong) NSString *funcUrl;

@property (nonatomic, strong) ForumModel *model;

- (void)setHeaderImg:(NSString *)url;

- (void)setTitle:(NSString *)title content:(NSString *)content;

- (void)setImg1:(NSString *)url1 img2:(NSString *)url2 img3:(NSString *)url3;

@end


@protocol BaGuaViewDelegate <NSObject>
@optional
- (void)baGuaView:(BaGuaView*)drawLotsView funcUrl:(NSString *)funcUrl;
@end
