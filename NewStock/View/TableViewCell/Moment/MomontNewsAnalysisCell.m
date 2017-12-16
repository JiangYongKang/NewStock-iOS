//
//  MomontNewsAnalysisCell.m
//  NewStock
//
//  Created by 王迪 on 2017/5/25.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "MomontNewsAnalysisCell.h"
#import "MomentNewsBottomStockView.h"
#import "SystemUtil.h"
#import "Defination.h"
#import <Masonry.h>

@interface MomontNewsAnalysisCell () <MomentNewsBottomStockViewDelegate>

@property (nonatomic, strong) UILabel *tt_lable;
@property (nonatomic, strong) UILabel *c_lable;
@property (nonatomic, strong) UILabel *ball_lb;
@property (nonatomic, strong) UILabel *vLine_lb;
@property (nonatomic, strong) UILabel *tm_lb;
@property (nonatomic, strong) UILabel *line;

@property (nonatomic, strong) MomentNewsBottomStockView *stock1;
@property (nonatomic, strong) MomentNewsBottomStockView *stock2;
@property (nonatomic, strong) MomentNewsBottomStockView *stock3;
@property (nonatomic, strong) MomentNewsBottomStockView *stock4;

@property (nonatomic, assign) CGFloat labelW;

@property (nonatomic, strong) NSMutableArray <NSDictionary *> *colorDictArray;
@property (nonatomic, strong) NSMutableArray <NSDictionary *> *titleColorDictArray;

@end

@implementation MomontNewsAnalysisCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setupUI {
    
    [self.contentView addSubview:self.tt_lable];
    [self.contentView addSubview:self.c_lable];
    [self.contentView addSubview:self.ball_lb];
    [self.contentView addSubview:self.vLine_lb];
    [self.contentView addSubview:self.tm_lb];
    [self.contentView addSubview:self.stock1];
    [self.contentView addSubview:self.stock2];
    [self.contentView addSubview:self.stock3];
    [self.contentView addSubview:self.stock4];
    [self.contentView addSubview:self.line];
    
    [self.tm_lb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(12 * kScale);
        make.top.equalTo(self.contentView).offset(15 * kScale);
    }];
    
    [self.tt_lable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(56 * kScale);
        make.right.equalTo(self.contentView).offset(-12 * kScale);
        make.top.equalTo(self.contentView).offset(12 * kScale);
    }];
    
    [self.c_lable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.tt_lable);
        make.top.equalTo(self.tt_lable.mas_bottom).offset(10 * kScale);
    }];
    
    [self.ball_lb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@(9 * kScale));
        make.top.equalTo(self.contentView).offset(33 * kScale);
        make.left.equalTo(self.contentView).offset(24 * kScale);
    }];
    
    [self.vLine_lb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.ball_lb);
        make.top.equalTo(self.ball_lb.mas_bottom).offset(0);
        make.width.equalTo(@(1));
        make.bottom.equalTo(self.contentView).offset(-14 * kScale);
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.tt_lable);
        make.top.equalTo(self.c_lable.mas_bottom).offset(15 * kScale);
        make.height.equalTo(@(0.5));
    }];
    
    [self.stock1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.tt_lable);
        make.top.equalTo(self.line.mas_bottom).offset(12 * kScale);
        make.height.equalTo(@(30 * kScale));
        make.width.equalTo(@(146 * kScale));
    }];
    
    [self.stock2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.width.height.equalTo(self.stock1);
        make.right.equalTo(self.tt_lable);
    }];
    
    [self.stock3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.left.height.equalTo(self.stock1);
        make.top.equalTo(self.stock1.mas_bottom).offset(15 * kScale);
    }];
    
    [self.stock4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.width.height.equalTo(self.stock2);
        make.top.equalTo(self.stock3);
    }];
    
    [self.stockViewArray addObject:self.stock1];
    [self.stockViewArray addObject:self.stock2];
    [self.stockViewArray addObject:self.stock3];
    [self.stockViewArray addObject:self.stock4];
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([self.delegate respondsToSelector:@selector(momentNewsAnalysisCellDidInit:)]) {
            [self.delegate momentNewsAnalysisCellDidInit:self.stockViewArray];
        }
    });
}

- (void)setModel:(MomentNewsAnalysisModel *)model {
    _model = model;
    
    self.tm_lb.text = [self getDateString:model.tm];
    [self dealWithTt];
    [self dealWithSy:_model.isShow];
    [self dealWithStock];
}

#pragma mark function

- (void)dealWithTt {
    NSString *tt = [self matchSpan:_model.tt withArray:self.titleColorDictArray];
    NSMutableParagraphStyle *ttPara = [[NSMutableParagraphStyle alloc] init];
    CGFloat w = [tt boundingRectWithSize:CGSizeMake(MAXFLOAT, _tt_lable.font.lineHeight) options:1 attributes:@{NSFontAttributeName : _tt_lable.font} context:nil].size.width;
    if (w > self.labelW) {
        ttPara.lineSpacing = 7;
    } else {
        ttPara.lineSpacing = 0;
    }
    
    NSMutableAttributedString *attrTt = [[NSMutableAttributedString alloc] initWithString:tt attributes:@{NSParagraphStyleAttributeName : ttPara}];
    [self dealWithStringColor:attrTt andArray:self.titleColorDictArray];
    self.tt_lable.attributedText = attrTt;
    [self.tt_lable sizeToFit];
}

- (void)dealWithSy:(BOOL)isShow {
    
    //匹配span 标签
    NSString *oriSy = [self matchSpan:_model.sy withArray:self.colorDictArray];
    NSString *sy = oriSy;

    NSInteger syCount = 80;
    //缩放展开
    if (sy.length > syCount && !_model.isShow) {
        sy = [sy substringToIndex:syCount];
    } else {
        sy = sy;
    }
    
    //是否加行间距
    NSMutableParagraphStyle *cPara = [NSMutableParagraphStyle new];
    CGFloat w = [sy boundingRectWithSize:CGSizeMake(MAXFLOAT, _c_lable.font.lineHeight) options:1 attributes:@{NSFontAttributeName : _c_lable.font} context:nil].size.width;
    if (w > self.labelW) {
        cPara.lineSpacing = 4;
    } else {
        cPara.lineSpacing = 0;
    }
    
    NSMutableAttributedString *c = [[NSMutableAttributedString alloc] initWithString:sy attributes:@{NSParagraphStyleAttributeName : cPara}];
    
    //处理 颜色
    [self dealWithStringColor:c andArray:self.colorDictArray];
    
    //拼接 ...全文
    if (oriSy.length > syCount && !_model.isShow) {
      NSAttributedString *m = [[NSAttributedString alloc] initWithString:@"  ...全文" attributes:@{NSFontAttributeName : _c_lable.font,NSForegroundColorAttributeName : kNameColor}];
        [c appendAttributedString:m];
        _model.hideStr = c;
    } else {
        _model.showStr = c;
    }
    
    self.c_lable.attributedText = c;
    [self.c_lable sizeToFit];
}

- (void)dealWithStock {
    for (MomentNewsBottomStockView *view in self.stockViewArray) {
        view.hidden = YES;
    }
    for (int i = 0; i < _model.sl.count && i < 4; i ++) {
        MomentNewsAnalysisStockModel *stock = _model.sl[i];
        MomentNewsBottomStockView *stockView = self.stockViewArray[i];
        stockView.stock = stock;
        stockView.hidden = NO;
    }
    if (_model.sl.count == 0) {
        self.line.hidden = YES;
    } else {
        self.line.hidden = NO;
    }
}

- (NSString *)getDateString:(NSString *)tm {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *date = [formatter dateFromString:tm];
    
    formatter.dateFormat = @"HH:mm";
    NSString *s = [formatter stringFromDate:date];
    return s;
}

- (void)MomentNewsBottomStockViewDelegate:(MomentNewsAnalysisStockModel *)stock {
    if ([self.delegate respondsToSelector:@selector(momentNewsAnalysisCellStockPush:)]) {
        [self.delegate momentNewsAnalysisCellStockPush:stock];
    }
}

- (NSString *)matchSpan:(NSString *)str withArray:(NSMutableArray *)array {
    [array removeAllObjects];
    NSMutableString *nmSy = [NSMutableString string];
    __block NSInteger index = 0;
    __block BOOL isMatched = NO;
    NSMutableArray *tempColorArray = [NSMutableArray array];
    NSString *patten = @"</?span.*?>";
    NSString *pattenColor = @"color: #";
    NSRegularExpression *regular = [NSRegularExpression regularExpressionWithPattern:patten options:0 error:nil];
    
    [regular enumerateMatchesInString:str options:0 range:NSMakeRange(0, str.length) usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL * _Nonnull stop) {

        NSRange matchRange = [result rangeAtIndex:0];
        NSString *matchStr = [str substringWithRange:matchRange];
        NSString *leftStr = [str substringWithRange:NSMakeRange(index, matchRange.location - index)];
        index = matchRange.location + matchRange.length;
        [nmSy appendString:leftStr];
        
        NSString *colorStr = nil;

        if (isMatched) {
            NSRange newSyRange = [nmSy rangeOfString:leftStr];
            NSMutableDictionary *colorDict = [NSMutableDictionary dictionary];
            [colorDict setObject:[NSValue valueWithRange:newSyRange] forKey:@"range"];
            [colorDict setObject:tempColorArray.lastObject forKey:@"color"];
            [array addObject:colorDict];
        }
        
        if ([matchStr hasPrefix:@"<span"]) {
            NSRange colorRange = [matchStr rangeOfString:pattenColor];
            colorStr = [matchStr substringWithRange:NSMakeRange(colorRange.location + colorRange.length, 6)];
            [tempColorArray addObject:colorStr];
        }
        
        isMatched = YES;
    }];
    
    if (index == 0) {
        return str;
    } else if (index < str.length - 1) {
        [nmSy appendString:[str substringFromIndex:index]];
        return nmSy.copy;
    } else {
        return nmSy.copy;
    }
}

- (void)dealWithStringColor:(NSMutableAttributedString *)c andArray:(NSMutableArray *)array {
    for (NSDictionary *dict in array) {
        NSValue *rangeV = dict[@"range"];
        NSRange range = rangeV.rangeValue;
        NSString *colorStr = dict[@"color"];
        UIColor *color = [SystemUtil colorwithHexString:colorStr];
        if (range.location > c.length - 1) {
            continue;
        } else if (range.length + range.location > c.length - 1) {
            range.length = c.length - range.location;
        }
        [c addAttribute:NSForegroundColorAttributeName value:color range:range];
    }
}

- (void)showOrHideContentLabel {
    _model.isShow = !_model.isShow;
    if (_model.isShow && _model.showStr != nil) {
        self.c_lable.attributedText = _model.showStr;
        [self.c_lable sizeToFit];
        return;
    } else if (!_model.isShow && _model.hideStr != nil) {
        self.c_lable.attributedText = _model.hideStr;
        [self.c_lable sizeToFit];
        return;
    }
    
    [self dealWithSy:_model.isShow];
}

#pragma mark lazyloading

- (UILabel *)ball_lb {
    if (_ball_lb == nil) {
        _ball_lb = [UILabel new];
        _ball_lb.layer.borderWidth = 1 * kScale;
        _ball_lb.layer.borderColor = kUIColorFromRGB(0xe4e4e4).CGColor;
        _ball_lb.layer.cornerRadius = 4.5 * kScale;
        _ball_lb.layer.masksToBounds = YES;
    }
    return _ball_lb;
}

- (UILabel *)vLine_lb {
    if (_vLine_lb == nil) {
        _vLine_lb = [UILabel new];
        _vLine_lb.backgroundColor = kUIColorFromRGB(0xe4e4e4);
    }
    return _vLine_lb;
}

- (UILabel *)tt_lable {
    if (_tt_lable == nil) {
        _tt_lable = [UILabel new];
        _tt_lable.textColor = kUIColorFromRGB(0x333333);
        _tt_lable.preferredMaxLayoutWidth = self.labelW;
        _tt_lable.font = [UIFont systemFontOfSize:17 * kScale];
        _tt_lable.numberOfLines = 2;
    }
    return _tt_lable;
}

- (UILabel *)c_lable {
    if (_c_lable == nil) {
        _c_lable = [UILabel new];
        _c_lable.textColor = kUIColorFromRGB(0x666666);
        _c_lable.font = [UIFont systemFontOfSize:14 * kScale];
        _c_lable.preferredMaxLayoutWidth = self.labelW;
        _c_lable.numberOfLines = 0;
    }
    return _c_lable;
}

- (UILabel *)tm_lb {
    if (_tm_lb == nil) {
        _tm_lb = [UILabel new];
        _tm_lb.textColor = kTitleColor;
        _tm_lb.font = [UIFont systemFontOfSize:12 * kScale];
    }
    return _tm_lb;
}

- (UILabel *)line {
    if (_line == nil) {
        _line = [UILabel new];
        _line.backgroundColor = kUIColorFromRGB(0xe4e4e4);
    }
    return _line;
}

- (MomentNewsBottomStockView *)stock1 {
    if (_stock1 == nil) {
        _stock1 = [MomentNewsBottomStockView new];
        _stock1.delegate = self;
    }
    return _stock1;
}

- (MomentNewsBottomStockView *)stock2 {
    if (_stock2 == nil) {
        _stock2 = [MomentNewsBottomStockView new];
        _stock2.delegate = self;
    }
    return _stock2;
}

- (MomentNewsBottomStockView *)stock3 {
    if (_stock3 == nil) {
        _stock3 = [MomentNewsBottomStockView new];
        _stock3.delegate = self;
    }
    return _stock3;
}

- (MomentNewsBottomStockView *)stock4 {
    if (_stock4 == nil) {
        _stock4 = [MomentNewsBottomStockView new];
        _stock4.delegate = self;
    }
    return _stock4;
}

- (NSMutableArray *)stockViewArray {
    if (_stockViewArray == nil) {
        _stockViewArray = [NSMutableArray array];
    }
    return _stockViewArray;
}

- (CGFloat)labelW {
    return MAIN_SCREEN_WIDTH - (12 + 56) * kScale;
}

- (NSMutableArray <NSDictionary *> *)colorDictArray {
    if (_colorDictArray == nil) {
        _colorDictArray = [NSMutableArray array];
    }
    return _colorDictArray;
}

- (NSMutableArray <NSDictionary *> *)titleColorDictArray {
    if (_titleColorDictArray == nil) {
        _titleColorDictArray = [NSMutableArray array];
    }
    return _titleColorDictArray;
}

@end
