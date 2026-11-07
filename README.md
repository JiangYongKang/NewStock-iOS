# 一、这个仓库是什么

股怪侠是面向 A 股的手机客户端。它提供行情、自选、选股策略和股侠圈社区，也带东莞证券开户插件。界面几乎全部用代码搭出来，窗口在 `AppDelegate` 里创建。

<div>
  <img src="https://user-images.githubusercontent.com/19708877/140886398-2b71fd92-442f-4c65-9e0d-90f4953b3554.png" width="200" height="333" alt="" />
  <img src="https://user-images.githubusercontent.com/19708877/140886372-19cd9d01-9713-4137-b9b5-3987e6eb504e.png" width="200" height="333" alt="" />
  <img src="https://user-images.githubusercontent.com/19708877/140886390-a96d3bff-ab00-4ed3-ae82-cae67ecbce6b.png" width="200" height="333" alt="" />
</div>

正式接口写在 `NewStock/Util/Defination.h`，基地址是 `https://www.guguaixia.com/eagle-frontap/`。同文件里还留着若干已注释的内网地址。页面上的买入、卖出和一部分资料页，打开的是这套服务上的 H5。

# 二、五个主页

根控制器是自定义的 `WXTabBarController`，外面套一层隐藏了系统导航栏的 `WDNavController`。五个页从左到右是：

1. 发现，对应 `MainViewController`。页头是轮播，下面是上证、深证、创业板三个指数，再往下是功能入口、快讯、新股申购和热门题材。右上角搜索进入搜股。功能入口的地址由接口下发，以 `native://` 开头的地址在本地打开。
2. 自选，对应 `OptionalViewController`，顶部分成「自选」和「行情」。自选维护用户的股票列表，行情里有指数、板块，以及涨幅、跌幅、五分钟涨幅、换手率、成交额几类排行。
3. 淘牛股，对应 `GoodStockViewController`。首页数据来自 `jiabei/tao/v2.0/index`，下面挂着牛散达人、深度龙虎榜、主力股票池、涨停分析、连板捕捉、次新捉妖、新股池、技术形态选股和潜力牛股。
4. 股侠圈，对应 `NewMomentViewController`，三个分段是大 V 说、头条和快讯。用户可以发帖、评论、点赞、收藏和举报，也会拉未读提醒。
5. 我的，对应 `AccountViewController`。这里看头像、昵称、等级和积分，也能进关注、粉丝、帖子、评论、收藏和匿名。列表里还有积分任务、活动广场、推荐给好友、吐槽、评分和申请认证。右上角进入设置，可改推送、行情刷新频率和缓存。

长按图标的快捷方式有四项：牛散名单、行情、自选、龙虎榜搜索。前三项切到对应主页，最后一项打开龙虎榜搜索。

# 三、行情和个股

点进个股会到 `StockChartViewController`。图区可以看分时、五日、日 K、周 K、月 K，副图支持 MA、EMA、MACD、KDJ、RSI、BOLL。分时旁边有五档。图下方用网页展示新闻、公告、F10 和财务。指数走另一页 `IndexChartViewController`。

底部栏的买入、卖出会打开 `jiabei/TR0001`，并带上股票代码和买卖方向。加自选走本地和 `jiabei/mystock` 相关接口。开户由工程里的 TKOpen 插件处理，启动时会调用 `TKAppEngine`。

启动后还会拉三份本地码表，并按版本号增量更新：股票代码、牛散用户、营业部。码表放在 `StockCodesInstance`，用 `NSKeyedArchiver` 存到本地。

# 四、代码怎么放

业务实现大约 460 个 `.m` 文件，不含 `ThirdParties` 和内置的 AFNetworking。控制器约 114 个，接口类约 101 个，模型约 50 个。

1. `NewStock/Controller` 按发现、自选、行情、淘牛股、股侠圈、账户、登录、设置分目录。页面多继承 `BaseViewController`，共用自定义导航栏 `NavBar`。
2. `NewStock/View` 放单元格、页头和弹层。`NewStock/Molel` 是模型目录，文件夹名就是这样拼的，模型用 Mantle 解析 JSON。
3. `NewStock/Network/API` 按业务放接口子类。`NewStock/Network/APINetwork` 是请求封装，支持代理和 block，也能做批量请求和链式请求，下面用的是工程自带的 AFNetworking。
4. `NewStock/StockChart` 是 K 线和分时的绘制。指标公式的说明写在该目录的几份 Markdown 里。
5. `NewStock/Util` 放接口常量、登录态、自选缓存、码表和跳转。`native://` 由 `NativeUrlRedirectAction` 分发，网页里的链接由 `UrlRedirectAction` 处理。
6. `NewStock/ThirdParties` 放没有走 CocoaPods 的库，包括极光推送、东莞证券开户框架、下拉刷新、轮播、引导页和表情键盘。`NewStock/Data` 里有字体、提示音，以及证书和密钥文件。

工程还有三个 target：`NewStock`、`NewStockTests`、`NewStockUITests`。两个测试 target 仍是 Xcode 生成的空例子。预编译头文件名是 `TKOpenDemo-Prefix.pch`。

# 五、启动和网络

`main.m` 进入 `AppDelegate`。启动时依次做这些事：创建窗口和主页，给请求加上公共头，已登录则写入 Cookie，检查网络和登录态，注册 `CustomUrlProtocol`，更新三份码表，初始化友盟统计、极光推送、分享和自选股，检查版本，并查询未读消息。

公共头包括设备号、机型、系统版本、应用版本、广告标识和接口版本 `1.0`。登录、注册、验证码、第三方登录都走 `jiabei/login` 这一组账户接口。第三方登录接的是微信、QQ 和微博。

`CustomUrlProtocol` 会留意不是本站接口的 http、https 请求，并把记录交给东莞证券统计接口。

H5 与原生通过 `WebViewJavascriptBridge` 通信，网页容器仍是旧的 `UIWebView`。应用自己的 URL Scheme 是 `guguaixia`，关联域名是 `guguaixia.com` 和 `www.guguaixia.com`。

# 六、依赖与工程

CocoaPods 锁在 1.3.1。`Pods` 目录被忽略，当前树里没有这份依赖，需要时用当时的 Podfile 重新安装。

1. Mantle 2.0 负责模型，Masonry 1.0.1 负责布局，SDWebImage 负责图片，YYText 负责富文本。
2. Reachability 检查网络，FCUUID 提供设备标识，MBProgressHUD 做加载提示，MMPlaceHolder 是调试占位。
3. WebViewJavascriptBridge 连接网页，CocoaSecurity 做加解密。
4. UMengAnalytics 做统计，UMengSocialCOM 做微信、QQ、微博分享。

打开工程用 `NewStock.xcworkspace`。Xcode 工程最后一次升级检查记的是 8.2。发布签名身份写的是 Shanghai Jiabei Mdt InfoTech Co., Ltd.。

# 七、阅读时要注意的地方

1. 第三方应用的密钥、极光和友盟的配置直接写在 `NewStock/Util/Defination.h`。本文不抄这些值。归档之后不要再把它们当成可用密钥。
2. `NewStock/Data` 里有证书和私钥文件，只作为历史材料留在树里，不要再拿去连接任何环境。
3. 推送的 entitlements 写的是 development。Info.plist 里为友盟、微博和证券页面放宽了一部分 ATS 限制。
4. 源码里能看到另一套已注释的个人账号配置，当前生效的是公司账号那一组宏。
5. 这个仓库适合对照旧版界面和接口查阅。它依赖已经停更的系统框架、旧版 CocoaPods 和当年的服务端，不适合直接拿来继续开发或上架。
