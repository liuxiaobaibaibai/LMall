//
//  lwSelectCell.h
//  shopCart
//
//  Created by lw on 16/4/21.
//  Copyright © 2016年 lw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface lwSelectCell : UITableViewCell

@property (retain, nonatomic) NSMutableArray *labelArray;

@property (assign, nonatomic) id lwSelectWindow;

@property (copy, nonatomic) NSString *sign;

@property (assign, nonatomic) NSInteger cellTag;

@property (copy, nonatomic) NSString *price;

@property (copy, nonatomic) NSString *KC;


@end
