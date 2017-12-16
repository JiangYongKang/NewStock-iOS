//
//  TKThemeManager.h
//  TKAppBase_V1
//
//  Created by liubao on 15-5-3.
//  Copyright (c) 2015年 liubao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NimbusCore.h"
#import "NimbusCSS.h"

/**
 *  @Author 刘宝, 2015-05-04 20:05:08
 *
 *  改变主题的消息通知
 */
#define NOTE_THEME_CHANGED @"note_theme_changed"

/**
 *  @Author 刘宝, 2015-05-03 23:05:06
 *
 *  皮肤管理类
 * <h2>Supported CSS Properties</h2>
 *
 @code
 UIView {
 border: <dimension> <ignored> <color> {view.layer.borderWidth view.layer.borderColor}
 border-color: <color>       {view.layer.borderColor}
 border-width: <dimension>   {view.layer.borderWidth}
 background-color: <color|image_name>   {view.backgroundColor}
 border-radius: <dimension>  {view.layer.cornerRadius}
 opacity: xx.xx              {view.alpha}
 -ios-autoresizing: [left|top|right|bottom|width|height|all|margins|dimensions]    {view.autoresizingMask}
 visibility: [hidden|visible] {view.hidden}
 width: [x%,xpx,auto]          {view.frameWidth}
 height: [x%,xpx,auto]         {view.frameHeight}
 padding: <vertical unit> <horizontal unit> {used in auto height and width calculations}
 -mobile-hpadding: <horizontal unit>   {used in auto width}
 -mobile-vpadding: <vertical unit>     {used in auto height}
 max-width: [x%,xpx]           {view.frameWidth}
 max-height: [x%,xps]          {view.frameHeight}
 min-width: [x%,xpx]           {view.frameWidth}
 min-height: [x%,xps]          {view.frameHeight}
 top: [x%,xpx]                 {view.frameMinY}
 left: [x%,xpx]                {view.frameMinX}
 bottom: [x%,xpx]              {view.frameMaxY}
 right: [x%,xpx]               {view.frameMaxX}
 -mobile-halign: [left|right|center]   {view.frameX}
 -mobile-valign: [top|bottom|middle]   {view.frameY}
 -mobile-relative: [#id|.prev|.next|.first|.last]  {controls the position of the view relative to another view}
 margin-top: [x%,xpx,auto]     {distance from view.frameMinY to relative.frameMaxY - % is relative to size of relative element, px is absolute, auto aligns the vertical centers}
 margin-bottom: [x%,xpx,auto]     {distance from view.frameMaxY to relative.frameMinY - % is relative to size of relative element, px is absolute, auto aligns the vertical centers}
 margin-left: [x%,xpx,auto]     {distance from view.frameMinX to relative.frameMaxX - % is relative to size of relative element, px is absolute, auto aligns the horizontal centers}
 margin-right: [x%,xpx,auto]     {distance from view.frameMaxX to relative.frameMinX - % is relative to size of relative element, px is absolute, auto aligns the horizontal centers}
 }
 
 UILabel {
 color: <color>                  {label.textColor}
 
 font: <font-size> <font-name>   {label.font}
 font-size: <font-size>          {label.font}
 font-family: <font-name>        {label.font}
 
 Can not be used in conjunction with font/font-family properties. Use the italic/bold font
 name instead.
 font-style: [italic|normal]     {label.font}
 font-weight: [bold|normal]      {label.font}
 
 text-align: [left|right|center] {label.textAlignment}
 
 text-shadow: <color> <x-offset> <y-offset> {label.shadowColor label.shadowOffset}
 
 -ios-highlighted-color: <color>      {label.highlightedTextColor}
 -ios-line-break-mode: [wrap|character-wrap|clip|head-truncate|tail-truncate|middle-truncate] [label.lineBreakMode]
 -ios-number-of-lines: xx             {label.numberOfLines}
 -ios-minimum-font-size: <font-size>  {label.minimumFontSize}
 -ios-adjusts-font-size: [true|false] {label.adjustsFontSizeToFitWidth}
 -ios-baseline-adjustment: [align-baselines|align-centers|none] {label.baselineAdjustment}
 -mobile-text-key: "Key Name"          {attaches a localized string (or the key name if not found) to this label}
 }
 
 UIButton {
 -mobile-title-insets
 -mobile-content-insets
 -mobile-image-insets
 font: <font-size> <font-name>   {button.font}
 
 Buttons also support pseudo selectors: :selected,:highlighted,:disabled with the following rules:
 color: <color>        {[button titleColorForState:]}
 text-shadow: <color>  {[button titleShadowColorForState:]}
 -mobile-image: url(image_name)
 -mobile-text-key: "Key Name"          {attaches a localized string (or the key name if not found) to this button}
 background-image: url(image_name)
 -mobile-background-stretch: top left bottom right
 -ios-button-adjust
 }
 
 UINavigationBar {
 -ios-tint-color: <color>  {navBar.tintColor}
 }
 
 UISearchBar {
 -ios-tint-color: <color>  {searchBar.tintColor}
 }
 
 UIToolbar {
 -ios-tint-color: <color>  {toolbar.tintColor}
 }
 @endcode
 */
@interface TKThemeManager : NSObject

/**
 *  @Author 刘宝, 2015-02-03 18:02:30
 *
 *  单例模式
 *
 *  @return
 */
+(TKThemeManager *)shareInstance;

/**
 *  @Author 刘宝, 2015-05-03 23:05:36
 *
 *  当前主题名称
 */
@property (nonatomic,copy)NSString *theme;

/**
 *  @Author 刘宝, 2015-05-04 02:05:54
 *
 *  刷新整个界面主题样式
 */
-(void)refreshCss;

/**
 *  @Author 刘宝, 2015-05-04 02:05:43
 *
 *  刷新局部界面主题样式
 *
 *  @param view 界面UI元素
 */
-(void)refreshCssForView:(UIView *)view;

/**
 *  @Author 刘宝, 2015-05-04 02:05:35
 *
 *  为界面UI绑定样式
 *
 *  @param view 界面UI元素
 */
- (void)addCssForView:(UIView *)view;

/**
 *  @Author 刘宝, 2015-05-04 02:05:22
 *
 *  为界面UI绑定样式类
 *
 *  @param cssClass 样式类名称
 *  @param view     界面UI元素
 */
-(void)addCssClass:(NSString *)cssClass forView:(UIView *)view;

/**
 *  @Author 刘宝, 2015-05-04 02:05:07
 *
 *  为界面元素绑定样式ID
 *
 *  @param cssId 样式Id名称
 *  @param view  界面UI元素
 */
-(void)addCssId:(NSString *)cssId forView:(UIView *)view;

/**
 *  @Author 刘宝, 2015-05-04 02:05:24
 *
 *  删除界面UI样式类
 *
 *  @param cssClass 样式类名称
 *  @param view     界面UI元素
 */
- (void)removeCssClass:(NSString*)cssClass forView:(UIView*)view;

/**
 *  @Author 刘宝, 2015-05-04 02:05:27
 *
 *  删除界面UI整个样式
 *
 *  @param view 界面UI元素
 */
- (void)removeCssForView:(UIView *)view;

/**
 *  @Author 刘宝, 2015-09-10 03:09:57
 *
 *  获取css配置的属性值对象
 *
 *  @param cssKey 可以是css类名称 如.class
                  或者是css的id 如#cssId
                  或者是组件的类名称 如UIButton
 *
 *  @return 值
 */
-(NICSSRuleset *)getCssRulesetByCssKey:(NSString *)cssKey;

@end
