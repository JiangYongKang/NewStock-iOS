//
//  EmotionButton.m
//  oc-emotion
//
//  Created by 王迪 on 2017/2/9.
//  Copyright © 2017年 JiaBei. All rights reserved.
//

#import "EmotionButton.h"

@implementation EmotionButton


- (void)setModel:(EmotionModel *)model {
    
    _model = model;
    
    NSString *bundleStr = [[NSBundle mainBundle] pathForResource:@"Emoticons.bundle" ofType:nil];
    NSBundle *bundle = [[NSBundle alloc] initWithPath:bundleStr];
    NSString *imgPath = [NSString stringWithFormat:@"default/%@",model.png];
    UIImage *image = [UIImage imageNamed:imgPath inBundle:bundle compatibleWithTraitCollection:nil];
    [self setImage:image forState:UIControlStateNormal];
    
    _attach = [[EmotionAttachment alloc] init];
    _attach.image = image;
    _attach.chs = model.chs;
    
}


@end
