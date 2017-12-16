//
//  RecordHoldingController.m
//  NewStock
//
//  Created by Willey on 16/8/23.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "RecordHoldingController.h"
#import "AppDelegate.h"
#import "DEMOCustomAutoCompleteCell.h"
#import "MarketConfig.h"
#import "DEMOCustomAutoCompleteObject.h"
#import "UMMobClick/MobClick.h"

@interface RecordHoldingController ()

@property (nonatomic, strong) UILabel *lb_gu;

@property (nonatomic, strong) UILabel *lb_yuan;

@end

@implementation RecordHoldingController

- (UILabel *)lb_gu {
    if (_lb_gu == nil) {
        _lb_gu = [UILabel new];
        _lb_gu.textColor = kUIColorFromRGB(0x808080);
        _lb_gu.font = [UIFont systemFontOfSize:13];
        _lb_gu.text = @"股";
    }
    return _lb_gu;
}

- (UILabel *)lb_yuan {
    if (_lb_yuan == nil) {
        _lb_yuan = [UILabel new];
        _lb_yuan.textColor = kUIColorFromRGB(0x808080);
        _lb_yuan.font = [UIFont systemFontOfSize:13];
        _lb_yuan.text = @"元";
    }
    return _lb_yuan;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"录入持仓";
    [_navBar setTitle:self.title];
    [self setRightBtnTitle:@"完成"];
    _navBar.line_view.hidden = YES;
    
    [_scrollView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(NAV_BAR_HEIGHT, 0, 0, 0));
    }];
    [_scrollView layoutIfNeeded];
    
    _mainView.backgroundColor = [UIColor whiteColor];

    _resultArray = [[NSMutableArray alloc] init];
    
    _autocompleteDataSource = [[DEMODataSource alloc] init];
    
    _autoCompleteTF=[[MLPAutoCompleteTextField alloc] initWithFrame:CGRectMake(30, 20, _nMainViewWidth-60, 40)];
    _autoCompleteTF.font = [UIFont systemFontOfSize:16];
    _autoCompleteTF.placeholder = @"请输入股票代码或股票名称";//\\名称
    _autoCompleteTF.delegate = self;
    _autoCompleteTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    _autoCompleteTF.autoCompleteDelegate = self;
    _autoCompleteTF.autoCompleteDataSource = _autocompleteDataSource;
    _autoCompleteTF.backgroundColor = [UIColor clearColor];
    [_autoCompleteTF setAutoCompleteTableAppearsAsKeyboardAccessory:NO];
    [_mainView addSubview:_autoCompleteTF];
    [_autoCompleteTF registerAutoCompleteCellClass:[DEMOCustomAutoCompleteCell class]
                                       forCellReuseIdentifier:@"CustomCellId"];
    [_autoCompleteTF setMaximumNumberOfAutoCompleteRows:(_nMainViewHeight/50-4)];
    
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(_autoCompleteTF.frame.origin.x, _autoCompleteTF.frame.origin.y+_autoCompleteTF.frame.size.height, _autoCompleteTF.frame.size.width, 0.5)];
    line1.backgroundColor = SEP_LINE_COLOR;
    [_mainView addSubview:line1];
    
    _buyPriceTF = [[UITextField alloc] init];
    _buyPriceTF.backgroundColor = [UIColor whiteColor];
    _buyPriceTF.placeholder = @"请输入成本价";
    _buyPriceTF.delegate = self;
    _buyPriceTF.font = [UIFont systemFontOfSize:16];
    _buyPriceTF.keyboardType = UIKeyboardTypeDecimalPad;
    [_mainView addSubview:_buyPriceTF];
    [_buyPriceTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_autoCompleteTF.mas_bottom).offset(10);
        make.left.equalTo(_mainView).offset(30);
        make.right.equalTo(_mainView).offset(-30);
        make.height.mas_equalTo(40);
    }];
    
    [_buyPriceTF addSubview:self.lb_yuan];
    [self.lb_yuan mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.equalTo(_buyPriceTF);
    }];
    
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(_autoCompleteTF.frame.origin.x, _autoCompleteTF.frame.origin.y+_autoCompleteTF.frame.size.height+50, _autoCompleteTF.frame.size.width, 0.5)];
    line2.backgroundColor = SEP_LINE_COLOR;
    [_mainView addSubview:line2];
    
    _buyAmountTF = [[UITextField alloc] init];
    _buyAmountTF.backgroundColor = [UIColor whiteColor];
    _buyAmountTF.placeholder = @"请输入持股数";
    _buyAmountTF.delegate = self;
    _buyAmountTF.font = [UIFont systemFontOfSize:16];
    _buyAmountTF.keyboardType = UIKeyboardTypeDecimalPad;
    [_mainView addSubview:_buyAmountTF];
    [_buyAmountTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_buyPriceTF.mas_bottom).offset(10);
        make.left.equalTo(_mainView).offset(30);
        make.right.equalTo(_mainView).offset(-30);
        make.height.mas_equalTo(40);
    }];
    
    [_buyAmountTF addSubview:self.lb_gu];
    [self.lb_gu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.equalTo(_buyAmountTF);
    }];
    
    UIView *line3 = [[UIView alloc] initWithFrame:CGRectMake(_autoCompleteTF.frame.origin.x, _autoCompleteTF.frame.origin.y+_autoCompleteTF.frame.size.height+100, _autoCompleteTF.frame.size.width, 0.5)];
    line3.backgroundColor = SEP_LINE_COLOR;
    [_mainView addSubview:line3];

    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:self action:@selector(addBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"保存并继续添加" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.backgroundColor = kButtonBGColor;
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    btn.layer.cornerRadius = 6;
    btn.layer.masksToBounds = YES;
    [_mainView addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_buyAmountTF.mas_bottom).offset(50);
        make.left.equalTo(_mainView).offset(30);
        make.right.equalTo(_mainView).offset(-30);
        make.height.mas_equalTo(40);
    }];
    
    _uploadPositionAPI = [[UploadPositionAPI alloc] init];
    _uploadPositionAPI.delegate = self;
    
    _symbol = @"";
    _symbolTyp = @"";
    _marketCd = @"";
}

- (void)addBtnAction {
    _bContinue = YES;
    if ([_autoCompleteTF.text isEqualToString:@""])
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入股票代码!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
    }
    else if([_buyPriceTF.text isEqualToString:@""])
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入成本价!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
    }
    else if([_buyAmountTF.text isEqualToString:@""])
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入持股数!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
    }
    else if([_symbol isEqualToString:@""])
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请从下拉列表中选择股票！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
    }
    else
    {
        if ([SystemUtil isPureFloat:_buyPriceTF.text] && [SystemUtil isPureInt:_buyAmountTF.text])
        {
            _uploadPositionAPI.symbol = _symbol;
            _uploadPositionAPI.symbolTyp = _symbolTyp;
            _uploadPositionAPI.marketCd = _marketCd;
            
            _uploadPositionAPI.qty = _buyAmountTF.text;
            _uploadPositionAPI.inPrice = _buyPriceTF.text;
            
            [_uploadPositionAPI start];
        }
        else
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入正确的买入价格和买入量！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alertView show];
        }
        
    }
}

- (void)navBar:(NavBar*)navBar rightButtonTapped:(UIButton*)sender {

    [self addBtnAction];
    _bContinue = NO;

}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == 1001) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:YES];
        });
    }
}

- (void)requestFinished:(APIBaseRequest *)request {
    NSLog(@"succeed:%@",request.responseJSONObject);
    
    //事件统计
    NSDictionary *dict = @{@"name":_autoCompleteTF.text,@"buyPrice":_buyPriceTF.text,@"buyAmount":_buyAmountTF.text};
    [MobClick event:RECORD_HOLDING attributes:dict];
    
    _symbol = @"";
    _symbolTyp = @"";
    _marketCd = @"";
    
    _autoCompleteTF.text = @"";
    _buyPriceTF.text = @"";
    _buyAmountTF.text = @"";
    NSNumber *nub = [request.responseJSONObject objectForKey:@"code"];
    if (nub.integerValue == 0) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"添加成功！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        alertView.tag = _bContinue ? 0 : 1001;
        [alertView show];
    }else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:[request.responseJSONObject objectForKey:@"msg"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
    }
    
}

- (void)requestFailed:(APIBaseRequest *)request {
    //NSLog(@"failed:%@",request.responseJSONObject);
    
    if([SystemUtil isNotNSnull:request.responseJSONObject]) {
        NSString *msg = [request.responseJSONObject objectForKey:@"msg"];
        if ([SystemUtil isNotNSnull:msg]) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alertView show];
            
            return;
        }
    }
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"记录失败！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - MLPAutoCompleteTextField Delegate

- (BOOL)autoCompleteTextField:(MLPAutoCompleteTextField *)textField
          shouldConfigureCell:(UITableViewCell *)cell
       withAutoCompleteString:(NSString *)autocompleteString
         withAttributedString:(NSAttributedString *)boldedString
        forAutoCompleteObject:(id<MLPAutoCompletionObject>)autocompleteObject
            forRowAtIndexPath:(NSIndexPath *)indexPath; {
    //This is your chance to customize an autocomplete tableview cell before it appears in the autocomplete tableview
//    NSString *filename = [autocompleteString stringByAppendingString:@".png"];
//    filename = [filename stringByReplacingOccurrencesOfString:@" " withString:@"-"];
//    filename = [filename stringByReplacingOccurrencesOfString:@"&" withString:@"and"];
//    [cell.imageView setImage:[UIImage imageNamed:filename]];
    cell.detailTextLabel.text = @"test";
    return YES;
}

- (void)autoCompleteTextField:(MLPAutoCompleteTextField *)textField
  didSelectAutoCompleteString:(NSString *)selectedString
       withAutoCompleteObject:(id<MLPAutoCompletionObject>)selectedObject
            forRowAtIndexPath:(NSIndexPath *)indexPath {
    if(selectedObject){
        NSLog(@"selected object from autocomplete menu %@ with string %@", selectedObject, [selectedObject autocompleteString]);
        

        DEMOCustomAutoCompleteObject *object = selectedObject;
        _symbol = object.symbol;
        _symbolTyp = object.symbolTyp;
        _marketCd = object.marketCd;
        
    } else {
        NSLog(@"selected string '%@' from autocomplete menu", selectedString);
    }
}

- (void)autoCompleteTextField:(MLPAutoCompleteTextField *)textField willHideAutoCompleteTableView:(UITableView *)autoCompleteTableView {
    NSLog(@"Autocomplete table view will be removed from the view hierarchy");
}

- (void)autoCompleteTextField:(MLPAutoCompleteTextField *)textField willShowAutoCompleteTableView:(UITableView *)autoCompleteTableView {
    NSLog(@"Autocomplete table view will be added to the view hierarchy");
}

- (void)autoCompleteTextField:(MLPAutoCompleteTextField *)textField didHideAutoCompleteTableView:(UITableView *)autoCompleteTableView {
    NSLog(@"Autocomplete table view ws removed from the view hierarchy");
}

- (void)autoCompleteTextField:(MLPAutoCompleteTextField *)textField didShowAutoCompleteTableView:(UITableView *)autoCompleteTableView {
    NSLog(@"Autocomplete table view was added to the view hierarchy");
}

@end
