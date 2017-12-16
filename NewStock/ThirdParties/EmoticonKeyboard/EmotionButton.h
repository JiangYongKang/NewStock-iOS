//
//  EmotionButton.h
//  oc-emotion
//
//  Created by 王迪 on 2017/2/9.
//  Copyright © 2017年 JiaBei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EmotionModel.h"
#import "EmotionAttachment.h"


@interface EmotionButton : UIButton

@property (nonatomic, strong) EmotionModel *model;

@property (nonatomic, strong) EmotionAttachment *attach;

@end
