//
//  PlateBlock.h
//  NewStock
//
//  Created by Willey on 16/7/26.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BoardListModel.h"

@protocol PlateBlockDelegate;

@interface PlateBlock : UIView<UIGestureRecognizerDelegate>
{
    NSString *_strCode;

    UILabel *_lbTitle;
    UILabel *_lbValue;
    
    UILabel *_nameLb;
    UILabel *_lbChange;
    UILabel *_lbChangeRate;
}
@property (weak, nonatomic) id<PlateBlockDelegate> delegate;
@property (nonatomic, strong) BoardListModel * model;

- (id)initWithDelegate:(id)theDelegate tag:(int)tag;

- (void)setCode:(NSString *)code title:(NSString *)title value:(NSString *)value name:(NSString *)name change:(NSString *)change changeRate:(NSString *)changeRate;
@end


@protocol PlateBlockDelegate <NSObject>
@optional
- (void)plateBlock:(PlateBlock*)plateBlock code:(NSString *)code;
@end
