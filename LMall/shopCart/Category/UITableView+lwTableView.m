//
//  UITableView+lwTableView.m
//  sixApp
//
//  Created by lw on 16/1/12.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "UITableView+lwTableView.h"

@implementation UITableView (lwTableView)

- (void)hideKeyBoard:(BOOL)hidden{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
    [self addGestureRecognizer:tap];
}

- (void)hide{
//    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    [self.superview endEditing:YES];
}

@end
