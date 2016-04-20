//
//  lwEntity.h
//  shopCart
//
//  Created by 刘威 on 16/4/4.
//  Copyright © 2016年 lw. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface lwEntity : NSObject

// 订单完成开始 //
/**普通ID*/
@property (copy, nonatomic, readonly) NSString *CompletedOrderCellID;
@property (copy, nonatomic, readonly) NSString *CompletedOrderAddressCellID;
@property (copy, nonatomic, readonly) NSString *CompletedOrderCommodityCellID;
@property (copy, nonatomic, readonly) NSString *CompletedOrderCommonCellID;
// 订单完成结束 //

// 商品详情开始 //
/**定制ID*/
@property (copy, nonatomic, readonly) NSString *CommodityCellCustomID;
/**标题ID*/
@property (copy, nonatomic, readonly) NSString *CommodityCellTitleID;
/**其他ID*/
@property (copy, nonatomic, readonly) NSString *CommodityCellOtherID;
// 商品详情结束 //

// 商城首页开始
@property (copy, nonatomic, readonly) NSString *homeHeaderCellID;
@property (copy, nonatomic, readonly) NSString *homeCommonCellID;
@property (copy, nonatomic, readonly) NSString *homeCustomCellID;

@property (copy, nonatomic, readonly) NSString *homeHeaderFirstViewID;
@property (copy, nonatomic, readonly) NSString *homeHeaderOtherViewID;
@property (copy, nonatomic, readonly) NSString *homeFooterCommonViewID;
@property (copy, nonatomic, readonly) NSString *homeFooterViewID;

// 商城首页结束

// 发现页面开始
@property (copy, nonatomic, readonly) NSString *lwFindVCellID;
// 发现页面结束

+ (instancetype)entitySingleton;


@end
