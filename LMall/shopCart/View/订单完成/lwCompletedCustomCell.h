//
//  lwCompletedCustomCell.h
//  shopCart
//
//  Created by 刘威 on 16/4/9.
//  Copyright © 2016年 lw. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "lwMall_OrderModel.h"

@protocol lwCompletedCustomCellDelegate <NSObject>

- (void)textFiledResult:(UITextField *)txt Model:(lwMall_ScoreModel *)model;

@end

@interface lwCompletedCustomCell : UITableViewCell

<
    UITextFieldDelegate
>

@property (assign, nonatomic) id<lwCompletedCustomCellDelegate>delegate;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitelLabel;
@property (weak, nonatomic) IBOutlet UISwitch *sth;
@property (weak, nonatomic) IBOutlet UITextField *inputFiled;

@property (retain, nonatomic) lwMall_OrderServiceModel *serviceModel;

@end
