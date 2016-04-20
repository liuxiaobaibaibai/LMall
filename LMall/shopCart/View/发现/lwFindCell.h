//
//  lwFindCell.h
//  shopCart
//
//  Created by lw on 16/4/20.
//  Copyright © 2016年 lw. All rights reserved.
//

#import <UIKit/UIKit.h>

@class lwFindModel;

@interface lwFindCell : UITableViewCell
{
    __weak IBOutlet UILabel *titleLabel;
    __weak IBOutlet UILabel *addressLabel;
    __weak IBOutlet UIImageView *logoImgView;
    __weak IBOutlet UIButton *distanceBtn;
    __weak IBOutlet UIButton *favroiteBtn;
    
    __weak IBOutlet UIButton *telBtn;
    __weak IBOutlet UIButton *navBtn;
    __weak IBOutlet UIButton *shopBtn;
}

@property (retain, nonatomic) id source;

@property (retain, nonatomic) lwFindModel *findModel;

@end
