//
//  PlateRankView.h
//  NewStock
//
//  Created by Willey on 16/11/24.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BoardListModel.h"

@protocol PlateRankViewDelegate;

@interface PlateRankView : UIView
{
   
}
@property (weak, nonatomic) id<PlateRankViewDelegate> delegate;


-(void)setConceptModels:(NSArray *)array;
-(void)setIndustryModels:(NSArray *)array;

@end


@protocol PlateRankViewDelegate <NSObject>
@optional
- (void)plateRankView:(PlateRankView*)plateRankView selectModel:(BoardListModel *)model;
@end
