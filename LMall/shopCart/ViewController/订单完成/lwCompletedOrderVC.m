//
//  lwCompletedOrderVC.m
//  shopCart
//
//  Created by lw on 16/4/8.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "lwCompletedOrderVC.h"

// model
#import "lwMall_CommmodityModel.h"
#import "lwMall_OrderModel.h"
#import "lwMall_AddressModel.h"

// view
#import "lwAddressCell.h"
#import "lwCommodityCell.h"
#import "lwCompletedCustomCell.h"
#import "lwCompletdOrderCommonCell.h"


@interface lwCompletedOrderVC ()

<
    UITableViewDataSource,
    UITableViewDelegate,
    lwCompletedCustomCellDelegate,
    UIKeyboardViewControllerDelegate

>

{
    __weak IBOutlet UITableView *myTableView;
    NSMutableArray *dataArray;
    UIKeyboardViewController *keyBoard;
}

@end

@implementation lwCompletedOrderVC

#pragma mark - 生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated{
    keyBoard = [[UIKeyboardViewController alloc] initWithControllerDelegate:self];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self initDataSource];
    [self setupView];
}


#pragma mark - 加载数据
static lwMall_PriceModel *newPrice;
- (void)initDataSource
{
    dataArray  = [NSMutableArray new];
    
    // 地址model
    lwMall_AddressModel *aModel = [lwMall_AddressModel new];
    aModel.username = @"哦 哀木涕";
    aModel.mobileNo = @"18812345678";
    aModel.address = @"新疆八神的好事都暗红色的反馈了敬爱华盛顿；发卡号是；到港后输入该健身房女票；速发货v";
    NSMutableArray *addressArray = [NSMutableArray arrayWithObject:aModel];
    
    
    // 商品model
    lwMall_CommmodityModel *oneCModel = [lwMall_CommmodityModel new];
    oneCModel.logoUrl = @"https://img.alicdn.com/bao/uploaded/i2/TB1uecNLFXXXXcIXXXXXXXXXXXX_!!0-item_pic.jpg_430x430q90.jpg";
    oneCModel.title = @"春夏吊带背心女 中长款莫代尔打底衫吊带衫百搭背心吊带修身纯色";
    oneCModel.norm = @"尺码：均码，颜色：白色";
    oneCModel.cCount = 1;
    oneCModel.price = 117.00;
    oneCModel.labelArray = [NSMutableArray arrayWithObjects:@"花呗分期",@"七天退换",@"消费即返", nil];
    
    lwMall_CommmodityModel *twoCModel = [lwMall_CommmodityModel new];
    twoCModel.logoUrl = @"https://img.alicdn.com/bao/uploaded/i2/TB1uecNLFXXXXcIXXXXXXXXXXXX_!!0-item_pic.jpg_430x430q90.jpg";
    twoCModel.title = @"春夏吊带背心女 中长款莫代尔打底衫吊带衫百搭背心吊带修身纯色";
    twoCModel.norm = @"尺码：均码，颜色：白色";
    twoCModel.cCount = 1;
    twoCModel.price = 117.00;
    twoCModel.labelArray = [NSMutableArray arrayWithObjects:@"花呗分期",@"七天退换",@"消费即返", nil];

    NSMutableArray *commodityArray = [NSMutableArray arrayWithObjects:oneCModel,twoCModel, nil];
    
    // 辅助视图
    NSMutableArray *footerArray = [NSMutableArray new];
    
    // 账单model
    lwMall_PriceModel *priceModel = [lwMall_PriceModel new];
    priceModel.sumPrice = 244.00;
    priceModel.truePrice = 234.00;
    priceModel.couponPrice = 0.00;
    priceModel.postage = 10.00;
    newPrice = priceModel;
    
    lwMall_ScoreModel *scOneModel = [lwMall_ScoreModel new];
    scOneModel.sID = @"8";
    scOneModel.name = @"生活用品";
    scOneModel.point = 0.01;
    scOneModel.price = 4.00;
    scOneModel.usefull = 400;
    scOneModel.changedScore = 0;
    scOneModel.changedPrice = scOneModel.changedScore * scOneModel.point;
    
    lwMall_ScoreModel *scTwoModel = [lwMall_ScoreModel new];
    scTwoModel.sID = @"9";
    scTwoModel.name = @"快餐积分";
    scTwoModel.point = 0.02;
    scTwoModel.price = 6.00;
    scTwoModel.usefull = 300;
    scTwoModel.changedScore = 0;
    scTwoModel.changedPrice = scTwoModel.point * scTwoModel.changedScore;
    
    lwMall_OrderServiceModel *JFOneModel = [lwMall_OrderServiceModel new];
    JFOneModel.serviceType = lwServiceSubTypeInputMsg;
    JFOneModel.scoreModel = scOneModel;
    
    lwMall_OrderServiceModel *JFTwoModel = [lwMall_OrderServiceModel new];
    JFTwoModel.serviceType = lwServiceSubTypeInputMsg;
    JFTwoModel.scoreModel = scTwoModel;
    
    
    lwMall_OrderServiceModel *PSSModel = [lwMall_OrderServiceModel new];
    PSSModel.serviceTitle = @"商品总额";
    PSSModel.subTitleColor = [lwStyleTool colorInstance].JDColor;
    PSSModel.serviceSubTitle = [NSString stringWithFormat:@"%.2f",priceModel.truePrice];
    PSSModel.serviceType = lwServiceSubTypeShowMsg;
    
    lwMall_OrderServiceModel *JFPModel = [lwMall_OrderServiceModel new];
    JFPModel.serviceTitle = @"积分优惠";
    JFPModel.subTitleColor = [UIColor greenColor];
    JFPModel.serviceSubTitle = [NSString stringWithFormat:@"%.2f",priceModel.couponPrice];
    PSSModel.serviceType = lwServiceSubTypeShowMsg;
    
    lwMall_OrderServiceModel *YFPModel = [lwMall_OrderServiceModel new];
    YFPModel.serviceTitle = @"运费";
    YFPModel.subTitleColor = [UIColor redColor];
    YFPModel.serviceSubTitle = [NSString stringWithFormat:@"%.2f",priceModel.postage];
    YFPModel.serviceType = lwServiceSubTypeShowMsg;
    
    
    lwMall_OrderServiceModel *ZSPModel = [lwMall_OrderServiceModel new];
    ZSPModel.serviceTitle = @"应付金额";
    ZSPModel.subTitleColor = [UIColor redColor];
    ZSPModel.serviceSubTitle = [NSString stringWithFormat:@"%.2f",priceModel.sumPrice];
    ZSPModel.serviceType = lwServiceSubTypeShowMsg;
    
    footerArray = [NSMutableArray arrayWithObjects:JFOneModel,JFTwoModel,PSSModel,JFPModel,YFPModel,ZSPModel, nil];
    
    [dataArray insertObject:addressArray atIndex:0];
    [dataArray addObject:commodityArray];
    [dataArray addObject:footerArray];
    
}


#pragma mark - 设置视图

- (void)setupView{
    myTableView.delegate = self;
    myTableView.dataSource = self;
}

- (UIView *)setupHeaderView{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, lW, 150)];
    headerView.backgroundColor = RGB(150, 150, 150);
    return headerView;
}

#pragma mark - lwCompletedCustomCellDelegate

- (void)textFiledResult:(UITextField *)txt Model:(lwMall_ScoreModel *)model{
    // 修改积分，重新计算价格
    if ([txt.text intValue] > model.usefull) {
        NSLog(@"您的积分不够哦！");
        txt.text = [NSString stringWithFormat:@"%d",model.changedScore];
        return;
    }
    
    /** 计算积分优惠金额 */
    double P = 0;
    
    model.changedPrice = [txt.text intValue] * model.point;
    model.changedScore = [txt.text intValue];
    
    
    for (int i = 0; i<[[dataArray lastObject] count]; i++) {
        lwMall_OrderServiceModel *serviceModel = [dataArray lastObject][i];
        
        if (serviceModel.serviceType == lwServiceSubTypeInputMsg && [serviceModel.scoreModel.sID isEqualToString:model.sID]) {
            ((lwMall_OrderServiceModel *)[[dataArray lastObject] objectAtIndex:i]).scoreModel = model;
        }
        
        if (serviceModel.serviceType == lwServiceSubTypeInputMsg) {
            lwMall_ScoreModel *pModel = ((lwMall_OrderServiceModel *)[[dataArray lastObject] objectAtIndex:i]).scoreModel;
            P += pModel.changedScore * pModel.point;
        }
        
        
        if (serviceModel.serviceType == lwServiceSubTypeShowMsg  && [serviceModel.serviceTitle
            isEqualToString:@"积分优惠"]) {
            newPrice.couponPrice += model.changedPrice;
            
            serviceModel.serviceSubTitle = [NSString stringWithFormat:@"%.2f",P];
        }
        
        if (serviceModel.serviceType == lwServiceSubTypeShowMsg && [serviceModel.serviceTitle isEqualToString:@"商品总额"]) {
            newPrice.truePrice = [[serviceModel.serviceSubTitle stringByReplacingOccurrencesOfString:@"￥" withString:@""] doubleValue];
        }
        
        if (serviceModel.serviceType == lwServiceSubTypeShowMsg && [serviceModel.serviceTitle isEqualToString:@"运费"]) {
            newPrice.postage = [[serviceModel.serviceSubTitle stringByReplacingOccurrencesOfString:@"￥" withString:@""] doubleValue];
        }
        
        if (serviceModel.serviceType == lwServiceSubTypeShowMsg && [serviceModel.serviceTitle isEqualToString:@"应付金额"]) {
            newPrice.sumPrice = newPrice.truePrice - P + newPrice.postage;
            serviceModel.serviceSubTitle = [NSString stringWithFormat:@"%.2f",newPrice.sumPrice];
        }
    }

    dispatch_async(dispatch_get_main_queue(), ^{
        [myTableView reloadData];
    });
    
    
}


#pragma mark - UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 15;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 100;
    }else if (indexPath.section == dataArray.count - 1){
        
        lwMall_OrderServiceModel *model = [dataArray objectAtIndex:indexPath.section][indexPath.row];
        
        return model.serviceType == lwServiceSubTypeShowMsg ? 44 : 85;
    }else{
        return 116;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0 || section == dataArray.count - 1) {
        return [dataArray[section] count];
    }else{
        return [dataArray[section] count];
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    lwCompletedCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:CompletedOrderCellID];
    lwAddressCell *addressCell = [tableView dequeueReusableCellWithIdentifier:CompletedOrderAddressCellID];
    lwCommodityCell *commodityCell = [tableView dequeueReusableCellWithIdentifier:CompletedOrderCommodityCellID];
    lwCompletdOrderCommonCell *commonCell = [tableView dequeueReusableCellWithIdentifier:CompletedOrderCommonCellID];
    
    if (!addressCell) {
        addressCell = [[lwAddressCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CompletedOrderAddressCellID];
        addressCell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    if (!commodityCell) {
        commodityCell = [[NSBundle mainBundle] loadNibNamed:@"lwCommodityCell" owner:self options:nil].firstObject;
        commodityCell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"lwCompletedCustomCell" owner:self options:nil].firstObject;
        cell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    if (!commonCell) {
        commonCell = [[lwCompletdOrderCommonCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CompletedOrderCommonCellID];
        commonCell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    
    
    if (indexPath.section == 0) {
        
        addressCell.addressModel = (lwMall_AddressModel *)[dataArray objectAtIndex:indexPath.section][0];
    
        return addressCell;
    }else if(indexPath.section == dataArray.count - 1){
        lwMall_OrderServiceModel *model = [dataArray objectAtIndex:indexPath.section][indexPath.row];
        
        if (model.serviceType == lwServiceSubTypeInputMsg) {
            [cell setServiceModel:model];
            return cell;
        }else{
            [commonCell setServiceModel:model];
            return commonCell;
        }
    }else{
        return commodityCell;
    }
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == dataArray.count - 1) {
        [self.view endEditing:YES];
    }
    [myTableView reloadData];
}

@end
