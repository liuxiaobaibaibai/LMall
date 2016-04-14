//
//  lwShopcartVC.m
//  lwGiftView
//
//  Created by 刘威 on 16/3/6.
//  Copyright © 2016年 刘威. All rights reserved.
//

#import "lwShopcartVC.h"

#import "lwShopcartCell.h"

#import "lwShopcartModel.h"


#import "lwCommodityDetailVC.h"


#import "lwNoContentView.h"

static NSString *cellID = @"cell";
@interface lwShopcartVC ()


<
    UITableViewDataSource,
    UITableViewDelegate,
    lwNoContentViewDelegate
>
{
    __weak IBOutlet UITableView *myTableView;
    lwShopcartCell *cell;
    lwShopcartModel *model;
    NSMutableArray *dataArray;
    
    UIWindow *resultWindow;
    UILabel *priceLabel;
    UIButton *payBtn;
    lwNoContentView *noContentView;
}

@end

@implementation lwShopcartVC

- (void)viewDidLoad {
    [super viewDidLoad];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    [myTableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 50)]];
    [self initDatasource];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeValue:) name:@"changeValue" object:nil];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    [self addWindow];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self addResultViewWithPrice:[NSString stringWithFormat:@"总金额：￥ %.2f",[lwShopcartModel caculPrice:dataArray]] Count:[lwShopcartModel calculCount:dataArray]];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self releaseWindow];
}

- (void)releaseWindow{
    [resultWindow resignKeyWindow];
    resultWindow = nil;
}

- (UIView *)tableHeaderView{
    noContentView = [[lwNoContentView alloc] initWithFrame:CGRectMake(0, 0, lW, 200) withDelegate:self];
    noContentView.alertType = lwAlertTypeNoCommodity;
    return noContentView;
}



/**下面两个方法都是添加购物车结算的视图*/
- (void)addWindow{
    CGFloat y = 0;
    if (_isHidden) {
        y = lH - 50;
    }else{
        y = self.view.frame.size.height - 50 - self.tabBarController.tabBar.frame.size.height;
    }
    
    resultWindow = [[UIWindow alloc] initWithFrame:CGRectMake(0, y, lW, 50)];
    resultWindow.windowLevel = UIWindowLevelAlert;
    resultWindow.backgroundColor = [UIColor blackColor];
    resultWindow.alpha = 0.8;
    [resultWindow makeKeyAndVisible];
}

- (void)addResultViewWithPrice:(NSString *)price Count:(NSInteger)count{
    if (![[resultWindow subviews] containsObject:priceLabel]) {
        priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, lW-100, 50)];
        priceLabel.text = price;
        priceLabel.backgroundColor = [UIColor clearColor];
        priceLabel.textColor = [UIColor whiteColor];
        priceLabel.textAlignment = NSTextAlignmentLeft;
        priceLabel.font = [UIFont systemFontOfSize:16.0];
        
        payBtn = [[UIButton alloc] initWithFrame:CGRectMake(lW-100, 0, 100, 50)];
        [payBtn setTitle:[NSString stringWithFormat:@"结算(%@)",count>99?@"99+":[NSString stringWithFormat:@"%ld",(long)count]] forState:UIControlStateNormal];
        [payBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [payBtn setBackgroundColor:[UIColor colorWithRed:200/255.0 green:150/255.0 blue:50/2550 alpha:1.0]];
        [payBtn.titleLabel setFont:[UIFont systemFontOfSize:16.0]];
        [payBtn addTarget:self action:@selector(shopCartButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [resultWindow addSubview:payBtn];
        [resultWindow addSubview:priceLabel];
    }else{
        priceLabel.text = price;
        [payBtn setTitle:[NSString stringWithFormat:@"结算(%@)",count>99?@"99+":[NSString stringWithFormat:@"%ld",(long)count]] forState:UIControlStateNormal];
    }
}

- (void)shopCartButtonClick:(UIButton *)btn{
    UIStoryboard *main = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc = [main instantiateViewControllerWithIdentifier:@"completedVC"];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

/**监听加减控件方法*/
- (void)changeValue:(NSNotification *)no{
    // 根据Tag找出当前被修改的商品，更新购物车数组
    for (int i = 0; i<dataArray.count; i++) {
        if ([((lwShopcartModel *)dataArray[i]).tag isEqualToString:no.userInfo[@"tag"]]) {
            lwShopcartModel *mo = dataArray[i];
            [dataArray removeObject:dataArray[i]];
            mo.count = [no.userInfo[@"value"] integerValue];
            [dataArray insertObject:mo atIndex:i];
            [myTableView reloadData];
        }
    }
    NSLog(@"当前金额：%.2f",[lwShopcartModel caculPrice:dataArray]);
    [self addResultViewWithPrice:[NSString stringWithFormat:@" 总金额：￥ %.2f",[lwShopcartModel caculPrice:dataArray]] Count:[lwShopcartModel calculCount:dataArray]];
}

- (void)initDatasource{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"lwShopcart" ofType:@"plist"];
    NSArray *array = [NSArray arrayWithContentsOfFile:path];
    dataArray = [NSMutableArray new];
    
    for (int i = 0; i<array.count; i++) {
        model = [lwShopcartModel allocWithDict:array[i]];
        [dataArray addObject:model];
    }
    
    [myTableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - lwNoContentViewDelegate
- (void)noContentButtonClick:(UIButton *)btn{
    [self showToast:btn.titleLabel.text];
}

- (void)showToast:(NSString *)msg{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:msg delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
}

#pragma mark - 
- (IBAction)addressInfo:(id)sender {
    
}



#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 145;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return  YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

- (nullable NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        NSLog(@"删除当前产品！");
    }];
    [deleteAction setBackgroundColor:[UIColor colorWithRed:238/255.0 green:87/255.0 blue:90/255.0 alpha:1.0]];
    return @[deleteAction];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [dataArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"lwShopcartCell" owner:self options:nil].firstObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    [cell setContent:dataArray[indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
}

@end
