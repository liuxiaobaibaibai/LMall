//
//  lwPeronalCell.m
//  shopCart
//
//  Created by lw on 16/5/4.
//  Copyright © 2016年 lw. All rights reserved.
//

#define PADDING 8
#define LABELHEIGHT 21



#import "lwPeronalCell.h"
#import "lwPersonalModel.h"


@implementation lwPeronalCell
{
    UIImageView *imgView;
    UILabel *titleLabel;
}

- (id)init{
    self = [super init];
    if (self) {
        imgView = [[UIImageView alloc] init];
        titleLabel = [[UILabel alloc] init];
        [self addSubview:imgView];
        [self addSubview:titleLabel];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
//        self.layer.borderColor = [UIColor lightGrayColor].CGColor;
//        self.layer.borderWidth = 0.5;
        imgView = [[UIImageView alloc] init];
        imgView.contentMode = UIViewContentModeScaleAspectFit;
        titleLabel = [[UILabel alloc] init];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:imgView];
        [self addSubview:titleLabel];
    }
    return self;
}


- (void)setModel:(lwPersonalModel *)model{
    _model = model;
    
    [imgView sd_setImageWithURL:[NSURL URLWithString:model.imgPath]];
    [titleLabel setText:model.title];
    
    [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(PADDING);
        make.top.mas_equalTo(PADDING);
        make.right.mas_equalTo(-PADDING);
        make.bottom.mas_equalTo(titleLabel.mas_top).with.offset(-PADDING);
    }];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(imgView.mas_bottom).with.offset(PADDING);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(LABELHEIGHT);
    }];
    
}



@end
