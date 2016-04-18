//
//  lwHomeFooterView.m
//  shopCart
//
//  Created by lw on 16/4/14.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "lwHomeFooterView.h"

@implementation lwHomeFooterView

- (void)awakeFromNib {
    // Initialization code
}

- (void)setFooterArray:(NSMutableArray *)footerArray{
    _footerArray = footerArray;
    
    
    
    [__footerScrollview setContentSize:CGSizeMake(footerArray.count*(lW-2), __footerScrollview.frame.size.height)];
    __footerScrollview.pagingEnabled = YES;
    
    for (UIView *view in [__footerScrollview subviews]) {
        [view removeFromSuperview];
    }
    
    for (int i = 0; i<footerArray.count; i++) {
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake((lW-2)*i, 0, lW, __footerScrollview.frame.size.height)];
        imgView.contentMode = UIViewContentModeScaleToFill;
        [imgView sd_setImageWithURL:[NSURL URLWithString:footerArray[i][@"img"]]];
        [__footerScrollview addSubview:imgView];
    }
    
}

@end
