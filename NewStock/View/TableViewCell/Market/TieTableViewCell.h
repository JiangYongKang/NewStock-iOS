//
//  TieTableViewCell.h
//  NewStock
//
//  Created by Willey on 16/9/1.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TieTableViewCell : UITableViewCell
{
    UILabel *_contentLb;
    UILabel *_tagLb;

    UILabel *_readNumLb;
    UILabel *_comNumLb;
    UILabel *_praiseNumLb;

    UIView *_sepLine1;
    UIView *_sepLine2;

}

- (void)setContent:(NSString *)content tagType:(NSString *)tagType readNum:(NSString *)readNum comNum:(NSString *)comNum praiseNum:(NSString *)praiseNum;

@end
