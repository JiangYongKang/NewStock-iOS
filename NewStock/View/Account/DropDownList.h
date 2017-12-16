//
//  DropDownList.h

#import <UIKit/UIKit.h>


@protocol DropDownListDelegate;

@interface DropDownList : UIView<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
	UITextField *_textField;//文本输入框
//	NSMutableArray *list;//下拉列表数据
	BOOL showList;//是否弹出下拉列表
	BOOL isDrawList;//绘制下拉列表的开关
	BOOL showDropDownBtn;
	UITableView *listView;//下拉列表
	CGRect oldFrame,newFrame;//整个控件（包括下拉前和下拉后）的矩形
	UIColor *lineColor,*listBgColor;//下拉框的框色、背景色
	CGFloat lineWidth;//下拉框粗细
	UITextBorderStyle borderStyle;//文本边框style
	UIButton *dropDownBtn;
	int selectedRow;
	
}
@property (nonatomic,retain) UITextField *_textField;
@property (nonatomic,retain) NSArray *list;
@property (nonatomic,retain) UITableView *listView;
@property (nonatomic,retain) UIColor *lineColor,*listBgColor;
@property (nonatomic,assign) UITextBorderStyle borderStyle;
@property (nonatomic,assign) int selectedRow;
@property (nonatomic,assign) BOOL showDropDownBtn;
@property (nonatomic,assign) id<DropDownListDelegate> delegate;                       // default nil. weak reference
-(void)drawView;
-(void)drawList;
-(void)setShowList:(BOOL)b;
-(void)setshowDropDownBtn:(BOOL)b;

-(int)getSelectedRow;
-(void)setDropDownListFrame:(CGRect)rt;

@end

@protocol DropDownListDelegate
-(void)dropdownList:(DropDownList *)dropdownList didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)dropdownListDidBeginEditing:(DropDownList *)dropdownList;
- (void)dropdownListDidEndEditing:(DropDownList *)dropdownList;
- (void)dropdownList:(DropDownList *)dropdownList shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;

@end
