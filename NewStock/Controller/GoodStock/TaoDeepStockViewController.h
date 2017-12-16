//
//  TaoDeepStockViewController.h
//  NewStock
//
//  Created by 王迪 on 2017/6/27.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "BaseViewController.h"

@protocol TaoDeepTigetSendCountDelegate <NSObject>

- (void)taoDeepTigerSendCount:(NSString *)countStr;

@end

@interface TaoDeepStockViewController : BaseViewController

@property (nonatomic, copy) NSString *dateStr;

@property (nonatomic, weak) id <TaoDeepTigetSendCountDelegate> delegate;

- (void)scrollToTop;

@end
