//
//  lwFindModel.h
//  shopCart
//
//  Created by lw on 16/4/20.
//  Copyright © 2016年 lw. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^block)(id result, NSError *error);

@interface lwFindModel : NSObject

@property (copy, nonatomic) NSString *sid;

@property (copy, nonatomic) NSString *logoUrl;

@property (copy, nonatomic) NSString *shopName;

@property (copy, nonatomic) NSString *address;

@property (copy, nonatomic) NSString *distance;

@property (copy, nonatomic) NSString *telephoneNo;

@property (assign, nonatomic) CGFloat latitude;

@property (assign, nonatomic) CGFloat longtitude;

@property (assign, nonatomic) BOOL favorite;


/**
 *  关注店铺
 *  @param  favorite    关注OR 取关
 *  @param  completion  回调操作
 */
- (void)attentionShop:(BOOL)favorite Completion:(block)completion;

@end
