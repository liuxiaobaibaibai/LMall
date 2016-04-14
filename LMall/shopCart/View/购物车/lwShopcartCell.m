//
//  lwShopcartCell.m
//  lwGiftView
//
//  Created by 刘威 on 16/3/6.
//  Copyright © 2016年 刘威. All rights reserved.
//

#import "lwShopcartCell.h"

#import "lwStepper.h"

#import "lwShopcartModel.h"

@implementation lwShopcartCell

- (void)awakeFromNib {
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setContent:(lwShopcartModel *)model{
    self.goodsImgView.image = [UIImage imageNamed:model.logo];
    self.goodsTitleLabel.text = model.title;
    self.colorLabel.text = [NSString stringWithFormat:@"颜色：%@",model.color];
    self.versionsLabel.text = [NSString stringWithFormat:@"规格：%@",model.norm];
    self.priceLabel.text = [NSString stringWithFormat:@"￥ %.2f",model.price];
    
    
    lwStepper *stepper = [[lwStepper alloc] initWithFrame:_countView.frame];
    stepper.MaxValue = model.max;
    stepper.value = model.count;
    stepper.stag = model.tag;
    [self addSubview:stepper];
}


@end
