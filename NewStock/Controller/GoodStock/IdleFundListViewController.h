//
//  IdleFundListViewController.h
//  NewStock
//
//  Created by 王迪 on 2017/2/14.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "BaseViewController.h"
#import "IdleFundStockModel.h"

@protocol IdleFundListViewControllerDelegate <NSObject>

- (void)idleFundListViewControllerDelegateDsc:(NSString *)dsc icon:(NSString *)icon;

@end

@interface IdleFundListViewController : BaseViewController

@property (nonatomic, copy) NSString *code;

@property (nonatomic, weak) id <IdleFundListViewControllerDelegate> delegate;

@property (nonatomic, copy) void(^pushBlock)(IdleFundStockListModel *);

@property (nonatomic, copy) dispatch_block_t tigerVCPushBlock;

@end
