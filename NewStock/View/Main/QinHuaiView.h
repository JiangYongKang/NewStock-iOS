//
//  QinHuaiView.h
//  NewStock
//
//  Created by Willey on 16/11/11.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol QinHuaiViewDelegate;

@interface QinHuaiView : UIView
{
    UIImageView *_bgImgView;
    
    UILabel *_descLb;
    UILabel *_sourceLb;
    
    UILabel *_tipsLb;
    UIButton *_likeBtn;
}
@property (weak, nonatomic) id<QinHuaiViewDelegate> delegate;
@property (strong, nonatomic) NSString *fid;
@property (nonatomic, copy) dispatch_block_t loginBlock;

- (void)setBgImg:(NSString *)url;

- (void)setContent:(NSString *)content source:(NSString *)source;

- (void)setTm:(NSString *)tm;

- (void)setLikeNum:(NSString *)num;

- (void)setLkd:(BOOL)b;

@end


@protocol QinHuaiViewDelegate <NSObject>

@optional

- (void)qinHuaiView:(QinHuaiView *)qinHuaiView fid:(NSString *)fid;

- (void)qinghuaiViewClick;

@end

