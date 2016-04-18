//
//  lwHedaerCell.h
//  shopCart
//
//  Created by lw on 16/4/15.
//  Copyright © 2016年 lw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface lwHedaerCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIScrollView *flashScrollView;

/**按钮数组*/
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *menuArray;

/**幻灯片数组*/
@property (retain, nonatomic) NSArray *flashArray;

@property (retain, nonatomic) NSMutableArray *menu;
@end
