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
    [self createdView];
}

- (void)createdView{
    NSArray *itemArray = @[@"标签二三四",@"比钱",@"标签四五六",@"撒大大",@"我爱",@"撒",@"我爱",@"标签二三四",@"比钱",@"标签四五六",@"撒大大",@"标签二三四",@"比钱",@"标签四五六",@"撒大大",@"我爱上的",@"撒大大",@"我爱",@"标签二三四",@"比钱",@"标签四五六",@"撒我搜到生到死的考试大咖",];
    
    __block UIButton *lastButton = nil;
    
    CGFloat sumWidth = 0;

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
        [self.view addSubview:button];
    
        sumWidth += [itemArray[i] computedSize:CGSizeMake(MAXFLOAT, 21) Font:[UIFont systemFontOfSize:14.0]].width+10;
        
        CGFloat nowWidth = [itemArray[i] computedSize:CGSizeMake(MAXFLOAT, 21) Font:[UIFont systemFontOfSize:14.0]].width+10;
        
        static int row = 1;
        static int lastRow = 1;
        static int itemCount;
        
        itemCount = i;

        
        NSLog(@"%d---->row:%d  lRow:%d  宽和：%.2f  当前宽：%.2f",i,row,lastRow,sumWidth,nowWidth);
        
        if (lW - (sumWidth+(marign*(itemCount + 1))) < nowWidth) {
            row++;
            itemCount = 0;
            sumWidth = 0;
        }else{
            itemCount++;
        }
        
        
        
        if (!lastButton) {
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(marign*row+labelHeight*row);
                make.left.mas_equalTo(marign);
                make.height.mas_equalTo(21);
                CGFloat width = [itemArray[i] computedSize:CGSizeMake(MAXFLOAT, 21) Font:[UIFont systemFontOfSize:14.0]].width + 10;
                make.width.mas_equalTo(width);
            }];
        }else{
            if (lastRow == row) {
                [button mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(lastButton.mas_right).offset(marign);
                    make.top.mas_equalTo(marign*row+labelHeight*row);
                    make.height.mas_equalTo(21);
                    CGFloat width = [itemArray[i] computedSize:CGSizeMake(MAXFLOAT, 21) Font:[UIFont systemFontOfSize:14.0]].width + 10;
                    make.width.mas_equalTo(width);
                }];
            }else{
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




@end
