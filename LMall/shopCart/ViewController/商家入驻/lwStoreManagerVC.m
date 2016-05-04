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
#define URL @"http://192.168.1.29/lw/storeManager.json"

#import "lwStoreManagerVC.h"

//view
#import "lwStoreManagerImgCell.h"

// model
#import "lwStoreManagerModel.h"
#import "StoreInfo.h"
static NSString *imgCellId = @"cellImg";
static lwStoreManagerModel *staticModel;
static CGRect contentRect;
@interface lwStoreManagerVC ()
<
    UITableViewDataSource,
    UITableViewDelegate,
    UIActionSheetDelegate,
    UIImagePickerControllerDelegate,
    UINavigationControllerDelegate,
    MBProgressHUDDelegate
>
{
    UITableView *myTableView;
    UILabel *titleLabel;
    UIScrollView *myScrollView;
    NSMutableArray *setupArray;
    NSMutableArray *dataArray;
    MBProgressHUD *HUD;
    
}
@property (assign, nonatomic) int selectIndex;

@end

@implementation lwStoreManagerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setupView];
    [self showToast:@selector(getData)];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void)showToast:(SEL)sel{
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    HUD.dimBackground = YES;
    HUD.delegate = self;
    [HUD showWhileExecuting:sel onTarget:self withObject:nil animated:YES];
}


- (void)getData{
    setupArray = [NSMutableArray new];
    NSURL *url = [NSURL URLWithString:URL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSError *error = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    if (data == nil) {
        return;
    }else{
        NSDictionary *responseObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        if (responseObject == nil) {
            return;
        }
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

- (void)setupView{
    myTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    [myTableView setTableFooterView:[self tableFooterView]];
    [self.view addSubview:myTableView];
    
    [myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(64);
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
        make.width.mas_equalTo(lW-30);
        make.centerX.mas_equalTo(footerView.mas_centerX);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(-10);
    }];
    
    return footerView;
}

- (void)nextSetUp:(UIButton *)sender{
    NSLog(@"%@",setupArray);
    
    for (int i = 0; i<setupArray.count; i++) {
        lwStoreModel *model = [[lwStoreModel alloc] init];
    }
    
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
            return 80;
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
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    if (!imgCell) {
        imgCell = [[lwStoreManagerImgCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:imgCellId];
        imgCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
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
    staticModel = model;
    switch (model.type) {
        case lwStoreManagerModelTypeImg:
        {
            contentRect = CGRectMake(myTableView.contentOffset.x, myTableView.contentOffset.y, myTableView.contentSize.width, myTableView.contentSize.height);
            // 打开照片
            [self showActionSheet:@"提示"];
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
            NSString *msg = [NSString stringWithFormat:@"请输入%@",model.title];
            [self showAlert:msg];
        }
        case lwStoreManagerModelTypeMap:
        {
            // 打开地图
        }
            break;
        default:
            break;
    }
}

- (void)showAlert:(NSString *)msg{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:msg delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
    [alert setAlertViewStyle:UIAlertViewStylePlainTextInput];
    [alert setTag:10];
    [alert show];
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (alertView.tag) {
        case 10:
        {
            [self.view.window endEditing:YES];
            if (buttonIndex == 0) {
            }else{
                [self update:[alertView textFieldAtIndex:0].text];
            }
        }
            break;
            
        default:
            break;
    }
}

- (void)update:(NSString *)subtitle{
    NSLog(@"%@",staticModel.title);
    for (int i = 0; i<[setupArray count]; i++) {
        for (lwStoreManagerModel *model in setupArray[i][@"content"]) {
            if ([staticModel.title isEqualToString:model.title]) {
                model.subtitle = subtitle;
                dispatch_async(dispatch_get_main_queue(), ^{
                    [myTableView reloadData];
                });
            }
        }
    }
}

#pragma mark - 照片选择
- (void)showActionSheet:(NSString *)title{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:title delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从手机相册选择", nil];
    actionSheet.tag = 10;
    [actionSheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (actionSheet.tag) {
        case 10:
        {
            if (buttonIndex == 0) {
                // 拍照
                if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                    [self cameraOperation:YES];
                }else{
                    NSLog(@"当前没有权限");
                }
            }else if (buttonIndex == 1){
                // 相册
                [self cameraOperation:NO];
            }else{
                // 取消
            }
            
        }
            break;
            
        default:
            break;
    }
}

- (void)cameraOperation:(BOOL)isCamera{
    UIImagePickerController *imgPicker = [[UIImagePickerController alloc] init];
    imgPicker.delegate = self;
    if (isCamera) {
        imgPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        imgPicker.showsCameraControls = YES;
    }else{
        imgPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    imgPicker.allowsEditing = YES;
    [self presentViewController:imgPicker animated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *img = info[@"UIImagePickerControllerOriginalImage"];
    for (int i = 0; i<[setupArray count]; i++) {
        for (lwStoreManagerModel *model in setupArray[i][@"content"]) {
            if ([staticModel.title isEqualToString:model.title]) {
                model.img = img;
                dispatch_async(dispatch_get_main_queue(), ^{
                    [myTableView reloadData];
                });
            }
        }
    }
    
}



@end
