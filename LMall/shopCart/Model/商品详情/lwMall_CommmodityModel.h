//
//  lwMall_CommmodityModel.h
//  shopCart
//
//  Created by lw on 16/4/8.
//  Copyright © 2016年 lw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface lwMall_CommmodityModel : NSObject

/**图片链接*/
@property (copy, nonatomic) NSString *logoUrl;

/**标题*/
@property (copy, nonatomic) NSString *title;

/**价格*/
@property (assign, nonatomic) double price;

/**原价*/
@property (copy, nonatomic) NSString *oPrice;

/**数量*/
@property (assign, nonatomic) NSInteger cCount;

/**规格*/
@property (copy, nonatomic) NSString *norm;

/**其他标签*/
@property (retain, nonatomic) NSMutableArray <__kindof NSString *> *labelArray;

@end
