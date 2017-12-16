//
//  TaoQLNGCommentModel.h
//  NewStock
//
//  Created by 王迪 on 2017/6/27.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface TaoQLNGCommentModel : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong) NSString *icon;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *tm;
@property (nonatomic, strong) NSString *c;
@property (nonatomic, strong) NSString *uid;

@end
