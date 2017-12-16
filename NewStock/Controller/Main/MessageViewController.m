//
//  MessageViewController.m
//  NewStock
//
//  Created by Willey on 16/8/18.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "MessageViewController.h"
#import "Defination.h"
#import "MessageModel.h"
#import "MarketConfig.h"
#import "WebViewController.h"
#import "MessageInstance.h"
#import "MessageCell.h"

@implementation MessageViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [_navBar setTitle:self.title];
    
    
    [_scrollView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(NAV_BAR_HEIGHT, 0, 0, 0));
    }];

    _curCount = 0;
    
    _tipsLb = [[UILabel alloc] init];
    _tipsLb.font = [UIFont systemFontOfSize:16];
    _tipsLb.text = @"暂无消息";
    _tipsLb.textAlignment = NSTextAlignmentCenter;
    _tipsLb.textColor = kUIColorFromRGB(0x808080);
    [_mainView addSubview:_tipsLb];
    [_tipsLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_mainView).offset(180);
        make.left.equalTo(_mainView).offset(0);
        make.right.equalTo(_mainView).offset(0);
        make.height.mas_equalTo(40);
    }];
    _tipsLb.hidden = YES;
    
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    //_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.separatorColor = kUIColorFromRGB(0xd3d3d3);
    _tableView.separatorInset = UIEdgeInsetsMake(0, 15, 0, 15);
    _tableView.tableFooterView = [UIView new];
    _tableView.bounces = NO;
    [_mainView addSubview:_tableView];
//    [[_tableView layer] setBorderWidth:0.5];
//    [[_tableView layer] setBorderColor:SEP_LINE_COLOR.CGColor];
//    [_tableView setSeparatorInset:UIEdgeInsetsZero];
//    [_tableView setLayoutMargins:UIEdgeInsetsZero];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_mainView);
//        make.width.equalTo(_scrollView);
//        make.height.equalTo(_scrollView).priorityMedium();
//        //make.height.equalTo(_scrollView).multipliedBy(1.5);
    }];
    
    
    _messageRequestAPI = [[MessageAPI alloc] init];
    _messageRequestAPI.mId = @"";
    _messageRequestAPI.delegate = self;
    _messageRequestAPI.animatingView = _mainView;
    [_messageRequestAPI start];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_resultListArray)
    {
        _curCount = [_resultListArray count];
        
        if (_curCount>0)
        {
            return _curCount;
        }
    }
    
    return 1;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_curCount>0)
    {
        /*
        if (indexPath.row<[_resultListArray count])
        {
            MessageModel *model = [_resultListArray objectAtIndex:indexPath.row];
            
            NSString *contentStr = model.c;//[NSString stringWithFormat:@"%@%@%@",model.c,model.c,model.c];//
            
            
            NSAttributedString *name = [[NSAttributedString alloc]initWithString:contentStr attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]}];
            CGRect contentStrRect = [name boundingRectWithSize:CGSizeMake(widthEx(290), CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin context:nil];
            CGSize contentStrSize = contentStrRect.size;
            
            return contentStrSize.height+heightEx(40);
        }
        */
        return 70;
    }
    
    return 50;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (_curCount>0)
    {
        static NSString *tiecellid=@"MessageCell";
        MessageCell *cell=[tableView dequeueReusableCellWithIdentifier:tiecellid];
        if (cell==nil)
        {
            cell=[[MessageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tiecellid];
        }
        
        //cell.selectionStyle=UITableViewCellSelectionStyleNone;

        MessageModel *model = [_resultListArray objectAtIndex:indexPath.row];
        NSString *contentStr = model.c;//[NSString stringWithFormat:@"%@%@%@",model.c,model.c,model.c];//model.c;
        NSString *timeStr = model.tm;
        NSString *titleStr = model.tt;
        NSString *icoStr = model.ico;
        
        [cell setName:titleStr time:timeStr content:contentStr];
        [cell setHeader:icoStr];
        
        return cell;
        
        /*
        static NSString *myCell = @"cell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:myCell];
        if(cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:myCell];
            cell.backgroundColor = [UIColor whiteColor];
            //cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            UILabel *timeLbl = [[UILabel alloc] initWithFrame:CGRectZero];
            timeLbl.tag = 100;
            timeLbl.font = [UIFont systemFontOfSize:11];
            timeLbl.textColor = kUIColorFromRGB(0xb2b2b2);
            timeLbl.textAlignment = NSTextAlignmentRight;
            [cell.contentView addSubview:timeLbl];
            
//            UIView *bgView = [[UIView alloc] initWithFrame:CGRectZero];
//            bgView.tag = 102;
//            bgView.backgroundColor = [UIColor whiteColor];
//            [cell.contentView addSubview: bgView];

            
            UILabel *contentLbl = [[UILabel alloc] initWithFrame:CGRectZero];
            contentLbl.tag = 101;
            contentLbl.backgroundColor = [UIColor clearColor];
            contentLbl.clipsToBounds = YES;
            contentLbl.font = [UIFont systemFontOfSize:16];
            contentLbl.textColor = kUIColorFromRGB(0x333333);
            contentLbl.numberOfLines = 0;
            [cell.contentView addSubview:contentLbl];
            
        }
        
        MessageModel *model = [_resultListArray objectAtIndex:indexPath.row];
        NSString *contentStr = model.c;//[NSString stringWithFormat:@"%@%@%@",model.c,model.c,model.c];//model.c;
        NSString *timeStr = model.tm;
        //NSString *titleStr = model.tt;
        
        NSAttributedString *name = [[NSAttributedString alloc]initWithString:contentStr attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]}];
        CGRect contentStrRect = [name boundingRectWithSize:CGSizeMake(widthEx(290), CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin context:nil];
        CGSize contentStrSize = contentStrRect.size;

        //int cellHeight = contentStrSize.height+heightEx(40);

        
        UILabel *timeLbl = (UILabel *)[cell.contentView viewWithTag:100];
        timeLbl.text = timeStr;
        timeLbl.frame = CGRectMake(15, contentStrSize.height+heightEx(15), _nMainViewWidth-30, 20);
        timeLbl.textColor = [SystemUtil hexStringToColor:@"#868686"];
        
        
//        UIView *bgView = (UIView *)[cell.contentView viewWithTag:102];
//        bgView.frame = CGRectMake(0, timeStrSize.height+heightEx(12), widthEx(304), contentStrSize.height+heightEx(16));
        
        UILabel *contentLbl = (UILabel *)[cell.contentView viewWithTag:101];
        contentLbl.text = contentStr;
        contentLbl.frame = CGRectMake(widthEx(15), heightEx(10), widthEx(290), contentStrSize.height) ;
        return cell;
        */
    }
    else
    {
        static NSString *nonCell = @"noncell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:nonCell];
        if(cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nonCell];
            cell.backgroundColor = [UIColor clearColor];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMakeEx(20, 10, 280, 30)];
        label.backgroundColor = [UIColor clearColor];
        label.text = @"暂无消息!";
        label.textAlignment = NSTextAlignmentCenter;
        [cell.contentView addSubview:label];
        
        
        return cell;
        
    }
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_curCount>0)
    {
        if (indexPath.row<[_resultListArray count])
        {
            MessageModel *model = [_resultListArray objectAtIndex:indexPath.row];
            
            WebViewController *viewController = [[WebViewController alloc] init];
            NSString *url = model.url;
            NSString *urlStr = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            viewController.myUrl = urlStr;
            [self.navigationController pushViewController:viewController animated:YES];
        }
    }
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}

- (void)requestFinished:(APIBaseRequest *)request {
    NSLog(@"succeed:%@",[request.responseJSONObject objectForKey:@"list"]);
    
    _resultListArray = [MTLJSONAdapter modelsOfClass:[MessageModel class] fromJSONArray:[request.responseJSONObject objectForKey:@"list"] error:nil];
    
    if ([_resultListArray count]>0)
    {
        MessageModel *model = [_resultListArray objectAtIndex:0];
        [[MessageInstance sharedMessageInstance] setMsgRead:model.mId];
        
    }
    
    [_tableView reloadData];

}

- (void)requestFailed:(APIBaseRequest *)request {
    NSLog(@"failed:%@",request.responseJSONObject);
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:[request.responseJSONObject objectForKey:@"msg"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alertView show];
    
}



@end
