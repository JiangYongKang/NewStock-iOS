//
//  MomentNewsBottomStockView.h
//  NewStock
//
//  Created by 王迪 on 2017/5/25.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MomentNewsAnalysisModel.h"

@protocol MomentNewsBottomStockViewDelegate <NSObject>

- (void)MomentNewsBottomStockViewDelegate:(MomentNewsAnalysisStockModel *)stock;

@end

@interface MomentNewsBottomStockView : UIView

@property (nonatomic, weak) id <MomentNewsBottomStockViewDelegate> delegate;

@property (nonatomic, strong) MomentNewsAnalysisStockModel *stock;

- (void)setRate:(NSString *)zdf;

@end
