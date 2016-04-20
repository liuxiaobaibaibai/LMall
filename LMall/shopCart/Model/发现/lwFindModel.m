//
//  lwFindModel.m
//  shopCart
//
//  Created by lw on 16/4/20.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "lwFindModel.h"

@implementation lwFindModel

- (void)attentionShop:(BOOL)favorite Completion:(block)completion{
    int result = arc4random()%30;
    // 模拟加载时间
    sleep(0.5);
    switch (result) {
        case 9:
        {
            // 处理失败
            NSError *error = [NSError errorWithDomain:@"获取失败" code:201 userInfo:@{@"reason":@"服务器异常,处理失败！"}];
            completion([error userInfo][@"reason"],error);
        }
            break;
        case 8:
        {
            // 其他情况
            NSError *error = [NSError errorWithDomain:@"网络连接失败！" code:202 userInfo:@{@"reason":@"您的网络似乎有问题"}];
            completion([error userInfo][@"reason"],error);
        }
            break;
        default:
        {
            // 处理成功
            self.favorite = favorite;
            NSString *msg = favorite ? @"关注成功" : @"取消关注成功";
            completion(msg,nil);
        }
            break;
    }
}

@end
