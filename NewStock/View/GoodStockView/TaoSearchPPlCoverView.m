//
//  TaoSearchPPlCoverView.m
//  NewStock
//
//  Created by 王迪 on 2017/3/6.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "TaoSearchPPlCoverView.h"
#import "Defination.h"
#import <Masonry.h>
#import "StockCodesInstance.h"
#import "TaoHotPeopleModel.h"


@interface TaoSearchPPlCoverView () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UILabel *hotLb;

@property (nonatomic, strong) UILabel *hotLb1;
@property (nonatomic, strong) UILabel *hotLb2;
@property (nonatomic, strong) UILabel *hotLb3;
@property (nonatomic, strong) UILabel *hotLb4;
@property (nonatomic, strong) UILabel *hotLb5;
@property (nonatomic, strong) UILabel *hotLb6;
@property (nonatomic, strong) UILabel *hotLb7;
@property (nonatomic, strong) UILabel *hotLb8;
@property (nonatomic, strong) UILabel *hotLb9;
@property (nonatomic, strong) UILabel *hotLb10;

@property (nonatomic, strong) NSMutableArray *nmLbArray;

@property (nonatomic, strong) UIView *topView;

@property (nonatomic, strong) UITableView *tableView1;

@property (nonatomic, strong) NSMutableArray *titleArray;

@property (nonatomic, strong) NSMutableDictionary *dataDict;

@property (nonatomic, strong) UIView *blackCoverView;

@end

@implementation TaoSearchPPlCoverView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self dealWithArray:NO];
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    [self addSubview:self.tableView1];
    [self addSubview:self.blackCoverView];
    
    [self.topView addSubview:self.hotLb];
    [self.topView addSubview:self.hotLb1];
    [self.topView addSubview:self.hotLb2];
    [self.topView addSubview:self.hotLb3];
    [self.topView addSubview:self.hotLb4];
    [self.topView addSubview:self.hotLb5];
    [self.topView addSubview:self.hotLb6];
    [self.topView addSubview:self.hotLb7];
    [self.topView addSubview:self.hotLb8];
    [self.topView addSubview:self.hotLb9];
    [self.topView addSubview:self.hotLb10];

    [self.nmLbArray addObject:_hotLb1];
    [self.nmLbArray addObject:_hotLb2];
    [self.nmLbArray addObject:_hotLb3];
    [self.nmLbArray addObject:_hotLb4];
    [self.nmLbArray addObject:_hotLb5];
    [self.nmLbArray addObject:_hotLb6];
    [self.nmLbArray addObject:_hotLb7];
    [self.nmLbArray addObject:_hotLb8];
    [self.nmLbArray addObject:_hotLb9];
    [self.nmLbArray addObject:_hotLb10];
    
    [self.blackCoverView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
//    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.equalTo(self);
//        make.top.equalTo(self);
//        make.height.equalTo(@(45 * kScale));
//    }];
    
    [self.tableView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.right.equalTo(self);
        make.bottom.equalTo(self);
    }];
    
    CGFloat width = 288 * kScale / 5;
    
    [self.hotLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.topView).offset(15 * kScale);
        make.top.equalTo(self.topView).offset(20 * kScale);
    }];
    
    [self.hotLb1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.hotLb.mas_right).offset(0 * kScale);
        make.centerY.equalTo(self.hotLb);
        make.width.equalTo(@(width));
    }];
    
    [self.hotLb2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.hotLb1.mas_right).offset(0 * kScale);
        make.centerY.equalTo(self.hotLb);
        make.width.equalTo(@(width));
    }];
    
    [self.hotLb3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.hotLb2.mas_right).offset(0 * kScale);
        make.centerY.equalTo(self.hotLb);
        make.width.equalTo(@(width));
    }];
    
    [self.hotLb4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.hotLb3.mas_right).offset(0 * kScale);
        make.centerY.equalTo(self.hotLb);
        make.width.equalTo(@(width));
    }];
    
    [self.hotLb5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.hotLb4.mas_right).offset(0 * kScale);
        make.centerY.equalTo(self.hotLb);
        make.width.equalTo(@(width));
    }];
    
    [self.hotLb6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.hotLb1).offset(0 * kScale);
        make.top.equalTo(self.hotLb1.mas_bottom).offset(15 * kScale);
        make.width.equalTo(@(width));
    }];
    
    [self.hotLb7 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.hotLb6.mas_right).offset(0);
        make.centerY.equalTo(self.hotLb6);
        make.width.equalTo(@(width));
    }];
    
    [self.hotLb8 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.hotLb7.mas_right).offset(0);
        make.centerY.equalTo(self.hotLb7);
        make.width.equalTo(@(width));
    }];
    
    [self.hotLb9 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.hotLb8.mas_right).offset(0);
        make.centerY.equalTo(self.hotLb8);
        make.width.equalTo(@(width));
    }];
    
    [self.hotLb10 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.hotLb9.mas_right).offset(0);
        make.centerY.equalTo(self.hotLb9);
        make.width.equalTo(@(width));
    }];
    
}

- (void)tap:(UITapGestureRecognizer *)tap {
    NSLog(@"%zd",tap.view.tag);
    if (self.pushBlock) {
        TaoHotPeopleModel *model = self.hotNameArray[tap.view.tag];
        self.pushBlock(model);
    }
}

- (void)close:(UITapGestureRecognizer *)tap {
    NSLog(@"dsadasdsd");
    if (self.endEditingBlock) {
        self.endEditingBlock();
    }
}

#pragma mark 

- (void)dealWithArray:(BOOL)isPure {
    NSArray *arr;
    if (isPure) {
        arr = [StockCodesInstance sharedStockCodesInstance].pureUserArray;
    } else {
        arr = [StockCodesInstance sharedStockCodesInstance].userArray;
    }
    
    [self.titleArray removeAllObjects];
    [self.dataDict removeAllObjects];
    
    NSMutableArray *tempArray = [NSMutableArray array];
    
    for (TaoHotPeopleModel *model in arr) {
        if (model.p.length == 0) {
            continue;
        }
        
        NSString *p = [model.p substringToIndex:1];
        p = [self dealWithStr:p];
        if ([self.dataDict.allKeys containsObject:p]) {
            NSMutableArray *nmA = [self.dataDict objectForKey:p];
            [nmA addObject:model];
        } else {
            tempArray = [NSMutableArray arrayWithObject:model];
            [self.titleArray addObject:p];
            [self.dataDict setObject:tempArray forKey:p];
        }
        
    }
    
//    [self.titleArray sortUsingComparator:^NSComparisonResult(NSString *obj1,NSString *obj2) {
//        if (obj1 > obj2) {
//            return NSOrderedDescending;
//        } else {
//            return NSOrderedAscending;
//        }
//    }];
    
    [self.tableView1 reloadData];
}

- (NSString *)dealWithStr:(NSString *)str {
    if ([str characterAtIndex:0] >= 'a' && [str characterAtIndex:0] <= 'z') {
        return str;
    }
    return @"#";
}

- (void)setHotNameArray:(NSArray *)hotNameArray {
    _hotNameArray = hotNameArray;
    for (int i = 0; i < self.nmLbArray.count ; i ++) {
        UILabel *lb = self.nmLbArray[i];
        if (i < hotNameArray.count) {
            TaoHotPeopleModel *model = _hotNameArray[i];
            lb.text = model.n;
        } else {
            lb.text = @"";
        }
    }
}


- (void)setIsUp:(BOOL)isUp {
    _isUp = isUp;
    
    if (isUp) {
        [self.tableView1 mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self).offset(-200);
        }];
        self.blackCoverView.alpha = 1;
    } else {
        [self.tableView1 mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self).offset(0);
        }];
        self.blackCoverView.alpha = 0;
    }
    
    [UIView animateWithDuration:0.5 animations:^{
        [self layoutIfNeeded];
    }];
    
}

#pragma mark tableView delegate

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *s = self.titleArray[section];
    
    return s.uppercaseString;
}

- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    NSMutableArray *A = [NSMutableArray array];
    for (NSString *s in self.titleArray) {
        [A addObject:s.uppercaseString];
    }
    return A;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.titleArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSString *p = self.titleArray[section];
    NSArray *arr = [self.dataDict objectForKey:p];
    return arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
     
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"taoSearchPPlCell" forIndexPath:indexPath];
    
    NSString *p = self.titleArray[indexPath.section];
    NSArray *arr = [self.dataDict objectForKey:p];
    TaoHotPeopleModel *model = arr[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = model.n;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *s = self.titleArray[indexPath.section];
    NSArray *arr = self.dataDict[s];
    TaoHotPeopleModel *model = arr[indexPath.row];
    if (self.pushBlock) {
        self.pushBlock(model);
    }
}

#pragma mark lazy

- (NSMutableArray *)nmLbArray {
    if (_nmLbArray == nil) {
        _nmLbArray = [NSMutableArray array];
    }
    return _nmLbArray;
}

- (UILabel *)hotLb {
    if (_hotLb == nil) {
        _hotLb = [UILabel new];
        _hotLb.text = @"近期热门:";
        _hotLb.textColor = kUIColorFromRGB(0x666666);
        _hotLb.font = [UIFont systemFontOfSize:14 * kScale];
    }
    return _hotLb;
}

- (UILabel *)hotLb1 {
    if (_hotLb1 == nil) {
        _hotLb1 = [UILabel new];
        _hotLb1.textAlignment = NSTextAlignmentCenter;
        _hotLb1.textColor = kUIColorFromRGB(0x358ee7);
        _hotLb1.font = [UIFont systemFontOfSize:14 * kScale];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        _hotLb1.userInteractionEnabled = YES;
        [_hotLb1 addGestureRecognizer:tap];
        _hotLb1.tag = 0;
    }
    return _hotLb1;
}

- (UILabel *)hotLb2 {
    if (_hotLb2 == nil) {
        _hotLb2 = [UILabel new];
        _hotLb2.textAlignment = NSTextAlignmentCenter;
        _hotLb2.textColor = kUIColorFromRGB(0x358ee7);
        _hotLb2.font = [UIFont systemFontOfSize:14 * kScale];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        _hotLb2.userInteractionEnabled = YES;
        [_hotLb2 addGestureRecognizer:tap];
        _hotLb2.tag = 1;
    }
    return _hotLb2;
}

- (UILabel *)hotLb3 {
    if (_hotLb3 == nil) {
        _hotLb3 = [UILabel new];
        _hotLb3.textAlignment = NSTextAlignmentCenter;
        _hotLb3.textColor = kUIColorFromRGB(0x358ee7);
        _hotLb3.font = [UIFont systemFontOfSize:14 * kScale];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        _hotLb3.userInteractionEnabled = YES;
        [_hotLb3 addGestureRecognizer:tap];
        _hotLb3.tag = 2;
    }
    return _hotLb3;
}

- (UILabel *)hotLb4 {
    if (_hotLb4 == nil) {
        _hotLb4 = [UILabel new];
        _hotLb4.textAlignment = NSTextAlignmentCenter;
        _hotLb4.textColor = kUIColorFromRGB(0x358ee7);
        _hotLb4.font = [UIFont systemFontOfSize:14 * kScale];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        _hotLb4.userInteractionEnabled = YES;
        [_hotLb4 addGestureRecognizer:tap];
        _hotLb4.tag = 3;
    }
    return _hotLb4;
}

- (UILabel *)hotLb5 {
    if (_hotLb5 == nil) {
        _hotLb5 = [UILabel new];
        _hotLb5.textAlignment = NSTextAlignmentCenter;
        _hotLb5.textColor = kUIColorFromRGB(0x358ee7);
        _hotLb5.font = [UIFont systemFontOfSize:14 * kScale];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        _hotLb5.userInteractionEnabled = YES;
        [_hotLb5 addGestureRecognizer:tap];
        _hotLb5.tag = 4;
    }
    return _hotLb5;
}

- (UILabel *)hotLb6 {
    if (_hotLb6 == nil) {
        _hotLb6 = [UILabel new];
        _hotLb6.textAlignment = NSTextAlignmentCenter;
        _hotLb6.textColor = kUIColorFromRGB(0x358ee7);
        _hotLb6.font = [UIFont systemFontOfSize:14 * kScale];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        _hotLb6.userInteractionEnabled = YES;
        [_hotLb6 addGestureRecognizer:tap];
        _hotLb6.tag = 5;
    }
    return _hotLb6;
}

- (UILabel *)hotLb7 {
    if (_hotLb7 == nil) {
        _hotLb7 = [UILabel new];
        _hotLb7.textAlignment = NSTextAlignmentCenter;
        _hotLb7.textColor = kUIColorFromRGB(0x358ee7);
        _hotLb7.font = [UIFont systemFontOfSize:14 * kScale];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        _hotLb7.userInteractionEnabled = YES;
        [_hotLb7 addGestureRecognizer:tap];
        _hotLb7.tag = 6;
    }
    return _hotLb7;
}

- (UILabel *)hotLb8 {
    if (_hotLb8 == nil) {
        _hotLb8 = [UILabel new];
        _hotLb8.textAlignment = NSTextAlignmentCenter;
        _hotLb8.textColor = kUIColorFromRGB(0x358ee7);
        _hotLb8.font = [UIFont systemFontOfSize:14 * kScale];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        _hotLb8.userInteractionEnabled = YES;
        [_hotLb8 addGestureRecognizer:tap];
        _hotLb8.tag = 7;
    }
    return _hotLb8;
}

- (UILabel *)hotLb9 {
    if (_hotLb9 == nil) {
        _hotLb9 = [UILabel new];
        _hotLb9.textAlignment = NSTextAlignmentCenter;
        _hotLb9.textColor = kUIColorFromRGB(0x358ee7);
        _hotLb9.font = [UIFont systemFontOfSize:14 * kScale];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        _hotLb9.userInteractionEnabled = YES;
        [_hotLb9 addGestureRecognizer:tap];
        _hotLb9.tag = 8;
    }
    return _hotLb9;
}

- (UILabel *)hotLb10 {
    if (_hotLb10 == nil) {
        _hotLb10 = [UILabel new];
        _hotLb10.textAlignment = NSTextAlignmentCenter;
        _hotLb10.textColor = kUIColorFromRGB(0x358ee7);
        _hotLb10.font = [UIFont systemFontOfSize:14 * kScale];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        _hotLb10.userInteractionEnabled = YES;
        [_hotLb10 addGestureRecognizer:tap];
        _hotLb10.tag = 9;
    }
    return _hotLb10;
}

- (UIView *)topView {
    if (_topView == nil) {
        _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WIDTH, 90 * kScale)];
        _topView.backgroundColor = kUIColorFromRGB(0xffffff);
    }
    return _topView;
}

- (UITableView *)tableView1 {
    if (_tableView1 == nil) {
        _tableView1 = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView1.separatorColor = kUIColorFromRGB(0xd3d3d3);
        _tableView1.separatorInset = UIEdgeInsetsMake(0, 15, 0, 15);
        _tableView1.delegate = self;
        _tableView1.dataSource = self;
        [_tableView1 registerClass:[UITableViewCell class] forCellReuseIdentifier:@"taoSearchPPlCell"];
        _tableView1.tableHeaderView = self.topView;
    }
    return _tableView1;
}

- (NSMutableArray *)titleArray {
    if (_titleArray == nil) {
        _titleArray = [NSMutableArray array];
    }
    return _titleArray;
}

- (NSMutableDictionary *)dataDict {
    if (_dataDict == nil) {
        _dataDict = [NSMutableDictionary dictionary];
    }
    return _dataDict;
}

- (UIView *)blackCoverView {
    if (_blackCoverView == nil) {
        _blackCoverView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _blackCoverView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(close:)];
        [_blackCoverView addGestureRecognizer:tap];
        _blackCoverView.alpha = 0;
    }
    return _blackCoverView;
}

@end
