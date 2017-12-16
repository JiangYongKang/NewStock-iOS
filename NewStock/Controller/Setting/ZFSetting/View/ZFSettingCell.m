//
//  ZFSettingself.m
//  ZFSetting
//
//  Created by 任子丰 on 15/9/19.
//  Copyright (c) 2013年 任子丰. All rights reserved.
//

#import "ZFSettingCell.h"
#import "ZFSettingItem.h"
#import "UIImageView+WebCache.h"
#import "Masonry.h"
#import "Defination.h"

@interface ZFSettingCell()
{
    UISwitch *_switch;
    UILabel *_detailLb;
    UIImageView *_imgView;
}
@end

@implementation ZFSettingCell

+ (id)settingCellWithTableView:(UITableView *)tableView
{
    // 0.用static修饰的局部变量，只会初始化一次
    static NSString *ID = @"Cell";
    
    // 1.拿到一个标识先去缓存池中查找对应的Cell
    ZFSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    // 2.如果缓存池中没有，才需要传入一个标识创建新的Cell
    if (cell == nil) {
        cell = [[ZFSettingCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];//UITableViewCellStyleDefault
    }
    
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setItem:(ZFSettingItem *)item
{
    _item = item;
    
    // 设置数据
    self.imageView.image = [UIImage imageNamed:item.icon];
    self.textLabel.text = item.title;
    self.textLabel.font = [UIFont systemFontOfSize:16];
    self.textLabel.textColor = kUIColorFromRGB(0x333333);
    
    if (item.type == ZFSettingItemTypeArrow) {
        
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        // 用默认的选中样式
        self.selectionStyle = UITableViewCellSelectionStyleBlue;
        
        self.detailTextLabel.text = @"";

        if(_imgView)_imgView.hidden = YES;
        if(_detailLb)_detailLb.hidden = YES;

    } else if (item.type == ZFSettingItemTypeSwitch) {
        
        if (_switch == nil) {
            _switch = [[UISwitch alloc] init];
            [_switch addTarget:self action:@selector(switchStatusChanged:) forControlEvents:UIControlEventValueChanged];
        }
        
        _switch.on = item.switchOn;
        
        // 右边显示开关
        self.accessoryView = _switch;
        // 禁止选中
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.detailTextLabel.text = @"";

        if(_imgView)_imgView.hidden = YES;
        if(_detailLb)_detailLb.hidden = YES;

    }else if (item.type == ZFSettingItemTypeDetail) {
        
        
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        // 用默认的选中样式
        self.selectionStyle = UITableViewCellSelectionStyleBlue;
        
//        self.detailTextLabel.text = item.detail;
//        self.detailTextLabel.textColor = kUIColorFromRGB(0x666666);
//        self.detailTextLabel.font = [UIFont systemFontOfSize:13];

        if (_detailLb == nil)
        {
            _detailLb = [[UILabel alloc] init];
            [self addSubview:_detailLb];
            
            [_detailLb mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(_detailLb.superview).offset(5);
                make.bottom.equalTo(_detailLb.superview).offset(-5);
                make.right.equalTo(_detailLb.superview).offset(-40);
                make.width.mas_equalTo(180);
                
            }];
            
            _detailLb.textColor = kUIColorFromRGB(0x666666);
            _detailLb.font = [UIFont systemFontOfSize:12];
            _detailLb.textAlignment = NSTextAlignmentRight;
        }
        _detailLb.text = item.detail;
        _detailLb.hidden = NO;


        if(_imgView)_imgView.hidden = YES;

    }else if (item.type == ZFSettingItemTypeImage) {
        
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        // 用默认的选中样式
        self.selectionStyle = UITableViewCellSelectionStyleBlue;
        
        self.detailTextLabel.text = @"";

        if (_imgView == nil) {
            _imgView = [[UIImageView alloc] init];
            [self addSubview:_imgView];
            
            /*
            [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(_imgView.superview).offset(10);
                make.bottom.equalTo(_imgView.superview).offset(-10);
                make.right.equalTo(_imgView.superview).offset(-35);
                make.width.mas_equalTo(70);
                
                _imgView.layer.cornerRadius = 35;
                _imgView.layer.masksToBounds = YES;
                _imgView.layer.borderWidth = 1.0;
                _imgView.layer.borderColor = [UIColor lightGrayColor].CGColor;
            }];
             */
            
            [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(_imgView.superview).offset(5);
                make.bottom.equalTo(_imgView.superview).offset(-5);
                make.right.equalTo(_imgView.superview).offset(-40);
                make.width.mas_equalTo(34);
                
                _imgView.layer.cornerRadius = 17;
                _imgView.layer.masksToBounds = YES;
                _imgView.layer.borderWidth = 1.0;
                _imgView.layer.borderColor = [UIColor lightGrayColor].CGColor;
            }];
        }
        
        _imgView.hidden = NO;
        [_imgView sd_setImageWithURL:[NSURL URLWithString:item.imgUrl]
                    placeholderImage:[UIImage imageNamed:@"header_placeholder"]];
        
        if(_detailLb)_detailLb.hidden = YES;

        
    }else if (item.type == ZFSettingItemTypeCheckmark)
    {
        self.accessoryType = UITableViewCellAccessoryCheckmark;
        // 用默认的选中样式
        self.selectionStyle = UITableViewCellSelectionStyleBlue;
        
        self.detailTextLabel.text = @"";
        
        if(_imgView)_imgView.hidden = YES;
        if(_detailLb)_detailLb.hidden = YES;

    }
    else {
        
        // 什么也没有，清空右边显示的view
        //self.accessoryView = nil;
        self.accessoryType = UITableViewCellAccessoryNone;

        // 用默认的选中样式
        self.selectionStyle = UITableViewCellSelectionStyleBlue;
        
        self.detailTextLabel.text = @"";

        if(_imgView)_imgView.hidden = YES;
        if(_detailLb)_detailLb.hidden = YES;

    }
}

#pragma mark - SwitchValueChanged

- (void)switchStatusChanged:(UISwitch *)sender
{
    if (self.switchChangeBlock) {
        self.switchChangeBlock(sender.on);
    }
}
@end
