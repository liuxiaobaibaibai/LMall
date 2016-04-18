//
//  lwMallModel.h
//  shopCart
//
//  Created by lw on 16/4/15.
//  Copyright © 2016年 lw. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^MallBlock)(id result, NSError *error);

@interface lwMallModel : NSObject

+ (void)getTopData:(MallBlock)completion;

+ (void)getMallData:(MallBlock)completion;

+ (void)getProducts:(MallBlock)completion;

@end
