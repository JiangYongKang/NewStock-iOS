//
//  LoginAPI.h
//  NewStock
//
//  Created by Willey on 16/8/23.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "APIRequest.h"

@interface LoginAPI : APIRequest
{
    
}
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *pwd;
@end
