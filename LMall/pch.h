//
//  pchFile.pch
//  skyCar
//
//  Created by liuwei on 15-6-15.
//  Copyright (c) 2015年 liuwei. All rights reserved.
//


#ifdef __OBJC__ // 只被object－c文件所引用

#import <UIKit/UIKit.h>
#import "AFNetworking.h"
#import <AFNetworking.h>
#import "lwGetData.h"
#import "lwPlayerView.h"
#import "NSString+lwString.h"
#import "lwCommon.h"
#import <EaseMob.h>
#import <MBProgressHUD.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "AFNetworking.h"

#import <UIKit/UIKit.h>
#import "UIColor+lwColor.h"
#import "lwStyleTool.h"
#import "Masonry.h"
#import "lwEntity.h"
#import "MJRefresh.h"
#import "lwLocation.h"
#import <AlipaySDK/AlipaySDK.h>
#import <MapKit/MapKit.h>


#define CityDataURL @"http://www.hunliji.com/cities.json"

#define liveStreamUrlPath @"rtmp://v1.live.126.net/live/86aff005009b402c85543b53c7691f1f"

#endif


#ifndef sixApp_pchFile_pch
#define sixApp_pchFile_pch

#define DLog(format, ...) \
do { \
NSLog(@"<%@ : %d : %s>-: %@", \
[[NSString stringWithUTF8String:__FILE__] lastPathComponent], \
__LINE__, \
__FUNCTION__, \
[NSString stringWithFormat:format, ##__VA_ARGS__]); \
} while(0)

/**记录时间*/
#define TICK   NSDate *startTime = [NSDate date]
/**结束时间*/
#define TOCK   NSLog(@"Time: %f", -[startTime timeIntervalSinceNow])



#define lW [UIApplication sharedApplication].delegate.window.bounds.size.width
#define lH [UIApplication sharedApplication].delegate.window.bounds.size.height
#define HXsingletion [[EaseMob sharedInstance] chatManager]

#define systemVersions [[[UIDevice currentDevice] systemVersion] floatValue]
//是否为iOS7
#define iOS7 ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)
//是否为iOS8及以上系统
#define iOS8 ([[UIDevice currentDevice].systemVersion doubleValue] >= 8.0)

// 2.获得RGB颜色
#define RGBA(r, g, b, a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r, g, b)     RGBA(r, g, b, 1.0f)
//  十六进度颜色，预设透明度
#define HTMLColor(c) HTMLColorWithA(c,1.0)
//  十六进制颜色，不预设透明度
#define HTMLColorWithA(c,a) [UIColor colorWithHexString:c Alpha:a]

#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;

/// 极光AppKey
#define JpushAppKey @"d4cceabcd234cb90cf494ee3"
/// 环信AppKey
#define MobAppKey @"fulangyiwu#juyingbao"
/// 环信ClientID
#define MobClientID @"YXA6Lgn1gPrZEeW1ejGEN1v5Cw"
/// 环信ClientSecret
#define MobClientSecret @"YXA6eA2gWzspfVMfxQEWp34-4QvM1Q4"


/// 微信AppID
#define WXAppID @"wxc8511ea9032146b1"
/// 微信Secret
#define WXAppSecret @"717541a1a138809662257998fb4476c5"
/// 微信获取token
#define GetAccess_tokenUrl @"https://api.weixin.qq.com/sns/oauth2/access_token?"
/// 微信获取身份信息
#define GetUserInfoUrl @"https://api.weixin.qq.com/sns/userinfo?access_token="
/// 刷新token
#define refreshTokenUrl @"https://api.weixin.qq.com/sns/oauth2/refresh_token?"


/**用户模块*/
#define user_login @"http://www.juyingbao.cn/index.php?g=Wap&m=API&a=login"
#define user_regist @"http://www.juyingbao.cn/index.php?g=Wap&m=API&a=reg"

#define user_giftPay @"http://www.wxcom.cn/index.php?&g=Wap&m=API&a=giftPay"

/*** 商城页面开始 ***/

// 商城首页
/// getTop
#define mall_getTop @"http://www.juyingbao.cn/index.php?&g=Wap&m=API&a=getTop"
/// getIndexData
#define mall_getIndex @"http://www.juyingbao.cn/index.php?&g=Wap&m=API&a=getIndexData"
/// getProducts
#define mall_getProducts @"http://www.juyingbao.cn/index.php?&g=Wap&m=API&a=getRecProducts"
/// 搜索
#define mall_searchProducts @"http://www.juyingbao.cn/index.php?&g=Wap&m=API&a=getProductByKeyword"


// 分类数据
#define mall_category @"http://www.juyingbao.cn/index.php?g=Wap&m=API&a=getcats"
// 商品列表
#define mall_getProductList @"http://www.juyingbao.cn/index.php?g=Wap&m=API&a=getGoods"
// 获取商品详情
#define mall_getProduct @"http://www.juyingbao.cn/index.php?&g=Wap&m=API&a=getproduct"
// 添加购物车
#define mall_addShopCart @"http://www.juyingbao.cn/index.php?&g=Wap&m=API&a=addcart"
// 获取购物车列表
#define mall_getShopCartList @"http://www.juyingbao.cn/index.php?&g=Wap&m=API&a=getCartList"
// 获取地区信息
#define mall_getAddressInfo @"http://www.juyingbao.cn/index.php?&g=Wap&m=API&a=editaddress"
// 获取收货地址列表
#define mall_getAddressList @"http://www.juyingbao.cn/index.php?&g=Wap&m=API&a=address"
// 新增/修改收货地址
#define mall_editAddress @"http://www.juyingbao.cn/index.php?&g=Wap&m=API&a=editaddress"
// 删除收货地址
#define mall_deleteAddress @"http://www.juyingbao.cn/index.php?&g=Wap&m=API&a=deladdress"
// 设为默认地址
#define mall_serDefault @"http://www.juyingbao.cn/index.php?&g=Wap&m=API&a=setdefault"
// 获取区域列表
#define mall_getArea @"http://www.juyingbao.cn/index.php?&g=Wap&m=API&a=getArea"
// 删除购物车
#define mall_deleteCart @"http://www.juyingbao.cn/index.php?&g=Wap&m=API&a=delcart"
// 创建于支付订单
#define mall_createWillPayOrderByShopCart @"http://www.juyingbao.cn/index.php?&g=Wap&m=API&a=createorderbycart"
// 从购物车选择商品提交订单
#define mall_commitOrderByShopCart @"http://www.juyingbao.cn/index.php?&g=Wap&m=API&a=PayByCart"
// 更新地址，重新计算邮费
#define mall_updateAddressInfo @"http://www.juyingbao.cn/index.php?&g=Wap&m=API&a=getNewPostAgeByCart"

// 微信支付签名
#define mall_paySign @"http://www.juyingbao.cn/index.php?&g=Wap&m=API&a=toPay"
// 支付宝支付签名
#define mall_alipaySign @"http://www.juyingbao.cn/index.php?&g=Wap&m=Alipaydemo&a=alipay"
// 获取订单
#define mall_getOrder @"http://www.juyingbao.cn/index.php?&g=Wap&m=API&a=getOrder"
// 获取订单详情
#define mall_getOrderDetail @"http://www.juyingbao.cn/index.php?&g=Wap&m=API&a=OrderDetail"

/*** 商城页面结束 ***/


/*** 个人中心开始 ***/
// 个人中心
#define personal_info @"http://www.juyingbao.cn/index.php?&g=Wap&m=API&a=personal"
// 我的人脉
#define personal_Contacts @"http://www.juyingbao.cn/index.php?&g=Wap&m=API&a=myContacts"
// 积分明细
#define personal_allScore @"http://www.juyingbao.cn/index.php?&g=Wap&m=API&a=allScore"
// 赠送积分
#define personal_giveScore @"http://www.juyingbao.cn/index.php?&g=Wap&m=API&a=giveScore"
// 消费明细
#define personal_consumeScore @"http://www.juyingbao.cn/index.php?&g=Wap&m=API&a=consumeScore"
// 转换明细
#define personal_switchScore @"http://www.juyingbao.cn/index.php?&g=Wap&m=API&a=switchScore"

// --- 商户管理 --- //
/**获取商品分类*/
#define personal_getcats @"http://www.wxcom.cn/index.php?g=Wap&m=API&a=getcats"
// --- 商户管理 --- //

/*** 个人中心结束 ***/


/**直播相关*/
#define live_getGift @"http://www.juyingbao.cn/index.php?g=Wap&m=API&a=getGift&token="
#define sixDToken @"fkdgiw1454290393"



#endif

