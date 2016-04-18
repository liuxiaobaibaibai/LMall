//
//  lwHedaerCell.m
//  shopCart
//
//  Created by lw on 16/4/15.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "lwHedaerCell.h"

#define w self.frame.size.width
#define h self.frame.size.height

@implementation lwHedaerCell



- (void)setFlashArray:(NSArray *)flashArray{

    [_flashScrollView setContentSize:CGSizeMake(flashArray.count*_flashScrollView.frame.size.width, _flashScrollView.frame.size.height)];
    _flashScrollView.pagingEnabled = YES;
    
    for (int i = 0; i<flashArray.count; i++) {
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(_flashScrollView.frame.size.width*i, 0, _flashScrollView.frame.size.width, _flashScrollView.frame.size.height)];
        imgView.contentMode = UIViewContentModeScaleAspectFill;
        [imgView sd_setImageWithURL:[NSURL URLWithString:flashArray[i]]];
        [_flashScrollView addSubview:imgView];
    }
}



@end
