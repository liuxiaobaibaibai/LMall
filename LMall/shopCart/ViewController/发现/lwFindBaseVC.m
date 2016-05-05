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

#import "lwSearchVC.h"

#define h self.view.frame.size.height
#define w self.view.frame.size.width

@interface lwFindBaseVC ()

@property (retain, nonatomic) UIViewController *currentVC;

@end

@implementation lwFindBaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]
                                  initWithImage:[UIImage imageNamed:@"find_Menu_Search"]
                                          style:UIBarButtonItemStylePlain
                                         target:self
                                         action:@selector(barItemClick:)];
    
    UIButton *leftItem = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
    [leftItem setTitle:@"北塘区" forState:UIControlStateNormal];
    [leftItem setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [leftItem setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    [leftItem setContentHorizontalAlignment:UIControlContentHorizontalAlignmentFill];
    [leftItem setImageEdgeInsets:UIEdgeInsetsMake(0, 70, 0, 0)];
    [leftItem.titleLabel setFont:[UIFont systemFontOfSize:16.0]];
    
    [leftItem addTarget:self
                 action:@selector(leftItemClick:)
       forControlEvents:UIControlEventTouchUpInside];
    
    [leftItem setImage:[UIImage imageNamed:@"btn_feedCell_unFold"] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = rightItem;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftItem];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self initChildVC];
}


- (void)initChildVC{
    _find_ListVC = [[lwFind_ListVC alloc] init];
    _find_ListVC.view.frame = CGRectMake(0, 64, lW, h-108);
    [self.view addSubview:_find_ListVC.view];

    _find_MapVC = [[lwFind_MapVC alloc] init];
    _find_MapVC.view.frame = CGRectMake(0, 64, lW, h-108);

    [self addChildViewController:_find_ListVC];
    
    [self.view addSubview:_find_ListVC.tableView];
    self.currentVC = _find_ListVC;
}

- (void)leftItemClick:(UIButton *)button{
    if (button.selected) {
        [button setImage:[UIImage imageNamed:@"btn_feedCell_unFold"] forState:UIControlStateNormal];
        button.selected = NO;
    }else{
        [button setImage:[UIImage imageNamed:@"btn_feedCell_Fold"] forState:UIControlStateNormal];
        button.selected = YES;
    }
}

- (void)barItemClick:(UIBarButtonItem *)barItem{
    UIStoryboard *main = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    lwSearchVC *searchVC = [main instantiateViewControllerWithIdentifier:@"searchVC"];
    searchVC.searchStr = @"聚赢宝云商城";
    [self presentViewController:searchVC animated:NO completion:nil];
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
