//
//  lwStoreManagerModel.m
//  shopCart
//
//  Created by lw on 16/4/28.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "lwStoreManagerModel.h"

@implementation lwStoreManagerModel

- (id)initWithDict:(NSDictionary *)dict{
    self = [super init];
    if (self) {
        self.title = dict[@"title"];
        self.subtitle = dict[@"content"];
        if ([dict[@"type"] isEqualToString:@"text"]) {
            self.type = lwStoreManagerModelTypeText;
        }else if ([dict[@"type"] isEqualToString:@"select"]) {
            self.type = lwStoreManagerModelTypeSelect;
        }else if ([dict[@"type"] isEqualToString:@"img"]) {
            self.type = lwStoreManagerModelTypeImg;
        }
    }
    return self;
}

@end


@implementation lwStoreModel


@end