//
//  lwHomeHeaderOtherView.m
//  shopCart
//
//  Created by lw on 16/4/14.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "lwHomeHeaderOtherView.h"

@implementation lwHomeHeaderOtherView

- (void)awakeFromNib {
    // Initialization code
}

- (void)setHeaderImgUrlPath:(NSString *)headerImgUrlPath{
    _headerImgUrlPath = headerImgUrlPath;
    [_headerImgView sd_setImageWithURL:[NSURL URLWithString:headerImgUrlPath]];
}

@end
