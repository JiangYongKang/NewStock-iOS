//
//  BaseViewController.h
//  NewStock
//
//  Created by Willey on 16/7/18.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NavBar.h"
#import "Masonry.h"
#import "MMPlaceHolder.h"
#import "Defination.h"
#import "SystemUtil.h"
#import "ScreenAdaptation.h"
#import "APIBaseRequest.h"

#import "ScreenAdaptation.h"
#import "APIBaseRequest+AnimatingAccessory.h"

@interface BaseViewController : UIViewController<NavBarDelegate,APIRequestDelegate>
{
    UIScrollView *_scrollView;
    UIView *_mainView;
    int _nMainViewWidth;
    int _nMainViewHeight;
    
    NavBar *_navBar;
}

-(void)setNavBarTitle:(NSString *)title;
-(void)setNavBarSubTitle:(NSString *)title;
-(void)setNavBg:(UIImage *)bg;
-(void)setLeftBtnImg:(UIImage *)image;
-(void)setRightBtnImg:(UIImage *)image;
-(void)setRIghtImageFrame:(CGRect)frame;
-(void)setRightBtnImg:(UIImage *)image withNum:(int)num;
-(void)setRightBtnTitle:(NSString *)title;

-(void)loadData;


-(void)popLoginViewController;
@end
