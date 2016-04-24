//
//  lwAddressInfo.m
//  shopCart
//
//  Created by lw on 16/3/7.
//  Copyright © 2016年 lw. All rights reserved.
//
#import "AppDelegate.h"
#import "lwCommodityDetailVC.h"
#import "lwShopcartVC.h"


#import "lwTitleCell.h"
#import "lwCustomCell.h"
#import "lwSelectWindow.h"

/******/
#import "lwCustomCellContentFrameModel.h"
#import "lwCustomModel.h"
/******/


@interface lwCommodityDetailVC ()

<
    lwSelectNormViewDelegate
>

{
    NSMutableArray *dataArray;
    NSMutableArray *secondArray;
    AppDelegate *_appDelegate;
    
    UIWindow *toolView;
    lwSelectWindow *selectWindow;
}

@end

@implementation lwCommodityDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView setTableHeaderView:[self setTableHeaderView]];
    [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 60)]];
    

    [self initDataSource];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    [self setToolView];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self releaseToolView];
}

- (void)initDataSource{
    dataArray = [NSMutableArray new];
    dataArray = [NSMutableArray arrayWithObjects:@"测试数据0",@"测试数据1",@"测试数据2",@"测试数据3", nil];


    lwCustomModel *lqModel = [lwCustomModel new];
    lqModel.title = @"领券";
    lqModel.subArray = @[@"  [满100减5]  [满199减10]  [满99减50]"];
    lqModel.currentColor = [UIColor redColor];
    lwCustomCellContentFrameModel *lqFModel = [lwCustomCellContentFrameModel new];
    lqFModel.customModel = lqModel;

    lwCustomModel *cxModle = [lwCustomModel new];
    cxModle.title = @"促销";
    cxModle.subArray = @[@"【 多买优惠 】 限购：购买1-5件时享受优惠",@"【 满减 】 活动预告：04月08日00:00满4件，立减最低一件半价优惠",@"【 现买立返 】"];
    cxModle.currentColor = [UIColor blackColor];
    lwCustomCellContentFrameModel *cxFModel = [lwCustomCellContentFrameModel new];
    cxFModel.customModel = cxModle;
    
    lwCustomModel *yxModel = [lwCustomModel new];
    yxModel.title = @"已选";
    yxModel.subArray = @[@"2个白色装，1个黑色装"];
    yxModel.currentColor = [lwStyleTool colorInstance].DZClolor;
    lwCustomCellContentFrameModel *yxFModel = [lwCustomCellContentFrameModel new];
    yxFModel.customModel = yxModel;
    
    lwCustomModel *szModel = [lwCustomModel new];
    szModel.title = @"送至";
    szModel.subArray = @[@"江苏省无锡市崇安区上马墩路18号A座112楼"];
    szModel.currentColor = [lwStyleTool colorInstance].DZClolor;
    lwCustomCellContentFrameModel *szFModel = [lwCustomCellContentFrameModel new];
    szFModel.customModel = szModel;
    
    lwCustomModel *yfModel = [lwCustomModel new];
    yfModel.title = @"运费";
    yfModel.subArray = @[@"在线支付免运费"];
    yfModel.currentColor = [lwStyleTool colorInstance].DZClolor;
    lwCustomCellContentFrameModel *yfFModel = [lwCustomCellContentFrameModel new];
    yfFModel.customModel = yfModel;
    
    secondArray = [NSMutableArray new];
    secondArray = [NSMutableArray arrayWithObjects:lqFModel,cxFModel,szFModel,yxFModel,yfFModel, nil];
    
    [self.tableView reloadData];
}

- (UIView *)setTableHeaderView{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, lW, 200)];
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, lW, 200)];
    imgView.image = [UIImage imageNamed:@"header"];
    [headerView addSubview:imgView];
    
    return headerView;
}

- (void)setToolView{
    toolView = [[UIWindow alloc] initWithFrame:CGRectMake(0, lH-60, lW, 60)];
    toolView.backgroundColor = [UIColor whiteColor];
    
    UIView *firstView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, lW-100, 60)];

    NSArray *array = @[@"卖家",@"店铺",@"关注",@"购物车"];
    NSArray *imgArray = @[@"pd_dongdong_bottom",@"pd_shop_bottom",@"pd_unfavorite_bottom",@"pd_shopcart_bottom"];
    for (int i = 0; i<array.count; i++) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(i*(lW/6), 0, lW/6, 60)];
        [btn setTitleColor:[lwStyleTool colorInstance].DZClolor forState:UIControlStateNormal];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:12.0]];
        [btn setTitle:array[i] forState:UIControlStateNormal];
        [btn.layer setBorderWidth:0.5];
        [btn.layer setBorderColor:RGB(120, 120, 120).CGColor];
        [btn setImage:[UIImage imageNamed:imgArray[i]] forState:UIControlStateNormal];
        [btn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
        [btn setImageEdgeInsets:UIEdgeInsetsMake(8, (lW/18), 20, (lW/18))];
        [btn setTitleEdgeInsets:UIEdgeInsetsMake(lW/6-20, -(lW/16),8, 0)];
        [btn setTag:i];
        [btn addTarget:self action:@selector(commodityBottomButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [firstView addSubview:btn];
    }
    
    UIButton *secondView = [[UIButton alloc] initWithFrame:CGRectMake(lW-(lW/3), 0, lW/3, 60)];
    secondView.backgroundColor = [lwStyleTool colorInstance].JDColor;
    [secondView setTitle:@"加入购物车" forState:UIControlStateNormal];
    [secondView setTag:5];
    [secondView addTarget:self action:@selector(commodityBottomButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [toolView addSubview:firstView];
    [toolView addSubview:secondView];

    [toolView makeKeyAndVisible];
}

#pragma mark - userOperationStart

- (void)commodityBottomButtonClick:(UIButton *)btn{
    switch (btn.tag) {
        case lwCommodityDetailBottomTypeFavorite:
        {
            if (btn.selected) {
                [btn setImage:[UIImage imageNamed:@"pd_unfavorite_bottom"] forState:UIControlStateNormal];
                btn.selected = NO;
            }else{
                
                [btn setImage:[UIImage imageNamed:@"pd_favorite_bottom"] forState:UIControlStateNormal];
                btn.selected = YES;
            }
        }
            break;
        case 5:
        {
            selectWindow = [[lwSelectWindow alloc] initWithFrame:self.view.frame Delegate:self];
            [selectWindow showInView:self.tableView];
        }
            break;
            
        default:
        {
            UIStoryboard *main = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            lwShopcartVC *vc = [main instantiateViewControllerWithIdentifier:@"shopcart"];
            vc.isHidden = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
    }
}

#pragma mark - 弹窗代理
- (void)removeWindow
{
    selectWindow.hidden = YES;
}


#pragma mark - userOperationEnd

- (void)releaseToolView{
    [toolView resignKeyWindow];
    toolView = nil;
    [toolView removeFromSuperview];
}


- (void)setupView{
    [self.tableView setTableHeaderView:[self tableHeaderView]];
}

- (UIView *)tableHeaderView{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, lW, lW)];
    headerView.backgroundColor = HTMLColor(@"#FFDAB9");
    return headerView;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section == 0 ? 1 : secondArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 170;
    }else{
        NSInteger row = indexPath.row;
        return ((lwCustomCellContentFrameModel *)secondArray[row]).cellHeight;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return section == 0 ? 1 : 15;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    lwTitleCell  *cellOne = [tableView dequeueReusableCellWithIdentifier:[lwEntity entitySingleton].CommodityCellTitleID];
    lwCustomCell *cellTwo = [tableView dequeueReusableCellWithIdentifier:[lwEntity entitySingleton].CommodityCellCustomID];
    if (!cellOne) {
        cellOne = [[lwTitleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[lwEntity entitySingleton].CommodityCellTitleID];
        cellOne.selectionStyle = UITableViewCellSelectionStyleNone;
    }
        
    if (!cellTwo) {
        cellTwo = [[lwCustomCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:[lwEntity entitySingleton].CommodityCellCustomID];
        cellTwo.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    if (indexPath.section == 1) {
        [cellTwo setFrameModel:secondArray[indexPath.row]];
    }
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        return cellOne;
    }else{
        return cellTwo;
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}


@end
