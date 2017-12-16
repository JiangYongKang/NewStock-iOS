//
//  MyStockHeaderView.h
//  NewStock
//
//  Created by 王迪 on 2017/1/12.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyStockHeaderView : UIView

- (void)setTotalMarketValue:(NSString *)marketValue buy:(NSString *)buy today:(NSString *)today totalEarn:(NSString *)totalEarn ;

- (void)setInitValue ;

@end
