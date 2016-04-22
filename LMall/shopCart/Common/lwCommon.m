//
//  lwCommon.m
//  sixApp
//
//  Created by lw on 15/11/6.
//  Copyright © 2015年 lw. All rights reserved.
//

#import "lwCommon.h"
#import <SystemConfiguration/SystemConfiguration.h>
#import <SystemConfiguration/CaptiveNetwork.h>
#import <MapKit/MapKit.h>

@implementation lwCommon

+ (void)loginWithWeChat{
    
}

+ (BOOL)connectNetWork{
    // Create zero addy
    struct sockaddr_storage zeroAddress;//IP地址
    bzero(&zeroAddress, sizeof(zeroAddress));//将地址转换为0.0.0.0
    zeroAddress.ss_len = sizeof(zeroAddress);//地址长度
    zeroAddress.ss_family = AF_INET;//地址类型为UDP, TCP, etc.
    
    // Recover reachability flags
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;
    //获得连接的标志
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    //如果不能获取连接标志，则不能连接网络，直接返回
    if (!didRetrieveFlags)
    {
        return NO;
    }
    //根据获得的连接标志进行判断
    BOOL isReachable = flags & kSCNetworkFlagsReachable;
    BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
    return (isReachable && !needsConnection) ? YES : NO;
}


#pragma mark - 相关验证
// 邮箱验证
+ (BOOL)validateEmail:(NSString *)email{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

/**验证邮编*/
+ (BOOL) isValidZipcode:(NSString*)value
{
    const char *cvalue = [value UTF8String];
    int len = (int)strlen(cvalue);
    if (len != 6) {
        return FALSE;
    }
    for (int i = 0; i < len; i++)
    {
        if (!(cvalue[i] >= '0' && cvalue[i] <= '9'))
        {
            return FALSE;
        }
    }
    return TRUE;
}

+ (void)call:(NSString *)phoneNo{
    UIWebView*callWebview =[[UIWebView alloc] init];
    NSURL *telURL =[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",phoneNo]];// 貌似tel:// 或者 tel: 都行
    [callWebview loadRequest:[NSURLRequest requestWithURL:telURL]];
    //记得添加到view上
    [[[UIApplication sharedApplication] keyWindow] addSubview:callWebview];
}

//手机号码验证
+ (BOOL)validateMobile:(NSString *)mobile{
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}


//车牌号验证
+ (BOOL)validateCarNo:(NSString *)carNo{
    NSString *carRegex = @"^[\u4e00-\u9fa5]{1}[a-zA-Z]{1}[a-zA-Z_0-9]{4}[a-zA-Z_0-9_\u4e00-\u9fa5]$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",carRegex];
    return [carTest evaluateWithObject:carNo];
}

// 网址验证
+ (BOOL)validateUrlpath:(NSString *)urlpath{
    NSString *carRegex = @"^[a-zA-z]+://[^\\s]*";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",carRegex];
    return [carTest evaluateWithObject:urlpath];
}

//车型
+ (BOOL)validateCarType:(NSString *)CarType{
    NSString *CarTypeRegex = @"^[\u4E00-\u9FFF]+$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",CarTypeRegex];
    return [carTest evaluateWithObject:CarType];
}


//用户名
+ (BOOL)validateUserName:(NSString *)name{
    NSString *userNameRegex = @"^[A-Za-z0-9]{6,20}+$";
    NSPredicate *userNamePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",userNameRegex];
    BOOL B = [userNamePredicate evaluateWithObject:name];
    return B;
}


//密码
+ (BOOL)validatePassword:(NSString *)passWord{
    NSString *passWordRegex = @"^[a-zA-Z0-9]{6,20}+$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    return [passWordPredicate evaluateWithObject:passWord];
}


//昵称
+ (BOOL)validateNickname:(NSString *)nickname{
    NSString *nicknameRegex = @"^[\u4e00-\u9fa5]{4,8}$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",nicknameRegex];
    return [passWordPredicate evaluateWithObject:nickname];
}


//身份证号
+ (BOOL)validateIdentityCard: (NSString *)identityCard{
    BOOL flag;
    if (identityCard.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:identityCard];
}

+ (void)turnByTurn:(CLLocationCoordinate2D)endPoint EndAddressName:(NSString *)name PhoneNo:(NSString *)phoneNo{
    if ([[[UIDevice currentDevice] systemVersion] floatValue]<6.0){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"暂不支持7.0以下的系统导航" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }else{
        //当前的位置
        MKMapItem *currentLocation = [MKMapItem mapItemForCurrentLocation];
        
        //目的地的位置
        MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:endPoint addressDictionary:nil]];
        toLocation.name = name;
        toLocation.phoneNumber = phoneNo;
        
        
        NSArray *items = [NSArray arrayWithObjects:currentLocation, toLocation, nil];
        NSDictionary *options = @{ MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving, MKLaunchOptionsMapTypeKey: [NSNumber numberWithInteger:MKMapTypeStandard], MKLaunchOptionsShowsTrafficKey:@YES };
        
        //打开苹果自身地图应用，并呈现特定的item
        [MKMapItem openMapsWithItems:items launchOptions:options];
    }
}

@end
