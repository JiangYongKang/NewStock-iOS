//
//  QingHuaiCollectionViewCell.h
//  NewStock
//
//  Created by 王迪 on 2017/1/11.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainPageModel.h"

@class QingHuaiCollectionViewCell;

@protocol QingHuaiCollectionViewCellDelegate <NSObject>

- (void)qingHuaiCollectionViewCellLikeBtnClick:(QingHuaiCollectionViewCell *)cell;

@end



@interface QingHuaiCollectionViewCell : UICollectionViewCell


@property (nonatomic, weak) id <QingHuaiCollectionViewCellDelegate> delegate;

@property (nonatomic, strong) ForumModel *model;

@end
