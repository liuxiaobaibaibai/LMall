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

//view
#import "lwStoreManagerImgCell.h"

// model
#import "lwStoreManagerModel.h"
#import "StoreInfo.h"
static NSString *imgCellId = @"cellImg";
@interface lwStoreManagerVC ()
<
    UITableViewDataSource,
    UITableViewDelegate
>
{
    UITableView *myTableView;
    UILabel *titleLabel;
    UIScrollView *myScrollView;
    NSMutableArray *setupArray;
    NSMutableArray *dataArray;
    
}
@property (assign, nonatomic) int selectIndex;

@end

@implementation lwStoreManagerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _selectIndex = 0;
//    setupArray = @[@{@"setup":@"商家资料",@"content":@[@{@"商家名称":@"测试商家"},@{@"商家简称":@"测试"},@{@"管理员平台账号":@"18812345678"},@{@"地区":@"江苏省无锡市北塘区"},@{@"详细地址":@"锡澄路274-17"},@{@"坐标":@"21.12,121.235"},@{@"门头照片":@"header"},@{@"商城LOGO":@"cry"},@{@"商家邮箱":@"123456789@qq.com"}]},@{@"setup":@"店主信息",@"content":@[@{@"店主电话":@"4000510408"},@{@"身份证号":@"360430199912345678"},@{@"身份证正面":@"header"},@{@"身份证反面":@"header"}]},@{@"setup":@"营业执照",@"content":@[@{@"统一社会信用代码":@"2016032516"},@{@"营业执照":@"header"},@{@"主行业":@"IT,软件"},@{@"副行业":@"IT,金融"}]},@{@"setup":@"银行信息",@"content":@[@{@"银行名称":@"中国建设银行"},@{@"户名":@"测试账号"},@{@"银行账号":@"6221 4008 2653 196532"}]}];
    [self getData];
}

- (void)viewDidAppear:(BOOL)animated{
    [self setupView];
}


- (void)getData{
    setupArray = [NSMutableArray new];
    NSURL *url = [NSURL URLWithString:@"http://192.168.1.73/lw/storeManager.json"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSError *error = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    if (data == nil) {
        return;
    }else{
        NSDictionary *responseObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        if (responseObject != nil) {
            if (responseObject) {
                if (responseObject != nil) {
                    NSArray *array = responseObject[@"root"];
                    
                    for (int i = 0; i<array.count; i++) {
                        NSArray *contentArray = array[i][@"content"];
                        NSMutableArray *setupArr = [NSMutableArray new];
                        for (int i = 0; i<contentArray.count; i++) {
                            lwStoreManagerModel *managerModel = [[lwStoreManagerModel alloc] initWithDict:contentArray[i]];
                            [setupArr addObject:managerModel];
                        }
                        
                        NSMutableDictionary *dict = [NSMutableDictionary new];
                        [dict setObject:array[i][@"setup"] forKey:@"setup"];
                        [dict setObject:setupArr forKey:@"content"];
                        
                        [setupArray addObject:dict];
                    }
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [myTableView reloadData];
                    });
                }
            }
        }
    }
    
}

- (void)setupView{
    myTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    [myTableView setTableFooterView:[self tableFooterView]];
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
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, lW, 50)];
    
    UIButton *nextBtn = [[UIButton alloc] init];
    [nextBtn setTitle:@"提交审核" forState:UIControlStateNormal];
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
    
    return footerView;
}

- (void)nextSetUp:(UIButton *)sender{
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [setupArray[section][@"content"] count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [setupArray count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [setupArray[section] objectForKey:@"setup"];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    lwStoreManagerModel *model = (lwStoreManagerModel *)setupArray[indexPath.section][@"content"][indexPath.row];
    switch (model.type) {
        case lwStoreManagerModelTypeImg:
            return 60;
            break;
        default:
            return 44;
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    lwStoreManagerImgCell *imgCell = [tableView dequeueReusableCellWithIdentifier:imgCellId];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    
    if (!imgCell) {
        imgCell = [[lwStoreManagerImgCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:imgCellId];
    }
    
    lwStoreManagerModel *model = (lwStoreManagerModel *)setupArray[indexPath.section][@"content"][indexPath.row];
    
    switch (model.type) {
        case lwStoreManagerModelTypeImg:
        {
            [imgCell setModel:model];
            return imgCell;
        }
            break;
        default:
        {
            [cell.textLabel setText:model.title];
            [cell.detailTextLabel setText:model.subtitle];
            return cell;
        }
            break;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    lwStoreManagerModel *model = (lwStoreManagerModel *)setupArray[indexPath.section][@"content"][indexPath.row];
    switch (model.type) {
        case lwStoreManagerModelTypeImg:
        {
            // 打开照片
        }
            break;
        case lwStoreManagerModelTypeSelect:
        {
            // 打开选择器
        }
            break;
        case lwStoreManagerModelTypeText:
        {
            // 弹出文本框
        }
            
        default:
            break;
    }
}

- (void)selectImagePickerView{
    UIImagePickerController *imgPicker = [[UIImagePickerController alloc] init];
}




@end
