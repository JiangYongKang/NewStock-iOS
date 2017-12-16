//
//  ContentViewController.m
//  NewStock
//
//  Created by Willey on 16/10/8.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "ContentViewController.h"
#import "Defination.h"

@interface ContentViewController ()

@end

@implementation ContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setNavBarTitle:@"用户协议"];
    
    [_scrollView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(NAV_BAR_HEIGHT, 0, 0, 0));
    }];
    [_scrollView layoutIfNeeded];
    
    
    UITextView *textView = [[UITextView alloc] init];
    textView.text = @"您只有接受以下所有服务条款，才能继续申请：\n\
    \n\
    1、服务条款的确认和接纳\n\
    　　股怪侠服务（以下简称股怪侠）的所有权和运作权归上海嘉贝信息科技有限公司（以下简称上海嘉贝公司）所有，包括但不限于行情软件、委托交易系统、网站、手机短信服务等。所提供的服务必须按照上海嘉贝公司章程，服务条款和操作规则严格执行。用户完成注册程序即表示用户与上海嘉贝公司达成协议并接受所有的服务条款。\n\
    \n\
    2、服务简介\n\
    　　上海嘉贝公司运用自己的服务系统通过互联网络为用户提供各项服务。用户必须：\n\
    支付个人上网和与此服务有关的费用。\n\
    　　考虑到股怪侠产品服务的重要性，用户同意：\n\
    （1）提供及时、详尽及准确的个人资料。\n\
    （2）不断更新注册资料，符合及时、详尽准确的要求。所有原始键入的资料将引用为注册资料。\n\
    　　用户主动填写的注册信息为上海嘉贝信息科技有限公司及所有，上海嘉贝信息科技有限公司可据此为用户提供服务。另外，用户可授权上海嘉贝信息科技有限公司向其他公司透露其注册资料，否则上海嘉贝公司不能公开用户的姓名、住址、电子邮箱、帐号。除非：\n\
    （1）用户要求上海嘉贝公司通过电子邮件服务透露这些信息。\n\
    （2）相应的法律、法规要求及程序服务需要上海嘉贝公司提供用户的个人资料。\n\
    　　如果用户提供的资料不准确，不真实，不合法有效，上海嘉贝公司保留结束用户使用股怪侠各项服务的权利。\n\
    \n\
    3、服务条款的修改\n\
    　　上海嘉贝公司会在必要时修改服务条款，服务条款一旦发生变动，上海嘉贝公司将会在用户进入下一步使用前的页面提示修改内容。如果您同意改动，则再一次激活“我同意”按钮。如果您不接受，则及时取消您的用户使用服务资格。\n\
    　　用户要继续使用股怪侠各项服务需要两方面的确认：\n\
    （1）首先确认服务条款及其变动。\n\
    （2）同意接受所有的服务条款限制。\n\
    \n\
    4、服务修订\n\
    　　上海嘉贝公司保留随时修改或中断服务而不需通知用户的权利。用户接受上海嘉贝公司行使修改或中断服务的权利，上海嘉贝公司不需对用户或第三方负责。\n\
    \n\
    5、用户隐私制度\n\
    　　尊重用户个人隐私是上海嘉贝公司的一项基本政策。所以，作为对以上第二点个人注册资料分析的补充，上海嘉贝公司一定不会公开、编辑或透露用户的注册资料及保存在股怪侠各项服务中的非公开内容，除非上海嘉贝公司在诚信的基础上认为透露这些信息在以下几种情况是必要的：\n\
    （1）遵守有关法律规定，包括在国家有关机关查询时，提供用户在股怪侠的网页上发布的信息内容及其发布时间、互联网地址或者域名。\n\
    （2）遵从上海嘉贝公司产品服务程序。\n\
    （3）保持维护上海嘉贝公司的商标所有权。\n\
    （4）在紧急情况下竭力维护用户个人和社会大众的隐私安全。\n\
    （5）根据第10条的规定或者上海嘉贝公司认为必要的其他情况下。\n\
    用户在此授权上海嘉贝公司可以向其电子邮箱发送商业信息。用户在享用股怪侠各项服务的同时，同意接收上海嘉贝公司发出的各类信息。\n\
    \n\
    6、用户的帐号、密码和安全性\n\
    　　您一旦注册成功成为用户，您将得到一个密码和帐号。如果您未保管好自己的帐号和密码而对您、上海嘉贝公司或第三方造成的损害，您将负全部责任。另外，每个用户都要对其帐户中的所有活动和事件负全责。您可随时改变您的密码，也可以结束旧的帐户重开一个新帐户。用户同意若发现任何非法使用用户帐号或安全漏洞的情况，立即通告上海嘉贝公司。\n\
    \n\
    7、拒绝提供担保\n\
    　　用户明确同意服务的使用由用户个人承担风险。上海嘉贝公司明确表示不提供任何类型的担保，不论是明确的或隐含的，但是对商业性的隐含担保，特定目的和不违反规定的适当担保除外。上海嘉贝公司不担保服务一定能满足用户的要求，也不担保服务不会受中断，对服务的及时性、安全性、出错发生都不作担保。上海嘉贝公司拒绝提供任何担保，包括信息能否准确、及时、顺利地传送。用户理解并接受下载或通上海嘉贝公司产品服务取得的任何信息资料取决于用户自己，并由其承担系统受损或资料丢失的所有风险和责任。上海嘉贝公司对在股怪侠上得到的任何商品购物服务或交易进程，都不作担保。用户不会从上海嘉贝公司收到口头或书面的意见或信息，上海嘉贝公司也不会在这里作明确担保。\n\
    \n\
    8、有限责任\n\
    　　上海嘉贝公司对直接、间接、偶然、特殊及继起的损害不负责任，这些损害来自：不正当使用产品服务，在网上购买商品或类似服务，在网上进行交易，非法使用服务或用户传送的信息有所变动。这些损害会导致上海嘉贝公司形象受损，所以上海嘉贝公司早已提出这种损害的可能性。\n\
    \n\
    9、股怪侠信息的储存及限制\n\
    　　上海嘉贝公司不对用户所发布信息的删除或储存失败负责。上海嘉贝公司保留判定用户的行为是否符合股怪侠服务条款的要求和精神的权利，如果用户违背了服务条款的规定，则中断其股怪侠服务的帐号。股怪侠所有的文章版权归原文作者和上海嘉贝公司共同所有，任何人需要转载股怪侠的文章，必须征得原文作者和上海嘉贝公司授权。\n\
    \n\
    10、用户管理\n\
    　　用户单独承担发布内容的责任。用户对服务的使用是根据所有适用于服务的地方法律、国家法律和国际法律标准的。用户承诺：\n\
    （1）在股怪侠的网页上发布信息或者利用股怪侠的服务时必须符合中国有关法规(部分法规请见附录)，不得在股怪侠的网页上或者利用股怪侠的服务制作、复制、发布、传播以下信息：\n\
    　  (a)反对宪法所确定的基本原则的；\n\
    　  (b) 危害国家安全，泄露国家秘密，颠覆国家政权，破坏国家统一的；\n\
    　  (c) 损害国家荣誉和利益的；\n\
    　  (d) 煽动民族仇恨、民族歧视，破坏民族团结的；\n\
    　  (e) 破坏国家宗教政策，宣扬邪教和封建迷信的；\n\
    　  (f) 散布谣言，扰乱社会秩序，破坏社会稳定的；\n\
    　  (g) 散布淫秽、色情、赌博、暴力、凶杀、恐怖或者教唆犯罪的；\n\
    　  (h) 侮辱或者诽谤他人，侵害他人合法权益的；\n\
    　  (i) 含有法律、行政法规禁止的其他内容的。\n\
    （2）在股怪侠的网页上发布信息或者利用股怪侠的服务时还必须符合其他有关国家和地区的法律规定以及国际法的有关规定。\n\
    （3）不利用股怪侠的服务从事以下活动：\n\
    　  (a) 未经允许，进入计算机信息网络或者使用计算机信息网络资源的；\n\
    　  (b) 未经允许，对计算机信息网络功能进行删除、修改或者增加的；\n\
    　  (c) 未经允许，对进入计算机信息网络中存储、处理或者传输的数据和应用程序进行删除、修改或者增加的；\n\
    　  (d) 故意制作、传播计算机病毒等破坏性程序的；\n\
    　  (e) 其他危害计算机信息网络安全的行为。\n\
    （4）不以任何方式干扰股怪侠的服务。\n\
    （5）遵守股怪侠的所有其他规定和程序。\n\
    　　用户需对自己在使用股怪侠服务过程中的行为承担法律责任。用户理解，如果股怪侠发现其网站传输的信息明显属于上段第(1)条所列内容之一，依据中国法律，上海嘉贝公司有义务立即停止传输，保存有关记录，向国家有关机关报告，并且删除含有该内容的地址、目录或关闭服务器。\n\
    　　用户使用股怪侠电子公告服务，包括电子布告牌、电子白板、电子论坛、网络聊天室和留言板等以交互形式为上网用户提供信息发布条件的行为，也须遵守本条的规定以及股怪侠将专门发布的电子公告服务规则，上段中描述的法律后果和法律责任同样适用于电子公告服务的用户。\n\
    若用户的行为不符合以上提到的服务条款，上海嘉贝公司将作出独立判断立即取消用户服务帐号。\n\
    \n\
    11、保障\n\
    　　用户同意保障和维护上海嘉贝公司全体成员的利益，负责支付由用户使用超出服务范围引起的律师费用，违反服务条款的损害补偿费用，其它人使用用户的电脑、帐号和其它知识产权的追索费。\n\
    \n\
    12、结束服务\n\
    　　用户或上海嘉贝公司可随时根据实际情况中断服务。上海嘉贝公司不需对任何个人或第三方负责而随时中断服务。用户若反对任何服务条款的建议或对后来的条款修改有异议，或对股怪侠的服务不满，用户只有以下的追索权：\n\
    （1）不再使用股怪侠服务。\n\
    （2）结束用户使用股怪侠服务的资格。\n\
    （3）通告上海嘉贝公司停止该用户的服务。\n\
    　　结束用户服务后，用户使用股怪侠服务的权利马上中止。从那时起，上海嘉贝公司不再对用户承担任何义务。\n\
    \n\
    13、通告\n\
    　　所有发给用户的通告都可通过电子邮件或常规的信件传送。上海嘉贝公司会通过邮件服务发报消息给用户，告诉他们服务条款的修改、服务变更、或其它重要事情。\n\
    \n\
    14、参与广告策划\n\
    　　在上海嘉贝公司许可下用户可在他们发表的信息中加入宣传资料或参与广告策划，在股怪侠各项免费服务上展示他们的产品。任何这类促销方法，包括运输货物、付款、服务、商业条件、担保及与广告有关的描述都只是在相应的用户和广告销售商之间发生。上海嘉贝公司不承担任何责任，上海嘉贝公司没有义务为这类广告销售负任何一部分的责任。\n\
    \n\
    15、内容的所有权\n\
    　　内容的定义包括：文字、软件、声音、相片、录象、图表；在广告中的全部内容；股怪侠服务为用户提供的商业信息。所有这些内容均受版权、商标、标签和其它财产所有权法律的保护。所以，用户只能在上海嘉贝公司和广告商授权下才能使用这些内容，而不能擅自复制、再造这些内容、或创造与内容有关的派生产品。\n\
    \n\
    16、法律\n\
    　　用户和上海嘉贝公司一致同意有关本协议以及使用股怪侠的服务产生的争议交由仲裁解决，但是上海嘉贝公司有权选择采取诉讼方式，并有权选择受理该诉讼的有管辖权的法院。若有任何服务条款与法律相抵触，那这些条款将按尽可能接近的方法重新解析，而其它条款则保持对用户产生法律效力和影响。\n\
    \n\
    17、股怪侠所含服务的信息储存及安全\n\
    　　上海嘉贝公司对股怪侠服务将尽力维护其安全性及方便性，但对服务中出现信息删除或储存失败不承担任何负责。另外我们保留判定用户的行为是否符合股怪侠服务条款的要求的权利，如果用户违背了服务条款的规定，将会中断其服务的帐号。\n\
    \n\
    \n\
    \n\
    附：\n\
    中华人民共和国电信条例\n\
    互联网信息服务管理办法\n\
    互联网电子公告服务管理规定\n\
    中华人民共和国计算机信息网络国际联网管理暂行规定\n\
    中华人民共和国计算机信息网络国际联网管理暂行规定实施办法\n\
    中华人民共和国计算机信息系统安全保护条例\n\
    计算机信息网络国际联网安全保护管理办法\n\
    \n\
";
    textView.editable = NO;
    textView.font = [UIFont systemFontOfSize:14];
    textView.textColor = kUIColorFromRGB(0x666666);
    textView.backgroundColor = [UIColor clearColor];
    [_mainView addSubview:textView];
    
    [textView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(textView.superview).with.insets(UIEdgeInsetsMake(0, 10, 0, 10));
    }];
}


@end
