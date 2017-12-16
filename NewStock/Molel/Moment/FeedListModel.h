//
//  FeedListModel.h
//  NewStock
//
//  Created by 王迪 on 2016/12/19.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import <Mantle/Mantle.h>
#import <UIKit/UIKit.h>


@interface FeedListIconModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, copy) NSString *origin;

@end

@interface FeedListUserModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, strong) FeedListIconModel *ico;
@property (nonatomic, copy) NSString *n;         //昵称
@property (nonatomic, copy) NSString *aty;    //等级
@property (nonatomic, copy) NSString *uid;    //id
@property (nonatomic, copy) NSString *fld;     //关注
@property (nonatomic, copy) NSArray *tag;

@end

@interface FeedListFootModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, copy) NSString *clk;       //阅读数
@property (nonatomic, copy) NSString *cs;        //评论数
@property (nonatomic, copy) NSString *lkd;       //赞

@end

@interface FeedListCtmModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, copy) NSString *stag_code; //原创转载爆料
@property (nonatomic, copy) NSString *ams;       //匿名

@end

@interface FeedListSLModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, copy) NSString *t;
@property (nonatomic, copy) NSString *s;
@property (nonatomic, copy) NSString *n;
@property (nonatomic, copy) NSString *m;
@property (nonatomic, copy) NSArray *c;

@end

@interface FeedListModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, copy) NSString *lkd;
@property (nonatomic, copy) NSString *pid;
@property (nonatomic, copy) NSString *sr;
@property (nonatomic, copy) NSString *ty;
@property (nonatomic, copy) NSString *tm;        //时间
@property (nonatomic, copy) NSString *ids;       //帖子标识
@property (nonatomic, copy) NSString *tt;        //title
@property (nonatomic, copy) NSString *c;         //content
@property (nonatomic, copy) NSString *istop;
@property (nonatomic, copy) NSString *tag;
@property (nonatomic, strong) NSArray *imgs;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, strong) NSArray *sl;

@property (nonatomic, strong) FeedListCtmModel *ctm; //ctm
@property (nonatomic, strong) FeedListFootModel *ss; //阅读 评论 赞
@property (nonatomic, strong) FeedListUserModel *u;  //用户相关


// add
@property (nonatomic, assign) BOOL selected;
@property (nonatomic, copy) NSString *imgStr;
@property (nonatomic, copy) NSString *contentStr;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, strong) NSMutableAttributedString *saveAttr;

@end








