//
//  ForeignIndexListViewController.h
//  NewStock
//
//  Created by Willey on 16/11/28.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "BaseViewController.h"
#import "IndexBlock.h"

@interface ForeignIndexListViewController : BaseViewController
{
    IndexBlock *_hsIndex;
    IndexBlock *_nasdaqIndex;
    IndexBlock *_dowIndex;
    
    IndexBlock *_bpIndex;
    IndexBlock *_rjIndex;
    IndexBlock *_ygfsIndex;
}
@end
