//
//  lwPersonalVC.m
//  shopCart
//
//  Created by 刘威 on 16/4/23.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "lwPersonalVC.h"
#import "lwStoreManagerVC.h"
#import "lwWalletVC.h"

#import "lwFlowLayout.h"
#import "lwPeronalCell.h"
#import "lwPersonalHeaderView.h"

#import "lwPersonalModel.h"

#define itemCount 3
#define minSpace 0

static NSString *personalCellID = @"cellsb";
static NSString *HedaerCell = @"headerCell";
static NSString *FooterCell = @"footerID";
@interface lwPersonalVC ()
<
    UICollectionViewDataSource,
    UICollectionViewDelegate,
    UICollectionViewDelegateFlowLayout
>
{
    UICollectionView *myCollectionView;
    NSMutableArray *dataArray;
}

@end

@implementation lwPersonalVC


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"会员中心";
    [self setupView];
    [self initDataSource];
}

- (void)setupView{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    myCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    [myCollectionView registerClass:[lwPeronalCell class] forCellWithReuseIdentifier:personalCellID];
    [myCollectionView registerClass:[lwPersonalHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HedaerCell];
    [myCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:FooterCell];
    myCollectionView.backgroundColor = [UIColor whiteColor];
    myCollectionView.delegate = self;
    myCollectionView.dataSource = self;
    [self.view addSubview:myCollectionView];
    
    [myCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
    }];
}



- (void)initDataSource{
    dataArray = [NSMutableArray new];
    
    NSMutableArray *sectionArray = [NSMutableArray new];
    NSArray *menuArray = @[@"扫码付款",@"我的钱包",@"我的积分",@"我的订单",@"我的人脉",@"推广二维码",@"收货地址",@"银行账户",@"设置支付密码",@"成为合伙人"];
    for (int i = 0; i<[menuArray count]; i++) {
        lwPersonalModel *model = [lwPersonalModel new];
        model.imgPath = @"http://www.easyicon.net/api/resizeApi.php?id=1108155&size=128";
        model.title = menuArray[i];
        [sectionArray addObject:model];
    }
    
    
    NSMutableArray *headerArray = [NSMutableArray new];
    NSArray *titleArray = @[@"待付款",@"待收货",@"积分兑换",@"所有订单"];
    for (int i = 0; i<[titleArray count]; i++) {
        lwPersonalModel *model = [lwPersonalModel new];
        model.imgPath = @"http://www.easyicon.net/api/resizeApi.php?id=1108155&size=128";
        model.title = titleArray[i];
        [headerArray addObject:model];
    }
    
    
    
    [dataArray addObject:headerArray];
    for (int i = 0; i<1; i++) {
        [dataArray addObject:sectionArray];
    }
    
    [myCollectionView reloadData];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return dataArray.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [dataArray[section] count];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return section == 0 ? CGSizeMake(lW, 150) : CGSizeMake(lW, 0);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return section == 0 ? CGSizeMake(lW, 20) : CGSizeMake(lW, 50);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return section == 0 ? 0 : 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return section == 0 ? 0 : 0;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 ) {
        return CGSizeMake(lW/4, lW/4);
    }else{
        return CGSizeMake(lW/itemCount-minSpace*(itemCount +1), lW/itemCount-minSpace*(itemCount +1));
    }
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        // 返回头部视图
        lwPersonalHeaderView *reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:HedaerCell forIndexPath:indexPath];
        lwPersonalHeaderModel *headerModel = [[lwPersonalHeaderModel alloc] init];
        headerModel.headerImgPath = @"http://www.easyicon.net/api/resizeApi.php?id=1108155&size=128";
        headerModel.nickname = @"这里是昵称";
        headerModel.mobileNo = @"18812345678";
        headerModel.identity = @"金牌合伙人 区域代理  商家";
        headerModel.superior = @"Xu.R";
        headerModel.superiorMobileNo = @"18887654321";
        reusableView.headerModel = headerModel;
        return indexPath.section == 0 ? reusableView : nil;
    }else{
        // 返回尾部视图
        UICollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:FooterCell forIndexPath:indexPath];
        footerView.backgroundColor = RGB(237, 237, 237);
        return footerView;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    lwPeronalCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:personalCellID forIndexPath:indexPath];
    [cell setModel:(lwPersonalModel *)dataArray[indexPath.section][indexPath.row]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    lwPeronalCell *cell = (lwPeronalCell *)[collectionView cellForItemAtIndexPath:indexPath];
    if ([cell.titleLabel.text isEqualToString:@"我的钱包"]) {
        lwWalletVC *wallet = [[lwWalletVC alloc] init];
        wallet.title = @"我的钱包";
        wallet.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:wallet animated:YES];
    }
}

@end








