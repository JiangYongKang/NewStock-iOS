//
//  TaoSearchPPlCoverView.h
//  NewStock
//
//  Created by 王迪 on 2017/3/6.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaoHotPeopleModel.h"

@interface TaoSearchPPlCoverView : UIView

@property (nonatomic, strong) NSArray <TaoHotPeopleModel *> *hotNameArray;

@property (nonatomic, copy) dispatch_block_t endEditingBlock;

@property (nonatomic, copy) void(^pushBlock)(TaoHotPeopleModel *);

@property (nonatomic, assign) BOOL isUp;

- (void)dealWithArray:(BOOL)isPure;

@end
