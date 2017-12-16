//
//  JSGCommentView.m
//  blur_comment
//
//  Created by dai.fengyi on 15/5/15.
//  Copyright (c) 2015年 childrenOurFuture. All rights reserved.
//

#import "BlurCommentView.h"
#import "UIImageEffects.h"
#import "Defination.h"
#import <Masonry.h>

#import "EmotionKeyboardView.h"
#import "EmotionButton.h"
#import "EmotionAttachment.h"

#define ANIMATE_DURATION    0.3f
#define kMarginWH           10
#define kButtonWidth        60
#define kButtonHeight       24
#define kTextFont           [UIFont systemFontOfSize:14]
#define kTextViewHeight     100
#define kSheetViewHeight    (kMarginWH * 3 + kButtonHeight + kTextViewHeight)
@interface BlurCommentView () <UITextViewDelegate>

@property (strong, nonatomic) SuccessBlock success;
@property (weak, nonatomic) id<BlurCommentViewDelegate> delegate;
@property (strong, nonatomic) UIView *sheetView;
@property (strong, nonatomic) UITextView *commentTextView;
@property (nonatomic, strong) EmotionKeyboardView *keyboardView;
@property (nonatomic, strong) UILabel *totalLb;

@end

@implementation BlurCommentView

- (EmotionKeyboardView *)keyboardView {
    if (_keyboardView == nil) {
        _keyboardView = [[EmotionKeyboardView alloc] initWithFrame:CGRectMake(0, 0, 0, 220)];
    }
    return _keyboardView;
}

+ (void)commentshowInView:(UIView *)view success:(SuccessBlock)success delegate:(id <BlurCommentViewDelegate>)delegate {
    BlurCommentView *commentView = [[BlurCommentView alloc] initWithFrame:view.bounds];
    if (commentView) {
        //挡住响应
        commentView.userInteractionEnabled = YES;
        //增加EventResponsor
        [commentView addEventResponsors];
        //block or delegate
        commentView.success = success;
        commentView.delegate = delegate;
        //截图并虚化
        //commentView.image = [UIImageEffects imageByApplyingLightEffectToImage:[commentView snapShot:view]];
        commentView.image = [commentView snapShot:view];
        
        [view addSubview:commentView];
        [view addSubview:commentView.sheetView];
        [commentView.commentTextView becomeFirstResponder];
    }
}

- (void)commentshowInView:(UIView *)view andView:(BlurCommentView *)commentView success:(SuccessBlock)success delegate:(id <BlurCommentViewDelegate>)delegate {

    if (commentView) {
        //挡住响应
        commentView.userInteractionEnabled = YES;
        //增加EventResponsor
        [commentView addEventResponsors];
        //block or delegate
        commentView.success = success;
        commentView.delegate = delegate;
        //截图并虚化
        //commentView.image = [UIImageEffects imageByApplyingLightEffectToImage:[commentView snapShot:view]];
        commentView.image = [commentView snapShot:view];
        
        [view addSubview:commentView];
        [view addSubview:commentView.sheetView];
        [commentView.commentTextView becomeFirstResponder];
    }

}

#pragma mark - 外部调用
+ (void)commentshowSuccess:(SuccessBlock)success {
    [BlurCommentView commentshowInView:[UIApplication sharedApplication].keyWindow success:success delegate:nil];
}

+ (void)commentshowDelegate:(id<BlurCommentViewDelegate>)delegate {
    [BlurCommentView commentshowInView:[UIApplication sharedApplication].keyWindow success:nil delegate:delegate];
}

+ (void)commentshowInView:(UIView *)view success:(SuccessBlock)success {
    [BlurCommentView commentshowInView:view success:success delegate:nil];
}

+ (void)commentshowInView:(UIView *)view delegate:(id<BlurCommentViewDelegate>)delegate {
    [BlurCommentView commentshowInView:view success:nil delegate:delegate];
}
#pragma mark - 内部调用
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubviews];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(inputEmotion:) name:@"KSelectEmoticon" object:nil];
    }
    return self;
}

- (void)initSubviews {
    self.alpha = 0;
    
    CGRect rect = self.bounds;
    _sheetView = [[UIView alloc] initWithFrame:CGRectMake(0, rect.size.height - kSheetViewHeight, rect.size.width, kSheetViewHeight)];
    _sheetView.backgroundColor = [UIColor whiteColor];//kUIColorFromRGB(0xedf1f5)
    
    _commentTextView = [[UITextView alloc] initWithFrame:CGRectMake(kMarginWH, kMarginWH, rect.size.width - kMarginWH * 2, kTextViewHeight)];
    _commentTextView.layer.borderColor = kUIColorFromRGB(0xd3d3d3).CGColor;
    _commentTextView.layer.borderWidth = 0.7;
    _commentTextView.layer.cornerRadius = 5;
    _commentTextView.delegate = self;
    _commentTextView.font = [UIFont systemFontOfSize:16 * kScale];
    _commentTextView.text = nil;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [_commentTextView addGestureRecognizer:tap];
    [_sheetView addSubview:_commentTextView];

    
    UIButton *commentButton = [UIButton buttonWithType:UIButtonTypeCustom];
    commentButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin;
    [commentButton setTitle:@"发表评论" forState:UIControlStateNormal];
    [commentButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [commentButton setBackgroundColor:kUIColorFromRGB(0x358ee7)];
    commentButton.titleLabel.font = [UIFont systemFontOfSize:12 * kScale];
    commentButton.layer.cornerRadius = 5;
    [commentButton addTarget:self action:@selector(comment:) forControlEvents:UIControlEventTouchUpInside];
    [_sheetView addSubview:commentButton];
    [commentButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_sheetView).offset(-10);
        make.right.equalTo(_sheetView).offset(-10);
        make.width.equalTo(@kButtonWidth);
        make.height.equalTo(@kButtonHeight);
    }];
    
    _btn = [[UIButton alloc] init];
    [_btn setImage:[UIImage imageNamed:@"ic_biaoqing_nor"] forState:UIControlStateNormal];
    [_btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_sheetView addSubview:_btn];
    [_btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(commentButton);
        make.left.equalTo(_sheetView).offset(10);
    }];
    
    [_sheetView addSubview:self.totalLb];
    [self.totalLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_btn);
        make.right.equalTo(commentButton.mas_left).offset(-10 * kScale);
    }];
    
}

- (void)btnClick:(UIButton *)btn {
    if (_commentTextView.inputView == nil) {
        _commentTextView.inputView = self.keyboardView;
        [_btn setImage:[UIImage imageNamed:@"ic_keyboard_nor"] forState:UIControlStateNormal];
    } else {
        _commentTextView.inputView = nil;
        [_btn setImage:[UIImage imageNamed:@"ic_biaoqing_nor"] forState:UIControlStateNormal];
    }
    [_commentTextView reloadInputViews];
}

- (UIImage *)snapShot:(UIView *)view {
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, YES, 0.0f);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (void)addEventResponsors {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    UITapGestureRecognizer *singleTap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(buttonpress:)];
    [self addGestureRecognizer:singleTap1];
}

#pragma mark - Botton Action

- (void)tap:(UITapGestureRecognizer *)tap {
    if (_commentTextView.inputView == nil) {
        _commentTextView.inputView = self.keyboardView;
        [_commentTextView reloadInputViews];
    }
}

- (void)cancelComment:(id)sender {
    [_sheetView endEditing:YES];
}

- (void)comment:(id)sender {
    //[_commentTextView resignFirstResponder];

    [_sheetView endEditing:YES];
    
    NSMutableString *nmStr = [NSMutableString string];
    
    [_commentTextView.attributedText enumerateAttributesInRange:NSMakeRange(0, _commentTextView.attributedText.length) options:0 usingBlock:^(NSDictionary<NSString *,id> * _Nonnull attrs, NSRange range, BOOL * _Nonnull stop) {
        EmotionAttachment *attach = attrs[@"NSAttachment"];
        if ([attach isKindOfClass:[EmotionAttachment class]]) {
            [nmStr appendString:attach.chs];
        } else {
            [nmStr appendString:[_commentTextView.text substringWithRange:range]];
        }
    }];

    //发送请求
    if (_success) {
        _success(nmStr.copy);
    }
    
    if ([_delegate respondsToSelector:@selector(commentDidFinished:)]) {
        [_delegate commentDidFinished:nmStr.copy];
    }
    
}

- (void)dismissCommentView {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self removeFromSuperview];
    [_sheetView removeFromSuperview];
}

#pragma mark textView delegate

- (void)textViewDidChange:(UITextView *)textView {
    NSString *str = [NSString stringWithFormat:@"%zd字",300 - textView.attributedText.length];
    self.totalLb.text = str;
}

//点击事件
- (void)buttonpress:(UIGestureRecognizer *)gestureRecognizer {
    if (self.sendSaveText) {
        self.sendSaveText(_commentTextView.attributedText);
    }
    [_sheetView endEditing:YES];
}

- (void)inputEmotion:(NSNotification *)noti {
    if (noti.object == nil) {
        [_commentTextView deleteBackward];
        return;
    }
    
    CGFloat lineH = _commentTextView.font.lineHeight;
    
    EmotionButton *btn = noti.object;
    
    EmotionAttachment *attach = [EmotionAttachment new];
    attach.image = btn.attach.image;
    attach.chs = btn.attach.chs;
    
    attach.bounds = CGRectMake(0, -5, lineH, lineH);
    
    NSMutableAttributedString *nmAttrStr = [[NSMutableAttributedString alloc] initWithAttributedString:[NSAttributedString attributedStringWithAttachment:attach]];
    
    [nmAttrStr addAttributes:@{
                               NSFontAttributeName : _commentTextView.font
                               } range:NSMakeRange(0, 1)];
    
    NSMutableAttributedString *strM = [[NSMutableAttributedString alloc] initWithAttributedString:_commentTextView.attributedText];
    
    NSRange range = _commentTextView.selectedRange;
    
    [strM replaceCharactersInRange:range withAttributedString:nmAttrStr];
    
    _commentTextView.attributedText = strM;
    
    _commentTextView.selectedRange = NSMakeRange(range.location + 1, 0);
    
    [_commentTextView.delegate textViewDidChange:_commentTextView];
}

#pragma mark - Keyboard Notification Action
- (void)keyboardWillShow:(NSNotification *)aNotification {
    NSLog(@"%@", aNotification);
    if (self.saveText != nil && _commentTextView.attributedText.length == 0) {
        _commentTextView.attributedText = self.saveText;
    }

    CGFloat keyboardHeight = [[aNotification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    NSTimeInterval animationDuration = [[aNotification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:animationDuration animations:^{
        self.alpha = 1;
        _sheetView.frame = CGRectMake(0, self.superview.bounds.size.height - _sheetView.bounds.size.height - keyboardHeight, _sheetView.bounds.size.width, kSheetViewHeight);
    } completion:nil];
}

- (void)keyboardWillHide:(NSNotification *)aNotification {
    self.saveText = _commentTextView.attributedText;
    NSDictionary *userInfo = [aNotification userInfo];
    NSTimeInterval animationDuration = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:animationDuration animations:^{
        self.alpha = 0;
        _sheetView.frame = CGRectMake(0, self.superview.bounds.size.height, _sheetView.bounds.size.width, kSheetViewHeight);
    } completion:^(BOOL finished){
        [self dismissCommentView];
    }];
}

- (UILabel *)totalLb {
    if (_totalLb == nil) {
        _totalLb = [UILabel new];
        _totalLb.font = [UIFont systemFontOfSize:11 * kScale];
        _totalLb.textColor = kUIColorFromRGB(0x666666);
    }
    return _totalLb;
}

@end
