//
//  lwBaseVC.m
//  shopCart
//
//  Created by 刘威 on 16/4/9.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "lwBaseVC.h"

@interface lwBaseVC ()

<
    MBProgressHUDDelegate
>

{
    MBProgressHUD *HUD;
}


@end

@implementation lwBaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)showToast:(NSString *)msg{
    dispatch_async(dispatch_get_main_queue(), ^{
        HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
        [[[UIApplication sharedApplication] keyWindow] addSubview:HUD];
        HUD.mode = MBProgressHUDModeCustomView;
        
        HUD.delegate = self;
        HUD.labelText = msg;
        
        [HUD show:YES];
        [HUD hide:YES afterDelay:1.5];
    });
}

- (void)dealloc{
    [self removeHUD];
}

- (void)hudWasHidden:(MBProgressHUD *)hud {
    // Remove HUD from screen when the HUD was hidded
    [hud removeFromSuperview];
    hud = nil;
}

- (void)removeHUD{
    [HUD removeFromSuperview];
}



@end
