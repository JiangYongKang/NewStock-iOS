//
//  StockCodesAPI.h
//  NewStock
//
//  Created by Willey on 16/8/2.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "APIRequest.h"

@interface StockCodesAPI : APIRequest

- (id)initWithLastModified:(NSString *)lastModified;
@end
