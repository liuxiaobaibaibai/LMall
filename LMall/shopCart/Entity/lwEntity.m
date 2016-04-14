//
//  lwEntity.m
//  shopCart
//
//  Created by 刘威 on 16/4/4.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "lwEntity.h"


static lwEntity *entity = nil;

@implementation lwEntity

+ (instancetype)entitySingleton{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        entity = [[self alloc] init];
    });
    return entity;
}


- (id)init{
    self = [super init];
    if (self) {
        [self initEntity];
    }
    return self;
}

/**
 *  自动初始化目标数据
 */
- (void)initEntity{
    
    /*** 订单完成开始 ***/
    _CompletedOrderCellID = @"cell1";
    _CompletedOrderAddressCellID = @"cell2";
    _CompletedOrderCommodityCellID = @"cell3";
    _CompletedOrderCommonCellID = @"cell4";
    /*** 订单完成结束 ***/
    
    /*** 商品详情开始 ***/
    _CommodityCellCustomID = @"cell5";
    _CommodityCellTitleID = @"cell6";
    /*** 商品详情结束 ***/
    
    /*** 商城首页开始 ***/
    _homeCommonCellID = @"celasd";
    _homeCustomCellID = @"cejs";
    _homeHeaderFirstViewID = @"homecell1";
    _homeHeaderOtherViewID = @"homecell2";
    _homeFooterViewID = @"homecell3";
    /*** 商城首页结束 ***/
}


@end
