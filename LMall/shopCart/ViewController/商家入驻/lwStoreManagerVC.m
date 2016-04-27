//
//  lwStoreManagerVC.m
//  shopCart
//
//  Created by lw on 16/4/27.
//  Copyright © 2016年 lw. All rights reserved.
//
#define padding 8

#define nextBtnTag 10
#define previousBtnTag 20
#import "lwStoreManagerVC.h"

#import "StoreInfo.h"

@interface lwStoreManagerVC ()
<
    UITableViewDataSource,
    UITableViewDelegate
>
{
    UITableView *myTableView;
    UILabel *titleLabel;
    UIScrollView *myScrollView;
    NSArray *setupArray;
    NSMutableArray *dataArray;
    
}
@property (assign, nonatomic) int selectIndex;

@end

@implementation lwStoreManagerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _selectIndex = 0;
    setupArray = @[@{@"setup":@"商家资料",@"content":@[@"商家名称",@"商家简称",@"管理员平台账号",@"省份",@"城市",@"区域",@"详细地址",@"坐标",@"门头照片",@"商城LOGO",@"商家邮箱"]},@{@"setup":@"店主信息",@"content":@[@"店主电话",@"身份证号",@"身份证正面",@"身份证反面"]},@{@"setup":@"营业执照",@"content":@[@"统一社会信用代码",@"营业执照",@"主行业",@"副行业"]},@{@"setup":@"银行信息",@"content":@[@"银行名称",@"户名",@"银行账号"]},@{@"setup":@"等待审核",@"content":@[@"提示信息"]}];
    dataArray = [setupArray[_selectIndex] objectForKey:@"content"];
    [self setupView];
}

- (void)setupView{
    myTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    [myTableView setTableFooterView:[self tableFooterView]];
    [myTableView setTableHeaderView:[self tableHeaderView]];
    [self.view addSubview:myTableView];
    
    [myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
}
- (UIView *)tableHeaderView{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, lW, 150)];
    UIImageView *imgView = [[UIImageView alloc] init];
    imgView.image = [UIImage imageNamed:@"header"];
    [headerView addSubview:imgView];
    
    [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.right.mas_equalTo(0);
    }];
    
    return headerView;
}

- (UIView *)tableFooterView{
    NSString *btnTitle = [NSString new];
    if (_selectIndex == 0) {
        btnTitle = @"下一步";
    }
    if (_selectIndex == setupArray.count -1) {
        btnTitle = @"修改信息";
    }
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, lW, 50)];
    
    if (_selectIndex == 0 || _selectIndex == setupArray.count -1) {
        UIButton *nextBtn = [[UIButton alloc] init];
        [nextBtn setTitle:btnTitle forState:UIControlStateNormal];
        [nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [nextBtn setBackgroundColor:[lwStyleTool colorInstance].JDColor];
        [nextBtn addTarget:self
                    action:@selector(nextSetUp:)
          forControlEvents:UIControlEventTouchUpInside];
        nextBtn.layer.cornerRadius = 5.0;
        [nextBtn setTag:nextBtnTag];
        nextBtn.layer.masksToBounds = YES;
        [footerView addSubview:nextBtn];
        
        [nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(200);
            make.centerX.mas_equalTo(footerView.mas_centerX);
            make.top.mas_equalTo(0);
            make.bottom.mas_equalTo(-20);
        }];
    }else{
        
        UIButton *previousBtn = [[UIButton alloc] init];
        [previousBtn setTitle:@"上一步" forState:UIControlStateNormal];
        [previousBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [previousBtn setBackgroundColor:[lwStyleTool colorInstance].JDColor];
        [previousBtn addTarget:self
                    action:@selector(nextSetUp:)
          forControlEvents:UIControlEventTouchUpInside];
        previousBtn.layer.cornerRadius = 5.0;
        previousBtn.layer.masksToBounds = YES;
        [previousBtn setTag:previousBtnTag];
        [footerView addSubview:previousBtn];
        
        
        UIButton *nextBtn = [[UIButton alloc] init];
        [nextBtn setTitle:_selectIndex == 3 ? @"提交审核" : @"下一步" forState:UIControlStateNormal];
        [nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [nextBtn setBackgroundColor:[lwStyleTool colorInstance].JDColor];
        [nextBtn addTarget:self
                    action:@selector(nextSetUp:)
          forControlEvents:UIControlEventTouchUpInside];
        nextBtn.layer.cornerRadius = 5.0;
        nextBtn.layer.masksToBounds = YES;
        [nextBtn setTag:nextBtnTag];
        [footerView addSubview:nextBtn];
        
        [previousBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(padding);
            make.right.mas_equalTo(nextBtn.mas_left).with.offset(-padding);
            make.top.mas_equalTo(0);
            make.width.mas_equalTo(nextBtn.mas_width);
        }];
        
        [nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(previousBtn.mas_right).with.offset(padding);
            make.right.mas_equalTo(-padding);
            make.top.mas_equalTo(0);
            make.width.mas_equalTo(previousBtn.mas_width);
        }];
    }
    
    return footerView;
}

- (void)nextSetUp:(UIButton *)sender{
    

    StoreInfo *store = [StoreInfo new];
    store.cityID = @"326";
    [StoreInfo insertStoreInfo:store Completion:nil];
    
    switch (sender.tag) {
        case previousBtnTag:
        {
            if (_selectIndex>0) {
                self.selectIndex--;
                [myTableView setTableFooterView:[self tableFooterView]];
                [myTableView reloadData];
            }
        }
            break;
        default:
        {
            if (_selectIndex<setupArray.count-1) {
                self.selectIndex++;
                [myTableView setTableFooterView:[self tableFooterView]];
                [myTableView reloadData];
            }
        }
            break;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[setupArray[_selectIndex] objectForKey:@"content"] count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [setupArray[_selectIndex] objectForKey:@"setup"];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    
    [cell.textLabel setText:setupArray[_selectIndex][@"content"][indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}




@end
