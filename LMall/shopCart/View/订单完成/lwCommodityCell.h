//
//  lwCommodityCell.h
//  shopCart
//
//  Created by 刘威 on 16/4/9.
//  Copyright © 2016年 lw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface lwCommodityCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *logoImgView;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *cCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *normLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@end
