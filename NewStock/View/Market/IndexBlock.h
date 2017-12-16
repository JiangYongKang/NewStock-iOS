//
//  IndexBlock.h
//  NewStock
//
//  Created by Willey on 16/7/26.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,IndexBlockType) {
    IndexBlockTypeDefault,
    IndexBlockTypeMainPage,
};

@protocol IndexBlockDelegate;

@interface IndexBlock : UIView<UIGestureRecognizerDelegate>
{
    NSString *_strCode;

    UILabel *_lbTitle;
    UILabel *_lbValue;
    UILabel *_lbChange;
    UILabel *_lbChangeRate;
}
@property (weak, nonatomic) id<IndexBlockDelegate> delegate;

@property (assign, nonatomic) IndexBlockType type;

- (id)initWithDelegate:(id)theDelegate tag:(int)tag;
- (id)initWithDelegate:(id)theDelegate tag:(int)tag type:(IndexBlockType)type;

- (void)setCode:(NSString *)code title:(NSString *)title value:(NSString *)value change:(NSString *)change changeRate:(NSString *)changeRate;
@end


@protocol IndexBlockDelegate <NSObject>
@optional
- (void)indexBlock:(IndexBlock*)indexBlock code:(NSString *)code;

@end
