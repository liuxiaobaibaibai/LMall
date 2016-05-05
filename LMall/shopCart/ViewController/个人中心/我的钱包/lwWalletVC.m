//
//  lwWalletVC.m
//  shopCart
//
//  Created by lw on 16/5/5.
//  Copyright © 2016年 lw. All rights reserved.
//

#define paddingLeft 15
#define paddingtop 10
#define customH 30

#import "lwWalletVC.h"
static NSString *cellID = @"cell";

typedef enum : NSUInteger {
    lwPayWayAliPay = 0,
    lwPayWayWeChat,
    lwPayWayScore
} lwPayWay;

@interface lwWalletVC ()

<
    UITableViewDataSource,
    UITableViewDelegate,
    UIKeyboardViewControllerDelegate
>

{
    UITableView *myTableView;
    UIKeyboardViewController *keyboard;
    UITextField *amountField;
    UILabel *balanceLabel;
}

@end

@implementation lwWalletVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
}

- (void)viewDidAppear:(BOOL)animated{
    keyboard = [[UIKeyboardViewController alloc] initWithControllerDelegate:self];
    [keyboard addToolbarToKeyboard];
}

- (void)setupView{
    myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, lW, lH) style:UITableViewStyleGrouped];
    [myTableView setDelegate:self];
    [myTableView setDataSource:self];
    [myTableView setTableHeaderView:[self tableHeaderView]];
    [myTableView setTableFooterView:[self tableFooterView]];
    [self.view addSubview:myTableView];
}

- (UIView *)tableHeaderView{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, lW, 120)];
    
    UIImageView *imgView = [[UIImageView alloc] init];
    [imgView setImage:[UIImage imageNamed:@"header"]];
    [headerView addSubview:imgView];
    
    [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.right.mas_equalTo(0);
    }];
    
    return headerView;
}

static NSMutableArray *btnArray;
- (UIView *)tableFooterView{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, lW, lW)];
    
    balanceLabel = [[UILabel alloc] init];
    balanceLabel.text = @"我的钱包余额：0";
    [footerView addSubview:balanceLabel];

    UILabel *amountLabel = [[UILabel alloc] init];
    amountLabel.text = @"充值金额";
    [footerView addSubview:amountLabel];
    
    amountField = [[UITextField alloc] init];
    amountField.placeholder = @"请输入充值金额";
    amountField.keyboardType = UIKeyboardTypeNumberPad;
    amountField.borderStyle = UITextBorderStyleBezel;
    [footerView addSubview:amountField];
    
    UIButton *rechargeBtn = [[UIButton alloc] init];
    [rechargeBtn setTitle:@"去充值" forState:UIControlStateNormal];
    [rechargeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rechargeBtn setBackgroundColor:[lwStyleTool colorInstance].JDColor];
    [rechargeBtn.layer setCornerRadius:5.0f];
    [rechargeBtn.layer setMasksToBounds:YES];
    [rechargeBtn addTarget:self action:@selector(pay:) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:rechargeBtn];
    
    NSArray *payWay = @[@"支付宝",@"微信支付",@"宝积分支付(余额:0)"];

    UIButton *lastButton = nil;
    btnArray = [NSMutableArray new];
    for (int i = 0; i<payWay.count; i++) {
        UIButton *btn = [[UIButton alloc] init];
        [btn setTitleColor:RGB(59, 118, 96)  forState:UIControlStateNormal];
        [btn setTitle:[NSString stringWithFormat:@" %@",payWay[i]] forState:UIControlStateNormal];
        [btn setTag:i];
        [btn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        [btn setImage:[UIImage imageNamed:@"personal_wallet_uncheck"] forState:UIControlStateNormal];
        [btn addTarget:self
                action:@selector(payButtonClcik:)
      forControlEvents:UIControlEventTouchUpInside];
        [footerView addSubview:btn];
        [btnArray addObject:btn];
        
        if (i == 0) {
            [btn setImage:[UIImage imageNamed:@"personal_wallet_check"] forState:UIControlStateNormal];
            btn.selected = YES;
        }
        
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            if (lastButton) {
                make.top.mas_equalTo(lastButton.mas_bottom).with.offset(paddingtop);
            }else{
                make.top.mas_equalTo(amountLabel.mas_bottom).with.offset(paddingtop);
            }
            make.height.mas_equalTo(21);
            make.left.mas_equalTo(15);
            make.right.mas_equalTo(-15);
        }];
        
        lastButton = btn;
    }
    
    [balanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(paddingLeft);
        make.top.mas_equalTo(paddingtop);
        make.right.mas_equalTo(-paddingLeft);
        make.height.mas_equalTo(customH);
        make.bottom.mas_equalTo(amountLabel.mas_top).with.offset(-paddingtop);
    }];
    
    [amountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(paddingLeft);
        make.right.mas_equalTo(amountField.mas_left).with.offset(-paddingtop);
        make.width.mas_equalTo(100);
        make.top.mas_equalTo(balanceLabel.mas_bottom).with.offset(paddingtop);
        make.height.mas_equalTo(customH);
    }];
    
    [amountField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(amountLabel.mas_right).with.offset(paddingtop);
        make.centerY.mas_equalTo(amountLabel.mas_centerY);
        make.height.mas_equalTo(amountLabel.mas_height);
        make.right.mas_equalTo(-paddingLeft);
    }];
    
    [rechargeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lastButton.mas_bottom).with.offset(paddingtop);
        make.left.mas_equalTo(paddingLeft);
        make.right.mas_equalTo(-paddingLeft);
        make.height.mas_equalTo(40);
    }];
    
    return footerView;
}

- (void)payButtonClcik:(UIButton *)payBtn{

    if (payBtn.selected) {
        NSLog(@"不处理");
    }else{
        for (UIButton *btn in btnArray) {
            if (btn.tag == payBtn.tag) {
                btn.selected = YES;
                [btn setImage:[UIImage imageNamed:@"personal_wallet_check"] forState:UIControlStateNormal];
            }else{
                btn.selected = NO;
                [btn setImage:[UIImage imageNamed:@"personal_wallet_uncheck"] forState:UIControlStateNormal];
            }
        }
    }
}

- (void)pay:(UIButton *)btn{
    
    if ([amountField.text isNull]) {
        NSLog(@"请输入充值金额");
        return;
    }
    
    NSLog(@"充值金额：%@",amountField.text);
    for (UIButton *payWayBtn in btnArray) {
        if (payWayBtn.selected) {
            switch (payWayBtn.tag) {
                case lwPayWayAliPay:
                {
                    NSLog(@"支付宝支付");
                }
                    break;
                case lwPayWayWeChat:
                {
                    NSLog(@"微信支付");
                }
                    break;
                default:
                {
                    NSLog(@"积分支付");
                }
                    break;
            }
        }
    }
    balanceLabel.text = [NSString stringWithFormat:@"我的钱包余额：%@",amountField.text];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 15;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    return cell;
}


@end
