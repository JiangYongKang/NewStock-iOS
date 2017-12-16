//
//  SuggestViewController.h
//  NewStock
//
//  Created by Willey on 16/8/23.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "BaseViewController.h"
#import "GCPlaceholderTextView.h"
#import "UserSuggestAPI.h"

@interface SuggestViewController : BaseViewController<UITextViewDelegate,APIRequestDelegate,UITextFieldDelegate>
{
    GCPlaceholderTextView *_textView;
    UITextField *_telTF;
    
    UserSuggestAPI *_userSuggestAPI;
}
@end
