//
//  UserSuggestAPI.h
//  NewStock
//
//  Created by Willey on 16/8/23.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "APIListRequest.h"

@interface UserSuggestAPI : APIRequest
{

}
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *tel;

- (id)initWithUserId:(NSString *)userId
                content:(NSString *)content;
@end
