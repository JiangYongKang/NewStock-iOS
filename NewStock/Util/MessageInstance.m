//
//  MessageInstance.m
//  NewStock
//
//  Created by Willey on 16/10/24.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "MessageInstance.h"
#import "SystemUtil.h"
#import "Defination.h"

@implementation MessageInstance
SYNTHESIZE_SINGLETON_FOR_CLASS(MessageInstance)


- (BOOL)hasUnReadMsg {
    return _bUnReadMsg;
}

- (void)setMsgRead:(NSString *)mId {
    [SystemUtil putCache:@"unReadMsgId" value:mId];

    _bUnReadMsg = NO;
}

- (NSString *)getMsgId {
    NSString *unReadMsgId = [SystemUtil getCache:@"unReadMsgId"];
    return unReadMsgId;
}

- (void)requestUnReadMsg {
    NSString *unReadMsgId = [SystemUtil getCache:@"unReadMsgId"];

    _unReadAPI = [[UnReadAPI alloc] init];
    _unReadAPI.mId = unReadMsgId;
    
    [_unReadAPI startWithCompletionBlockWithSuccess:^(APIBaseRequest *request) {
        NSLog(@"suc:%@",_unReadAPI.responseJSONObject);

        BOOL b = [[_unReadAPI.responseJSONObject objectForKey:@"st"] boolValue];
        if (b)
        {
            _bUnReadMsg = YES;

            
            NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
            [center postNotificationName:HAS_UN_READ_MSG object:nil userInfo:nil];
            
        }
        
    } failure:^(APIBaseRequest *request) {
        
        
    }];
}



@end
