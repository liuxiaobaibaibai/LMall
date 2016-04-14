//
//  lwHomeCommonCell.m
//  shopCart
//
//  Created by lw on 16/4/14.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "lwHomeCommonCell.h"

@implementation lwHomeCommonCell

- (void)awakeFromNib {
    _imgView.layer.cornerRadius = 5.0f;
    _imgView.clipsToBounds = YES;
}

@end
