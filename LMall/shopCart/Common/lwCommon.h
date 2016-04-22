//
//  lwCommon.h
//  sixApp
//
//  Created by lw on 15/11/6.
//  Copyright © 2015年 lw. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface lwCommon : NSObject

/// 微信登录
+ (void)loginWithWeChat;

/// 判断是否联网
+ (BOOL)connectNetWork;

// 拨打电话
+ (void)call:(NSString *)phoneNo;

#pragma mark - 相关验证

// 邮箱验证
+ (BOOL)validateEmail:(NSString *)email;
/**验证邮编*/
+ (BOOL) isValidZipcode:(NSString*)value;
//手机号码验证
+ (BOOL)validateMobile:(NSString *)mobile;

// 网址验证
+ (BOOL)validateUrlpath:(NSString *)urlpath;

//车牌号验证
+ (BOOL)validateCarNo:(NSString *)carNo;

//车型验证
+ (BOOL)validateCarType:(NSString *)CarType;

//用户名验证
+ (BOOL)validateUserName:(NSString *)name;

//密码验证
+ (BOOL)validatePassword:(NSString *)passWord;

//昵称验证
+ (BOOL)validateNickname:(NSString *)nickname;

//身份证号验证
+ (BOOL)validateIdentityCard: (NSString *)identityCard;

// 地图导航
+ (void)turnByTurn:(CLLocationCoordinate2D)endPoint EndAddressName:(NSString *)name PhoneNo:(NSString *)phoneNo;


@end
