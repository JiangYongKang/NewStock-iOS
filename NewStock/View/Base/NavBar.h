//
//  NavBar.h
//  YZLoan
//
//  Created by Willey Wang on 6/4/14.
//  Copyright (c) 2014 yz. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NavBarDelegate;

@interface NavBar : UIView
{
    UIImageView *_background;
	UILabel *_titleLb;
    UILabel *_subTitleLb;
    UIButton *_leftButton;
    UIButton *_rightButton;

    UIButton *_rightButton1;
    UIButton *_rightButton2;

    
    UIImageView *_bageView;
    UILabel *_bageNumber;
}
@property (nonatomic, assign) id<NavBarDelegate> delegate;

@property (nonatomic, strong) UIView *line_view;

-(void)setTitle:(NSString *)title;
-(void)setSubTitle:(NSString *)title;
-(void)setNavBg:(UIImage *)image;
-(void)setLeftBtnImg:(UIImage *)image;
-(void)setRightBtnImg:(UIImage *)image;
-(void)setRightBtnImg:(UIImage *)image withNum:(int)num;
-(void)setRIghtImageFrame:(CGRect)frame;

-(void)setLeftBtnTitle:(NSString *)title;
-(void)setRightBtnTitle:(NSString *)title;

-(void)setRightBtnTitle1:(NSString *)title1 title2:(NSString *)title2;

@end

@protocol NavBarDelegate <NSObject>
@optional
- (void)navBar:(NavBar*)navBar leftButtonTapped:(UIButton*)sender;
- (void)navBar:(NavBar*)navBar rightButtonTapped:(UIButton*)sender;

- (void)navBar:(NavBar*)navBar rightButton1Tapped:(UIButton*)sender;
- (void)navBar:(NavBar*)navBar rightButton2Tapped:(UIButton*)sender;
@end
