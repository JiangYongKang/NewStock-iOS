//
//  UIView+Masonry_Arrange.h
//  NewStock
//
//  Created by Willey on 16/7/26.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Masonry_Arrange)

- (void) distributeSpacingHorizontallyWith:(NSArray*)views;
- (void) distributeSpacingVerticallyWith:(NSArray*)views;

@end
