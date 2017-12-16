//
//  MsgAlertPopView.h
//  NewStock
//
//  Created by 王迪 on 2017/4/26.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "PopView.h"
@class MsgAlertPopView;

@protocol MsgAlertPopViewDelegate <NSObject>

- (void)MsgAlertPopViewBtnClick:(NSString *)url;

@end

@interface MsgAlertPopView : PopView

@property (nonatomic, copy) NSString *msg;

@property (nonatomic, copy) NSString *url;

@property (nonatomic, weak) id <MsgAlertPopViewDelegate> delegate;

@end
