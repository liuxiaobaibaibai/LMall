//
//  lwFindVC.m
//  shopCart
//
//  Created by lw on 16/4/20.
//  Copyright © 2016年 lw. All rights reserved.
//

// VC
#import "lwFind_ListVC.h"

// Model
#import "lwFindModel.h"

// View
#import "lwFindCell.h"
#import "lwSortHeaderView.h"
#import "lwFind_ListHeaderView.h"

@interface lwFind_ListVC ()

<
    MBProgressHUDDelegate
>

{
    NSMutableArray *dataArray;
    MBProgressHUD *HUD;
}

@end

@implementation lwFind_ListVC


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"lwFindCell" bundle:nil] forCellReuseIdentifier:[lwEntity entitySingleton].lwFindVCellID];
    [self initDataSource];
    
}

- (void)viewDidAppear:(BOOL)animated{
    [self tableHeaderView];
}


- (void)tableHeaderView{
    lwFind_ListHeaderView *headerView = [[lwFind_ListHeaderView alloc] initWithFrame:CGRectMake(0, 0, lW, 150)];
    [headerView setMenuArray:[NSMutableArray arrayWithObjects:@"21",@"32",@"43",@"56",@"78",@"21",@"32",@"43",@"56",@"78",@"21",@"32",@"43",@"56",@"78",@"21",@"32",@"43",@"56",@"78", nil]];
    [self.tableView setTableHeaderView:headerView];
}

- (void)initDataSource{
    dataArray = [NSMutableArray new];
    for (int i = 0; i<8; i++) {
        lwFindModel *oneModel = [lwFindModel new];
        oneModel.sid = [NSString stringWithFormat:@"%d",i];
        oneModel.shopName = [NSString stringWithFormat:@"聚赢宝商城%d号",i];
        oneModel.address = [NSString stringWithFormat:@"江苏省无锡市崇安区上马墩路%d",i*(arc4random()%15)];
        oneModel.distance = [NSString stringWithFormat:@"%.2fkm",0.3*(arc4random()%6+1)];
        oneModel.telephoneNo = @"10086";
        oneModel.latitude = 24.3526461;
        oneModel.longtitude = 121.132647;
        oneModel.favorite = arc4random()%2;
        
        [dataArray addObject:oneModel];
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}

#pragma mark - 相关操作
- (void)findCellButtonClick:(UIButton *)btn Model:(lwFindModel *)model Completion:(userOperatonBlock)completion{
    switch (btn.tag) {
        case 4:
        {
            for (int i = 0; i<dataArray.count; i++) {
                lwFindModel *aModel = (lwFindModel *)dataArray[i];
                if ([aModel.sid isEqualToString:model.sid]) {
                    [dataArray removeObjectAtIndex:i];
                    [dataArray insertObject:aModel atIndex:i];
                }
            }
            
            [model attentionShop:!model.favorite Completion:^(id result, NSError *error) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.tableView reloadData];
                    [self showToast:result];
                });
            }];
        }
            break;
        default:
        {
            NSError *error = [NSError errorWithDomain:@"获取失败" code:201 userInfo:@{@"reason":@"获取失败"}];
            completion(nil,error);
        }
            break;
    }
}

#pragma mark - Table view data source

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    lwSortHeaderView *chView = [[lwSortHeaderView alloc] initWithFrame:CGRectMake(0, 0, lW, 30)];
    [chView setDataArray:[NSMutableArray arrayWithObjects:@"时间",@"价格",@"销量", nil]];
    return chView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 115;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    lwFindCell *cell = [tableView dequeueReusableCellWithIdentifier:[lwEntity entitySingleton].lwFindVCellID];
    
    cell.source = self;
    
    [cell setFindModel:(lwFindModel *)dataArray[indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma mark - HUD
- (void)showToast:(NSString *)msg{
    dispatch_async(dispatch_get_main_queue(), ^{
        HUD = [[MBProgressHUD alloc] initWithView:[[UIApplication sharedApplication] keyWindow]];
        [[[UIApplication sharedApplication] keyWindow] addSubview:HUD];
        HUD.mode = MBProgressHUDModeCustomView;
        
        HUD.delegate = self;
        HUD.labelText = msg;
        
        [HUD show:YES];
        [HUD hide:YES afterDelay:0.5];
    });
}

- (void)dealloc{
    [self removeHUD];
}

- (void)hudWasHidden:(MBProgressHUD *)hud {
    // Remove HUD from screen when the HUD was hidded
    [hud removeFromSuperview];
    hud = nil;
}

- (void)removeHUD{
    [HUD removeFromSuperview];
}


@end
