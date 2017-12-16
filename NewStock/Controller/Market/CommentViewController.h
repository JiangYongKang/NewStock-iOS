//
//  CommentViewController.h
//  NewStock
//
//  Created by Willey on 16/9/19.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "BaseViewController.h"
#import "GCPlaceholderTextView.h"
#import "UserSuggestAPI.h"

@interface CommentViewController : BaseViewController<UITextViewDelegate,APIRequestDelegate>
{
    GCPlaceholderTextView *_textView;
    
    UserSuggestAPI *_userSuggestAPI;
}
@end
