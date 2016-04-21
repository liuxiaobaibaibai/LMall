//
//  lwTitleCell.m
//  shopCart
//
//  Created by 刘威 on 16/4/4.
//  Copyright © 2016年 lw. All rights reserved.
//

#define alertButtonTag 10

#define padding 8

#import "lwTitleCell.h"

@implementation lwTitleCell

{
    //  标题label
    UILabel *titleLabel;
    //  价格label
    UILabel *priceLabel;
    // 提醒label
    UIButton *alertButton;
    //  原价label
    UILabel *originalPriceLabel;
    //  定制标签
    UIButton *customLabel;
}

- (UITableViewCell *)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupView];
    }
    return self;
}

- (void)setupView{
    // 标题
    titleLabel = [[UILabel alloc] init];
    titleLabel.text =  @"家の物语 日本进口密封保鲜盒不粘底饺子盒 冰箱冷藏收纳盒 食品便当盒 2个装白色";
    titleLabel.font = [UIFont systemFontOfSize:16.0];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.numberOfLines = 0;
    [self.contentView addSubview:titleLabel];

    // 提醒标签（不一定有）
    alertButton = [[UIButton alloc] init];
    [alertButton setAttributedTitle:[self underline:@"好货提前抢 全场买4免1 数量有限赶紧抢 更多好品点击这里"] forState:UIControlStateNormal];
    [alertButton setTitleColor:[lwStyleTool colorInstance].JDColor forState:UIControlStateNormal];
    [alertButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [alertButton.titleLabel setNumberOfLines:0];
    [alertButton.titleLabel setFont:[UIFont systemFontOfSize:14.0]];
    [alertButton setTag:alertButtonTag];
    [self.contentView addSubview:alertButton];

    // 价格标签
    priceLabel = [[UILabel alloc] init];
    priceLabel.text = @"￥ 19.00";
    priceLabel.font = [UIFont systemFontOfSize:19.0];
    priceLabel.textColor = [lwStyleTool colorInstance].JDColor;
    [self.contentView addSubview:priceLabel];
    
    // 原价标签
    originalPriceLabel = [[UILabel alloc] init];
    
    NSAttributedString *at = [[NSAttributedString alloc] initWithString:@"原价：￥ 29.00" attributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor],NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle|NSUnderlinePatternSolid),NSStrikethroughColorAttributeName:[UIColor lightGrayColor]}];
    originalPriceLabel.attributedText = at;
    originalPriceLabel.font = [UIFont systemFontOfSize:14.0];
    originalPriceLabel.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:originalPriceLabel];
    
    customLabel = [[UIButton alloc] init];
    [customLabel setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [customLabel setTitle:@"  比PC端省13.3元 " forState:UIControlStateNormal];
    [customLabel setImage:[UIImage imageNamed:@"zx"] forState:UIControlStateNormal];
    [customLabel.titleLabel setFont:[UIFont systemFontOfSize:14.0]];
    [customLabel setTitleEdgeInsets:UIEdgeInsetsMake(8, 8, 8, 8)];
    [customLabel setTitleColor:[lwStyleTool colorInstance].JDColor forState:UIControlStateNormal];;
    [self.contentView addSubview:customLabel];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(padding);
        make.right.mas_equalTo(-padding);
        make.top.mas_equalTo(padding);
        make.bottom.mas_equalTo(alertButton.mas_top).with.offset(-padding);
    }];
    
    [alertButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(padding);
        make.top.mas_equalTo(titleLabel.mas_bottom).with.offset(padding);
        make.right.mas_equalTo(-padding);
        make.bottom.mas_equalTo(priceLabel.mas_top).with.offset(-padding);
    }];
    
    [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(padding);
        make.top.mas_equalTo(alertButton.mas_bottom).with.offset(padding);
        make.right.mas_equalTo(originalPriceLabel.mas_left).with.offset(-padding);
        make.bottom.mas_equalTo(customLabel.mas_top).with.offset(-padding);
        make.height.mas_equalTo(originalPriceLabel.mas_height);
        make.width.mas_equalTo(originalPriceLabel.mas_width);
    }];
    
    [originalPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(priceLabel.mas_right).with.offset(padding);
        make.top.mas_equalTo(alertButton.mas_bottom).with.offset(padding);
        make.right.mas_equalTo(-padding);
        make.bottom.mas_equalTo(customLabel.mas_top).with.offset(-padding);
        make.height.mas_equalTo(priceLabel.mas_height);
        make.width.mas_equalTo(priceLabel.mas_width);
    }];
    
    [customLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(padding);
        make.top.mas_equalTo(priceLabel.mas_bottom).with.offset(padding);
        make.right.mas_equalTo(-padding);
        make.bottom.mas_equalTo(-padding);
        make.height.mas_equalTo(31);
    }];
}

- (NSAttributedString *)underline:(NSString *)string{
    NSAttributedString *str = [[NSAttributedString alloc]initWithString:string
                                                             attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.f],
                                                                          NSForegroundColorAttributeName:[lwStyleTool colorInstance].JDColor,
                                                                          NSUnderlineStyleAttributeName:@(NSUnderlineStyleSingle),
                                                                          NSStrikethroughColorAttributeName:[lwStyleTool colorInstance].JDColor}];
    return str;
}

@end
