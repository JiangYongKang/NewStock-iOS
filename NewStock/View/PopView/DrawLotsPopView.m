//
//  DrawLotsPopView.m
//  NewStock
//
//  Created by Willey on 16/11/9.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "DrawLotsPopView.h"
#import "UILabel+VerticalText.h"
#import "Defination.h"
#import "SystemUtil.h"
#import "WebViewController.h"
#import "MarketConfig.h"
#import "AppDelegate.h"

#define DEGREES_TO_RADIANS(d) (d * M_PI / 180)

#define LOT_WIDTH 53
#define LOT_HEIGHT 254
@implementation DrawLotsPopView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.popupColor = [UIColor clearColor];

        _backgroundView.backgroundColor = [UIColor blackColor];
        
        _lot = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, LOT_WIDTH, LOT_HEIGHT)];
        _lot.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
        _lot.image = [UIImage imageNamed:@"lots"];
        _lot.userInteractionEnabled = YES;
        [self addSubview:_lot];
        _lot.hidden = YES;
        
        _lotContentLb = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, LOT_WIDTH, LOT_HEIGHT-50)];//(10, 30, 33, 203)
        _lotContentLb.textColor = kUIColorFromRGB(0x333333);
        _lotContentLb.textAlignment = NSTextAlignmentCenter;
        _lotContentLb.font = [UIFont boldSystemFontOfSize:18];
        [_lot addSubview:_lotContentLb];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, LOT_HEIGHT-40, LOT_WIDTH, 30);
        [btn addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:@"查看" forState:UIControlStateNormal];
        [btn setTitleColor:kUIColorFromRGB(0x333333) forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        [_lot addSubview:btn];
        
        _lotsView = [[UIView alloc] initWithFrame:frame];
        _lotsView.backgroundColor = [UIColor clearColor];
        [self addSubview:_lotsView];
        
        [self initLayer];
        
        _isRequesting = NO;
        
        _doneButton.frame = CGRectMake(self.frame.size.width-50, 60, 30, 30);
        [_doneButton setTitle:@"" forState:UIControlStateNormal];
        [_doneButton setBackgroundImage:[UIImage imageNamed:@"dismiss_icon"] forState:UIControlStateNormal];//setImage
        _doneButton.hidden = NO;
        [self bringSubviewToFront:_doneButton];
        
        
        UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 40)];
        lb.text = @"财神灵签\n摇一摇";
        lb.numberOfLines = 2;
        lb.font = [UIFont boldSystemFontOfSize:15];
        lb.textColor = [UIColor whiteColor];
        lb.textAlignment = NSTextAlignmentCenter;
        lb.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2+130);
        [self addSubview:lb];
        
        //设置默认参数
        _angle =25.0;
        _timeInter = 0.08;

        self.shakeStatus = SHAKE_STATUS_NOR;
        
        _drawLotsAPI = [[DrawLotsAPI alloc] init];
        _drawLotsAPI.delegate = self;
        
    }
    return self;
}

- (void)buttonClick {
    NSLog(@"%@",_drawLotsModel.no);

    [self dismissPopup];
    
    if (_drawLotsModel) {
        WebViewController *viewController = [[WebViewController alloc] init];
        NSString *url = _drawLotsModel.funcUrl;
        url = [url stringByReplacingOccurrencesOfString:@"./" withString:API_URL];
        NSString *urlStr = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        viewController.myUrl = urlStr;
        viewController.type = WEB_VIEW_TYPE_SHARE;
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        [appDelegate.navigationController pushViewController:viewController animated:YES];
    }
    
}

- (void)dismissPopup {
    
    self.shakeStatus = SHAKE_STATUS_CLOSE;
    [super dismissPopup];
    
    _lot.hidden = YES;
    _lotsView.hidden = NO;
    
    if (_drawLotsModel) {
        if([self.delegate respondsToSelector:@selector(drawLotsPopView:drawLotsModel:)]) {
            [self.delegate drawLotsPopView:self drawLotsModel:_drawLotsModel];
        }
    }
}

- (void)initLayer {
    _ballLayer=[CALayer layer];
    _ballLayer.bounds = CGRectMake(0, 0, 148,229);
    _ballLayer.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/2+100);
    _ballLayer.contents = (id)[UIImage imageNamed:@"drawLots_big"].CGImage;
    _ballLayer.anchorPoint = CGPointMake(0.5, 1.0);
    [_lotsView.layer addSublayer:_ballLayer];
    //[self.layer addSublayer:_ballLayer];
}

- (void)shake {
    
    if(self.shakeStatus == SHAKE_STATUS_NOR) {
        NSLog(@"----shake");
        //左右摇摆时间是定义的时间的2倍
        [NSTimer scheduledTimerWithTimeInterval:_timeInter*2
                                         target:self
                                       selector:@selector(ballAnmation:)
                                       userInfo:nil
                                        repeats:YES];
        
        self.shakeStatus = SHAKE_STATUS_SHAKE;
        
        
        //请求状态时，摇的角度不变，关闭按钮隐藏。请求完成出结果后再执行后继动画
        _isRequesting = YES;
        _doneButton.hidden = YES;
        
        [_drawLotsAPI start];

    }

    
}

- (void)ballAnmation:(NSTimer *)theTimer {
    //设置左右摇摆
    _angle=-_angle;
    
    if (_isRequesting == NO) {
        if (_angle > 0) {
            _angle--;
        }else{
            _angle++;
        }
    }
    
    CABasicAnimation* rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat:(DEGREES_TO_RADIANS(_angle))];
    rotationAnimation.duration = _timeInter;
    rotationAnimation.autoreverses = YES; // Very convenient CA feature for an animation like this
    rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [_ballLayer addAnimation:rotationAnimation forKey:@"revItUpAnimation"];
    if (_angle == 0) {
        [theTimer invalidate];
        //动画完毕操作
        _angle =25.0;
        _timeInter = 0.08;
        
        
        if (self.shakeStatus == SHAKE_STATUS_SHAKE)
        {
            self.shakeStatus = SHAKE_STATUS_DONE;
            
            
            //数据请求回调
            
            
            
        }
        

        
        
        _lot.frame = CGRectMake(0, 0, LOT_WIDTH, LOT_HEIGHT);
        _lot.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
        _lot.hidden = NO;
        
        _lot.transform = CGAffineTransformMake(0.33, 0, 0, 0.33, 0, 0);

        
        [UIView animateWithDuration:1.5 animations:^{

            _lot.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2-150);
            
            _lot.transform = CGAffineTransformMake(0.8, 0, 0, 0.8, 0, 0);


            _lotsView.transform = CGAffineTransformMake(0.5, 0, 0, 0.5, 0, 0);
            
            
        } completion:^(BOOL finished) {
            
            
            [UIView animateWithDuration:0.5 animations:^{
                
                _lot.transform = CGAffineTransformMake(1, 0, 0, 1, 0, 0);

                _lotsView.hidden = YES;
                _lotsView.transform = CGAffineTransformMake(1, 0, 0, 1, 0, 0);
                
                _lot.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2-30);
            } completion:^(BOOL finished) {
            }];
            
        }];
    }
}

- (void)requestFinished:(APIBaseRequest *)request {
    NSLog(@"succeed:%@",request.responseJSONObject);
    
    _isRequesting = NO;
    _doneButton.hidden = NO;
    
    _drawLotsModel = [MTLJSONAdapter modelOfClass:[DrawLotsModel class] fromJSONDictionary:request.responseJSONObject error:nil];
    NSLog(@"%@",_drawLotsModel);

    _lotContentLb.verticalText = [NSString stringWithFormat:@"%@ %@",_drawLotsModel.no,_drawLotsModel.n];

}

- (void)requestFailed:(APIBaseRequest *)request {
    NSLog(@"failed:%@",request.responseJSONObject);
    
    _isRequesting = NO;
    _doneButton.hidden = NO;
    
    _lotContentLb.verticalText = @"未摇出 请重新摇";

}

@end
