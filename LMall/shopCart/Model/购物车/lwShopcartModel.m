//
//  lwShopcartModel.m
//  lwGiftView
//
//  Created by 刘威 on 16/3/6.
//  Copyright © 2016年 刘威. All rights reserved.
//

#import "lwShopcartModel.h"

@implementation lwShopcartModel

+ (instancetype)allocWithDict:(NSDictionary *)dict{
    lwShopcartModel *model = [[lwShopcartModel alloc] initWithDict:dict];
    return model;
}

- (id)initWithDict:(NSDictionary *)dict{
    self = [super init];
    if (self) {
        self.logo = dict[@"logo"];
        self.title = dict[@"title"];
        self.color = dict[@"color"];
        self.norm = dict[@"norm"];
        self.price = [dict[@"price"] floatValue];
        self.count = [dict[@"count"] integerValue];
        self.tag = dict[@"tag"];
        self.max = [dict[@"max"] integerValue];
    }
    return self;
}

+ (float)caculPrice:(NSMutableArray *)dataArray{
    float price = 0;
    
    for (int i = 0; i<dataArray.count; i++) {
        float p = ((lwShopcartModel *)dataArray[i]).price * ((lwShopcartModel *)dataArray[i]).count;
        price += p;
        
    }
    return price;
}
+ (NSInteger)calculCount:(NSMutableArray *)dataArray{
    NSInteger count = 0;
    for (int i = 0; i<dataArray.count; i++) {
        count += ((lwShopcartModel *)dataArray[i]).count;
    }
    return count;
}

@end
