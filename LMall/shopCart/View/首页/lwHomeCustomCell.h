//
//  lwHomeCustomCell.h
//  shopCart
//
//  Created by lw on 16/4/14.
//  Copyright © 2016年 lw. All rights reserved.
//

#import <UIKit/UIKit.h>

@class lwCommodityModel;

@interface lwHomeCustomCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *logoUrl;
@property (weak, nonatomic) IBOutlet UILabel *commodityTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIButton *scoreLabel;

@property (retain, nonatomic) lwCommodityModel *cModel;

@end

