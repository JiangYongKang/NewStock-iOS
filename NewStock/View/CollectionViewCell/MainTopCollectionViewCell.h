//
//  MainTopCollectionViewCell.h
//  NewStock
//
//  Created by 王迪 on 2017/3/13.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainPageModel.h"



@interface MainTopCollectionViewCell : UICollectionViewCell
{
    UIImageView *_bgImgView;
    UILabel *_descLb;
    UILabel *_sourceLb;
    UILabel *_tipsLb;
    UIButton *_likeBtn;
}


@property (strong, nonatomic) NSString *fid;
@property (nonatomic, copy) dispatch_block_t loginBlock;
@property (nonatomic, strong) ForumModel *model;

@end



