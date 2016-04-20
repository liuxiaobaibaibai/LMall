//
//  lwFindCell.m
//  shopCart
//
//  Created by lw on 16/4/20.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "lwFindCell.h"
#import "lwFindVC.h"
#import "lwFindModel.h"

@implementation lwFindCell

- (void)awakeFromNib {
    [favroiteBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [telBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [navBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [shopBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)buttonClick:(UIButton *)btn{
    [(lwFindVC *)_source findCellButtonClick:btn Model:_findModel Completion:^(id result, BOOL success) {
        NSLog(@"完毕");
    }];
}

- (void)setFindModel:(lwFindModel *)findModel{
    _findModel = findModel;
    
    titleLabel.text = findModel.shopName;
    addressLabel.text = findModel.address;
    NSString *imgName = findModel.favorite ? @"star" : @"find_unfavorite";
    [favroiteBtn setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
    [distanceBtn setTitle:findModel.distance forState:UIControlStateNormal];
}

@end
