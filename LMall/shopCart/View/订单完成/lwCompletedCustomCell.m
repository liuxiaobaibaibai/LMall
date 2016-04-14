//
//  lwCompletedCustomCell.m
//  shopCart
//
//  Created by 刘威 on 16/4/9.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "lwCompletedCustomCell.h"
#import "lwMall_OrderModel.h"

@implementation lwCompletedCustomCell


- (void)drawRect:(CGRect)rect{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextMoveToPoint(context, 8, self.frame.size.height-1);
    CGContextAddLineToPoint(context, self.frame.size.width-8, self.frame.size.height-1);
    
    [RGB(220, 220, 220) set];
    
    CGContextStrokePath(context);
}


- (void)awakeFromNib {
    // Initialization code
    _inputFiled.delegate = self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    if (![_delegate  respondsToSelector:@selector(textFiledResult:Model:)]) {
        return NO;
    }
    lwMall_ScoreModel *scoreModel = _serviceModel.scoreModel;
    [_delegate textFiledResult:textField Model:scoreModel];
    return YES;
}


- (void)setServiceModel:(lwMall_OrderServiceModel *)serviceModel{
    _serviceModel = serviceModel;
    switch (serviceModel.serviceType) {
        case lwServiceSubTypeSwitch:
        {
            _inputFiled.hidden = YES;
            _subTitelLabel.text = @"请选择是否使用：";
        }
            break;
        case lwServiceSubTypeInputMsg:
        {
            _sth.hidden = YES;
            lwMall_ScoreModel *scoreModel = serviceModel.scoreModel;
            _titleLabel.text = [NSString stringWithFormat:@"可用%d%@积分抵扣￥ %.2f",scoreModel.usefull,scoreModel.name,scoreModel.price];
            _inputFiled.text = [NSString stringWithFormat:@"%d",scoreModel.changedScore];
        }
            break;
        default:
            break;
    }
    
    
}

@end
