//
//  lwMall_OrderModel.h
//  shopCart
//
//  Created by lw on 16/4/8.
//  Copyright © 2016年 lw. All rights reserved.
//
#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    lwServiceSubTypeShowMsg = 0,
    lwServiceSubTypeInputMsg,
    lwServiceSubTypeSwitch,
    lwServiceSubTypeStepper
} lwServiceSubType;

/**商品model*/
@class lwMall_CommmodityModel;


#pragma mark - 积分model

@interface lwMall_ScoreModel : NSObject

/**积分模板*/
@property (copy, nonatomic) NSString *sID;
/**积分名称*/
@property (copy, nonatomic) NSString *name;
/**可使用积分*/
@property (assign, nonatomic) int usefull;
/**转换比*/
@property (assign, nonatomic) double point;
/**本次可抵换金额*/
@property (assign, nonatomic) double price;
/**本次已转换的金额*/
@property (assign, nonatomic) double changedPrice;
/**本次已转换积分*/
@property (assign, nonatomic) int changedScore;

@end



#pragma mark - 订单金额Model

@interface lwMall_PriceModel : NSObject

/**总价*/
@property (assign, nonatomic) double sumPrice;
/**邮费*/
@property (assign, nonatomic) double postage;
/**商品价格*/
@property (assign, nonatomic) double truePrice;
/**积分优惠*/
@property (assign, nonatomic) double couponPrice;
/**积分数组*/
@property (retain, nonatomic) NSMutableArray <__kindof lwMall_ScoreModel *> *scoreArray;

@end




#pragma mark - 订单服务model

@interface lwMall_OrderServiceModel : NSObject

/**服务标题*/
@property (copy, nonatomic) NSString *serviceTitle;

/**服务标题
 *  如果是展示类型，这里就是子标题
 *  如果是输入类型，这里就是提示信息
 *  如果是加减类型，这里就是初始值
 */
@property (copy, nonatomic) NSString *serviceSubTitle;

@property (copy, nonatomic) UIColor *titleColor;

@property (copy, nonatomic) UIColor *subTitleColor;

/**服务类型*/
@property (assign, nonatomic) lwServiceSubType serviceType;

/**如果是开关，那么这里就是每个开关的状态*/
@property (assign, nonatomic) BOOL isOpen;

/**积分类型才有*/
@property (retain, nonatomic) lwMall_ScoreModel *scoreModel;

@end




#pragma mark - 订单model

@interface lwMall_OrderModel : NSObject

/**店铺名称*/
@property (copy, nonatomic) NSString *shopName;

/**商品数组（一个店铺可能会有多个商品）*/
@property (retain, nonatomic) NSMutableArray <__kindof lwMall_CommmodityModel *> *commodityArray;

/**服务数组*/
@property (copy, nonatomic) NSMutableArray <__kindof lwMall_OrderServiceModel *> *serviceArray;

/**计算结果*/
@property (copy, nonatomic) NSString *result;

/**返回多少个cell*/
@property (assign, nonatomic) NSInteger OCount;

/**
 *  计算商品数量和价格
 *  @param  model   商品model
 *  @return 返回商品信息
 */
+ (NSDictionary *)caulCountAndPrice:(NSMutableArray <__kindof lwMall_CommmodityModel *> *)model;



@end
