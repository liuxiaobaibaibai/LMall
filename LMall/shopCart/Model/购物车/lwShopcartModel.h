//
//  lwShopcartModel.h
//  lwGiftView
//
//  Created by 刘威 on 16/3/6.
//  Copyright © 2016年 刘威. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface lwShopcartModel : NSObject

@property (copy, nonatomic) NSString *logo;
@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *color;
@property (copy, nonatomic) NSString *norm;
@property (assign, nonatomic) float     price;
@property (assign, nonatomic) NSInteger max;
@property (copy, nonatomic) NSString *tag;

@property (assign, nonatomic) NSInteger count;


/**初始化方法*/
+ (instancetype)allocWithDict:(NSDictionary *)dict;

/**初始化方法*/
- (id)initWithDict:(NSDictionary *)dict;

/**
 *  计算当前总金额
 *  @param  dataArray   当前购物车数组
 */
+ (float)caculPrice:(NSMutableArray *)dataArray;

/**
 *  计算当前购物车中有多少商品
 *  @param  dataArray   当前购物车数组
 *  @return 返回当前购物车中商品数量
 */
+ (NSInteger)calculCount:(NSMutableArray *)dataArray;

@end
