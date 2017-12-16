//
//  TimelineItemCell.m
//

#import "TimelineItemView.h"
#import "SystemUtil.h"

#define BLUE_COLOR [UIColor colorWithRed:62/255.0 green:159/255.0 blue:232/255.0 alpha:1]

@implementation TimelineItemView
@synthesize index = _index;
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor whiteColor];
        
        _lbTitle = [[UILabel alloc] initWithFrame:CGRectMake(5, frame.size.height-23, frame.size.width, 20.0f)];
        _lbTitle.text = @"";
        _lbTitle.backgroundColor = [UIColor clearColor];
        _lbTitle.textAlignment = NSTextAlignmentCenter;
        _lbTitle.font = [UIFont boldSystemFontOfSize:11];
        _lbTitle.textColor = [UIColor darkGrayColor];
        [self addSubview:_lbTitle];
        
        
        _imageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _imageBtn.frame = CGRectMake(0, 0, frame.size.width+8, frame.size.height-15);
        [_imageBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
//        [_imageBtn setImageEdgeInsets:UIEdgeInsetsMake(13, (frame.size.width-20)/2, 7, (frame.size.width-20)/2)];
        [self addSubview:_imageBtn];
        
        UITapGestureRecognizer *gensture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
        gensture.delegate = self;
        [self addGestureRecognizer:gensture];
    }
    return self;
}

- (void)setTitle:(NSString *)title
{
    _lbTitle.text = title;
}
- (void)setIcon:(NSString *)iconStr selIcon:(NSString *)selIconStr
{
    [_imageBtn setImage:[UIImage imageNamed:iconStr] forState:UIControlStateNormal];
    [_imageBtn setImage:[UIImage imageNamed:selIconStr] forState:UIControlStateSelected];
}
- (void)setSelected:(BOOL)b
{
    if (b)
    {
        _lbTitle.textColor = [SystemUtil hexStringToColor:@"#409bd0"];//BLUE_COLOR;
        _imageBtn.selected = YES;
    }
    else
    {
        _lbTitle.textColor = [SystemUtil hexStringToColor:@"#898989"];
        _imageBtn.selected = NO;
    }
}


#pragma mark - Button Actions
- (void)btnAction:(UIButton*)sender
{
    if([delegate respondsToSelector:@selector(timelineItemView:selectedIndex:)])
    {
        [delegate timelineItemView:self selectedIndex:_index];
    }
}

- (void)tapAction
{
    if([delegate respondsToSelector:@selector(timelineItemView:selectedIndex:)])
    {
        [delegate timelineItemView:self selectedIndex:_index];
    }
}
@end
