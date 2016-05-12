//
//  lwCommodityDetailModel.m
//  shopCart
//
//  Created by 刘威 on 16/4/4.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "lwCommodityDetailModel.h"

#import "lwCommodityNormModel.h"

@implementation lwCommodityDetailModel

- (id)initWithDict:(NSDictionary *)dict{
    self = [super init];
    if (self) {
        self.gid = dict[@"id"];
        self.imgArray = dict[@"image"];
        self.intro = dict[@"intro"];
        self.name = dict[@"name"];
        self.catNorms = [NSMutableArray arrayWithObjects:dict[@"colorName"],dict[@"formatName"], nil];
        
        NSMutableArray *de = [NSMutableArray new];
        id norms = dict[@"norms"];
        
        if (![norms isKindOfClass:[NSObject class]]) {
            if ([norms intValue] == 0) {
                self.detailArray = [NSMutableArray new];
            }
        }
        
        if ([norms isKindOfClass:[NSArray class]]) {
            // 正常数据
            for (int i = 0; i<((NSArray *)norms).count; i++) {
                NSMutableDictionary *dict = norms[i];
                lwCommodityNormModel *normModel = [[lwCommodityNormModel alloc] initWithDict:dict];
                [de addObject:normModel];
            }
            self.detailArray = de;
        }
        
        self.num =  dict[@"num"];
        self.price = dict[@"price"];
        self.oPirce = dict[@"oprice"];
        self.XG = dict[@"xg"];
    }
    return self;
}

+ (void)getProduct:(NSString *)gid Completion:(commodityBlock)completion
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer new];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    
    NSMutableDictionary *dict = [NSMutableDictionary new];
    [dict setObject:gid forKey:@"id"];
    
    [manager GET:mall_getProduct parameters:dict progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"code"] intValue] == 200) {
            completion(responseObject[@"data"],nil);
        }else{
            NSError *error = [NSError errorWithDomain:@"获取失败" code:201 userInfo:@{@"reason":responseObject[@"message"]}];
            completion(nil, error);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completion(nil,error);
    }];
    
    
}

@end
