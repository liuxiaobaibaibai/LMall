//
//  lwMallModel.m
//  shopCart
//
//  Created by lw on 16/4/15.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "lwMallModel.h"

@implementation lwMallModel

+ (void)getMallData:(MallBlock)completion{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFJSONResponseSerializer new];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    [manager GET:mall_getIndex parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"code"] intValue] == 200) {
            completion(responseObject[@"data"],nil);
        }else{
            NSError *error = [NSError errorWithDomain:@"获取数据失败" code:201 userInfo:@{@"reason":@"获取数据失败！"}];
            completion(nil,error);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completion(nil,error);
    }];
}

+ (void)getProducts:(MallBlock)completion{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFJSONResponseSerializer new];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    
    [manager GET:mall_getPrducts parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"code"] intValue] == 200) {
            completion(responseObject[@"data"],nil);
        }else{
            NSError *error = [NSError errorWithDomain:@"获取数据失败" code:201 userInfo:@{@"reason":@"获取数据失败！"}];
            completion(nil,error);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completion(nil,error);
    }];

}

@end
