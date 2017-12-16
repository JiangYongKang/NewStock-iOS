//
//  ListPopView.m
//

#import "ListPopView.h"
#import "SystemUtil.h"
#import "StockBaseInfoCell.h"
#import "StockPriceInfoCell.h"

@implementation ListPopView
@synthesize contentArray = _contentArray;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _contentArray = nil;
        _value = @"";
        _increaseValue = @"";
        _increase = @"";
        
        int titleHeight = 50;
        _titleLb = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, frame.size.width-20, titleHeight-5)];
        _titleLb.backgroundColor = [UIColor clearColor];
        _titleLb.textColor = [UIColor blackColor];
        _titleLb.font = [UIFont boldSystemFontOfSize:18.0f];
        _titleLb.text = @"";
        _titleLb.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_titleLb];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(5, titleHeight, frame.size.width-10, 0.5)];
        line.backgroundColor  = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:0.9];
        [self addSubview:line];
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(10, 10+titleHeight, frame.size.width-20, frame.size.height-10-titleHeight) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.bounces = NO;
        //_tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.separatorColor = [UIColor clearColor];
        //_tableView.rowHeight = 60;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.allowsSelection = NO;
        [self addSubview:_tableView];
        
    }
    return self;
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    _tableView.frame = CGRectMake(10, 10, frame.size.width-20, frame.size.height-20);
    
}

- (void)setContentArray:(NSMutableArray *)contentArray {
    _contentArray = contentArray;
    [_tableView reloadData];
}

- (void)setTitle:(NSString *)title value:(NSString *)value increaseValue:(NSString *)increaseValue increase:(NSString *)increase {
    _titleLb.text = title;
    _value = value;
    _increaseValue = increaseValue;
    _increase = increase;
    
    if ([value isEqualToString:@"--"]) {
        _increase = @"--";
    }
    
}

- (void)setUp:(NSString *)upStr plan:(NSString *)planStr down:(NSString *)downStr {
    _upStr = upStr;
    _planStr = planStr;
    _downStr = downStr;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0)
    {
        if(_upStr)
            return 70;
        else
            return 30;
    }
    else
    {
        return 56;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_contentArray)
    {
        return [_contentArray count]+1;
    }
    else
    {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0)
    {
        static NSString *cellid=@"StockPriceInfoCell";
        StockPriceInfoCell *cell=[tableView dequeueReusableCellWithIdentifier:cellid];
        if (cell==nil)
        {
            cell=[[StockPriceInfoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        }
        
        [cell setValue:_value increaceValue:_increaseValue increace:_increase];
        if(_upStr)[cell setUp:_upStr plan:_planStr down:_downStr];
        return cell;
    }
    else
    {
        static NSString *baseInfoCellid=@"StockBaseInfoCell";
        StockBaseInfoCell *cell=[tableView dequeueReusableCellWithIdentifier:baseInfoCellid];
        if (cell==nil)
        {
            cell=[[StockBaseInfoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:baseInfoCellid];
        }
        NSInteger row=[indexPath row]-1;
        NSDictionary *dic = [_contentArray objectAtIndex:row];
        
        [cell setDic:dic];
      
        if (row == [_contentArray count]-1)
        {
            [cell showSepLine:NO];
        }
        else
        {
            [cell showSepLine:YES];
        }
        
        return cell;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if([self.delegate respondsToSelector:@selector(listPopView:selectIndex:)])
    {
        [self.delegate listPopView:self selectIndex:indexPath.row];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self dismissPopup];
}

@end
