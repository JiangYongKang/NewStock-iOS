//
//  DropDownList.m

#import "DropDownList.h"


@implementation DropDownList
@synthesize _textField;
@synthesize list;
@synthesize listView;
@synthesize lineColor,listBgColor;
@synthesize  borderStyle;
@synthesize selectedRow;
@synthesize  delegate;
@synthesize showDropDownBtn;

//数组的长度
static NSInteger arrayLength;

- (id)initWithFrame:(CGRect)frame 
{
    
    self = [super initWithFrame:frame];
    if (self) 
    {
        borderStyle=UITextBorderStyleNone;//UITextBorderStyleRoundedRect;
		showList=NO;//默认不显示下拉框
		isDrawList=NO;//绘制下拉列表的开关
		oldFrame=frame;//未下拉时控件初始大小
		lineColor=[UIColor lightGrayColor];//默认列表边框为灰色
		listBgColor=[UIColor whiteColor];//默认列表框背景为白色
		lineWidth=1;//默认列表边框粗细为1
		selectedRow=0;
		
		//把背景色设置为透明色，否则会有一个黑色的边
		self.backgroundColor=[UIColor clearColor];
		[self drawView];//调用方法，绘制控制
    }
    return self;
}

//drawView方法绘制一个文本框;
-(void)drawView
{
	_textField=[[UITextField alloc] initWithFrame:CGRectMake(0,0,oldFrame.size.width,oldFrame.size.height)];
	_textField.borderStyle=borderStyle;
	_textField.textAlignment = NSTextAlignmentLeft;
    _textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    //_textField.enabled = NO;
	_textField.delegate = self;
	[self addSubview:_textField];
	//[_textField addTarget:self action:@selector(dropdown) forControlEvents:UIControlEventAllTouchEvents];
    
    //余额查询
    UIImage *imgBt1	= [UIImage imageNamed:@"closeup.png"];
    UIImage *imgBt2	= [UIImage imageNamed:@"dropdown.png"];
	
	dropDownBtn	= [UIButton buttonWithType:UIButtonTypeCustom];
	[dropDownBtn setFrame:CGRectMake(160, 0, 40, 40)];
	[dropDownBtn setImage:imgBt1 forState:UIControlStateNormal];
    [dropDownBtn setImage:imgBt2 forState:UIControlStateSelected];
	[dropDownBtn addTarget:self action:@selector(dropdown:) forControlEvents:UIControlEventTouchUpInside];
	[self addSubview:dropDownBtn];
	showDropDownBtn=TRUE;

}

//画下拉列表
-(void)drawList
{
	arrayLength=[self.list count];
	int listHeighe = (arrayLength>8?8:arrayLength)*(oldFrame.size.height-5);
	//listHeighe = listHeighe<30?30:listHeighe;
	newFrame=CGRectMake(oldFrame.origin.x, oldFrame.origin.y, oldFrame.size.width, oldFrame.size.height + listHeighe);
	listView=[[UITableView alloc]initWithFrame:CGRectMake(lineWidth, oldFrame.size.height+lineWidth, oldFrame.size.width-lineWidth*2, listHeighe-lineWidth*2)];
	listView.dataSource=self;
	listView.delegate=self;
	listView.backgroundColor=[UIColor clearColor];
	listView.separatorColor=lineColor;
	listView.hidden=!showList;
	isDrawList=YES;
	[self addSubview:listView];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	[textField resignFirstResponder];
	return YES;
}

//dropdown方法
-(void)dropdown:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    
	[_textField resignFirstResponder];
	if (showList)
    {//如果下拉框显示，什么都不做
        btn.selected = NO;
        [self setShowList:NO];
		return;
	}
    else 
    {//如果下拉框尚未显示，则进行显示
		//把dropdownlist放到前面，防止下拉框被别的控件遮住
        btn.selected = YES;
		if (!isDrawList)
        {
			[self drawList];
		}
		[self.superview bringSubviewToFront:self];
		[self setShowList:YES];//显示下拉框
	}
	
}

//数据源绑定
#pragma mark listViewdataSource method and delegate method
//返回每个分区要显示的数据的行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [self.list count];
	
}

//生成可重用的cell填充每列
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *cellid=@"listviewid";
	UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellid];
	if (cell==nil) 
    {
		cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
	}
	NSInteger row=[indexPath row];
	cell.textLabel.text=(NSString *)[list objectAtIndex:row];
	cell.textLabel.font=_textField.font;
	cell.selectionStyle=UITableViewCellSelectionStyleBlue;
	//[cell setAccessoryType:UITableViewCellAccessoryDetailDisclosureButton];
	//[cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
	//[cell setAccessoryType:UITableViewCellAccessoryCheckmark];
	cell.textLabel.textAlignment = NSTextAlignmentCenter;
	
	cell.contentView.backgroundColor=[UIColor colorWithRed:0.40 green:0.43 blue:0.46 alpha:0.92];
	cell.textLabel.backgroundColor = [UIColor clearColor];
    //UIView *backgrdView = [[UIView alloc] initWithFrame:cell.frame];
	//    backgrdView.backgroundColor = [UIColor colorWithRed:0.40 green:0.43 blue:0.46 alpha:0.8];
	//    cell.backgroundView = backgrdView;
	
	return cell;
}
//计算每列的显示高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return oldFrame.size.height-5;
}
//数据源绑定结束

//当选择下拉列表中的一行时，设置文本框中的值，隐藏下拉列表
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	selectedRow = (int)[indexPath row];
	_textField.text=(NSString *)[list objectAtIndex:[indexPath row]];
	dropDownBtn.selected = NO;
	[self setShowList:NO];
	[delegate dropdownList:self didSelectRowAtIndexPath:indexPath];
}

-(void)setshowDropDownBtn:(BOOL)b
{
	showDropDownBtn = b;
	if (showDropDownBtn)
	{
		dropDownBtn.hidden = NO;
	}
	else 
	{
		dropDownBtn.hidden = YES;
	}

}

-(int)getSelectedRow
{
	return selectedRow;
}

//根据给定的参数隐藏或显示下拉框
-(BOOL)showList
{
	return showList;
}

-(BOOL)isDrawList
{
	return isDrawList;
}

//下拉列表显示开关
-(void)setShowList:(BOOL)b
{
	arrayLength=[self.list count];
	int listHeighe = (arrayLength>8?8:arrayLength)*(oldFrame.size.height-5);
	newFrame=CGRectMake(oldFrame.origin.x, oldFrame.origin.y, oldFrame.size.width, oldFrame.size.height + listHeighe);
	listView.frame=CGRectMake(lineWidth, oldFrame.size.height+lineWidth, oldFrame.size.width-lineWidth*2, listHeighe-lineWidth*2);
	
	showList=b;
	if (showList) 
    {
		self.frame=newFrame;
		dropDownBtn.selected = YES;
	}else 
    {
		self.frame=oldFrame;
		dropDownBtn.selected = NO;
	}
	listView.hidden=!b;
	
	//[listView reloadData];
	[self setNeedsDisplay];
}

//为先拉列表画边框
-(void)drawRect:(CGRect)rect
{
	CGContextRef ctx=UIGraphicsGetCurrentContext();
	CGRect drawRect;
	if (showList) 
    {
		CGContextSetStrokeColorWithColor(ctx, [lineColor CGColor]);
		drawRect=listView.frame;
		CGContextStrokeRect(ctx, drawRect);
	}
    else 
    {
		return;
	}
}

-(void)setDropDownListFrame:(CGRect)rt
{
	self.frame = rt;
	oldFrame = rt;
}
    
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (!textField.window.isKeyWindow) {
        [textField.window makeKeyAndVisible];
    }
    
	[self setShowList:YES];
	[delegate dropdownListDidBeginEditing:self];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    //if([delegate respondsToSelector:@selector(dropdownListDidEndEditing:)])
    {
        [delegate dropdownListDidEndEditing:self];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    //if([delegate respondsToSelector:@selector(dropdownList:shouldChangeCharactersInRange:replacementString:)])
    {
        [delegate dropdownList:self shouldChangeCharactersInRange:range replacementString:string];
    }
    return YES;
}
@end
