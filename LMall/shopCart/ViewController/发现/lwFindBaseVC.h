//
//  lwFindBaseVC.h
//  shopCart
//
//  Created by lw on 16/4/21.
//  Copyright © 2016年 lw. All rights reserved.
//

#import <UIKit/UIKit.h>

@class lwFind_ListVC;

@class lwFind_MapVC;

@interface lwFindBaseVC : UIViewController

@property (retain, nonatomic) lwFind_ListVC *find_ListVC;

@property (retain, nonatomic) lwFind_MapVC *find_MapVC;


@end
