//
//  BigVPopView.h
//  NewStock
//
//  Created by 王迪 on 2017/4/13.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "PopView.h"
@class BigVPopView;

@protocol BigVPopViewDelegate <NSObject>

- (void)BigVPopViewDelegate:(BigVPopView *)popView andBtnClick:(UIButton *)btn;

@end

@interface BigVPopView : PopView

@property (nonatomic, weak) id <BigVPopViewDelegate> delegate;

@end
