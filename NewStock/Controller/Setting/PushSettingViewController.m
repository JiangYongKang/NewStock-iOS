//
//  PushSettingViewController.m
//  NewStock
//
//  Created by Willey on 16/8/30.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "PushSettingViewController.h"
#import "SettingInfoModel.h"
#import "JPUSHService.h"

@interface PushSettingViewController ()<UIActionSheetDelegate>

@property (nonatomic, strong) ZFSettingItem *item01;
@property (nonatomic, strong) ZFSettingItem *item02;
@property (nonatomic, strong) NSArray *selectedArray;
@property (nonatomic) int curSelIndex;

@property (nonatomic, strong) GetUserSettingAPI *getUserSettingAPI;
@property (nonatomic, strong) SetUserSettingAPI *setUserSettingAPI;
@end


@implementation PushSettingViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"推送设置";
    [_navBar setTitle:self.title];
    
    //    [_scrollView mas_remakeConstraints:^(MASConstraintMaker *make) {
    //        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(NAV_BAR_HEIGHT, 0, 0, 0));
    //    }];
    //    [_scrollView layoutIfNeeded];
    
    self.selectedArray = [[NSArray alloc] initWithObjects:@"7:00-24:00",
                      @"9:00-16:00",
                      @"0:00-24:00", nil];
    
    self.curSelIndex = 0;
    
    [self add0SectionItems];
  
    
    self.getUserSettingAPI = [[GetUserSettingAPI alloc] init];
    NSString *userId = [SystemUtil getCache:USER_ID];
    self.getUserSettingAPI.userId = userId;
    self.getUserSettingAPI.pres_code = @"";//T_TSKG
    self.getUserSettingAPI.delegate = self;
    self.getUserSettingAPI.animatingView = _mainView;
    self.getUserSettingAPI.animatingText = @"正在加载";
    [self.getUserSettingAPI start];

    
    
    self.setUserSettingAPI = [[SetUserSettingAPI alloc] init];
    self.setUserSettingAPI.userId = userId;
    self.setUserSettingAPI.animatingView = _mainView;
    self.setUserSettingAPI.animatingText = @"正在修改";
}

- (void)add0SectionItems {
    __weak typeof(self) weakSelf = self;
    
    self.item01 = [ZFSettingItem itemWithIcon:@"" title:@"推送开关" type:ZFSettingItemTypeSwitch];//about_icon
    self.item01.switchBlock = ^(BOOL on) {
        
        //weakSelf.item01.switchBlock = ^(BOOL on) {
            if (on) {
                
                weakSelf.item02.detail = [weakSelf.selectedArray objectAtIndex:weakSelf.curSelIndex];

                weakSelf.setUserSettingAPI.cv = @"true";
                NSString *userId = [SystemUtil getCache:USER_ID];
                NSSet *tags = [[NSSet alloc] initWithObjects:@"ios",@"open",nil];
                [JPUSHService setTags:tags alias:userId fetchCompletionHandle:nil];
            }
            else
            {
                weakSelf.item02.detail = @"";
                
                weakSelf.setUserSettingAPI.cv = @"false";
                NSString *userId = [SystemUtil getCache:USER_ID];
                NSSet *tags = [[NSSet alloc] initWithObjects:@"ios",@"close",nil];
                [JPUSHService setTags:tags alias:userId fetchCompletionHandle:nil];
            }
            
            weakSelf.setUserSettingAPI.res_code = @"T_TSKG";//@"T_TSSZ";//@"T_HQSXPL";//
            [weakSelf.setUserSettingAPI startWithCompletionBlockWithSuccess:^(APIBaseRequest *request) {
                NSLog(@"_setUserSettingAPI:%@",request.responseJSONObject);
                
            } failure:^(APIBaseRequest *request) {
                NSLog(@"failed");
            }];
        //};
    };
    
    self.item02 = [ZFSettingItem itemWithIcon:@"" title:@"接受推送时间段" type:ZFSettingItemTypeDetail detail:[self.selectedArray objectAtIndex:self.curSelIndex]];//about_icon
    self.item02.operation = ^{
        
        UIActionSheet * actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                                  delegate:weakSelf
                                                         cancelButtonTitle:@"取消"
                                                    destructiveButtonTitle:nil
                                                         otherButtonTitles:[weakSelf.selectedArray objectAtIndex:0], [weakSelf.selectedArray objectAtIndex:1], [weakSelf.selectedArray objectAtIndex:2], nil];
        actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
        [actionSheet showInView:weakSelf.view];
    };
    
    ZFSettingGroup *group = [[ZFSettingGroup alloc] init];
    //group.header = @"基本设置";
    group.items = @[self.item01,self.item02];//
    [_allGroups addObject:group];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSString *sv;
    NSString *ev;
    if (buttonIndex == 0)
    {
        self.curSelIndex = 0;
        self.item02.detail = [_selectedArray objectAtIndex:0];
        
        sv = @"07:00";
        ev = @"24:00";
    }
    else if (buttonIndex == 1)
    {
        self.curSelIndex = 1;
        self.item02.detail = [_selectedArray objectAtIndex:1];
        
        sv = @"09:00";
        ev = @"16:00";
    }
    else if (buttonIndex == 2)
    {
        self.curSelIndex = 2;
        self.item02.detail = [_selectedArray objectAtIndex:2];
        
        sv = @"00:00";
        ev = @"24:00";
    }
    [_tableView reloadData];
    
    self.setUserSettingAPI.res_code = @"T_JSTSSJD";
    self.setUserSettingAPI.sv = sv;
    self.setUserSettingAPI.ev = ev;
    [self.setUserSettingAPI startWithCompletionBlockWithSuccess:^(APIBaseRequest *request) {
        NSLog(@"_setUserSettingAPI:%@",request.responseJSONObject);
        
    } failure:^(APIBaseRequest *request) {
        NSLog(@"failed");
    }];
}

- (void)analysisData:(NSArray *)json {
    NSArray * array = [MTLJSONAdapter modelsOfClass:[SettingInfoModel class] fromJSONArray:json error:nil];

    
    for (int i=0; i< [array count]; i++)
    {
        SettingInfoModel *model = [array objectAtIndex:i];
        NSString *res_code = model.res_code;

        if ([res_code isEqualToString:@"T_TSKG"])
        {
            NSString *cv = model.cv;
            if ([cv isEqualToString:@"false"])
            {
                self.item01.switchOn = NO;
            }
            else
            {
                self.item01.switchOn = YES;
            }
        }
        else if([res_code isEqualToString:@"T_JSTSSJD"])
        {
            NSString *sv = model.sv;
            NSString *ev = model.ev;

            self.item02.detail = [NSString stringWithFormat:@"%@-%@",sv,ev];
//            if ([sv isEqualToString:@"07:00"])
//            {
//                
//            }
            
        }
    }
    
    [_tableView reloadData];
}

- (void)requestFinished:(APIBaseRequest *)request {
    NSLog(@"succeed:%@",request.responseJSONObject);
    [self analysisData:request.responseJSONObject];
    
}

- (void)requestFailed:(APIBaseRequest *)request {
    NSLog(@"failed");
}

@end
