//
//  ProductSelView.m
//

#import "ProductSelView.h"
#import "Defination.h"
#import "Masonry.h"


@implementation ProductSelView
@synthesize delegate;

- (id)init {
    if (self = [super init]) {
        self.backgroundColor = kUIColorFromRGB(0xf0f4f7);
        _nCurSelIndex = 0;
        _productItemArray = [[NSMutableArray alloc] init];
        
        NSArray *productArray = [[NSArray alloc] initWithObjects:@"成交量",@"MACD",@"KDJ",@"RSI",@"BOLL",nil];

        _nItemHeigh = 35;
        for (int i = 0; i<[productArray count]; i++) {
            NSString *title = [productArray objectAtIndex:i];
            UIButton *btn = [[UIButton alloc] init];
            [btn setTitle:title forState:UIControlStateNormal];
            btn.tag = i;
            [btn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
            [btn setTitleColor:kUIColorFromRGB(0x666666) forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
            btn.titleLabel.font = [UIFont systemFontOfSize:13];
            [self addSubview:btn];
            
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self).offset(_nItemHeigh*i);
                make.right.equalTo(self);
                make.height.mas_equalTo(_nItemHeigh);
                make.width.mas_equalTo(self);
            }];
            
            [_productItemArray addObject:btn];
            
            if (i == 0)
            {
                btn.selected = YES;
                btn.backgroundColor = kUIColorFromRGB(0x358ee7);
            }
        }
    }
    return self;
}

- (void)buttonClicked:(UIButton *)button {
    NSInteger index = button.tag;
    for (int i = 0; i < [_productItemArray count]; i ++)
    {
        TimelineItemView *btn = [_productItemArray objectAtIndex:i];

        if (index == i)
        {
            btn.backgroundColor = kUIColorFromRGB(0x358ee7);
            [btn setSelected:YES];
            _nCurSelIndex = i;
        }
        else
        {
            btn.backgroundColor = [UIColor clearColor];
            [btn setSelected:NO];
        }
    }
    
    if([delegate respondsToSelector:@selector(productSelView:selectedIndex:)]) {
        [delegate productSelView:self selectedIndex:(int)index];
    }
}

@end
