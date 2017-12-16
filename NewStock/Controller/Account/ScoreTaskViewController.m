//
//  ScoreTaskViewController.m
//  NewStock
//
//  Created by 王迪 on 2017/4/14.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "ScoreTaskViewController.h"
#import "ScoreTaskTableViewCell.h"
#import "ReviseNameViewController.h"
#import "ChangeHeadViewController.h"
#import "WebViewController.h"
#import "ScoreTaskCenterView.h"
#import "NativeUrlRedirectAction.h"
#import "GetMyScoreAPI.h"
#import "MyScoreModel.h"

#import "UserInfoInstance.h"
#import <UIImageView+WebCache.h>
#import "Defination.h"
#import <Masonry.h>

static NSString *cellID = @"scoreTaskCellID";

@interface ScoreTaskViewController ()< UITableViewDelegate , UITableViewDataSource, ScoreTaskCenterViewBtnClick>

@property (nonatomic, strong) UIImageView *userIcon;
@property (nonatomic, strong) UILabel *userNameLb;
@property (nonatomic, strong) UILabel *scoreLb;
@property (nonatomic, strong) UILabel *beatLb;
@property (nonatomic, strong) UILabel *todayScoreLb;
@property (nonatomic, strong) ScoreTaskCenterView *centerBlock;
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) GetMyScoreAPI *getMyScoreAPI;

@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation ScoreTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的积分";
    [_navBar setTitle:self.title];
    [_navBar setRightBtnImg:[UIImage imageNamed:@"ic_qusetion_nor"]];
    
    self.view.backgroundColor = [UIColor whiteColor];//kUIColorFromRGB(0xf1f1f1);
    
    [self setupUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self loadData];
}

- (void)setupUI {
    
    UIView *topView = [UIView new];
    topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(64);
        make.left.right.equalTo(self.view);
        make.height.equalTo(@(165 * kScale));
    }];
    
    UILabel *scoreLb = [UILabel new];
    scoreLb.text = @"的积分";
    scoreLb.font = [UIFont systemFontOfSize:11 * kScale];
    scoreLb.textColor = kUIColorFromRGB(0xb2b2b2);
    
    [topView addSubview:self.userIcon];
    [topView addSubview:self.userNameLb];
    [topView addSubview:scoreLb];
    [topView addSubview:self.scoreLb];
    [topView addSubview:self.beatLb];
    [topView addSubview:self.todayScoreLb];
    
    [self.userNameLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(topView);
        make.top.equalTo(topView).offset(15 * kScale);
    }];
    
    [self.userIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.userNameLb.mas_left).offset(-8 * kScale);
        make.centerY.equalTo(self.userNameLb);
        make.width.height.equalTo(@(24 * kScale));
    }];
    
    [scoreLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.userNameLb);
        make.left.equalTo(self.userNameLb.mas_right).offset(8 * kScale);
    }];
    
    [self.scoreLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.userIcon.mas_bottom).offset(8 * kScale);
        make.centerX.equalTo(topView);
    }];

    
    [self.beatLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.scoreLb.mas_bottom).offset(8 * kScale);
        make.centerX.equalTo(topView);
    }];
    
    [self.todayScoreLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(topView);
        make.top.equalTo(self.beatLb.mas_bottom).offset(5 * kScale);
    }];
    
    [self.view addSubview:self.centerBlock];
    [self.centerBlock mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(topView.mas_bottom).offset(10 * kScale);
        make.height.equalTo(@(155 * kScale));
    }];

    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.centerBlock.mas_bottom).offset(10 * kScale);
        make.right.left.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    
}

#pragma mark aciton

- (void)activityTap {
    NSString *url = [NSString stringWithFormat:@"%@%@",API_URL,H5_AC0001];
    NSString *urlStr = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    WebViewController *vc = [WebViewController new];
    vc.type = WEB_VIEW_TYPE_NOR;
    vc.myUrl = urlStr;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)navBar:(NavBar *)navBar rightButtonTapped:(UIButton *)sender {
    NSString *url = [NSString stringWithFormat:@"%@%@",API_URL,H5_JF0001];
    NSString *urlStr = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    WebViewController *vc = [WebViewController new];
    vc.type = WEB_VIEW_TYPE_TOPCLEAR;
    vc.myUrl = urlStr;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)ScoreTaskCenterViewBtnClick:(NSString *)str {
    [[NativeUrlRedirectAction sharedNativeUrlRedirectAction] redictNativeUrl:str];
}

#pragma mark request

- (void)loadData {
    [self.getMyScoreAPI start];
}

- (void)requestFinished:(APIBaseRequest *)request {
    NSLog(@"%@",request.responseJSONObject);
    if (request.responseJSONObject != nil) {
        [self analiseData:request.responseJSONObject];
    }
}

- (void)analiseData:(NSDictionary *)json {
    MyScoreModel *model = [MTLJSONAdapter modelOfClass:[MyScoreModel class] fromJSONDictionary:json error:nil];

    self.userNameLb.text = model.name;
    [self.userIcon sd_setImageWithURL:[NSURL URLWithString:model.ico]];
    self.scoreLb.text = [NSString stringWithFormat:@"%zd",model.sc.integerValue];
    [self setTextBeatLbText:[NSString stringWithFormat:@"%@%%",model.exd]];
    self.todayScoreLb.text = [NSString stringWithFormat:@"今日已获得 %zd 积分,还可获取 %zd 积分",model.tsc.integerValue,model.utsc.integerValue];
    
    self.centerBlock.array = model.day;
    self.dataArray = model.listInit;
    [self.tableView reloadData];
}

- (void)setTextBeatLbText:(NSString *)text {
    NSString *str = [NSString stringWithFormat:@"打败了 %@ 的股怪侠",text];
    NSRange range = [str rangeOfString:text];
    NSMutableAttributedString *nmAttrS = [[NSMutableAttributedString alloc] initWithString:str attributes:@{NSFontAttributeName : [UIFont fontWithName:@"PingFangSC-Light" size:11 * kScale],NSForegroundColorAttributeName : kUIColorFromRGB(0xb2b2b2)}];
    
    [nmAttrS addAttributes:@{NSFontAttributeName : [UIFont fontWithName:@"PingFangSC-Light" size:13 * kScale],NSForegroundColorAttributeName : kUIColorFromRGB(0x358ee7)} range:range];
    
    self.beatLb.attributedText = nmAttrS;
}

#pragma tableView

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {

    return 60 * kScale;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 32 * kScale;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WIDTH, 60 * kScale)];
    view.backgroundColor = kUIColorFromRGB(0xf1f1f1);

    
    UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(0, 10 * kScale, MAIN_SCREEN_WIDTH, 50 * kScale)];;
    lb.backgroundColor = [UIColor whiteColor];
    lb.textAlignment = NSTextAlignmentCenter;
    [view addSubview:lb];
    
    NSMutableAttributedString *nmS = [[NSMutableAttributedString alloc] init];
    
    NSAttributedString *attrS1 = [[NSAttributedString alloc] initWithString:@"去 " attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:16 * kScale],                          NSForegroundColorAttributeName : kUIColorFromRGB(0x333333)}];
    NSAttributedString *attrS2 = [[NSAttributedString alloc] initWithString:@"活动广场" attributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:16 * kScale],                          NSForegroundColorAttributeName : kTitleColor}];
    NSAttributedString *attrS3 = [[NSAttributedString alloc] initWithString:@" 兑换>>" attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:16 * kScale],                          NSForegroundColorAttributeName : kUIColorFromRGB(0x333333)}];
    [nmS appendAttributedString:attrS1];
    [nmS appendAttributedString:attrS2];
    [nmS appendAttributedString:attrS3];
    
    lb.attributedText = nmS.copy;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(activityTap)];
    
    lb.userInteractionEnabled = YES;
    [lb addGestureRecognizer:tap];
    
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor whiteColor];
    
    UILabel *blockLb = [UILabel new];
    blockLb.backgroundColor = kButtonBGColor;
    
    UILabel *lb = [UILabel new];
    lb.text = @"初始任务";
    lb.font = [UIFont systemFontOfSize:14 * kScale];
    lb.textColor = kUIColorFromRGB(0x333333);
    
    UILabel *line = [UILabel new];
    line.backgroundColor = kUIColorFromRGB(0xe4e4e4);
    
    [view addSubview:lb];
    [view addSubview:blockLb];
    [view addSubview:line];
    
    [lb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(view);
        make.left.equalTo(blockLb.mas_right).offset(8 * kScale);
    }];
    
    [blockLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view).offset(12 * kScale);
        make.centerY.equalTo(view);
        make.width.equalTo(@(3 * kScale));
        make.height.equalTo(@(14 * kScale));
    }];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(view);
        make.height.equalTo(@(0.5 * kScale));
    }];
    
    return view;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ScoreTaskTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    MyScoreListModel *model = self.dataArray[indexPath.row];
    
    cell.leftStr = model.n;
    cell.centerStr = [NSString stringWithFormat:@"%zd分",model.sc.integerValue];
    cell.isCompleted = model.t.integerValue == model.sc.integerValue;
    cell.url = model.url;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MyScoreListModel *model = self.dataArray[indexPath.row];
    if (model.t.integerValue == model.sc.integerValue) {
        return;
    }
    
    [[NativeUrlRedirectAction sharedNativeUrlRedirectAction] redictNativeUrl:model.url];
}

#pragma lazyloading

- (UIImageView *)userIcon {
    if (_userIcon == nil) {
        _userIcon = [[UIImageView alloc] init];;
        _userIcon.layer.cornerRadius = 12 * kScale;
        _userIcon.layer.masksToBounds = YES;
    }
    return _userIcon;
}

- (UILabel *)userNameLb {
    if (_userNameLb == nil) {
        _userNameLb = [UILabel new];
        _userNameLb.textColor = kUIColorFromRGB(0x333333);
        _userNameLb.font = [UIFont systemFontOfSize:15 * kScale];
    }
    return _userNameLb;
}

- (UILabel *)scoreLb {
    if (_scoreLb == nil) {
        _scoreLb = [UILabel new];
        _scoreLb.textColor = kUIColorFromRGB(0x358ee7);
        _scoreLb.font = [UIFont boldSystemFontOfSize:49 * kScale];
    }
    return _scoreLb;
}

- (UILabel *)beatLb {
    if (_beatLb == nil) {
        _beatLb = [UILabel new];
    }
    return _beatLb;
}

- (UILabel *)todayScoreLb {
    if (_todayScoreLb == nil) {
        _todayScoreLb = [UILabel new];
        _todayScoreLb.textColor = kUIColorFromRGB(0x666666);
        _todayScoreLb.font = [UIFont fontWithName:@"PingFangSC-Light" size:12 * kScale];
    }
    return _todayScoreLb;
}

- (ScoreTaskCenterView *)centerBlock {
    if (_centerBlock == nil) {
        _centerBlock = [ScoreTaskCenterView new];
        _centerBlock.backgroundColor = [UIColor whiteColor];
        _centerBlock.delegate = self;
    }
    return _centerBlock;
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.backgroundColor = kUIColorFromRGB(0xf1f1f1);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.scrollEnabled = NO;
        _tableView.separatorColor = kUIColorFromRGB(0xe4e4e4);
        _tableView.separatorInset = UIEdgeInsetsMake(0, 12, 0, 12);
        [_tableView registerClass:[ScoreTaskTableViewCell class] forCellReuseIdentifier:cellID];
    }
    return _tableView;
}

- (GetMyScoreAPI *)getMyScoreAPI {
    if (_getMyScoreAPI == nil) {
        _getMyScoreAPI = [[GetMyScoreAPI alloc] init];
        _getMyScoreAPI.delegate = self;
        _getMyScoreAPI.animatingView = self.view;
    }
    return _getMyScoreAPI;
}

@end
