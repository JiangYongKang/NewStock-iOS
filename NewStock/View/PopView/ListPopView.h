//
//  ListPopView.h
//  


#import "PopView.h"

@protocol ListPopViewDelegate;

@interface ListPopView : PopView<UITableViewDataSource, UITableViewDelegate>
{
    UILabel *_titleLb;
    
    UITableView *_tableView;
    NSMutableArray *_contentArray;
    
    NSString *_value;
    NSString *_increaseValue;
    NSString *_increase;
    
    NSString *_upStr;
    NSString *_planStr;
    NSString *_downStr;
}
@property (nonatomic, assign) id<ListPopViewDelegate> delegate;
@property (nonatomic, strong) NSMutableArray *contentArray;

-(void)setTitle:(NSString *)title value:(NSString *)value increaseValue:(NSString *)increaseValue increase:(NSString *)increase;
-(void)setUp:(NSString *)upStr plan:(NSString *)planStr down:(NSString *)downStr;
@end


@protocol ListPopViewDelegate <NSObject>
@optional
- (void)listPopView:(ListPopView*)listPopView selectIndex:(long)index;
@end
