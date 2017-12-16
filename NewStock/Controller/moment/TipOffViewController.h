//
//  TipOffViewController.h
//  NewStock
//
//  Created by Willey on 16/9/26.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "ZFBaseSettingViewController.h"
#import "TipOffAPI.h"

@interface TipOffViewController : ZFBaseSettingViewController
{
    ZFSettingItem *_item1;
    ZFSettingItem *_item2;
    ZFSettingItem *_item3;
    ZFSettingItem *_item4;
    ZFSettingItem *_item5;
    ZFSettingItem *_item6;

    TipOffAPI *_tipOffAPI;
}
@property (nonatomic, strong) NSString *contentId;

@property (nonatomic, copy) NSString *ty;

@end
