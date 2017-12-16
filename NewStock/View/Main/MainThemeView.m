//
//  MainThemeView.m
//  NewStock
//
//  Created by 王迪 on 2017/5/4.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "MainThemeView.h"
#import "Defination.h"
#import "MainThemeCell.h"
#import <Masonry.h>

static NSString *cellID = @"MainThemeViewCell";

@interface MainThemeView ()<UITableViewDelegate,UITableViewDataSource,MainThemeCellDelegate>

@property (nonatomic) UILabel *leftBlcokLb;
@property (nonatomic) UILabel *leftThemeLb;
@property (nonatomic) UIButton *topMoreBtn;
@property (nonatomic) UITableView *tableView;

@end

@implementation MainThemeView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    self.backgroundColor = [UIColor whiteColor];
    UIView *topV = [UIView new];
    topV.backgroundColor = [UIColor whiteColor];
    
    UILabel *lb = [UILabel new];
//    lb.backgroundColor = kUIColorFromRGB(0xe4e4e4);
    [topV addSubview:lb];
    [lb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(topV);
        make.height.equalTo(@(0.5));
    }];   
    
    [self addSubview:topV];
    [self addSubview:self.tableView];
    
    [topV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.height.equalTo(@(40 * kScale));
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.top.equalTo(topV.mas_bottom).offset(0 * kScale);
    }];
    
    [topV addSubview:self.leftBlcokLb];
    [topV addSubview:self.leftThemeLb];
    [topV addSubview:self.topMoreBtn];
    
    [self.leftBlcokLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(12 * kScale);
        make.centerY.equalTo(topV);
        make.width.equalTo(@(2 * kScale));
        make.height.equalTo(@(12 * kScale));
    }];
    
    [self.leftThemeLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftBlcokLb.mas_right).offset(6 * kScale);
        make.centerY.equalTo(topV);
    }];
    
    [self.topMoreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(topV);
        make.right.equalTo(topV).offset(0 * kScale);
        make.width.equalTo(@(60 * kScale));
    }];
}

#pragma mark aciton

- (void)moreBtnClick:(UIButton *)btn {
    if ([self.delegate respondsToSelector:@selector(MainThemeViewMoreClick)]) {
        [self.delegate MainThemeViewMoreClick];
    }
}

- (void)setDataArray:(NSArray <MainThemeModel *> *)dataArray {
    _dataArray = dataArray;
    [self.tableView reloadData];
}

- (void)MainThemeCellDelegate:(MainThemeStockModel *)model {
    if ([self.delegate respondsToSelector:@selector(MainThemeViewStockClick:)]) {
        [self.delegate MainThemeViewStockClick:model];
    }
}

#pragma mark tableView delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    MainThemeModel *model = self.dataArray[indexPath.row];
    NSString *tt = model.tt;
    UIFont *font = [UIFont boldSystemFontOfSize:16 * kScale];
    CGFloat w = [tt boundingRectWithSize:CGSizeMake(MAXFLOAT, font.lineHeight) options:1 attributes:@{NSFontAttributeName : font} context:nil].size.width;
    if (w > MAIN_SCREEN_WIDTH - 48 * kScale) {
        return 163 * kScale;
    }
    return 137 * kScale;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MainThemeCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    cell.model = self.dataArray[indexPath.row];
    cell.model.rmd = @"1";
    cell.index = indexPath.row;
    cell.delegate = self;
    cell.style = MainThemeCellStyleBorder;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MainThemeModel *model = self.dataArray[indexPath.row];
    if ([self.delegate respondsToSelector:@selector(MainThemeViewClick:)]) {
        [self.delegate MainThemeViewClick:model.url];
    }
}

#pragma mark lazy loading

- (UILabel *)leftBlcokLb {
    if (_leftBlcokLb == nil) {
        _leftBlcokLb = [UILabel new];
        _leftBlcokLb.backgroundColor = kUIColorFromRGB(0xff1919);
    }
    return _leftBlcokLb;
}

- (UILabel *)leftThemeLb {
    if (_leftThemeLb == nil) {
        _leftThemeLb = [UILabel new];
        _leftThemeLb.text = @"热门题材";
        _leftThemeLb.textColor = kUIColorFromRGB(0x333333);
        _leftThemeLb.font = [UIFont boldSystemFontOfSize:16 * kScale];
    }
    return _leftThemeLb;
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        [_tableView registerClass:[MainThemeCell class] forCellReuseIdentifier:cellID];
        _tableView.scrollEnabled = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

- (UIButton *)topMoreBtn {
    if (_topMoreBtn == nil) {
        _topMoreBtn = [UIButton new];
        [_topMoreBtn setTitle:@"更多" forState:UIControlStateNormal];
        _topMoreBtn.titleLabel.font = [UIFont systemFontOfSize:12 * kScale];
        [_topMoreBtn setTitleColor:kUIColorFromRGB(0x999999) forState:UIControlStateNormal];
        [_topMoreBtn setImage:[UIImage imageNamed:@"theme_arror_ico"] forState:UIControlStateNormal];
        [_topMoreBtn addTarget:self action:@selector(moreBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        _topMoreBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 10);
        _topMoreBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 25, 0, -25);
    }
    return _topMoreBtn;
}

@end
