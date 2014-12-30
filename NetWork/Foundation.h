//
//  Foundation.h
//  beta1
//
//  Created by Zhou Zhi on 13-9-12.
//  Copyright (c) 2013年  All rights reserved.
//
#ifdef DEBUG
#   define DLog(fmt, ...) {NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);}
#   define ELog(err) {if(err) DLog(@"%@", err)}
#else
#   define DLog(...)
#   define ELog(err)
#endif

//------------------------------------------------------------------------------------------------
#define kScreenWidth [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height
#define KCellTitleColor [UIColor colorWithRed:27/255.0f green:76/255.0f blue:160/255.0f alpha:1]
#define KCellContentColor [UIColor colorWithRed:102/255.0f green:102/255.0f blue:102/255.0f alpha:1]
#define KCellSourceColor [UIColor colorWithRed:186/255.0f green:186/255.0f blue:186/255.0f alpha:1]
#define KTopBarTitleColor [UIColor colorWithRed:193/255.0f green:193/255.0f blue:193/255.0f alpha:1]
#define KbackgroundColor [UIColor colorWithRed:221/255.0f green:221/255.0f blue:221/255.0f alpha:1]
#define KDrawCartogramColor [UIColor colorWithRed:45/255.0f green:189/255.0f blue:195/255.0f alpha:1]


#define Font(x) [UIFont systemFontOfSize:x]
//判断屏幕大小
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)


//#define baseDomain  @"luyou1.7.zhw1.net"   //域名
//#define basePort     @""   //端口
//#define basePath     @"LTManage/index.php/LuTao"
//#define baseDomain  @"luyou2.sx3.7isp.com"   //域名
//#define basePort     @""   //端口
//#define basePath     @"ltmanage/index.php/LuTao"
//
////
////
//#define basePicPath      @""

//--------------数据接口---------------------
//#define customerURL @"luyou2.sx3.7isp.com/"   //全路径 √
#define customerRegister  @"register"   //注册 
#define customerLogin @"login" //登陆 √
#define customerGetImage @"getImg"  //获取广告图片集合  √
#define customerGetTypeList @"getTypeList" //获取所有类型
#define customerPlaceId @"getBuyList" //获取团购商品
#define customerGetIsHot @"getIsHot"  //获取热卖商品
#define customerGetIsSpecials @"getIsSpecials"  //获取特惠
#define customerOnlyType  @"OnlyType" 
#define customerGetOnlyGoods @"getOnlyGoods"   //单个商品信息
#define customerGetNewCount @"getNewCount" //获取最新更新的条数
#define customerAddGoodsRNumber @"addGoodsRNumber" //商品点评  好评  差评  还行 
#define customerAddGoodsReviews @"addGoodsReviews" //添加商品评价
#define customerQueryGoodsReviews  @"queryGoodsReviews" //查看点评
#define customerAddReply @"addReply" //添加回复
#define customerMyKeep @"MyKeep" //查看我的收藏 
#define customerAddKeep @"addKeep" //添加我的收藏
#define customerQueryMyReservations @"queryMyReservations" //查询我的预定
#define customerAddReservations @"addReservations" //添加预定
#define customerqueryMyGoods  @"queryMyGoods"  //查看我的商品
#define customerqueryOnlyListU @"queryOnlyListU" //查询我的商品下的某一商品所预定的用户集合
#define customerqueryOnlyUser @"queryOnlyUser" //查询预订用户的信息
#define customerupMyR  @"upMyR" //查看确认后 修改状态  -----确认预定
#define customerqueryViewedGoods @"queryViewedGoods" //查看我看过的商品
#define customergetMyRemarks @"getMyRemarks" //我的言论
#define customerqueryHeadlines @"queryHeadlines" //查看头条 
#define customergetResumeUrl @"getResume" // 查看某类型简历集合
#define customerqueryResumeUrl @"queryResumeUrl" // 查看简历
#define customerqueyrRecruitingType @"queyrRecruitingType" // 根据类型查询招聘集合
#define customergetREcruitUrl @"getREcruit"  // 查看具体的招聘信息
#define customerqueryProblemUrl @"queryProblem"  // 查看达人提问
#define customergetOnlyProblemUrl @"getOnlyProblemUrl" // 查看具体达人提问
#define customerqueryBulletinUrl @"queryBulletin" // 查看公告信息
#define customequeryNews  @"queryNews"//查询某类新闻集合
#define customequeryOnlyNews @"queryOnlyNews"//查询单条数据
#define customeaddNewsReviews @"addNewsReviews"//添加新闻评价
#define customeaddNewsReply @"addNewsReply"//添加新闻回复


#define customeSMS_Push @"SMS_Push"//短信验证
#define customeAgainPWD @"AgainPWD"//忘记密码
#define customegetNewsCount @"getNewsCount"//头条更新数
#define customegetbulletinCount @"getbulletinCount"//公告更新数
#define customegetProblemCount @"getProblemCount"//达人问答更新数

