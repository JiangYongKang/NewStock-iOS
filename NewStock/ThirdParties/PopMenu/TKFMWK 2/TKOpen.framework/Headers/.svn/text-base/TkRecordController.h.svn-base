//
//  TKChatControllerAC.h
//  TKchat_AC
//
//  Created by chensj on 14-4-18.
//  Copyright (c) 2014年 chensj. All rights reserved.
//

#import <UIKit/UIKit.h>
#include <AVFoundation/AVFoundation.h>
#import <CoreMedia/CoreMedia.h>
#import <MediaPlayer/MediaPlayer.h>



/**
  * @protocol TKRecordResultDelegate
  * @description 录像结果委托
 */
@protocol TKRecordResultDelegate <NSObject>

@required

/**
 *@method tkRecordDelegate: 录像结果代理处理方法
 *@param result 结果返回参数
 */

-(void)tkRecordDelegate:(id)result;

@end

/**
 * @class TkRecordController
 * @description 录制本地视频
 */
@interface TkRecordController : UIViewController

@property (nonatomic, assign)id <TKRecordResultDelegate> delegate;


- (id)initWithDelegate:(id<TKRecordResultDelegate>)delegate parm:(id)jsParam;

@end
