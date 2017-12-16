//
//  StockViewController.h
//  NewStock
//
//  Created by Willey on 16/7/23.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "EmbedBaseViewController.h"
#import "IndexBlock.h"
#import "SKSTableView.h"
#import "StockTitleTableViewCell.h"

@interface StockViewController : EmbedBaseViewController<UITableViewDelegate,UITableViewDataSource,SKSTableViewDelegate,StockTitleTableViewCellDelegate,IndexBlockDelegate>
{
    IndexBlock *_shIndex;
    IndexBlock *_szIndex;
    IndexBlock *_cybIndex;
    
    SKSTableView *_tableview;
}
@end
