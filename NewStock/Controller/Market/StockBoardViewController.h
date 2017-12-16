//
//  StockBoardViewController.h
//  NewStock
//
//  Created by Willey on 16/7/23.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "EmbedBaseViewController.h"
#import "SKSTableView.h"
#import "StockTitleTableViewCell.h"

@interface StockBoardViewController : EmbedBaseViewController<UITableViewDelegate,UITableViewDataSource,SKSTableViewDelegate,StockTitleTableViewCellDelegate>
{
    SKSTableView *_tableview;

}
@end
