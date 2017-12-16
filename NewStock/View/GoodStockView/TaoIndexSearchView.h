//
//  TaoIndexSearchView.h
//  NewStock
//
//  Created by 王迪 on 2017/3/9.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TaoIndexSearchView : UIView

@property (nonatomic, copy) NSString *dsc;

@property (nonatomic, copy) dispatch_block_t askBlock;

@property (nonatomic, copy) dispatch_block_t searchBlock;

@end
