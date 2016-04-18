//
//  lwHomeFooterView.h
//  shopCart
//
//  Created by lw on 16/4/14.
//  Copyright © 2016年 lw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface lwHomeFooterView : UICollectionReusableView
@property (weak, nonatomic) IBOutlet UIScrollView *_footerScrollview;

@property (retain, nonatomic) NSMutableArray *footerArray;

@end
