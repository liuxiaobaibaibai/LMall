//
//  lwSelectCell.m
//  shopCart
//
//  Created by lw on 16/4/21.
//  Copyright © 2016年 lw. All rights reserved.
//
#define BTN_HEIGHT 21
#define padding 8

#define SCREEN_W           [UIScreen mainScreen].bounds.size.width

#import "lwSelectCell.h"
#import "lwSelectWindow.h"

@implementation lwSelectCell
{
    NSMutableArray *_interestArray;
    NSMutableArray *_btnArray;
    NSInteger tagRow;
    UIButton *button;
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
    [self removeConstraints:[self constraints]];
    _labelArray = labelArray;
    
    [self viewView:labelArray];
}

- (void)CreateBtnUI:(NSInteger)tag{    
    button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.tag = tag;
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = 7.0f;
    button.backgroundColor = [UIColor lightGrayColor];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitle:_labelArray[tag] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(rowdleButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:button];
    [_interestArray addObject:button];
    [_btnArray addObject:button];
}

//第一种方法
- (void)viewView:(NSArray *)titleArr{
    
    _btnArray =[NSMutableArray new];
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

- (void)BeginBtnUpdateConstraint:(UIButton *)nowBtn{
    // 根据title 动态设置btn width 当title改变 width改变
    tagRow =0;
    
    [nowBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(padding);
        make.left.mas_equalTo(padding);
        make.right.mas_lessThanOrEqualTo(-padding);
        make.height.mas_greaterThanOrEqualTo(BTN_HEIGHT);
        
    }];
    if ([_btnArray count]==1) {
        [nowBtn mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(-padding);
        }];
    }
}

- (void)OtherBtnUpdateConstraint:(UIButton *)nowBtn last:(UIButton *)lastBtn{
    
    CGFloat lastMaxX =[self RowText:nowBtn];
    
    CGFloat MaxX =[self getSizeByString:[nowBtn titleForState:UIControlStateNormal] AndFontSize:16].width;
    
    if (!(SCREEN_W -lastMaxX >=(padding+ MaxX +padding))) { //如果不满足两个Button 放同一行
        tagRow =nowBtn.tag;
        [nowBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(lastBtn.mas_bottom).with.offset(padding);
            make.left.mas_equalTo(padding);
            make.right.mas_lessThanOrEqualTo(-padding);
            make.height.mas_greaterThanOrEqualTo(BTN_HEIGHT);
        }];
    }
    else
    {
        
        [nowBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(lastBtn.mas_top);
            make.left.mas_equalTo(lastMaxX +padding);
            make.right.mas_lessThanOrEqualTo(-padding);
            make.height.mas_greaterThanOrEqualTo(BTN_HEIGHT);
        }];
    }
    
    if(nowBtn.tag ==[_btnArray count]-1){//最后一个Button
        
        [nowBtn mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(-padding);
        }];
    }
}

- (CGFloat)RowText:(UIButton *)nowBtn{
    CGFloat row =0.0;
    
    for(NSInteger i =tagRow ;i<nowBtn.tag;i++){
        
        UIButton * lastBtn =[_btnArray objectAtIndex:i];
        
        row +=padding +[self getSizeByString:[lastBtn titleForState:UIControlStateNormal] AndFontSize:16].width;
    }
    return row;
}

- (void)rowdleButton:(UIButton *)rowdleBtn{
    
    [(lwSelectWindow *)_lwSelectWindow updateInfo:rowdleBtn.titleLabel.text Sign:_sign];
    
    rowdleBtn.selected = !rowdleBtn.selected;
    [rowdleBtn setBackgroundColor:[UIColor redColor]];
    for (int i = 0; i<_interestArray.count; i++) {
        UIButton *btn = _interestArray[i];
        if (btn.tag != rowdleBtn.tag) {
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
