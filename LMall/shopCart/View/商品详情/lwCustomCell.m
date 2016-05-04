//
//  lwCustomCell.m
//  shopCart
//
//  Created by lw on 16/4/7.
//  Copyright © 2016年 lw. All rights reserved.
//


#define padding 8

#import "lwCustomCell.h"
#import "lwCustomCellContentView.h"

#import "lwCustomCellContentFrameModel.h"
#import "lwCustomModel.h"


@implementation lwCustomCell

{
    UILabel *titleLabel;
    UIButton *subTitleBtn;
}


- (lwCustomCell *)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}

- (void)setFrameModel:(lwCustomCellContentFrameModel *)frameModel{
    
    lwCustomModel *model = frameModel.customModel;
    
    _frameModel = frameModel;
    
    
    for (UIView *view in [self subviews]) {
        [view removeFromSuperview];
    }
    
    
    titleLabel.text = model.title;
    titleLabel.frame = frameModel.titleRect;
    
    
    titleLabel = [[UILabel alloc] init];
    titleLabel.font = [UIFont systemFontOfSize:14.0];
    titleLabel.textColor = RGB(120, 120, 120);
    titleLabel.text = model.title;
    titleLabel.frame = frameModel.titleRect;
    titleLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:titleLabel];
    
    for (int i = 0; i<model.subArray.count; i++) {
        NSString *content = model.subArray[i];
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake((titleLabel.frame.size.width+padding*2), (i*30)+(i+1)*padding, lW-titleLabel.frame.size.width-(padding*3), 30)];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:14.0]];
        btn.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        [btn setAttributedTitle:[NSString strikethrough:content CurrentColor:model.currentColor]
                       forState:UIControlStateNormal];
        
        [btn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        [self addSubview:btn];
    }
}



@end
