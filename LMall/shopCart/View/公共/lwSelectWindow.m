//
//  lwSelectNormView.m
//  shopCart
//
//  Created by lw on 16/4/15.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "lwSelectWindow.h"

#define padding 8

@implementation lwSelectWindow
{
    UIView *backGroundView;
    UIView *backView;
    UITableView *myTbaleView;
    UIView *headerView;
    UIButton *bottomBtn;
    UIImageView *headerImgView;
    UIButton *closeButton;
    UILabel *priceLabel;
    UILabel *inventoryLabel;
    UILabel *normLabel;
    UIView *lineView;
}

- (id)initWithFrame:(CGRect)frame Delegate:(id)delegate{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = CGRectMake(0, 0, lW, lH);
        self.windowLevel = UIWindowLevelAlert + 1;
        self.delegate = delegate;
        [self setupView];
    }
    
    return self;
}

- (void)showInView:(UIView *)aView{
    
    [self makeKeyWindow];
    [self makeKeyAndVisible];
    backView.frame = CGRectMake(0, lH, lW, lH);
    [UIView animateWithDuration:0.3 animations:^{
        backView.frame = CGRectMake(0, 0, lW, lH);
    }completion:^(BOOL finished) {
        
    }];
}

- (void)tapClick:(UITapGestureRecognizer *)tap{
    if ([_delegate respondsToSelector:@selector(removeWindow)]) {
        [_delegate removeWindow];
    }
}

- (void)selectWindowButtonClick:(UIButton *)btn{
    if ([_delegate respondsToSelector:@selector(removeWindow)]) {
        [_delegate removeWindow];
    }
}

- (void)setupView{
    // 背景图
    backGroundView = [[UIView alloc] init];
    backGroundView.backgroundColor = [UIColor blackColor];
    backGroundView.alpha = 0.5;
    UITapGestureRecognizer *bgTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
    [backGroundView addGestureRecognizer:bgTap];
    [self addSubview:backGroundView];
    
    backView = [[UIView alloc] init];
    backView.backgroundColor = [UIColor clearColor];
    UITapGestureRecognizer *bTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
    [backView addGestureRecognizer:bTap];
    [self addSubview:backView];
    
    // 头部视图
    headerView = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor whiteColor];
    [backView addSubview:headerView];
    
    // 头部图片
    headerImgView = [[UIImageView alloc] init];
    headerImgView.image = [UIImage imageNamed:@"commodity_Test"];
    headerImgView.layer.borderColor = [UIColor whiteColor].CGColor;
    headerImgView.layer.borderWidth = 2.0;
    headerImgView.layer.cornerRadius = 5.0;
    self.layer.masksToBounds = YES;
    headerImgView.clipsToBounds = YES;
    [backView addSubview:headerImgView];
    
    // 关闭按钮
    closeButton = [[UIButton alloc] init];
    [closeButton setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    [headerView addSubview:closeButton];
    
    // 价格标签
    priceLabel = [[UILabel alloc] init];
    priceLabel.text = @"￥59";
    priceLabel.font = [UIFont systemFontOfSize:14.0];
    priceLabel.textColor = [lwStyleTool colorInstance].JDColor;
    [headerView addSubview:priceLabel];
    
    // 库存标签
    inventoryLabel = [[UILabel alloc] init];
    inventoryLabel.text = @"库存594128件";
    inventoryLabel.font = [UIFont systemFontOfSize:14.0];
    inventoryLabel.textColor = [UIColor blackColor];
    [headerView addSubview:inventoryLabel];
    
    // 规格标签
    normLabel = [[UILabel alloc] init];
    normLabel.text = @"选择规格";
    normLabel.font = [UIFont systemFontOfSize:14.0];
    normLabel.textColor = [lwStyleTool colorInstance].DZClolor;
    [headerView addSubview:normLabel];
    
    lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [headerView addSubview:lineView];
    
    // 列表视图
    myTbaleView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, lW, lW) style:UITableViewStylePlain];
    myTbaleView.delegate = self;
    myTbaleView.dataSource = self;
    [backView addSubview:myTbaleView];
    
    // 底部按钮
    bottomBtn = [[UIButton alloc] init];
    [bottomBtn setTitle:@"确定" forState:UIControlStateNormal];
    [bottomBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [bottomBtn setBackgroundColor:[lwStyleTool colorInstance].JDColor];
    [backView addSubview:bottomBtn];
    [bottomBtn addTarget:self action:@selector(selectWindowButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    
    [backGroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.bottom.mas_equalTo(myTbaleView.mas_top).with.offset(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(110);
    }];
    
    [headerImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(padding);
        make.top.mas_equalTo(headerView.mas_top).with.offset(-padding*2);
        make.right.mas_equalTo(priceLabel.mas_left).with.offset(-padding);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(100);
    }];
    
    [closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(headerView.mas_top).with.offset(padding);
        make.left.mas_equalTo(priceLabel.mas_right).with.offset(padding);
        make.right.mas_equalTo(headerView.mas_right).with.offset(-padding);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(30);
    }];
    
    [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(headerImgView.mas_right).with.offset(padding);
        make.right.mas_equalTo(closeButton.mas_left).with.offset(-padding);
        make.top.mas_equalTo(headerView.mas_top).with.offset(padding*3);
        make.bottom.mas_equalTo(inventoryLabel.mas_top).with.offset(-padding);
    }];
    
    [inventoryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(headerImgView.mas_right).with.offset(padding);
        make.right.mas_equalTo(closeButton.mas_left).with.offset(-padding);
        make.top.mas_equalTo(priceLabel.mas_bottom).with.offset(padding);
        make.bottom.mas_equalTo(normLabel.mas_top).with.offset(-padding);
        make.height.mas_equalTo(priceLabel.mas_height);
    }];
    
    [normLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(headerImgView.mas_right).with.offset(padding);
        make.right.mas_equalTo(closeButton.mas_left).with.offset(-padding);
        make.top.mas_equalTo(inventoryLabel.mas_bottom).with.offset(padding);
        make.height.mas_equalTo(priceLabel.mas_height);
    }];
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(headerView.mas_left).with.offset(padding);
        make.bottom.mas_equalTo(headerView.mas_bottom).with.offset(0);
        make.height.mas_equalTo(1);
        make.right.mas_equalTo(headerView.mas_right).with.offset(-padding);
    }];
    
    [myTbaleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(headerView.mas_bottom).with.offset(0);
        make.bottom.mas_equalTo(bottomBtn.mas_top).with.offset(0);
        make.width.mas_equalTo(lW);
        make.height.mas_equalTo(250);
    }];
    
    [bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(myTbaleView.mas_bottom).with.offset(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(50);
    }];
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    cell.textLabel.text = @"卧槽你妈";
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selected = NO;
}


@end










