//
//  ToolBarView.h
//  NewStock
//
//  Created by Willey on 16/8/18.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, TOOLBAR_TYPE) {
    TOOLBAR_TYPE_COMMENT_ONLY,
    TOOLBAR_TYPE_COMMENT_AMS,
};


typedef NS_ENUM(NSInteger, TOOLBAR_ACTION_INDEX) {
    TOOLBAR_ACTION_REPLY,
    TOOLBAR_ACTION_CHOOSE_AMS,
};

@protocol ToolBarViewDelegate;

@interface ToolBarView : UIView<UITextFieldDelegate>
{
    UITextField *_tf;
}
@property (weak, nonatomic) id<ToolBarViewDelegate> delegate;
@property (nonatomic, assign) TOOLBAR_TYPE type;
@property (nonatomic, copy) NSString *placeHolderStr;
@property (nonatomic, assign) BOOL isEmoticomAction;
@property (nonatomic, assign) BOOL isUpdateCons;

- (id)initWithType:(TOOLBAR_TYPE)type;

@end

@protocol ToolBarViewDelegate <NSObject>
@optional
- (void)toolBarView:(ToolBarView*)toolBarView actionIndex:(TOOLBAR_ACTION_INDEX)index;
@end
