//
//  lwMallVC.m
//  shopCart
//
//  Created by lw on 16/4/6.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "lwMallVC.h"
// view
#import "lwHomeCommonCell.h"
#import "lwHomeCustomCell.h"
#import "lwHomeHeaderOtherView.h"
#import "lwHomeFooterView.h"
#import "lwHedaerCell.h"

// ViewController
#import "lwSearchVC.h"
#import "lwCommodityDetailVC.h"
#import "lwShopcartVC.h"
#import "lwPartnerVC.h"


// model
#import "lwMallModel.h"
#import "lwCommodityModel.h"

struct rowStruct{
    CGFloat row;
    CGFloat width;
};
typedef struct rowStruct lwRow;


@interface lwMallVC ()
<
    UICollectionViewDataSource,
    UICollectionViewDelegate,
    UICollectionViewDelegateFlowLayout,
    UISearchBarDelegate
>
{
    UICollectionView *myCollectionView;
    NSMutableArray *commodityArray;
    
    /**幻灯片数据*/
    NSMutableArray *flashArray;
    /**按钮数据*/
    NSMutableArray *menuArray;
    /**栏目数组*/
    NSMutableArray *titleArray;
    /**四格数组*/
    NSMutableArray *floorArray;
    /**尾部数组*/
    NSMutableArray *footerArray;
}


@end

@implementation lwMallVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.automaticallyAdjustsScrollViewInsets = YES;
    self.navigationController.navigationBarHidden = YES;
    [self initDataSource];
}

- (void)initDataSource{
    flashArray = [NSMutableArray new];
    
    menuArray = [NSMutableArray new];
    
    titleArray = [NSMutableArray new];
    
    floorArray = [NSMutableArray new];
    
    footerArray = [NSMutableArray new];
    
    commodityArray = [NSMutableArray new];
    

    
    [lwMallModel getTopData:^(id result, NSError *error) {
        if (!error) {
            for (int i = 0; i<[result count]; i++) {
                [flashArray addObject:result[i][@"img"]];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [myCollectionView reloadData];
            });
        }
    }];
    
    [lwMallModel getMallData:^(id result, NSError *error) {
        if (!error) {
            menuArray = result[@"menu"];
            titleArray = result[@"title"];
            floorArray = result[@"channel"];
            footerArray = result[@"AD"];
            dispatch_async(dispatch_get_main_queue(), ^{
                [myCollectionView reloadData];
            });
        }
    }];
    
    [lwMallModel getProducts:^(id result, NSError *error) {
        if (!error) {
            for (int i = 0; i<[result count]; i++) {
                lwCommodityModel *cModel = [lwCommodityModel new];
                cModel.pid = result[i][@"pid"];
                cModel.commodityName = result[i][@"name"];
                cModel.logoUrl = result[i][@"logourl"];
                cModel.price = result[i][@"price"];
                [commodityArray addObject:cModel];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [myCollectionView reloadData];
            });
        }
    }];
}


- (void)setupView{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumInteritemSpacing = 2.0;
    layout.minimumLineSpacing = 2.0;
    
    UIView *nav_View = [[UIView alloc] initWithFrame:CGRectMake(0, 20, lW, 44)];
    nav_View.backgroundColor = [UIColor whiteColor];
    
    UIButton *headerBtn = [UIButton new];
    [headerBtn setImage:[UIImage imageNamed:@"j_05"] forState:UIControlStateNormal];
    headerBtn.tag = 0;
    [headerBtn addTarget:self action:@selector(mallTopButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UISearchBar *searchBar = [UISearchBar new];
    searchBar.placeholder = @"进口食品";
    searchBar.translucent = YES;
    searchBar.delegate = self;
    searchBar.searchBarStyle = UISearchBarStyleMinimal;
    searchBar.barStyle = UIBarStyleDefault;
    searchBar.barTintColor = [UIColor whiteColor];
    
    UIButton *msgBtn = [UIButton new];
    [msgBtn setImage:[UIImage imageNamed:@"pd_shopcart_bottom"] forState:UIControlStateNormal];
    [msgBtn setTag:1];
    [msgBtn addTarget:self action:@selector(mallTopButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [nav_View addSubview:headerBtn];
    [nav_View addSubview:searchBar];
    [nav_View addSubview:msgBtn];
    [self.view addSubview:nav_View];
    
    [headerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(8);
        make.right.mas_equalTo(searchBar.mas_left).with.offset(-8);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(30);
        make.centerY.mas_equalTo(nav_View.mas_centerY);
    }];
    
    [searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(headerBtn.mas_right).with.offset(8);
        make.centerY.mas_equalTo(nav_View.mas_centerY);
        make.right.mas_equalTo(msgBtn.mas_left).with.offset(-8);
    }];
    
    [msgBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(searchBar.mas_right).with.offset(8);
        make.right.mas_equalTo(-8);
        make.centerY.mas_equalTo(nav_View.mas_centerY);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(30);
    }];
    
    myCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, lW, lH-108) collectionViewLayout:layout];
    myCollectionView.delegate = self;
    myCollectionView.dataSource = self;
    myCollectionView.backgroundColor = RGB(240, 240, 240);

    [myCollectionView registerNib:[UINib nibWithNibName:@"lwHedaerCell" bundle:nil] forCellWithReuseIdentifier:[lwEntity entitySingleton].homeHeaderCellID];
    [myCollectionView registerNib:[UINib nibWithNibName:@"lwHomeCommonCell" bundle:nil] forCellWithReuseIdentifier:[lwEntity entitySingleton].homeCommonCellID];
    [myCollectionView registerNib:[UINib nibWithNibName:@"lwHomeCustomCell" bundle:nil] forCellWithReuseIdentifier:[lwEntity entitySingleton].homeCustomCellID];
    [myCollectionView registerNib:[UINib nibWithNibName:@"lwHomeHeaderView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:[lwEntity entitySingleton].homeHeaderFirstViewID];
    [myCollectionView registerNib:[UINib nibWithNibName:@"lwHomeHeaderOtherView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:[lwEntity entitySingleton].homeHeaderOtherViewID];
    [myCollectionView registerNib:[UINib nibWithNibName:@"lwHomeFooterView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:[lwEntity entitySingleton].homeFooterViewID];
    [myCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:[lwEntity entitySingleton].homeFooterCommonViewID];
    
    [self.view addSubview:myCollectionView];
}



- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    UIStoryboard *main = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    lwSearchVC *searchVC = [main instantiateViewControllerWithIdentifier:@"searchVC"];
    searchVC.searchStr = searchBar.placeholder;
    [self presentViewController:searchVC animated:NO completion:nil];
    return NO;
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 5;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else if (section == 4){
        return commodityArray.count;
    }else{
        return floorArray.count == 0 ? 0 : [floorArray[section-1] count];
    }
}

/**
 *  设置头部视图的size
 */
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    
    if (section == 0) {
        return CGSizeMake(0, 0);
    }else{
        return CGSizeMake(lW, 50);
    }
}

/**
 *  设置尾部视图的size
 */
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    if (section == 2 || section == 3) {
        return CGSizeMake(lW, 100);
    }else if(section == 1){
        return CGSizeMake(lW, 10);
    }else{
        return CGSizeMake(0, 0);
    }
}

/**
 *  设置每个section之间的边距
 */
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(1, 1, 1, 1);
}



/**
 *  设置头部视图和脚部视图
 */
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0){
        return nil;
    }else if(indexPath.section == 2 || indexPath.section == 3){

        if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
            lwHomeHeaderOtherView *homeOtherView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:[lwEntity entitySingleton].homeHeaderOtherViewID forIndexPath:indexPath];
            homeOtherView.headerImgUrlPath = titleArray.count == 0 ? @"" : titleArray[indexPath.section-1];
            return homeOtherView;
        }else{
            lwHomeFooterView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:[lwEntity entitySingleton].homeFooterViewID forIndexPath:indexPath];
            footerView.footerArray = footerArray.count == 0 ? [NSMutableArray new] : footerArray[indexPath.section-2];
            return footerView;
        }
    }else if(indexPath.section == 1){
        if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
            lwHomeHeaderOtherView *homeOtherView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:[lwEntity entitySingleton].homeHeaderOtherViewID forIndexPath:indexPath];
            homeOtherView.headerImgUrlPath = titleArray.count == 0 ? @"" : titleArray[indexPath.section-1];
            return homeOtherView;
        }else{
            UICollectionReusableView *commonView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:[lwEntity entitySingleton].homeFooterCommonViewID forIndexPath:indexPath];
            return commonView;
        }
    }else{
        if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
            lwHomeHeaderOtherView *homeOtherView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:[lwEntity entitySingleton].homeHeaderOtherViewID forIndexPath:indexPath];
            homeOtherView.headerImgUrlPath = titleArray.count == 0 ? @"" : titleArray[indexPath.section-1];
            return homeOtherView;
        }else{
            return nil;
        }
    }
}

/**
 *  设置每个item
 */
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    lwHomeCommonCell *commonCell = [collectionView dequeueReusableCellWithReuseIdentifier:[lwEntity entitySingleton].homeCommonCellID forIndexPath:indexPath];
    lwHomeCustomCell *customCell = [collectionView dequeueReusableCellWithReuseIdentifier:[lwEntity entitySingleton].homeCustomCellID forIndexPath:indexPath];
    lwHedaerCell *headerCell = [collectionView dequeueReusableCellWithReuseIdentifier:[lwEntity entitySingleton].homeHeaderCellID forIndexPath:indexPath];
    
    if (indexPath.section == 0) {
        [headerCell setFlashArray:flashArray];
        [headerCell setMenu:menuArray];
        return headerCell;
    }else if (indexPath.section == 4){
        [customCell setCModel:(lwCommodityModel *)commodityArray[indexPath.row]];
        return customCell;
    }else{
        [commonCell setUrlStr:floorArray[indexPath.section-1][indexPath.row][@"img"]];
        return commonCell;
    }
}

/**
 *  设置每个item的size
 */
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return CGSizeMake(lW-2, 250);
    }else if (indexPath.section == 4){
        return CGSizeMake(lW/2-2, 235);
    }else{
        return CGSizeMake(lW/2-2, lW/4-1);
    }
}

/**
 *  设置选中
 */
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return;
    }else{
        [self goCommodityDetailVC];
    }
}

#pragma mark - 用户操作事件

- (void)goCommodityDetailVC{
    lwCommodityDetailVC *commodityDetailVC = [[lwCommodityDetailVC alloc] init];
    commodityDetailVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:commodityDetailVC animated:YES];
}

- (void)goShopCart{
    UIStoryboard *main = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    lwShopcartVC *shopcartVC = [main instantiateViewControllerWithIdentifier:@"shopcart"];
    shopcartVC.hidesBottomBarWhenPushed = YES;
    shopcartVC.isHidden = YES;
    [self.navigationController pushViewController:shopcartVC animated:YES];
}

- (void)mallTopButtonClick:(UIButton *)btn{
    switch (btn.tag) {
        case 0:
        {
            // 头像按钮
            [self initDataSource];
//            [self goPartnerVC];
        }
            break;
        case 1:
        {
            // 购物车
            [self goShopCart];
        }
        default:
            break;
    }
}

- (void)goPartnerVC{
    lwPartnerVC *partnerVC = [[lwPartnerVC alloc] init];
    partnerVC.title = @"成为合伙人";
    partnerVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:partnerVC animated:YES];
}

@end
