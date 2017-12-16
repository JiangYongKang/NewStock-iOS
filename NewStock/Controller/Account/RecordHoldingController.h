//
//  RecordHoldingController.h
//  NewStock
//
//  Created by Willey on 16/8/23.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "BaseViewController.h"
#import "MLPAutoCompleteTextField.h"
#import "DEMODataSource.h"
#import "UploadPositionAPI.h"

@interface RecordHoldingController : BaseViewController<UITextFieldDelegate,MLPAutoCompleteTextFieldDelegate,MLPAutoCompleteTextFieldDataSource>
{
    NSMutableArray *_resultArray;
    MLPAutoCompleteTextField *_autoCompleteTF;
    DEMODataSource *_autocompleteDataSource;

    UITextField *_buyPriceTF;
    UITextField *_buyAmountTF;
    
    UploadPositionAPI *_uploadPositionAPI;
    
    
    NSString *_symbol;
    NSString *_symbolTyp;
    NSString *_marketCd;
    
    
    BOOL _bContinue;
}
@end
