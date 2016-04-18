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

//CGFloat

@implementation lwHedaerCell

- (void)awakeFromNib{
    _flashScrollView.translatesAutoresizingMaskIntoConstraints = NO;
    
    for (UIButton *btn in _menuArray) {
        [btn addTarget:self action:@selector(headerCellButtonCLick:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)headerCellButtonCLick:(UIButton *)btn{
    NSLog(@"%@",btn.titleLabel.text);
}

- (void)setFlashArray:(NSArray *)flashArray{
    
    _flashArray = flashArray;
    
    [_flashScrollView setContentSize:CGSizeMake(flashArray.count*(lW-2), 115)];
    _flashScrollView.pagingEnabled = YES;

    
    for (int i = 0; i<flashArray.count; i++) {
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake((lW-2)*i, 0, (lW-2), 120)];
        imgView.contentMode = UIViewContentModeScaleAspectFill;
        [imgView sd_setImageWithURL:[NSURL URLWithString:flashArray[i]]];
        [_flashScrollView addSubview:imgView];
    }
}

- (void)setMenu:(NSMutableArray *)menu{
    _menu = menu;
    for (int i = 0; i<menu.count; i++) {
        UIButton *btn = (UIButton *)_menuArray[i];
        [btn setTitle:menu[i][@"name"] forState:UIControlStateNormal];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:menu[i][@"img"]]];
            UIImage *img = [UIImage imageWithData:data];
            if (img != nil) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [btn setImage:img forState:UIControlStateNormal];
                });
            }
        });
        
    }
}

@end
