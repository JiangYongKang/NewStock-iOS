//
//  ProductSelView.h
//

#import <UIKit/UIKit.h>
#import "TimelineItemView.h"
@protocol ProductSelViewDelegate;

@interface ProductSelView : UIView<TimelineItemViewDelegate> //UIScrollView
{
    //UIView *_selView;
    NSMutableArray *_productItemArray;
    int _nItemWidth;
    int _nItemHeigh;
    int _nCurSelIndex;
    //BOOL _isManualAnimating;
}
@property (assign, nonatomic) id <ProductSelViewDelegate> delegate;

//-(void)setSelectedIndex:(int)index;
//-(int)getSelectedIndex;

@end


@protocol ProductSelViewDelegate <NSObject>

@optional

- (void)productSelView:(ProductSelView *)productSelView selectedIndex:(int)index;

@end
