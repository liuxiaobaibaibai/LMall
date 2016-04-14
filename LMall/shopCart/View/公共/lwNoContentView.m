//
//  lwNoContentView.m
//  shopCart
//
//  Created by lw on 16/4/6.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "lwNoContentView.h"

#define padding 8


@implementation lwNoContentView

{
    /**提示图片*/
    UIImageView *alertImgView;
    /**提示按钮*/
    UIButton *alertButton;

}

- (id)initWithFrame:(CGRect)frame withDelegate:(id)aDelegate{
    self = [super initWithFrame:frame];
    if (self) {
        _alertType = lwAlertTypeNoOrder;
        _delegate = aDelegate;
    }
    return self;
}

- (void)setAlertType:(lwAlertType)alertType{
    [self setupView:alertType];
}

- (void)setupView:(lwAlertType)type{
    if (![[self subviews] containsObject:alertImgView]) {
        alertImgView = [[UIImageView alloc] init];
        alertImgView.contentMode = UIViewContentModeScaleAspectFit;
        [alertImgView setImage:[UIImage imageNamed:@"cry"]];
        [self addSubview:alertImgView];
    }
    
    if (![[self subviews] containsObject:alertButton]) {
        alertButton = [[UIButton alloc] init];
        [alertButton setAttributedTitle:[@"当前没有内容" underline] forState:UIControlStateNormal];
        [alertButton addTarget:self action:@selector(alertButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:alertButton];
    }
    
    [alertImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(padding);
        make.left.mas_equalTo(padding);
        make.right.mas_equalTo(-padding);
        make.bottom.mas_equalTo(alertButton.mas_top).with.offset(-padding);
    }];
    
    [alertButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(alertImgView.mas_bottom).with.offset(padding);
        make.left.mas_equalTo(padding);
        make.right.mas_equalTo(-padding);
        make.bottom.mas_equalTo(-padding);
    }];
    
    switch (type) {
        case lwAlertTypeNoOrder:
        {
            [alertButton setAttributedTitle:[@"您当前没有订单，赶紧去下单吧！" underline] forState:UIControlStateNormal];
        }
            break;
        case lwAlertTypeNoCommodity:
        {
            [alertButton setAttributedTitle:[@"没有发现商品，不如我们去探索一把？" underline] forState:UIControlStateNormal];
        }
            break;
        default:
        {
            [alertButton setAttributedTitle:[@"什么都没有看到！" underline] forState:UIControlStateNormal];
        }
            break;
    }
}

- (void)alertButtonClick:(UIButton *)btn{
    [_delegate noContentButtonClick:btn];
}


@end
