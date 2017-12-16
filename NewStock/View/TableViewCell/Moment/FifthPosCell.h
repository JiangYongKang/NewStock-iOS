//
//  FifthPosCell.h
//  NewStock
//
//  Created by Willey on 16/8/12.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FifthPosCell : UITableViewCell
{
    UILabel *_nameLb;
    UILabel *_valueLb;
    UILabel *_handsLb;
    
    float _prevClose;
}
- (void)setName:(NSString *)name value:(NSString *)value hands:(NSString *)hands;
- (void)setPrevClose:(float)f;
- (void)setValueColor:(UIColor *)color;
- (void)setHandsColor:(UIColor *)color;
@end
