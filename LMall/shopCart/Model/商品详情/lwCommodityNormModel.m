//
//  lwCommodityNormModel.m
//  shopCart
//
//  Created by lw on 16/4/25.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "lwCommodityNormModel.h"

@implementation lwCommodityNormModel

- (id)initWithDict:(NSMutableDictionary *)dict{
    self = [super init];
    if (self) {
        self.nid    = dict[@"id"];
        self.pid    = dict[@"pid"];
        self.format = dict[@"format"];
        self.color  = dict[@"format"];
        self.num    = dict[@"num"];
        self.price  = dict[@"price"];
        self.vprice = dict[@"vprice"];
        self.logo   = dict[@"logo"];
        self.oprice = dict[@"oprice"];
        self.bno    = dict[@"bno"];
        self.formatName = dict[@"formatName"];
        self.colorName = dict[@"colorName"];
        self.prcurl = dict[@"prcurl"];
    }
    return self;
}

- (NSString *)description{
    NSString *desc = [NSString stringWithFormat:@"nid:%@pid:%@format:%@color:%@num:%@price:%@vprice:%@logo:%@oprice:%@bno:%@formatname:%@colorName:%@prcurl:%@",_nid,_pid,_format,_color,_num,_price,_vprice,_logo,_oprice,_bno,_formatName,_colorName,_prcurl];
    return desc;
}



@end
