//
//  lwPersonalVC.m
//  shopCart
//
//  Created by 刘威 on 16/4/23.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "lwPersonalVC.h"

#import "lwStoreManagerVC.h"

#import "lwFlowLayout.h"
#import "lwPeronalCell.h"


#import "lwPersonalModel.h"

#define itemCount 3
#define minSpace 0

static NSString *personalCellID = @"cellsb";
static NSString *HedaerCell = @"headerCell";
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
    [self setupView];
    [self initDataSource];
}

- (void)setupView{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
//    flowLayout.itemSize = CGSizeMake(lW/itemCount-minSpace*(itemCount +1), lW/itemCount-minSpace*(itemCount +1));
//    flowLayout.minimumInteritemSpacing = minSpace;
//    flowLayout.minimumLineSpacing = minSpace;
    myCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    [myCollectionView registerClass:[lwPeronalCell class] forCellWithReuseIdentifier:personalCellID];
    [myCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HedaerCell];
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
    for (int i = 0; i<9; i++) {
        lwPersonalModel *model = [lwPersonalModel new];
        model.imgPath = @"http://www.easyicon.net/api/resizeApi.php?id=1108155&size=128";
        model.title = @"百度贴吧";
        [sectionArray addObject:model];
    }
    
    NSMutableArray *headerArray = [NSMutableArray new];
    
    for (int i = 0; i<4; i++) {
        lwPersonalModel *model = [lwPersonalModel new];
        model.imgPath = @"http://www.easyicon.net/api/resizeApi.php?id=1108155&size=128";
        model.title = @"百度贴吧";
        [headerArray addObject:model];
    }
    
    [dataArray addObject:headerArray];
    
    for (int i = 0; i<6; i++) {
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
    return section == 0 ? CGSizeMake(lW, 100) : CGSizeMake(lW, 20);
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
    UICollectionReusableView *reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:HedaerCell forIndexPath:indexPath];
    reusableView.backgroundColor = RGB(arc4random()%255, arc4random()%255, arc4random()%255);
    
    return indexPath.section == 0 ? reusableView : reusableView;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    lwPeronalCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:personalCellID forIndexPath:indexPath];
    [cell setModel:(lwPersonalModel *)dataArray[indexPath.section][indexPath.row]];
    return cell;
}





@end








