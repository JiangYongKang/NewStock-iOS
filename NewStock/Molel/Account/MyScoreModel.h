//
//  MyScoreModel.h
//  NewStock
//
//  Created by 王迪 on 2017/4/17.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import <Mantle/Mantle.h>



@interface MyScoreDayModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, copy) NSString *o;
@property (nonatomic, copy) NSString *s;
@property (nonatomic, copy) NSString *n;
@property (nonatomic, copy) NSString *sc;
@property (nonatomic, copy) NSString *p;
@property (nonatomic, copy) NSString *t;
@property (nonatomic, copy) NSString *url;

@end

@interface MyScoreListModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *o;
@property (nonatomic, copy) NSString *s;
@property (nonatomic, copy) NSString *n;
@property (nonatomic, copy) NSString *sc;
@property (nonatomic, copy) NSString *t;

@end

@interface MyScoreModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *ico;
@property (nonatomic, copy) NSString *sc;
@property (nonatomic, copy) NSString *exd;
@property (nonatomic, copy) NSString *tsc;
@property (nonatomic, copy) NSString *utsc;
@property (nonatomic, strong) NSArray <MyScoreDayModel *> *day;
@property (nonatomic, strong) NSArray <MyScoreDayModel *> *listInit;

@end
