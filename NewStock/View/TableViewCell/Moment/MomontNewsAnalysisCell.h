//
//  MomontNewsAnalysisCell.h
//  NewStock
//
//  Created by 王迪 on 2017/5/25.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MomentNewsAnalysisModel.h"

@protocol MomontNewsAnalysisCellDelegate <NSObject>

- (void)momentNewsAnalysisCellStockPush:(MomentNewsAnalysisStockModel *)stock;

- (void)momentNewsAnalysisCellDidInit:(NSArray *)array;

@end

@interface MomontNewsAnalysisCell : UITableViewCell

@property (nonatomic, strong) MomentNewsAnalysisModel *model;

@property (nonatomic , strong) NSMutableArray *stockViewArray;

@property (nonatomic, weak) id <MomontNewsAnalysisCellDelegate> delegate;

- (void)showOrHideContentLabel;

@end
