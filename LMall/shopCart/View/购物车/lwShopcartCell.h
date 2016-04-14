//
//  lwShopcartCell.h
//  lwGiftView
//
//  Created by 刘威 on 16/3/6.
//  Copyright © 2016年 刘威. All rights reserved.
//

#import <UIKit/UIKit.h>

@class lwShopcartModel;

@interface lwShopcartCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *goodsImgView;
@property (weak, nonatomic) IBOutlet UILabel *goodsTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *colorLabel;
@property (weak, nonatomic) IBOutlet UILabel *versionsLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIView *countView;

- (void)setContent:(lwShopcartModel *)model;


@end
