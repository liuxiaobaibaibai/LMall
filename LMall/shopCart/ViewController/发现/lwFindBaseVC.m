//
//  lwFindBaseVC.m
//  shopCart
//
//  Created by lw on 16/4/21.
//  Copyright © 2016年 lw. All rights reserved.
//

// VC
#import "lwFindBaseVC.h"
#import "lwFind_ListVC.h"
#import "lwFind_MapVC.h"

#define h self.view.frame.size.height
#define w self.view.frame.size.width

@interface lwFindBaseVC ()

@property (retain, nonatomic) UIViewController *currentVC;

@end

@implementation lwFindBaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initChildVC];
}


- (void)initChildVC{
    _find_ListVC = [[lwFind_ListVC alloc] init];
    _find_ListVC.view.frame = CGRectMake(0, 64, lW, h-108);
    [self.view addSubview:_find_ListVC.view];
    
    
    _find_MapVC = [[lwFind_MapVC alloc] init];
    _find_MapVC.view.frame = CGRectMake(0, 64, lW, h-108);
    [self.view addSubview:_find_MapVC.view];
    
    [self addChildViewController:_find_ListVC];
    [self addChildViewController:_find_MapVC];
    
    [self.view addSubview:_find_ListVC.tableView];
    self.currentVC = _find_ListVC;
}

- (IBAction)chanedVC:(id)sender {
    NSInteger index = [(UISegmentedControl *)sender selectedSegmentIndex];
    switch (index) {
        case 0:
        {
            [self replaceController:self.currentVC newController:self.find_ListVC];
        }
            break;
        case 1:
        {
            [self replaceController:self.currentVC newController:self.find_MapVC];
        }
        default:
            break;
    }
}

//  切换各个标签内容
- (void)replaceController:(UIViewController *)oldController newController:(UIViewController *)newController{
    /**
     *  着重介绍一下它
     *  transitionFromViewController:toViewController:duration:options:animations:completion:
     *  fromViewController      当前显示在父视图控制器中的子视图控制器
     *  toViewController        将要显示的姿势图控制器
     *  duration                动画时间(这个属性,old friend 了 O(∩_∩)O)
     *  options                 动画效果(渐变,从下往上等等,具体查看API)
     *  animations              转换过程中得动画
     *  completion              转换完成
     */
    [self addChildViewController:newController];
    [self transitionFromViewController:oldController toViewController:newController duration:0 options:UIViewAnimationOptionTransitionCrossDissolve animations:nil completion:^(BOOL finished) {
        if (finished) {
            [newController didMoveToParentViewController:self];
            [oldController willMoveToParentViewController:nil];
            [oldController removeFromParentViewController];
            self.currentVC = newController;
        }else{
            self.currentVC = oldController;
        }
    }];
}

@end
