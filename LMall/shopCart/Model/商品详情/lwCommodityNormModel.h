//
//  lwCommodityNormModel.h
//  shopCart
//
//  Created by lw on 16/4/25.
//  Copyright © 2016年 lw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface lwCommodityNormModel : NSObject

/**规格ID*/
@property (copy, nonatomic) NSString *nid;
/**商品ID*/
@property (copy, nonatomic) NSString *pid;
@property (copy, nonatomic) NSString *format;
@property (copy, nonatomic) NSString *color;
@property (copy, nonatomic) NSString *num;
@property (copy, nonatomic) NSString *price;
@property (copy, nonatomic) NSString *vprice;
@property (copy, nonatomic) NSString *logo;
@property (copy, nonatomic) NSString *oprice;
@property (copy, nonatomic) NSString *bno;
@property (copy, nonatomic) NSString *formatName;
@property (copy, nonatomic) NSString *colorName;
@property (copy, nonatomic) NSString *prcurl;

- (id)initWithDict:(NSMutableDictionary *)dict;

@end
