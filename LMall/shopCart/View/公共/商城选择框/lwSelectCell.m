//
//  lwSelectCell.m
//  shopCart
//
//  Created by lw on 16/4/21.
//  Copyright © 2016年 lw. All rights reserved.
//
#define BTN_HEIGHT 40
#define padding 8

#import "lwSelectCell.h"
#import "lwSelectWindow.h"
@implementation lwSelectCell
{
    UIScrollView *myScrollView;
    NSMutableArray *_interestArray;
    NSMutableArray *_btnArray;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _interestArray = [NSMutableArray new];
        _btnArray =[NSMutableArray new];
        [self viewView:nil];
    }
    return self;
}

- (void)setLabelArray:(NSMutableArray *)labelArray{
    _labelArray = labelArray;
    [self viewView:labelArray];
}

- (void)CreateBtnUI:(NSInteger)tag{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.tag = tag;
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = 10.0f;
    button.backgroundColor = [UIColor lightGrayColor];
    button.titleLabel.font = [UIFont systemFontOfSize:16];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitle:_labelArray[tag] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(rowdleButton:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
    [_btnArray addObject:button];
}

//第一种方法
- (void)viewView:(NSArray *)titleArr{
    for (int i = 0; i < titleArr.count; i++) {
        [self CreateBtnUI:i];
    }
    
    [self ButtonUpdateConstraints];
}

- (void)ButtonUpdateConstraints{
    
    for(int i =0;i <[_btnArray count];i++) {
        
        UIButton * nowBtn =[_btnArray objectAtIndex:i];
        if (i== 0) {//第一个Button
            [self BeginBtnUpdateConstraint:nowBtn];
        }
        else
        {
            UIButton * lastBtn =[_btnArray objectAtIndex:i-1];
            
            [self OtherBtnUpdateConstraint:nowBtn last:lastBtn];
        }
        
    }
}

- (void)BeginBtnUpdateConstraint:(UIButton *)Btn{
    // 根据title 动态设置btn width 当title改变 width改变
    [Btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(padding);
        make.left.mas_equalTo(padding);
        make.right.mas_lessThanOrEqualTo(-padding);
        make.height.mas_equalTo(BTN_HEIGHT);
    }];
    [self layoutIfNeeded];
}

- (void)OtherBtnUpdateConstraint:(UIButton *)nowBtn last:(UIButton *)lastBtn{
    
    [nowBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(padding);
        make.left.mas_equalTo(padding);
        make.right.mas_lessThanOrEqualTo(-padding);
        make.height.mas_equalTo(BTN_HEIGHT);
    }];
    [self layoutIfNeeded];
    
    CGFloat lastMaxX =CGRectGetMaxX(lastBtn.frame);
    CGFloat MaxX=CGRectGetMaxX(nowBtn.frame);
    
    if (!(lW -lastMaxX >=(MaxX +padding))) { //如果不满足两个Button 放同一行
        
        [nowBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(lastBtn.mas_bottom).with.offset(padding);
            make.left.mas_equalTo(padding);
            make.right.mas_lessThanOrEqualTo(-padding);
            make.height.mas_equalTo(BTN_HEIGHT);
        }];
    }
    else
    {
        
        [nowBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(lastBtn.mas_top);
            make.left.mas_equalTo(lastBtn.mas_right).with.offset(padding);
            make.right.mas_lessThanOrEqualTo(-padding);
            make.height.mas_equalTo(BTN_HEIGHT);
        }];
    }
    
    if(nowBtn.tag ==[_btnArray count]){//最后一个Button
        
        [nowBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(-padding);
        }];
    }
    [self layoutIfNeeded];
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
