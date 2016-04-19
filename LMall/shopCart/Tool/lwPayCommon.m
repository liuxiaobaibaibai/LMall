//
//  lwPayCommon.m
//  shopCart
//
//  Created by lw on 16/4/19.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "lwPayCommon.h"

static lwPayCommon *payCommon = nil;

@implementation lwPayCommon

#pragma mark - 初始化工作

- (id)init
{
    self = [super init];
    if (self) {
        _payType = lwPayTypeAlipay;
        _commonType = lwPayCommonTypePrice;
    }
    return self;
}

+ (lwPayCommon *)pay
{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        payCommon = [[self alloc] init];
    });
    return payCommon;
}


#pragma mark - payOperation

+ (void)pay:(lwPayType)type Order:(NSString *)orderID
{
    switch (type) {
        case lwPayTypeAlipay:
        {
            [[lwPayCommon pay] aliPay:lwPayCommonTypeOrder Param:orderID];
        }
            break;
        case lwPayTypeWeChatpay:
        {
            [[lwPayCommon pay] wechatPay:lwPayCommonTypeOrder Param:orderID];
        }
            break;
        case lwPayTypeUnionpay:
        {
            [[lwPayCommon pay] unionPay:lwPayCommonTypeOrder Param:orderID];
        }
            break;
        default:

            break;
    }
}

+ (void)pay:(lwPayType)type Price:(NSString *)price
{
    switch (type) {
        case lwPayTypeAlipay:
        {
            [[lwPayCommon pay] aliPay:lwPayCommonTypePrice Param:price];
        }
            break;
        case lwPayTypeWeChatpay:
        {
            [[lwPayCommon pay] wechatPay:lwPayCommonTypePrice Param:price];
        }
            break;
        case lwPayTypeUnionpay:
        {
            [[lwPayCommon pay] unionPay:lwPayCommonTypePrice Param:price];
        }
            break;
        default:
            break;
    }
}

#pragma mark - Alipay
/**
 *  支付宝支付
 *  @param  commonType  支付类型
 *  @param  param   参数（订单ID 或者 金额）
 */
- (void)aliPay:(lwPayCommonType)commonType Param:(NSString *)param{
    switch (commonType) {
        case lwPayCommonTypeOrder:
        {
            [[lwPayCommon pay] aliPayWithOrder:param];
        }
            break;
        case lwPayCommonTypePrice:
        {
            [[lwPayCommon pay] aliPayWithPrice:param];
        }
            break;
        default:
            break;
    }
}

/**
 *  支付宝金额支付
 *  @param  orderID   订单ID
 */
- (void)aliPayWithOrder:(NSString *)orderID{
    NSLog(@"支付宝订单ID：%@",orderID);
}

/**
 *  支付宝金额支付
 *  @param  price   金额
 */
- (void)aliPayWithPrice:(NSString *)price{
    NSLog(@"支付宝支付金额：%@",price);
}

#pragma mark - WeCaht
/**
 *  微信支付
 *  @param  commonType  支付类型
 *  @param  param   参数（订单ID 或者 金额）
 */
- (void)wechatPay:(lwPayCommonType)commonType Param:(NSString *)param{
    switch (commonType) {
        case lwPayCommonTypeOrder:
        {
            [[lwPayCommon pay] wechatPayWithOrder:param];
        }
            break;
        case lwPayCommonTypePrice:
        {
            [[lwPayCommon pay] wechatPayWithPrice:param];
        }
            break;
        default:
            break;
    }
}

/**
 *  支付宝金额支付
 *  @param  orderID   订单ID
 */
- (void)wechatPayWithOrder:(NSString *)orderID{
    NSLog(@"微信订单ID：%@",orderID);
}

/**
 *  支付宝金额支付
 *  @param  price   金额
 */
- (void)wechatPayWithPrice:(NSString *)price{
    NSLog(@"微信支付金额：%@",price);
}

#pragma mark - UnionPay
/**
 *  微信支付
 *  @param  commonType  支付类型
 *  @param  param   参数（订单ID 或者 金额）
 */
- (void)unionPay:(lwPayCommonType)commonType Param:(NSString *)param{
    switch (commonType) {
        case lwPayCommonTypeOrder:
        {
            [[lwPayCommon pay] unionPayWithOrder:param];
        }
            break;
        case lwPayCommonTypePrice:
        {
            [[lwPayCommon pay] unionPayWitPrice:param];
        }
            break;
        default:
            break;
    }
}

/**
 *  支付宝金额支付
 *  @param  orderID   订单ID
 */
- (void)unionPayWithOrder:(NSString *)orderID{
    NSLog(@"银联订单ID：%@",orderID);
}

/**
 *  支付宝金额支付
 *  @param  price   金额
 */
- (void)unionPayWitPrice:(NSString *)price{
    NSLog(@"银联支付金额：%@",price);
}

#pragma mark - OtherPay 其他支付方式


@end
