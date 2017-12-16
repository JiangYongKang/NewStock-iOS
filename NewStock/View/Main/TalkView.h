//
//  TalkView.h
//  NewStock
//
//  Created by Willey on 16/8/16.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface TalkView : UIView
{
    UIImageView *_headerIcon;
    
    UILabel *_titleLb;
    UILabel *_timeLb;
    UILabel *_descLb;
    
}

-(void)setHeaderImg:(NSString *)url;

-(void)setTitle:(NSString *)title timeStr:(NSString *)timeStr content:(NSString *)content;
@end

