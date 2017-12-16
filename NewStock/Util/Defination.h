//
//  defination.h
//

#ifndef NewStock_defination_h
#define NewStock_defination_h


#define IOS7_OR_LATER       1
#define MAIN_SCREEN_WIDTH   [[UIScreen mainScreen] applicationFrame].size.width
#define MAIN_SCREEN_HEIGHT  [[UIScreen mainScreen] applicationFrame].size.height
#define NAV_BAR_HEIGHT      64
#define TAB_BAR_HEIGHT      49
#define TOOL_BAR_HEIGHT     44


////      个人帐号

//#define APP_ID @"1211105024"
//#define JPUSH_APPKEY @"988b7487e597173c675213a3"
//#define UM_SOCIALKEY @"58b7e1427f2c7463b9002592"
//#define UM_WXAppId @"wxc267b2e914a9036e"
//#define UM_WXAppSecret @"32bc49a96cc3ec96857f9ef0a96c0023"
//#define UM_QQAPPID @"1105825859"
//#define UM_QQAPPKEY @"g1wKFiqNnvYmwvFN"
//#define UM_Sina_Appkey @"3831528477"
//#define UM_Sina_secret @"34282491a13da6cb2d27af4f616c0ae4"
//#define H5_OPEN_PARAM @"vest"


////       公司帐号

#define APP_ID @"1160573329"
#define JPUSH_APPKEY @"e06e313a6c8d91821b38e38f"
#define UM_SOCIALKEY @"57c8d99f67e58e4113000c20"
#define UM_WXAppId @"wx0b5c570f38f070f1"
#define UM_WXAppSecret @"7f7160e5e7bdc693bff7904a2f1a0950"
#define UM_QQAPPID @"1105700884"
#define UM_QQAPPKEY @"KEYyzYvoTtYQxvNIcWJ"
#define UM_Sina_Appkey @"2452234373"
#define UM_Sina_secret @"c42f21b320622aadef6df1cf1c1175a6"
#define H5_OPEN_PARAM @"origin"





#define kUIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define kScale MIN([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) / 375
//[UIScreen mainScreen].bounds.size.width / 375
///ff8035  ff6e19

#define kNameColor kUIColorFromRGB(0x6aa7e5)
#define kButtonBGColor kUIColorFromRGB(0xff8036)
#define kTitleColor kUIColorFromRGB(0xff6e19)

#define kBlackTitleColor [UIColor colorWithRed:51.0/255.0 green:51/255.0 blue:51/255.0 alpha:1]
/*
 友盟事件统计
 */

#define STOCK_DETAIL @"STOCK_DETAIL"
#define RECORD_HOLDING @"RECORD_HOLDING"
#define SHARE_EVENT @"SHARE_EVENT"
#define ADD_MY_STOCK @"ADD_MY_STOCK"
#define DEL_MY_STOCK @"DEL_MY_STOCK"

////////






//股怪侠-官方粉丝群 433985872
#define QQ_NUMBER @"433985872"

#define MSG_LOGOUT @"logoutMessage"//退出

//logo 地址
#define LOGO_ASSERT @"https://guguaixia-product.oss-cn-shanghai.aliyuncs.com/static/img/logo.png"

//匿名头像地址
#define LOGO_SECRET @"https://guguaixia-product.oss-cn-shanghai.aliyuncs.com/ico/default/ams.png"

//下载渠道
#define CHANNEL_ID @"App Store"


#define TO_DO_FLAG NO

//通知
#define STATESBAR_TOUCH_NOTIFICATION @"statebarTouchNotifation" //通知栏点击事件通知

//东莞证券开户
#define DGZQ_OPENURL @"http://m.dgzq.com.cn/kh/m/open/index.html?camera=1&recommand_id=019970#!/account/msgVerify.html"//@"http://58.252.1.85:8082/m/open/index.html"

//用户信息
#define USER_ID @"user_id"
#define USER_NAME @"user_name"
#define USER_PW @"user_pw"

#define INPUT_USER_NAME @"input_user_name"

//设备信息
#define API_SIGNATURE_NAME @"signature"
#define API_DEVICE_IDENTIFICATION @"deviceIdentification"
#define API_DEVICE_MAC_ADDRESS @"macAddress"
#define API_DEVICE_PHONE_TYPE @"phoneType"
#define API_APP_VERSION @"appVersion"


//消息
#define HOLDING_SHEET_MSG @"HoldingSheetMsg"//持仓菜单消息

#define HAS_UN_READ_MSG @"hasUnReadMsg"//有未读消息

//接口版本号
#define API_VERSION @"1.0"

//版本号
#define versionStr  [NSString stringWithFormat:@"isFirstLoad%@",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]]  //@"isFirstLoan1.4.0"

//接口 上传苹果商店需要切换成正式服务器
//#define API_URL @"http://210.13.123.226:8008/eagle-frontap/"
//#define API_URL @"http://192.168.8.113:8080/eagle-frontap/"
//#define API_URL @"http://192.168.8.8/eagle-frontap/"
//#define API_URL @"http://139.196.249.213/eagle-frontap/"
//#define API_URL @"http://192.168.8.22:8080/eagle-frontap/"
//#define API_URL @"http://192.168.8.21:8080/eagle-frontap/"
//#define API_URL @"http://jiabei.f3322.net:8022/eagle-frontap/"
//#define API_URL @"http://192.168.32.36/eagle-frontap/"
#define API_URL @"https://www.guguaixia.com/eagle-frontap/"


//首页
#define API_MAIN_PAGE @"/jiabei/v2.0/index"

#define API_MAIN_MESSAGE @"jiabei/notice/list"
#define API_MAIN_MESSAGE_UNREAD @"jiabei/notice/unread"

#define API_DRAW_LOTS @"jiabei/draw/open"

//分享
#define API_SHARE @"jiabei/share"

/**
 *  行情相关
 */
//码表 个股
#define API_STOCK_CODES_INFO @"resource/codes/%@"

//码表新增 营业部
#define API_DEPARTMENT_ALL @"jiabei/tao/department/all/%@"

//码表 牛散名单
#define API_TAO_PPL_ALL @"jiabei/tao/ppl/user/all/%@"

//新股申购查询
#define API_STOCK_APPLY @"jiabei/stock/apply/%@"

//新股申购详情
#define API_STOCK_APPLY_DETAIL @"jiabei/stock/purchase/%@"

//新股上市表现
#define API_STOCKP_PERFORM @"jiabei/stock/being/perform"

//题材详情
#define API_THEME_DETAIL @"jiabei/theme/detail"

//题材列表
#define API_THEME_TIMELINE @"jiabei/theme/timeline"

//说文解股刷新
#define API_TALK_NEWS @"jiabei/news/headline"

//排名
#define API_MARKET_RANK @"resource/rank/details/zxjt"

//板块列表
#define API_BOARD_LIST_RANK @"resource/rank/details/zxjt"

//板块详情
#define API_BOARD_DETAIL_RANK @"resource/sector/details"

//指数信息
#define API_INDEX_INFO @"resource/symbols/hqlist"

//指数一览
#define API_INDEX_DETAILS @"jiabei/indexDetails"

//个股-详情
#define API_STOCK_BASE_INFO @"resource/symbols/%@/%@/%@/base"

//个股-K线
#define API_KLINE_INFO @"resource/symbols/%@/%@/%@/%@/ohlcs"

//个股-五档
#define API_STOCK_FIFTH_POSITION @"resource/symbols/%@/%@/%@/fifthPosition"

//个股-成交明细
#define API_STOCK_TRADES @"resource/symbols/%@/%@/%@/1/trades"//?query={\"fromNo\":1,\"toNo\":20}

//个股-财务
#define API_FINANCE_INFO @"resource/symbols/%@/%@/company"

//个股-公告
#define API_SYMBOL_NEWS_INFO @"resource/symbolnews/titles"


//添加自选
#define API_ADD_MY_STOCK @"jiabei/mystock/add"
//删除自选
#define API_DEL_MY_STOCK @"jiabei/mystock/del"
//重置自选股
#define API_RESET_MY_STOCK @"jiabei/mystock/reset"
//我的自选股
#define API_MY_STOCK_ALL @"jiabei/mystock/all"

//添加预警
#define API_USER_ALERTED @"jiabei/user/replace/alerted"

//预警信息查询
#define API_USER_ALER @"jiabei/user/toedit/alerted"

//自选股新闻
#define API_STOCK_NEWS_LIST @"jiabei/stock/news/list"

//自选公告
#define API_STOCK_ANNOUNCE_LIST @"jiabei/stock/announcement/list"

//广告列表
#define API_AD_LIST @"jiabei/ad/list"

//股侠圈帖子列表
#define API_FEED_LIST @"jiabei/feed/list"

//话题列表
#define API_FEED_CHILD_LIST @"jiabei/feed/child"

//股侠圈精华帖子列表
#define API_RECOMMENDED_LIST @"jiabei/feed/recommended"

//股侠圈帖子未读消息
#define API_MOMENT_UNREAD_COUNT @"jiabei/comment/notice/unread"

//股侠圈消息列表
#define API_MOMENT_UNREAD_LIST @"jiabei/comment/notice/list"

//股侠圈消息操作
#define API_MOMENT_UNREAD_OPERATION @"jiabei/comment/notice/opr"

//股侠圈消息提醒头像地址
#define API_MOMENT_NOTICE_ICON @"https://guguaixia-product.oss-cn-shanghai.aliyuncs.com/static/img/notice.png"

//股侠圈快讯
#define API_MOMENT_NEWS_ANALYIST @"jiabei/news/analysis"

//股侠圈发帖
#define API_POST_FEED @"jiabei/feed/pub"

//发布评论
#define API_POST_COMMENT @"jiabei/comment/pub"

//查询对应FEED
#define API_FEED_MAPPED @"jiabei/feed/mapped"

//收藏
#define API_FAVOURITES_FEED @"jiabei/favourites/feed"

//举报
#define API_SPAM_REPORT @"jiabei/spam/report"




//FEED赞/取消
#define API_FEED_LIKE @"jiabei/like/feed"

//关注 取消接口
#define API_USER_FOLLOWED @"jiabei/user/followed"

///////////////////////////////////////////////////////
//H5

//公告列表
#define H5_STOCK_NEWS_LIST @"jiabei/HQ1002"

//公告详情
#define H5_STOCK_NEWS_DETAIL @"jiabei/HQ1003"

//F10
#define H5_STOCK_F10 @"jiabei/HQ1004"

//财务信息
#define H5_STOCK_FINANCE @"jiabei/HQ1006"

//利润表
#define H5_STOCK_INCOME @"jiabei/HQ1007"

//资产负债表
#define H5_STOCK_BALANCE_SHEET @"jiabei/HQ1008"

//现金流量表
#define H5_STOCK_CASH_FLOW @"jiabei/HQ1009"

//谈股
#define H5_STOCK_TALK @"jiabei/HQ1000"

//个股资讯
#define H5_STOCK_HP0104 @"jiabei/HP0104"

//策略股票一览
#define H5_STOCK_STRATEGY_DETAIL @"jiabei/HP0101"

//新股申购流程
#define H5_NEW_STOCK_APPLY @"jiabei/NS0001"

//等级介绍
#define H5_ACCOUNT_MY_GRADE @"jiabei/MY9901"

//查看用户足迹
#define H5_ACCOUNT_MY_HISTORY @"jiabei/MY0400"
#define H5_ACCOUNT_MY_HISTORY_UNLOGIN @"jiabei/MY0400UNLOGIN"

//我的关注
#define H5_ACCOUNT_MY_FOLLOW @"jiabei/MY0500"
//我的粉丝
#define H5_ACCOUNT_MY_FANS @"jiabei/MY0501"
//我的帖子
#define H5_ACCOUNT_MY_FEED @"jiabei/MY0401"
//我的评论
#define H5_ACCOUNT_MY_COMMONED @"jiabei/MY0402"
//我的收藏
#define H5_ACCOUNT_MY_COLLECTION @"jiabei/MY0404"
//我的匿名
#define H5_ACCOUNT_MY_SECRET @"jiabei/MY0405"

//查询我的资产
#define H5_ACCOUNT_MY_ASSET @"jiabei/MY0200"
#define H5_ACCOUNT_MY_ASSET_UNLOGIN @"jiabei/MY0200UNLOGIN"

//编辑持仓
#define H5_ACCOUNT_MY0201 @"jiabei/MY0201"

//资讯详情
#define H5_NEWS_DETAIL @"jiabei/HP0105"

//说文解股
#define H5_LEIDA_NEWS_LIST @"jiabei/HP0106"

//说文解股分享页面
#define H5_TALK_SHARE @"jiabei/HP0107"

//股市江湖一览
#define H5_FM0100 @"jiabei/FM0100"

//股侠说
#define H5_FM0200 @"jiabei/FM0200"

//题材详情
#define H5_TH0001 @"jiabei/TH0001"

//主力股票池
#define H5_MF0101 @"jiabei/MF0101"

//涨停分析
#define H5_DB0001 @"jiabei/DB0001"

//连板捕捉
#define H5_DB0002 @"jiabei/DB0002"

//次新捉妖
#define H5_DB0003 @"jiabei/DB0003"

//新股池
#define H5_DB0004 @"jiabei/DB0004"

//技术选股
#define H5_SM0001 @"jiabei/SM0001"

//新手指引
#define H5_MY2901 @"jiabei/MY2201"//@"jiabei/MY2901"
//风险提示
#define H5_MY2902 @"jiabei/MY2202"//@"jiabei/MY2902"
//积分详情
#define H5_JF0001 @"jiabei/JF0001"
//活动地址
#define H5_AC0001 @"jiabei/AC0001"

//开户
#define H5_TR0001 @"jiabei/TR0001"

/**
 *  账户相关
 */
//登录 退出
#define API_ACCOUNT_LOGIN @"jiabei/login"
#define API_ACCOUNT_REGISITER @"jiabei/register"
#define API_ACCOUNT_LOGOUT @"/jiabei/logout"
//查询绑定手机
#define API_PHONE_CHECK @"jiabei/bind"

//第三方登录/绑定手机
#define API_THIRD_LOGIN @"jiabei/tlogin"

//获取验证码
#define API_ACCOUNT_SEND_MSG @"jiabei/send"

//验证码校验
#define API_ACCOUNT_VALIDATE @"jiabei/validate"

//查询用户信息
#define API_ACCOUNT_GET_USERINFO @"jiabei/user/info"

//修改用户信息
#define API_ACCOUNT_UPDATE_USERINFO @"jiabei/user/update"

//用户关注的动态
#define API_ACCOUNT_GET_USER_DYNAMIC @"jiabei/user/dynamic"

//删除动态
#define API_ACCOUNT_DELETE_DYNAMIC @"jiabei/user/dynamic/del"

//修改密码
#define API_ACCOUNT_UPDATE_PW @"jiabei/user/retpwd"

//申请认证
#define API_USER_VERFITY @"jiabei/user/verify/person"

//查询认证信息
#define API_USER_VERTIFY_MY @"jiabei/user/verify/my"

//上传图像
#define API_ACCOUNT_UPLOAD_IMG @"jiabei/user/img/update"
#define API_UPLOAD_IMG @"jiabei/upload/file"
#define API_UPLOAD_IMGS @"jiabei/upload/files"

//获取默认头像
#define API_ACCOUNT_GET_DEFAULT_USERICON @"jiabei/user/ico/default";

//#define API_ACCOUNT_PASSWORD_RESET @"account/password/reset"
//#define API_ACCOUNT_PASSWORD_CHANGE @"account/password/change"

//查询我的资产
#define API_GET_USER_ASSET @"jiabei/user/asset"

//获取我的积分
#define API_GET_MY_SCORE @"jiabei/score/my"

//录入持仓
#define API_INPUT_POSITION @"jiabei/user/asset/inputPos"

//清空持仓
#define API_CLEAR_POS @"jiabei/user/asset/clearPos"

/**
 *  设置
 */
//吐槽
#define USER_SUGGEST @"jiabei/user/suggest"

//查询系统设置
#define USER_SET_LIST @"jiabei/user/set/list"

//设置系统设置
#define USER_SET_UPDATE @"jiabei/user/set/update"

/*
 
 淘牛股
 
 */

//淘牛股首页
#define API_TAO_INDEX @"jiabei/tao/v2.0/index"//@"jiabei/tao/index"

//淘牛股技术形态选股列表
#define API_TAO_SKILL @"jiabei/tao/skill/stock/list"

//淘牛股主力股票池列表
#define API_TAO_ZHULI_LIST @"jiabei/tao/main/stock/pool/list"

//淘牛股四合一接口 康
#define API_TAO_DBSQ @"jiabei/tao/dbsq/stock/list"

//淘牛潜力牛股 康
#define API_TAO_QLNG @"jiabei/tao/smart/stock/list"

//淘牛潜力牛股评论列表 康
#define API_TAO_QLNG_COMMENT_LIST @"jiabei/comment/list"

//淘牛潜力牛股历史列表 康
#define API_TAO_QLNG_LIST @"jiabei/tao/smart/stock/history/list"

//淘牛股技术形态历史列表
#define API_TAO_SKILLL_HISTORY_LIST @"jiabei/tao/skill/stock/history/list"

//淘牛深度龙虎榜日历列表 康
#define API_TAO_DEEPTIGER_CALENDER_LIST @"jiabei/tao/lhb/calendar"

//淘牛深度龙虎榜数据列表 康
#define API_TAO_DEEPTIGER_LIST @"jiabei/tao/lhb/list"

//机构红苗
#define API_TAO_REEDROOT @"jiabei/tao/institution"

//游资侠股分类
#define API_IDLEFUND_CLASSIFY @"jiabei/tao/boss/classify"

//游资侠股 改----->>>>> 淘牛股主力股票池列表详情
#define API_IDLEFUND_STOCK @"jiabei/tao/main/stock/pool/info"

//日期列表
#define API_TAO_DATE_LIST @"jiabei/tao/date/list"

//淘牛股个股搜索
#define API_TAO_SEARCH_STOCK @"jiabei/tao/search/stock"

//淘牛股营业部详情
#define API_TAO_SEARCH_DEPARTMENT @"jiabei/tao/search/department"

//淘牛股范围日期
#define API_TAO_DATE_RANGE @"jiabei/tao/date/range"

//淘牛股牛散范围日期
#define API_TAO_PPL_RANGE @"jiabei/tao/ppl/date/range"

//淘牛股搜索热词
#define API_TAO_SEARCH_HOT @"jiabei/tao/search/hot"

//淘牛股搜索热人
#define API_TAO_SEARCH_HOT_PPL @"jiabei/tao/ppl/search/hot"

//淘牛股达人股票搜索
#define API_TAO_PPL_SEARCH_STOCK @"jiabei/tao/ppl/search/stock"

//淘牛股达人用户搜索
#define API_TAO_PPL_SEARCH_USER @"jiabei/tao/ppl/search/user"

//淘牛股牛股推荐日历
#define API_TAO_GPTJ_DATE_LIST @"jiabei/tao/gptj/date/list"

//淘牛股股票推荐列表
#define API_TAO_GPTJ_STOCK_LIST @"jiabei/tao/gptj/stock"

//淘牛股首页提示语
#define API_TAO_START_MESSAGE @"jiabei/notice/start/message"

//启动页判断是否有登录状态
#define API_GET_USER_LOGIN_STATE @"jiabei/luser"

//启动判断是否强制更新
#define API_LUNCH_UPDATE_APP @"jiabei/app/v"

//东莞证券统计API
#define API_DGZQ_MESSAGE @"jiabei/dgzj/message"

#endif
