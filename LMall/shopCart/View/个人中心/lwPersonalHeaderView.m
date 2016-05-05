//
//  lwPersonalHeaderView.m
//  shopCart
//
//  Created by lw on 16/5/4.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "lwPersonalHeaderView.h"

#import "lwPersonalModel.h"

#define padding 8
#define storeBtnW 60
#define headerBtnw 70
#define labelH 20
#define telephoneBtnH 30

@implementation lwPersonalHeaderView
{
    // 上面
    UIView *sectionOneView;
    // 头像
    UIImageView *headerImageView;
    // 昵称
    UILabel *nickNameLabel;
    // 电话
    UILabel *telephoneLabel;
    // 身份
    UILabel *identityLabel;
    // 商家后台入口
    UIButton *storeManagerBtn;
    // 电话入口
    UIButton *telephoneBtn;
}


- (id)init{
    self = [super init];
    if (self) {
        [self setupView];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}

- (void)setupView{
    self.backgroundColor = RGB(237, 237, 237);
    
    for (UIView *view in [self subviews]) {
        [view removeFromSuperview];
    }
    
    sectionOneView = [[UIView alloc] init];
    sectionOneView.backgroundColor = RGB(245, 72, 71);
    [self addSubview:sectionOneView];
    
    headerImageView = [[UIImageView alloc] init];
    headerImageView.contentMode = UIViewContentModeScaleToFill;
    headerImageView.layer.cornerRadius = headerImageView.frame.size.width/2;
    headerImageView.layer.masksToBounds = YES;
    [sectionOneView addSubview:headerImageView];
    
    nickNameLabel = [[UILabel alloc] init];
    nickNameLabel.textColor = [UIColor whiteColor];
    nickNameLabel.textAlignment = NSTextAlignmentLeft;
    nickNameLabel.font = [UIFont systemFontOfSize:14.0];
    [sectionOneView addSubview:nickNameLabel];
    
    telephoneLabel = [[UILabel alloc] init];
    telephoneLabel.textColor = [UIColor whiteColor];
    telephoneLabel.textAlignment = NSTextAlignmentLeft;
    telephoneLabel.font = [UIFont systemFontOfSize:14.0];
    [sectionOneView addSubview:telephoneLabel];
    
    identityLabel = [[UILabel alloc] init];
    identityLabel.textAlignment = NSTextAlignmentLeft;
    identityLabel.textColor = [UIColor whiteColor];
    identityLabel.font = [UIFont systemFontOfSize:14.0];
    [sectionOneView addSubview:identityLabel];
    
    storeManagerBtn = [[UIButton alloc] init];
    [storeManagerBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 10, 20, 10)];
    [storeManagerBtn setTitleEdgeInsets:UIEdgeInsetsMake(40, -40, 0, 0)];
    [storeManagerBtn.titleLabel setFont:[UIFont systemFontOfSize:12.0]];
    [storeManagerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [storeManagerBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [storeManagerBtn.imageView.layer setCornerRadius:storeManagerBtn.imageView.frame.size.width/2];
    [sectionOneView addSubview:storeManagerBtn];
    
    telephoneBtn = [[UIButton alloc] init];
    [telephoneBtn.titleLabel setFont:[UIFont systemFontOfSize:14.0]];
    [telephoneBtn setBackgroundColor:[UIColor whiteColor]];
    [telephoneBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self addSubview:telephoneBtn];
    
    [sectionOneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(telephoneBtn.mas_top).with.offset(0);
    }];
    
    // 头像
    [headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(padding);
        make.top.mas_equalTo(padding);
        make.height.mas_equalTo(headerBtnw);
        make.width.mas_equalTo(headerBtnw);
    }];
    
    // 昵称
    [nickNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(headerImageView.mas_right).with.offset(padding);
        make.top.mas_equalTo(padding);
        make.bottom.mas_equalTo(telephoneLabel.mas_top).with.offset(-padding);
        make.right.mas_equalTo(storeManagerBtn.mas_left).with.offset(-padding);
        make.width.mas_equalTo(telephoneLabel.mas_width);
        make.width.mas_equalTo(identityLabel.mas_width);
        make.centerX.mas_equalTo(telephoneLabel.mas_centerX);
        make.centerX.mas_equalTo(identityLabel.mas_centerX);
        make.height.mas_equalTo(labelH);
    }];
    
    // 手机号
    [telephoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(labelH);
        make.right.mas_equalTo(storeManagerBtn.mas_left).with.offset(-padding);
        make.bottom.mas_equalTo(identityLabel.mas_top).with.offset(-padding);
    }];
    
    // 身份
    [identityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-padding);
        make.right.mas_equalTo(storeManagerBtn.mas_left).with.offset(-padding);
    }];
    
    // 商城入口
    [storeManagerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-padding);
        make.centerY.mas_equalTo(sectionOneView.mas_centerY);
        make.width.mas_equalTo(storeBtnW);
        make.height.mas_equalTo(storeBtnW);
    }];
    
    // 电话按钮
    [telephoneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(telephoneBtnH);
        make.bottom.mas_equalTo(-20);
        make.top.mas_equalTo(sectionOneView.mas_bottom).with.offset(0);
        make.height.mas_equalTo(telephoneBtnH);
    }];
}



- (void)setHeaderModel:(lwPersonalHeaderModel *)headerModel{
    _headerModel = headerModel;
    NSString *imgPath = headerModel.headerImgPath;
    [headerImageView sd_setImageWithURL:[NSURL URLWithString:imgPath]];
    
    NSString *nickname = [NSString stringWithFormat:@"昵称：%@",headerModel.nickname];
    NSString *mobile= [NSString stringWithFormat:@"手机号：%@",headerModel.mobileNo];
    NSString *identity = [NSString stringWithFormat:@"%@",headerModel.identity];
    NSString *superior = [NSString stringWithFormat:@"您是由%@推荐",headerModel.superior];
    
    [nickNameLabel setText:nickname];
    [telephoneLabel setText:mobile];
    [identityLabel setText: identity];
    [storeManagerBtn setTitle:@"商家后台" forState:UIControlStateNormal];
    [storeManagerBtn setImage:[UIImage imageNamed:@"cry"] forState:UIControlStateNormal];
    superior = [superior stringByAppendingString:[headerModel.superior isEqualToString:@"聚赢宝"] ? @"" : @",给上级打电话"];
    [storeManagerBtn addTarget:self action:@selector(call:) forControlEvents:UIControlEventTouchUpInside];
    [telephoneBtn setTitle:superior forState:UIControlStateNormal];
}

- (void)call:(UIButton *)btn{
    [lwCommon call:_headerModel.superiorMobileNo];
}


@end
