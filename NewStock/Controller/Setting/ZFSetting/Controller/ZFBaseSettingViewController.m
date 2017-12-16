//
//  ZFBaseSettingViewController.m
//  ZFSetting
//
//  Created by 任子丰 on 15/9/19.
//  Copyright (c) 2013年 任子丰. All rights reserved.
//

#import "ZFBaseSettingViewController.h"
#import "ZFSettingCell.h"

@interface ZFBaseSettingViewController ()

@end

@implementation ZFBaseSettingViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _allGroups = [NSMutableArray array];
    
    [_scrollView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(NAV_BAR_HEIGHT, 0, 0, 0));
    }];
    [_scrollView layoutIfNeeded];
    
    _tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.bounces = NO;
    _tableView.separatorInset = UIEdgeInsetsMake(0, 15, 0, 15);
    _tableView.separatorColor = kUIColorFromRGB(0xe4e4e4);
    _tableView.backgroundColor = kUIColorFromRGB(0xf1f1f1);
    [_mainView addSubview:_tableView];
    //self.view = tableView;
    
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_mainView).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _allGroups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    ZFSettingGroup *group = _allGroups[section];
    return group.items.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    ZFSettingGroup *group = _allGroups[indexPath.section];
//    ZFSettingItem *item = group.items[indexPath.row];
//    if (item.type == ZFSettingItemTypeImage)
//    {
//        return 90;
//    }
    return 44;
}

#pragma mark 每当有一个cell进入视野范围内就会调用，返回当前这行显示的cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 1.创建一个ZFSettingCell
    ZFSettingCell *cell = [ZFSettingCell settingCellWithTableView:tableView];
    
    // 2.取出这行对应的模型（ZFSettingItem）
    ZFSettingGroup *group = _allGroups[indexPath.section];
    cell.item = group.items[indexPath.row];
    __block ZFSettingCell *weakCell = cell;
    cell.switchChangeBlock = ^ (BOOL on){
        if (weakCell.item.switchBlock) {
            weakCell.item.switchBlock(on);
        }
    };

    return cell;
}

#pragma mark 点击了cell后的操作
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 0.取出这行对应的模型
    ZFSettingGroup *group = _allGroups[indexPath.section];
    ZFSettingItem *item = group.items[indexPath.row];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    // 1.取出这行对应模型中的block代码
    if (item.operation) {
        // 执行block
        item.operation();
    }
}

#pragma mark 返回每一组的header标题
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    ZFSettingGroup *group = _allGroups[section];
    
    return group.header;
}
#pragma mark 返回每一组的footer标题
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    ZFSettingGroup *group = _allGroups[section];
    
    return group.footer;
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    view.tintColor = [UIColor clearColor];
}
- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section
{
    view.tintColor = [UIColor clearColor];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    ZFSettingGroup *group = _allGroups[section];
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WIDTH, 30)];;
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(15, 5, MAIN_SCREEN_WIDTH - 15, 30)];
    [bgView addSubview:label];
    label.text = group.footer;
    label.font = [UIFont systemFontOfSize:12];
    label.textColor = kUIColorFromRGB(0x333333);
    return bgView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.011;//如果设置section的header高度，不设置footer高度，footer默认等于header高度
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;//这个方法不写，或者return 0跟return 12的效果一样
    return 0.01;//把高度设置很小，效果可以看成footer的高度等于0
}
@end
