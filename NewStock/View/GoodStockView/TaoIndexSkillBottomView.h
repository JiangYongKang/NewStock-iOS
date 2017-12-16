//
//  TaoIndexSkillBottomView.h
//  NewStock
//
//  Created by 王迪 on 2017/6/22.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TaoIndexSkillBottomViewDelegate <NSObject>

- (void)taoIndexSkillBottomViewDelegatePushTo:(NSString *)url title:(NSString *)title;

@end

@interface TaoIndexSkillBottomView : UIView

@property (nonatomic, strong) NSArray *dataArray;

@property (nonatomic, weak) id <TaoIndexSkillBottomViewDelegate> delegate;

@end


@interface TaoIndexSkillBottomButton : UIButton

@property (nonatomic, strong) NSString *code;

@property (nonatomic, strong) NSString *title;

@end
