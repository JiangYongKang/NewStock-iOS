//
//  MainPageModel.h
//  NewStock
//
//  Created by Willey on 16/8/16.
//  Copyright © 2016年 Willey. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Mantle/Mantle.h>

//MainThemeStockModel

@interface MainThemeStockModel : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy) NSString *t;
@property (nonatomic, copy) NSString *s;
@property (nonatomic, copy) NSString *n;
@property (nonatomic, copy) NSString *m;
@property (nonatomic, copy) NSString *zdf;

@end

//MainThemeModel

@interface MainThemeModel : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy) NSString *ids;
@property (nonatomic, copy) NSString *n;
@property (nonatomic, copy) NSString *tt;
@property (nonatomic, copy) NSString *tm;
@property (nonatomic, copy) NSString *star;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *rmd;
@property (nonatomic, strong) NSArray *sl;

@end

//NewStockModel

@interface NewStockModel : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong) NSString *count;
@property (nonatomic, strong) NSString *funcUrl;
@property (nonatomic, strong) NSString *funcTitle;

@end

//Module
@interface ModuleMenuModel : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSString * url;
@property (nonatomic, strong) NSString * desc;

@end


//StrategyListModel
@interface StrategyListModel : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong) NSString * strategyId;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSString * category;
@property (nonatomic, strong) NSString * source;
@property (nonatomic, strong) NSString * srcIdOfStrat;
@property (nonatomic, strong) NSString * desc;
@property (nonatomic, strong) NSString * earningsYield;
@property (nonatomic, strong) NSArray * imageList;

@end

@interface ImageListModel : MTLModel<MTLJSONSerializing>
@property (nonatomic, strong) NSString * h240;
@property (nonatomic, strong) NSString * h640;
@property (nonatomic, strong) NSString * origin;
@property (nonatomic, strong) NSString * format;
@end



//Module
@interface NewsModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, strong) NSString * newsId;
@property (nonatomic, strong) NSString * pic;
@property (nonatomic, strong) NSString * sy;
@property (nonatomic, strong) NSString * tm;
@property (nonatomic, strong) NSString * tt;

@end

//Module
@interface LinksModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, strong) NSString * code;
@property (nonatomic, strong) NSString * ico;
@property (nonatomic, strong) NSString * n;
@property (nonatomic, strong) NSString * url;

@end


//Module
@interface ForumModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, assign) CGFloat rowHeight; //行高
//
@property (nonatomic, strong) NSString * seq;
@property (nonatomic, strong) NSString * c;
@property (nonatomic, strong) NSString * ctm;
@property (nonatomic, strong) NSString * funcUrl;
@property (nonatomic, strong) NSString * forumId;
@property (nonatomic, strong) NSString * fid;
@property (nonatomic, strong) NSString * st;
@property (nonatomic, strong) NSString * tm;
@property (nonatomic, strong) NSString * tt;
@property (nonatomic, strong) NSString * ty;
@property (nonatomic, strong) NSString * cs;
@property (nonatomic, strong) NSString * fd;
@property (nonatomic, strong) NSString * clk;
@property (nonatomic, strong) NSString * lkd;
@property (nonatomic, strong) NSString * stag_code;
@property (nonatomic, strong) NSString * uico;
@property (nonatomic, strong) NSString * uaty;
@property (nonatomic, strong) NSString * un;
@property (nonatomic, strong) NSString * uid;
@property (nonatomic, strong) NSArray * imgs;

@property (nonatomic, assign) BOOL hlkd;

@end


//TopicListModel
@interface TopicListModel : MTLModel<MTLJSONSerializing>
@property (nonatomic, strong) NSString * topicId;
@property (nonatomic, strong) NSString * u;
@property (nonatomic, strong) NSString * ty;
@property (nonatomic, strong) NSString * st;
@property (nonatomic, strong) NSString * tt;
@property (nonatomic, strong) NSString * ctm;
@property (nonatomic, strong) NSString * c;
@property (nonatomic, strong) NSString * loc;
@property (nonatomic, strong) NSString * mty;
@property (nonatomic, strong) NSString * tm;
@property (nonatomic, strong) NSArray * imgs;

@end


//ReportListModel
@interface ReportListModel : MTLModel<MTLJSONSerializing>
@property (nonatomic, strong) NSString * tt;
@property (nonatomic, strong) NSString * c;
@property (nonatomic, strong) NSString * cs;
@property (nonatomic, strong) NSString * fd;
@property (nonatomic, strong) NSString * lkd;
@property (nonatomic, strong) NSString * tm;
@property (nonatomic, strong) NSString * uName;
@property (nonatomic, strong) NSString * uIco;
@property (nonatomic, strong) NSString * funcUrl;

@property (nonatomic, strong) NSArray * imgs;

@end
