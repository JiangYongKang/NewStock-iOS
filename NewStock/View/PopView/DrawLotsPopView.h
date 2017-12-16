//
//  DrawLotsPopView.h
//  NewStock
//
//  Created by Willey on 16/11/9.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "PopView.h"
#import "DrawLotsAPI.h"
#import "DrawLotsModel.h"

typedef NS_ENUM(NSInteger, SHAKE_STATUS) {
    SHAKE_STATUS_NOR,
    SHAKE_STATUS_SHAKE,
    SHAKE_STATUS_DONE,
    SHAKE_STATUS_CLOSE
};



@protocol DrawLotsPopViewDelegate;

@interface DrawLotsPopView : PopView<APIRequestDelegate>
{
    UIView *_lotsView;
    UIImageView *_lot;
    UILabel *_lotContentLb;
    
    CALayer *_ballLayer;;//摇动的签
    float _angle;
    float _timeInter;
    
    BOOL _isRequesting;
    DrawLotsAPI *_drawLotsAPI;
    DrawLotsModel *_drawLotsModel;
}
@property (nonatomic, assign) id<DrawLotsPopViewDelegate> delegate;
@property (nonatomic, assign) SHAKE_STATUS shakeStatus;


- (void)shake;

@end




@protocol DrawLotsPopViewDelegate <NSObject>
@optional
- (void)drawLotsPopView:(DrawLotsPopView*)drawLotsPopView drawLotsModel:(DrawLotsModel *)drawLotsModel;
@end
