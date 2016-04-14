//
//  lwCompletdOrderCommonCell.m
//  shopCart
//
//  Created by 刘威 on 16/4/9.
//  Copyright © 2016年 lw. All rights reserved.
//

#define padding 8


#import "lwCompletdOrderCommonCell.h"
#import "lwMall_OrderModel.h"

@implementation lwCompletdOrderCommonCell
{
    UILabel *titleLabel;
    UILabel *subTitleLabel;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupView];
    }
    return self;
}

- (void)setupView{
    titleLabel = [UILabel new];
    titleLabel.font = [UIFont systemFontOfSize:14.0];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:titleLabel];
    
    subTitleLabel = [UILabel new];
    subTitleLabel.font = [UIFont systemFontOfSize:12.0];
    subTitleLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:subTitleLabel];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(padding);
        make.top.mas_equalTo(padding);
        make.bottom.mas_equalTo(-padding);
        make.width.mas_equalTo(80);
    }];
    
    [subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(titleLabel.mas_centerY);
        make.left.mas_equalTo(titleLabel.mas_right).with.offset(padding);
        make.right.mas_equalTo(-padding);
        make.height.mas_equalTo(titleLabel.mas_height);
    }];
}

- (void)setServiceModel:(lwMall_OrderServiceModel *)serviceModel{
    titleLabel.text = [NSString stringWithFormat:@"%@",serviceModel.serviceTitle];
    subTitleLabel.text = [NSString stringWithFormat:@"￥ %@",serviceModel.serviceSubTitle];
    subTitleLabel.textColor = serviceModel.subTitleColor;
}

@end
