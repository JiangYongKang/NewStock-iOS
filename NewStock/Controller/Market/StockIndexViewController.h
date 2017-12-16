//
//  StockIndexViewController.h
//  NewStock
//
//  Created by Willey on 16/7/23.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "EmbedBaseViewController.h"
#import "IndexBlock.h"

@interface StockIndexViewController : EmbedBaseViewController<IndexBlockDelegate>
{
    IndexBlock *_shIndex;
    IndexBlock *_szIndex;
    IndexBlock *_cybIndex;
    
    IndexBlock *_hs300Index;
    IndexBlock *_sz50Index;
    IndexBlock *_zz500bIndex;
    
    
    IndexBlock *_hsIndex;
    IndexBlock *_nasdaqIndex;
    IndexBlock *_dowIndex;
    
    IndexBlock *_bpIndex;
    IndexBlock *_rjIndex;
    IndexBlock *_ygfsIndex;
}
@end
