//
//  FifthPosView.h
//  NewStock
//
//  Created by Willey on 16/8/12.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HMSegmentedControl.h"
#import "FifthPosModel.h"


@protocol FifthPosViewDelegate;

@interface FifthPosView : UIView<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_fifthPosTableView;
    UITableView *_detailTableView;

    FifthPosModel * _fifthPosModel;
    NSMutableArray *_tradeArray;
    
    float _prevClose;
}
@property (weak, nonatomic) id<FifthPosViewDelegate> delegate;


- (id)initWithWidth:(int)width height:(int)height;
-(void)setFifthPosModel:(FifthPosModel *)fifthPosModel;
-(void)setTradeArray:(NSMutableArray *)array;

@end


@protocol FifthPosViewDelegate <NSObject>
@optional
- (void)fifthPosView:(FifthPosView*)fifthPosView selectIndex:(NSInteger)index;
@end
