//
//  TimelineItemView.h
//

#import <UIKit/UIKit.h>
@protocol TimelineItemViewDelegate;

@interface TimelineItemView : UIView<UIGestureRecognizerDelegate>
{
    int _index;
    UILabel *_lbTitle;
    UIButton *_imageBtn;
}
@property (weak, nonatomic) id<TimelineItemViewDelegate> delegate;
@property (assign, nonatomic) int index;

- (void)setTitle:(NSString *)title;
- (void)setIcon:(NSString *)iconStr selIcon:(NSString *)selIconStr;
- (void)setSelected:(BOOL)b;
@end


@protocol TimelineItemViewDelegate <NSObject>
@optional
- (void)timelineItemView:(TimelineItemView*)timelineItemView selectedIndex:(int)index;

@end