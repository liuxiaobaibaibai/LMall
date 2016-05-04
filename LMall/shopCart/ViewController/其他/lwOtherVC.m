//
//  lwOtherVC.m
//  shopCart
//
//  Created by lw on 16/4/29.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "lwOtherVC.h"

#define marign 8
#define labelHeight 21
@interface lwOtherVC ()

@end

@implementation lwOtherVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    for (UIView *view in [self.view subviews]) {
        [view removeFromSuperview];
    }
    NSArray *itemArray = @[@"标",@"标签",@"标签七",@"标签二三",@"标签四五六",@"标一个萨比是",@"标签",@"标签七",@"标签二啥都会的三",@"标",@"标签",@"标签七",@"标签二三",@"标签四五六",@"标一个萨比是",@"标签",@"标签七",@"标签二啥都会的三",@"标",@"标签",@"标签七",@"标签二三",@"标签四五六",@"标一个萨比是",@"标签",@"标签七",@"标签二啥都会的三",@"标",@"标签",@"标签七",@"标签二三",@"标签四五六",@"标一个萨比是",@"标签",@"标签七",@"标签二啥都会的三",@"标",@"标签",@"标签七",@"标签二三",@"标签四五六",@"标一个萨比是",@"标签",@"标签七",@"标签二啥都会的三",@"标",@"标签",@"标签七",@"标签二三",@"标签四五六",@"标一个萨比是",@"标签",@"标签七",@"标签二啥都会的三",@"标",@"标签",@"标签七",@"标签二三",@"标签四五六",@"标一个萨比是",@"标签",@"标签七",@"标签二啥都会的三",@"标",@"标签",@"标签七",@"标签二三",@"标签四五六",@"标一个萨比是",@"标签",@"标签七",@"标签二啥都会的三",];
    
    [self createdView:itemArray];
}


- (void)createdView:(NSArray *)itemArray{
    UIButton *lastButton = nil;
    
    CGFloat sumWidth = 0.0;
    int itemCount = 0;
    int row = 1;
    int lastRow = 1;
    
    for (int i = 0; i<itemArray.count; i++) {
        UIButton *button = [[UIButton alloc] init];
        [button setTitle:itemArray[i] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:14.0];
        [button setTitleColor:[lwStyleTool colorInstance].JDColor forState:UIControlStateNormal];
        [button setTag:i];
        [button setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 5)];
        button.layer.borderColor = [UIColor lightGrayColor].CGColor;
        button.layer.borderWidth = 1.0;
        button.layer.cornerRadius = 5.0;
        button.layer.masksToBounds = YES;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    
        sumWidth += [itemArray[i] computedSize:CGSizeMake(MAXFLOAT, 21) Font:[UIFont systemFontOfSize:14.0]].width +10;
        
        CGFloat nowWidth = [itemArray[i] computedSize:CGSizeMake(MAXFLOAT, 21) Font:[UIFont systemFontOfSize:14.0]].width +10;
    
        if (lW - ((sumWidth - nowWidth)+(marign*(itemCount+1))) <= nowWidth) {
            // 不在同一行
            row++;
            itemCount = 1;
            sumWidth = nowWidth;
        }else{
            // 在同一行
            itemCount++;
        }
        
        if (!lastButton) {
            // 第一个按钮
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(marign*row+labelHeight*row);
                make.left.mas_equalTo(marign);
                make.height.mas_equalTo(21);
                CGFloat width = [itemArray[i] computedSize:CGSizeMake(MAXFLOAT, 21) Font:[UIFont systemFontOfSize:14.0]].width + 10;
                make.width.mas_equalTo(width);
            }];
        }else{
            // 后续按钮
            if (lastRow == row) {
                // 还在同一行
                [button mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(lastButton.mas_right).offset(marign);
                    make.top.mas_equalTo(marign*row+labelHeight*row);
                    make.height.mas_equalTo(21);
                    CGFloat width = [itemArray[i] computedSize:CGSizeMake(MAXFLOAT, 21) Font:[UIFont systemFontOfSize:14.0]].width + 10;
                    make.width.mas_equalTo(width);
                }];
            }else{
                // 换行后的
                lastRow ++ ;
                [button mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(marign);
                    make.top.mas_equalTo(marign*row+labelHeight*row);
                    make.height.mas_equalTo(21);
                    CGFloat width = [itemArray[i] computedSize:CGSizeMake(MAXFLOAT, 21) Font:[UIFont systemFontOfSize:14.0]].width + 10;
                    make.width.mas_equalTo(width);
                }];
            }
        }
        lastButton = button;
    }
}

- (void)buttonClick:(UIButton *)btn{
    NSLog(@"%@",btn.titleLabel.text);
}




@end
