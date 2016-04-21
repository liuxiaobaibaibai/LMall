//
//  lwSelectCell.m
//  shopCart
//
//  Created by lw on 16/4/21.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "lwSelectCell.h"
#import "lwSelectWindow.h"

@implementation lwSelectCell
{
    UIScrollView *myScrollView;
    NSMutableArray *_interestArray;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _interestArray = [NSMutableArray new];
        [self viewView:nil];
    }
    return self;
}

- (void)setLabelArray:(NSMutableArray *)labelArray{
    _labelArray = labelArray;
    [self viewView:labelArray];
}

//第一种方法
- (void)viewView:(NSArray *)titleArr{
    UIView *view = [[UIView alloc]initWithFrame:self.bounds];
    view.backgroundColor = [UIColor clearColor];
    int width = 0;
    int height = 0;
    int column = 0;
    int row = 0;
    
    //创建button
    for (int i = 0; i < titleArr.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = i;
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        CGSize titleSize = [self getSizeByString:titleArr[i] AndFontSize:16];
        row = row +titleSize.width;
        if (row > [[UIScreen mainScreen]bounds].size.width) {
            row = 0;
            row = row + titleSize.width;
            height++;
            width = 0;
            width = width+titleSize.width;
            column = 0;
            button.frame = CGRectMake(8, 8 +38*height, titleSize.width, 30);
        }else{
            button.frame = CGRectMake(width+8+(column*8), 8 +38*height, titleSize.width, 30);
            width = width+titleSize.width;
        }
        column++;
        button.layer.masksToBounds = YES;
        button.layer.cornerRadius = 10.0f;
        button.backgroundColor = [UIColor lightGrayColor];
        button.titleLabel.font = [UIFont systemFontOfSize:16];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button setTitle:titleArr[i] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(rowdleButton:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:button];
        [_interestArray addObject:button];
    }
    [self addSubview:view];
    
}

- (void)rowdleButton:(UIButton *)button{

    [(lwSelectWindow *)_lwSelectWindow updateInfo:button.titleLabel.text Sign:_sign];
    
    button.selected = !button.selected;
    [button setBackgroundColor:[UIColor redColor]];
    for (int i = 0; i<_interestArray.count; i++) {
        UIButton *btn = _interestArray[i];
        if (btn.tag != button.tag) {
            [btn setBackgroundColor:[UIColor lightGrayColor]];
        }
    }
}


//计算文字所占大小
- (CGSize)getSizeByString:(NSString*)string AndFontSize:(CGFloat)font
{
    CGSize size = [string boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil].size;
    size.width = size.width < 30 ? 30 :size.width;
    size.width += 5;
    return size;
}

@end
