//
//  lwSortHeaderView.m
//  shopCart
//
//  Created by lw on 16/4/22.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "lwSortHeaderView.h"

@implementation lwSortHeaderView
{
    UIButton *btn;
}

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = CGRectMake(0, 0, lW, 30);
        self.backgroundColor = [UIColor lightGrayColor];
    }
    return self;
}

- (void)setupView:(NSMutableArray *)dataArray{
    for (int i = 0; i<dataArray.count; i++) {
        btn = [[UIButton alloc] initWithFrame:CGRectMake(i*(lW/3), 0, lW/3-1, 30)];
        [btn setTitle:[NSString stringWithFormat:@"   %@",dataArray[i]] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setBackgroundColor:[UIColor whiteColor]];
        [btn setImage:[UIImage imageNamed:@"btn_feedCell_unFold"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(sortBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
    }
}

- (void)setDataArray:(NSMutableArray *)dataArray{
    _dataArray = dataArray;
    [self setupView:dataArray];
}

- (void)sortBtnClick:(UIButton *)button{
    if (button.selected) {
        [button setImage:[UIImage imageNamed:@"btn_feedCell_unFold"] forState:UIControlStateNormal];
        button.selected = NO;
    }else{
        [button setImage:[UIImage imageNamed:@"btn_feedCell_Fold"] forState:UIControlStateNormal];
        button.selected = YES;
    }
}

@end
