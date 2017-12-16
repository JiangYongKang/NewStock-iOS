//
//  TaoDeepDepartmentViewController.h
//  NewStock
//
//  Created by 王迪 on 2017/6/27.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "BaseViewController.h"
#import "TaoDeepStockViewController.h"

@interface TaoDeepDepartmentViewController : BaseViewController

@property (nonatomic, strong) NSString *date;

- (void)scrollToTop;

@property (nonatomic, weak) id <TaoDeepTigetSendCountDelegate> delegate;


@end
