//
//  lwBaseVC.h
//  shopCart
//
//  Created by 刘威 on 16/4/9.
//  Copyright © 2016年 lw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface lwBaseVC : UIViewController

/**键盘处理的通知，放在基类里面处理*/
- (void)keyboardWillShow:(NSNotification *)noti;

@end
