//
//  RefreshSettingViewController.h
//  NewStock
//
//  Created by Willey on 16/8/23.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "ZFBaseSettingViewController.h"
#import "GetUserSettingAPI.h"

@interface RefreshSettingViewController : ZFBaseSettingViewController
{
    ZFSettingItem *_item0;
    ZFSettingItem *_item1;
    ZFSettingItem *_item2;
    ZFSettingItem *_item3;
    
    GetUserSettingAPI *_getUserSettingAPI;
}
@end
