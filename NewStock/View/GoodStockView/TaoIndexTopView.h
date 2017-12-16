//
//  TaoIndexTopView.h
//  NewStock
//
//  Created by 王迪 on 2017/3/3.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaoHotPeopleModel.h"

@interface TaoIndexTopView : UIView

@property (nonatomic, copy) dispatch_block_t pushBlock;

@property (nonatomic, copy) void (^hotLbTapBLock)(NSString *);

@property (nonatomic, strong) NSArray <TaoHotPeopleModel *> *hotNameArray;

@end
