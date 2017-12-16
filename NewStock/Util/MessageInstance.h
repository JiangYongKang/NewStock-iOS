//
//  MessageInstance.h
//  NewStock
//
//  Created by Willey on 16/10/24.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ARCSingletonTemplate.h"

#import "UnReadAPI.h"

@interface MessageInstance : NSObject
{
    UnReadAPI *_unReadAPI;
    
    BOOL _bUnReadMsg;
}

SYNTHESIZE_SINGLETON_FOR_HEADER(MessageInstance)


- (BOOL)hasUnReadMsg;

- (void)setMsgRead:(NSString *)mId;

- (NSString *)getMsgId;

- (void)requestUnReadMsg;


@end
