//
//  lwHomeCustomCell.m
//  shopCart
//
//  Created by lw on 16/4/14.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "lwHomeCustomCell.h"

#import "lwCommodityModel.h"

@implementation lwHomeCustomCell

- (void)awakeFromNib{
    
}

- (void)setCModel:(lwCommodityModel *)cModel{
    [_logoUrl sd_setImageWithURL:[NSURL URLWithString:cModel.logoUrl]];
    [_commodityTitleLabel setText:cModel.commodityName];
    [_priceLabel setText:[NSString stringWithFormat:@"￥ %@",cModel.price]];
    [_scoreLabel setTitle:[NSString stringWithFormat:@"  %@",cModel.price] forState:UIControlStateNormal];
}


@end
