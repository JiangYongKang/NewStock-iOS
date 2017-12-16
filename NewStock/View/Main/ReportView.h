//
//  ReportView.h
//  NewStock
//
//  Created by Willey on 16/8/16.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, REPORTVIEW_ACTION_INDEX) {
    REPORTVIEW_ACTION_LKD,
    REPORTVIEW_ACTION_CS,
    REPORTVIEW_ACTION_FD
};

@protocol ReportViewDelegate;

@interface ReportView : UIView
{
    UIImageView *_headerIcon;
    
    UILabel *_titleLb;
    UILabel *_timeLb;
    UILabel *_descLb;
    
    UIImageView *_imgView1;
    UIImageView *_imgView2;
    UIImageView *_imgView3;

    UIButton *_btn1;
    UIButton *_btn2;
    UIButton *_btn3;
    
    
    UILabel *_tipsLb;

}
@property (weak, nonatomic) id<ReportViewDelegate> delegate;

-(void)setHeaderImg:(NSString *)url;

-(void)setImg1Url:(NSString *)url;
-(void)setImg2Url:(NSString *)url;
-(void)setImg3Url:(NSString *)url;
-(void)setTitle:(NSString *)title timeStr:(NSString *)timeStr content:(NSString *)content;
-(void)setLkd:(NSString *)lkd cs:(NSString *)cs fd:(NSString *)fd;
@end



@protocol ReportViewDelegate <NSObject>
@optional
- (void)reportView:(ReportView*)reportView actionIndex:(REPORTVIEW_ACTION_INDEX)index;
@end
