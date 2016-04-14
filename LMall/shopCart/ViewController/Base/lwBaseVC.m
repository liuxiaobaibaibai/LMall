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
    UIKeyboardViewControllerDelegate
>

{
    UIKeyboardViewController *keyBoard;
    UIToolbar *toolView;
}

@end

@implementation lwBaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)keyboardWillShow:(NSNotification *)noti{
    NSDictionary *userInfo = noti.userInfo;
    CGFloat duration = [userInfo[@"UIKeyboardAnimationDurationUserInfoKey"] doubleValue];
    
    CGRect keyFrame = [userInfo[@"UIKeyboardFrameEndUserInfoKey"] CGRectValue];
    CGFloat moveY = keyFrame.origin.y - self.view.frame.size.height;
    
    if (![[self.view subviews] containsObject:toolView]) {
        toolView = [[UIToolbar alloc] initWithFrame:CGRectMake(0, lH-50, lW, 50)];
        toolView.backgroundColor = [UIColor whiteColor];
        
        UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(barButtonItemClick:)];
        cancelItem.tag = 10;
        
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
        
        UITextField *txtFiled = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
        txtFiled.borderStyle = UITextBorderStyleRoundedRect;
        UIBarButtonItem *txtItem = [[UIBarButtonItem alloc] initWithCustomView:txtFiled];
        txtItem.tag = 30;
        [txtFiled becomeFirstResponder];
        
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
        
        UIBarButtonItem *confirmItem = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(barButtonItemClick:)];
        confirmItem.tag = 20;
        
        [toolView setItems:@[cancelItem,leftItem,txtItem,rightItem,confirmItem]];
        [self.view addSubview:toolView];
    }
    
    
    [UIView animateWithDuration:duration animations:^{
        toolView.transform = CGAffineTransformMakeTranslation(0, moveY);
        [self.view bringSubviewToFront:toolView];
    }];
}

- (void)barButtonItemClick:(UIBarButtonItem *)item{
    switch (item.tag) {
        case 10:
        {
            
        }
            break;
        case 20:
        {
            // 将值传出去
            
        }
            break;
            
        default:
            break;
    }
    [self.view endEditing:YES];

}

@end
