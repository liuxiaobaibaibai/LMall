//
//  lwFind_ListHeaderView.m
//  shopCart
//
//  Created by lw on 16/4/22.
//  Copyright © 2016年 lw. All rights reserved.
//

#define padding 0

#import "lwFind_ListHeaderView.h"


@implementation lwFind_ListHeaderView

{
    UIScrollView *myScrollView;
}

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = CGRectMake(0, 0, lW, lW/5);
        [self setupView];
    }
    return self;
}

- (void)setupView{
    myScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, lW, lW/5)];
    [self addSubview:myScrollView];
}

- (void)setMenuArray:(NSMutableArray *)menuArray{
    _menuArray = menuArray;
    
    int pageCount = 5;
    
    myScrollView.showsHorizontalScrollIndicator = NO;
    [myScrollView setContentSize:CGSizeMake(lW*(menuArray.count/pageCount), lW/5)];
    myScrollView.pagingEnabled = YES;
    
    UIButton *lastButton = nil;
    
    for (int i = 0; i<menuArray.count; i++) {
        UIButton *btn = [[UIButton alloc] init];
        [btn setTitle:[NSString stringWithFormat:@"按钮%d",i] forState:UIControlStateNormal];
        [btn setBackgroundColor:RGB(arc4random()%255, arc4random()%255, arc4random()%255)];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(categoryButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [myScrollView addSubview:btn];
        
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            if (!lastButton) {
                make.left.mas_equalTo(padding);
            }else{
                make.left.mas_equalTo(lastButton.mas_right).with.offset(padding);
            }
            make.top.mas_equalTo(padding);
            make.width.mas_equalTo(lW/pageCount);
            make.height.mas_equalTo(lW/pageCount);
        }];
        lastButton = btn;
    }

    /*
    int page = (int)menuArray.count/10;
    int pageCount = 10;
    int row = 2;
    [myScrollView setContentSize:CGSizeMake(lW*page, 150)];
    myScrollView.pagingEnabled = YES;
    
    
    CGFloat w = lW/5;
    CGFloat h = self.frame.size.height/row;
    
    for (int i = 0; i<menuArray.count; i++) {
        
        if (i<menuArray.count/row) {
            UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(i*w, 0, lW/5, h)];
            [btn setTitle:[NSString stringWithFormat:@"按钮%d",i] forState:UIControlStateNormal];
            [btn setBackgroundColor:RGB(arc4random()%255, arc4random()%255, arc4random()%255)];
            [btn setTitleColor:[lwStyleTool colorInstance].JDColor forState:UIControlStateNormal];
            [btn.layer setBorderWidth:1.0];
            [btn.layer setBorderColor:[UIColor whiteColor].CGColor];
            [btn addTarget:self action:@selector(categoryButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            [myScrollView addSubview:btn];
        }else if(i+1>page*pageCount){
            NSLog(@"超过了%d   %d",i,page*pageCount);
        }else{
            UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake((i-(menuArray.count/row))*w, h, lW/5, h)];
            [btn setTitle:@"按钮" forState:UIControlStateNormal];
            [btn setTitle:[NSString stringWithFormat:@"按钮%d",i] forState:UIControlStateNormal];
            [btn setBackgroundColor:RGB(arc4random()%255, arc4random()%255, arc4random()%255)];
            [btn setTitleColor:[lwStyleTool colorInstance].JDColor forState:UIControlStateNormal];
            [btn.layer setBorderWidth:1.0];
            [btn.layer setBorderColor:[UIColor whiteColor].CGColor];
            [btn addTarget:self action:@selector(categoryButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            [myScrollView addSubview:btn];
        }
    }
    */
    
    /*
    int pageCount = 10;
    int pageRow = 2;
    double page = menuArray.count%pageCount == 0 ? menuArray.count/pageCount : (menuArray.count/pageCount)+1;
    
    NSLog(@"%.0f",page);
    
    myScrollView.showsHorizontalScrollIndicator = NO;
    [myScrollView setContentSize:CGSizeMake(lW*page, 150)];
    myScrollView.pagingEnabled = YES;
    
    UIButton *lastButton = nil;
    
    for (int i = 0; i<menuArray.count; i++) {
        UIButton *btn = [[UIButton alloc] init];
        [btn setTitle:[NSString stringWithFormat:@"按钮%d",i] forState:UIControlStateNormal];
        [btn setBackgroundColor:RGB(arc4random()%255, arc4random()%255, arc4random()%255)];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(categoryButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [myScrollView addSubview:btn];
        
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            if (!lastButton) {
                make.left.mas_equalTo(padding);
                make.top.mas_equalTo(padding);
            }else{
                if (i<pageCount) {
                    make.left.mas_equalTo(lastButton.mas_right).with.offset(padding);
                }else if (i == pageCount) {
                    make.left.mas_equalTo(padding);
                    make.top.mas_equalTo(lW/(pageCount/pageRow));
                }else{
                    make.left.mas_equalTo(lastButton.mas_right).with.offset(padding);
                    make.top.mas_equalTo(lW/(pageCount/pageRow));
                }
            }
            make.width.mas_equalTo(lW/(pageCount/pageRow));
            make.height.mas_equalTo(lW/(pageCount/pageRow));
        }];
        lastButton = btn;
    }
     */
}


- (void)categoryButtonClick:(UIButton *)btn{
    NSLog(@"%@",btn.titleLabel.text);
}


@end
