/***************************************************************************
 
 Toast+UIView.h
 Toast
 Version 2.0
 
 Copyright (c) 2013 Charles Scalesse.
 
 Permission is hereby granted, free of charge, to any person obtaining a
 copy of this software and associated documentation files (the
 "Software"), to deal in the Software without restriction, including
 without limitation the rights to use, copy, modify, merge, publish,
 distribute, sublicense, and/or sell copies of the Software, and to
 permit persons to whom the Software is furnished to do so, subject to
 the following conditions:
 
 The above copyright notice and this permission notice shall be included
 in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
 OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
 MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
 IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
 CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
 TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
 SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 
 ***************************************************************************/


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIView (TKToast)


// each makeToast method creates a view and displays it as toast
- (void)makeTKToast:(NSString *)message;
- (void)makeTKToast:(NSString *)message duration:(CGFloat)interval position:(id)position;
- (void)makeTKToast:(NSString *)message duration:(CGFloat)interval position:(id)position title:(NSString *)title;
- (void)makeTKToast:(NSString *)message duration:(CGFloat)interval position:(id)position title:(NSString *)title image:(UIImage *)image;
- (void)makeTKToast:(NSString *)message duration:(CGFloat)interval position:(id)position image:(UIImage *)image;

// displays toast with an activity spinner
- (void)makeTKToastActivity;
- (void)makeTKToastActivity:(id)position;
- (void)hideTKToastActivity;

// the showToast methods display any view as toast
- (void)showTKToast:(UIView *)toast;
- (void)showTKToast:(UIView *)toast duration:(CGFloat)interval position:(id)point;

@end