//
//  TipicView.h
//  NewStock
//
//  Created by Willey on 16/8/16.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TopicView : UIView
{
    UILabel *_titleLb;
    UILabel *_descLb;
}

-(void)setTitle:(NSString *)title content:(NSString *)content;
@end
