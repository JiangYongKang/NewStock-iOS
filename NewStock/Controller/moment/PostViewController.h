//
//  PostViewController.h
//  NewStock
//
//  Created by Willey on 16/9/20.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "BaseViewController.h"
#import "PostFeedAPI.h"
#import "PostFeedPicAPI.h"
#import "GCPlaceholderTextView.h"

@interface PostViewController : BaseViewController<UIActionSheetDelegate,UITextViewDelegate,UIGestureRecognizerDelegate>
{
    PostFeedAPI *_postFeedAPI;
    PostFeedPicAPI *_postFeedPicAPI;
    
    GCPlaceholderTextView *_titleTV;
    GCPlaceholderTextView *_contentTV;
    
    UIButton *_typeBtn;
    UISwitch *_switch;
    NSString *_stag_code;
    NSString *_ams;
}

@property (nonatomic, strong) NSString *fid;
@property (nonatomic, strong) NSString *titleStr;
@property (nonatomic, strong) NSString *contentStr;
@property (nonatomic, strong) NSString *stag_code;
@property (nonatomic, strong) NSString *ams;

@end
