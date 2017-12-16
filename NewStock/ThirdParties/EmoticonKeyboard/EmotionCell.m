//
//  EmotionCell.m
//  oc-emotion
//
//  Created by 王迪 on 2017/2/9.
//  Copyright © 2017年 JiaBei. All rights reserved.
//

#import "EmotionCell.h"
#import "EmotionButton.h"

@interface EmotionCell ()

@property (nonatomic ,strong) NSMutableArray <EmotionButton *> *btnArray;

@end

@implementation EmotionCell


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    [self addChildBtn];
}

- (void)addChildBtn {
    CGFloat btnW = [UIScreen mainScreen].bounds.size.width / 7;
    CGFloat btnH = 190 / 4;
    for (int i = 0; i < 27; i ++) {
        
        CGFloat row = i / 7;
        CGFloat col = i % 7;
        
        CGFloat x = col * btnW;
        CGFloat y = row * btnH;
        
        EmotionButton *btn = [[EmotionButton alloc] initWithFrame:CGRectMake(x, y, btnW, btnH)];
        [self addSubview:btn];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.btnArray addObject:btn];
    }
    
    UIButton *delBtn = [[UIButton alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - btnW, 3 * btnH, btnW, btnH)];
    [delBtn setImage:[UIImage imageNamed:@"compose_emotion_delete_highlighted"] forState:UIControlStateNormal];
    [self addSubview:delBtn];
    [delBtn addTarget:self action:@selector(delBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)setModelArray:(NSArray<EmotionModel *> *)modelArray {
    _modelArray = modelArray;
    
    for (EmotionButton *btn in self.btnArray) {
        btn.hidden = YES;
    }
    
    for (int i = 0; i < modelArray.count; i ++) {
        EmotionButton *btn = self.btnArray[i];
        btn.hidden = NO;
        btn.model = modelArray[i];
    }
}

- (void)btnClick:(EmotionButton *)btn {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"KSelectEmoticon" object:btn];
}

- (void)delBtnClick {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"KSelectEmoticon" object:nil];
}

- (NSMutableArray *)btnArray {
    if (_btnArray == nil) {
        _btnArray = [NSMutableArray array];
    }
    return _btnArray;
}





@end
