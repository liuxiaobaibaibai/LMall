//
//  lwPayCommon.h
//  shopCart
//
//  Created by lw on 16/4/19.
//  Copyright © 2016年 lw. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    lwPayTypeAlipay = 0,
    lwPayTypeWeChatpay,
    lwPayTypeUnionpay,
    lwPayTypeOtherPay
} lwPayType;

typedef enum : NSUInteger {
    lwPayCommonTypeOrder,
    lwPayCommonTypePrice
} lwPayCommonType;

typedef void(^payBlock)(id reult,NSError *error);

@interface lwPayCommon : NSObject

/**支付类型*/
@property (assign, nonatomic) lwPayType payType;
/**交易类型（订单还是金额）*/
@property (assign, nonatomic) lwPayCommonType commonType;

+ (lwPayCommon *)pay;

/**
 *  通用支付接口
 *  @param  type    支付类型
 *  @param  orderID 订单ID（根据订单支付的时候）
 */
+ (void)pay:(lwPayType)type Order:(NSString *)orderID;

/**
 *  通用支付接口
 *  @param  type    支付类型
 *  @param  price   本次支付金额
 */
+ (void)pay:(lwPayType)type Price:(NSString *)price;



@end
