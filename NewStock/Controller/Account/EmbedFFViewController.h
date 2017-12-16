//
//  EmbedFFViewController.h
//  NewStock
//
//  Created by 王迪 on 2017/1/16.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "EmbedBaseViewController.h"
#import "EmbedWebView.h"


@interface EmbedFFViewController : EmbedBaseViewController

@property (nonatomic, strong) EmbedWebView *webView;

@property (nonatomic, copy) NSString *myUrl;

@end
