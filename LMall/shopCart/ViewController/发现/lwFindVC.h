//
//  lwFindVC.h
//  shopCart
//
//  Created by lw on 16/4/20.
//  Copyright © 2016年 lw. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^userOperatonBlock)(id result, BOOL success);

@class lwFindModel;

@interface lwFindVC : UITableViewController




- (void)findCellButtonClick:(UIButton *)btn Model:(lwFindModel *)model Completion:(userOperatonBlock)completion;

@end
