//
//  lwPersonalFooterView.m
//  livePlayer
//
//  Created by 刘威 on 16/2/25.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "lwPersonalFooterView.h"
#define RGB(r,g,b) RGBA(r,g,b,1.0)

@implementation lwPersonalFooterView

{
    UIScrollView *myScrollView;
}

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupBtnView];
    }
    return self;
}

- (void)setupBtnView{
    for (int i = 0; i<3; i++) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(i*(lW/3), 0, lW/3, 30)];
        [btn setTitle:[NSString stringWithFormat:@"按钮%d",i] forState:UIControlStateNormal];
        [btn setBackgroundColor:RGB(239, 42, 47)];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTag:i];
        
        if (btn.tag == 0) {
            [btn setBackgroundColor:[UIColor lightGrayColor]];
        }
        
        [self addSubview:btn];
    }
}

- (void)btnClick:(UIButton *)btn{
    
    for (UIView *btn1 in [self subviews]) {
        
        if ([btn1 isKindOfClass:[UIButton class]]) {
            if (btn1.tag == btn.tag) {
                [btn1 setBackgroundColor:[UIColor lightGrayColor]];
            }else{
                [btn1 setBackgroundColor:RGB(239, 42, 47)];
            }
        }
    }
    
    [self jumpToPage:btn.tag];
}

- (void)jumpToPage:(NSInteger)pageIndex{
    
    if (pageIndex>_dataArray.count) {
        pageIndex = _dataArray.count;
    }
    
    [myScrollView scrollRectToVisible:CGRectMake(pageIndex*lW, 0, lW, self.frame.size.height) animated:NO];
}

- (void)jumpToSpecified:(NSString *)imgUrlPath{
    for (UIImageView *imgView in [myScrollView subviews]) {
        if (imgView.tag == 0) {
            // 第一个
        }
    }
}


/**
 *  设置猜你喜欢
 *  @param  array   商品数组
 */
- (void)setup:(NSMutableArray *)array{
    
    if (array.count == 0) {
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:self.frame];
        imgView.contentMode = UIViewContentModeScaleAspectFit;
        imgView.image = [UIImage imageNamed:@"noOrder"];
        [self addSubview:imgView];
        return;
    }
    
    myScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 30, lW, self.frame.size.height)];
    myScrollView.delegate = self;
    myScrollView.contentSize = CGSizeMake(lW*array.count, self.frame.size.height-30);
    myScrollView.pagingEnabled = YES;
    myScrollView.userInteractionEnabled = NO;
    
    for (int i = 0 ; i<array.count; i++) {
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(lW*i,30, lW, self.frame.size.height-30)];
        [imgView sd_setImageWithURL:[NSURL URLWithString:array[i]]];
        imgView.tag = i;
        [myScrollView addSubview:imgView];
    }
    
    [self addSubview:myScrollView];
}

- (void)setDataArray:(NSMutableArray *)dataArray{
    if (![_dataArray isEqualToArray:dataArray]) {
        _dataArray = dataArray;
        [self setup:dataArray];
    }
}


- (void)goodsClick:(UITapGestureRecognizer *)tap{
    NSLog(@"点击了第：%ld个",tap.view.tag+1);
}


@end
