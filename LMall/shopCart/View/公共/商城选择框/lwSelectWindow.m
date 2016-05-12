//
//  lwSelectNormView.m
//  shopCart
//
//  Created by lw on 16/4/15.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "lwSelectWindow.h"
#import "lwCommodityNormModel.h"
#import "lwCommodityDetailModel.h"
#import "lwSelectCell.h"

#import "lwStepper.h"
#import "UITableView+lwTableView.h"


#define padding 8
#define txtWidth 80
#define txtHeight 30

@implementation lwSelectWindow
{
    UIView *backGroundView;
    UIView *backView;
    UIView *otherView;
    UITableView *myTbaleView;
    UIView *headerView;
    UIButton *bottomBtn;
    UIImageView *headerImgView;
    UIButton *closeButton;
    UILabel *priceLabel;
    UILabel *inventoryLabel;
    UILabel *normLabel;
    UIView *lineView;
    
    UIKeyboardViewController *keyBoard;
    
    /**控制数量加减*/
    UITextField *numberTextFiled;
    /**积分输入框*/
    UITextField *scoreTextFiled;
    
}

- (id)initWithFrame:(CGRect)frame Delegate:(id)delegate{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = CGRectMake(0, 0, lW, lH);
        self.windowLevel = UIWindowLevelAlert + 1;
        self.delegate = delegate;
        [self setupView];
        
    }
    
    return self;
}

- (void) removeNotification{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)dealloc{
    [self removeNotification];
}

- (void)addNotification{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardNotification:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)keyboardNotification:(NSNotification *)noti{
    NSDictionary *userInfo = noti.userInfo;
    
    NSTimeInterval duration = [userInfo[@"UIKeyboardAnimationDurationUserInfoKey"] doubleValue];
    
    CGRect rect = [userInfo[@"UIKeyboardFrameEndUserInfoKey"] CGRectValue];
    
    [UIView animateWithDuration:duration animations:^{
        backView.transform = CGAffineTransformMakeTranslation(0, rect.origin.y-lH);
    }];
    
}


- (void)calculate:(NSMutableArray *)arr{
    
}

- (void)showInView:(UIView *)aView{
    [self addNotification];
    [self makeKeyWindow];
    [self makeKeyAndVisible];
    backView.frame = CGRectMake(0, lH, lW, lH);
    [UIView animateWithDuration:0.3 animations:^{
        backView.frame = CGRectMake(0, 0, lW, lH);
    }completion:^(BOOL finished) {
        
    }];
}



- (CGSize)getSizeByString:(NSString*)string AndFontSize:(CGFloat)font
{
    CGSize size = [string boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil].size;
    size.width += 5;
    return size;
}


- (void)setupView{
    // 背景图
    backGroundView = [[UIView alloc] init];
    backGroundView.backgroundColor = [UIColor blackColor];
    backGroundView.alpha = 0.5;
    [self addSubview:backGroundView];
    
    backView = [[UIView alloc] init];
    backView.backgroundColor = [UIColor clearColor];
    [self addSubview:backView];
    
    otherView = [[UIView alloc] init];
    otherView.backgroundColor = [UIColor clearColor];
    UITapGestureRecognizer *bTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
    [otherView addGestureRecognizer:bTap];
    [backView addSubview:otherView];
    
    // 头部视图
    headerView = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor whiteColor];
    UITapGestureRecognizer *Tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
    headerView.tag = 10;
    [headerView addGestureRecognizer:Tap];
    [backView addSubview:headerView];
    
    // 头部图片
    headerImgView = [[UIImageView alloc] init];
    headerImgView.image = [UIImage imageNamed:@"commodity_Test"];
    headerImgView.layer.borderColor = [UIColor whiteColor].CGColor;
    headerImgView.layer.borderWidth = 2.0;
    headerImgView.layer.cornerRadius = 5.0;
    self.layer.masksToBounds = YES;
    headerImgView.clipsToBounds = YES;
    [backView addSubview:headerImgView];
    
    // 关闭按钮
    closeButton = [[UIButton alloc] init];
    [closeButton setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    [headerView addSubview:closeButton];
    [closeButton addTarget:self action:@selector(selectWindowButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    // 价格标签
    priceLabel = [[UILabel alloc] init];
    priceLabel.text = @"￥59";
    priceLabel.font = [UIFont systemFontOfSize:14.0];
    priceLabel.textColor = [lwStyleTool colorInstance].JDColor;
    [headerView addSubview:priceLabel];
    
    // 库存标签
    inventoryLabel = [[UILabel alloc] init];
    inventoryLabel.text = @"库存594128件";
    inventoryLabel.font = [UIFont systemFontOfSize:14.0];
    inventoryLabel.textColor = [UIColor blackColor];
    [headerView addSubview:inventoryLabel];
    
    // 规格标签
    normLabel = [[UILabel alloc] init];
    normLabel.text = @"选择规格";
    normLabel.font = [UIFont systemFontOfSize:14.0];
    normLabel.textColor = [lwStyleTool colorInstance].DZColor;
    [headerView addSubview:normLabel];
    
    lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [headerView addSubview:lineView];
    
    // 列表视图
    myTbaleView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    myTbaleView.delegate = self;
    myTbaleView.dataSource = self;
    [myTbaleView hideKeyBoard:YES];
    myTbaleView.estimatedRowHeight = 44.0f;
    myTbaleView.rowHeight = UITableViewAutomaticDimension;
    myTbaleView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [myTbaleView setTableFooterView:[self tableFooterView]];
    [backView addSubview:myTbaleView];

    
    // 底部按钮
    bottomBtn = [[UIButton alloc] init];
    [bottomBtn setTitle:@"确定" forState:UIControlStateNormal];
    [bottomBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [bottomBtn setBackgroundColor:[lwStyleTool colorInstance].JDColor];
    [backView addSubview:bottomBtn];
    [bottomBtn addTarget:self action:@selector(selectWindowButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    
    [otherView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(headerView.mas_top).with.offset(0);
    }];
    
    [backGroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.bottom.mas_equalTo(myTbaleView.mas_top).with.offset(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(110);
    }];
    
    [headerImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(padding);
        make.top.mas_equalTo(headerView.mas_top).with.offset(-padding*2);
        make.right.mas_equalTo(priceLabel.mas_left).with.offset(-padding);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(100);
    }];
    
    [closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(headerView.mas_top).with.offset(padding);
        make.left.mas_equalTo(priceLabel.mas_right).with.offset(padding);
        make.right.mas_equalTo(headerView.mas_right).with.offset(-padding);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(30);
    }];
    
    [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(headerImgView.mas_right).with.offset(padding);
        make.right.mas_equalTo(closeButton.mas_left).with.offset(-padding);
        make.top.mas_equalTo(headerView.mas_top).with.offset(padding*3);
        make.bottom.mas_equalTo(inventoryLabel.mas_top).with.offset(-padding);
    }];
    
    [inventoryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(headerImgView.mas_right).with.offset(padding);
        make.right.mas_equalTo(closeButton.mas_left).with.offset(-padding);
        make.top.mas_equalTo(priceLabel.mas_bottom).with.offset(padding);
        make.bottom.mas_equalTo(normLabel.mas_top).with.offset(-padding);
        make.height.mas_equalTo(priceLabel.mas_height);
    }];
    
    [normLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(headerImgView.mas_right).with.offset(padding);
        make.right.mas_equalTo(closeButton.mas_left).with.offset(-padding);
        make.top.mas_equalTo(inventoryLabel.mas_bottom).with.offset(padding);
        make.height.mas_equalTo(priceLabel.mas_height);
    }];
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(headerView.mas_left).with.offset(padding);
        make.bottom.mas_equalTo(headerView.mas_bottom).with.offset(0);
        make.height.mas_equalTo(1);
        make.right.mas_equalTo(headerView.mas_right).with.offset(-padding);
    }];
    
    [myTbaleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(headerView.mas_bottom).with.offset(0);
        make.bottom.mas_equalTo(bottomBtn.mas_top).with.offset(0);
        make.width.mas_equalTo(lW);
        make.height.mas_equalTo(250);
    }];
    
    [bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(myTbaleView.mas_bottom).with.offset(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(50);
    }];
}

- (UIView *)tableFooterView{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, lW, 100)];
    
    UILabel *scoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(padding, padding, lW-padding*3-txtWidth, txtHeight)];
    scoreLabel.text = @"可用97412快消品分抵￥97412.00";
    scoreLabel.font = [UIFont systemFontOfSize:12.0];
    [footerView addSubview:scoreLabel];
    
    UILabel *numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(padding, txtHeight+padding*2, lW-txtWidth-padding*3, txtHeight)];
    numberLabel.text = @"数量";
    numberLabel.font = [UIFont systemFontOfSize:12.0];
    [footerView addSubview:numberLabel];
    
    scoreTextFiled = [[UITextField alloc] initWithFrame:CGRectMake(lW-txtWidth-padding, padding, txtWidth, txtHeight)];
    scoreTextFiled.placeholder = @"抵扣积分";
    scoreTextFiled.font = [UIFont systemFontOfSize:12.0];
    scoreTextFiled.textAlignment = NSTextAlignmentCenter;
    scoreTextFiled.borderStyle = UITextBorderStyleRoundedRect;
    scoreTextFiled.keyboardType = UIKeyboardTypeNumberPad;
    [footerView addSubview:scoreTextFiled];
    
    numberTextFiled = [[UITextField alloc] initWithFrame:CGRectMake(lW-txtWidth-padding, txtHeight+padding*2, txtWidth, 30)];
    numberTextFiled.text = @"1";
    numberTextFiled.keyboardType = UIKeyboardTypeNumberPad;
    numberTextFiled.font = [UIFont systemFontOfSize:12.0];
    numberTextFiled.textAlignment = NSTextAlignmentCenter;
    numberTextFiled.borderStyle = UITextBorderStyleRoundedRect;
    [footerView addSubview:numberTextFiled];
    
    return footerView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _titleArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section<_titleArray.count) {
        return _titleArray[section];
    }else{
        return @"";
    }
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    lwSelectCell *cell = [tableView dequeueReusableCellWithIdentifier:[lwEntity entitySingleton].CommoditySelectNormSelectCellID];

    if (!cell) {
        cell = [[lwSelectCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[lwEntity entitySingleton].CommoditySelectNormSelectCellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = myTbaleView.backgroundColor;
        cell.lwSelectWindow = self;
    }

    if (indexPath.section < _titleArray.count) {
        NSMutableDictionary *color = [NSMutableDictionary new];
        NSMutableDictionary *norm = [NSMutableDictionary new];
        for (lwCommodityNormModel *normModel in _normArray) {
            [color setObject:normModel.color forKey:normModel.color];
            [norm setObject:normModel.format forKey:normModel.format];
        }
        cell.cellTag = indexPath.section;
        NSArray *normsArray = @[[color allKeys],[norm allKeys]];
        [cell setLabelArray:normsArray[indexPath.section]];
        [cell setPrice:((lwCommodityNormModel *)_normArray[indexPath.row]).price];
        [cell setKC:((lwCommodityNormModel *)_normArray[indexPath.row]).num];
    }
    
    if (indexPath.section < _titleArray.count) {
        [cell setSign:_titleArray[indexPath.section]];
    }
    return cell;
}

static NSMutableArray *info;
static NSString *label;
/**
 *  选择规格，修改头部标签
 *
 */
- (void)updateInfo:(NSString *)param Price:(NSString *)price KC:(NSString *)kc Sign:(NSInteger)sign{
    [_titleArray replaceObjectAtIndex:sign withObject:param];
    NSString *norm = [NSString new];
    for (int i = 0; i<_titleArray.count; i++) {
        norm = [norm stringByAppendingString:[NSString stringWithFormat:@"【%@】",_titleArray[i]]];
    }
    
    normLabel.text = norm;
    inventoryLabel.text = [NSString stringWithFormat:@"库存：%@",kc];
    priceLabel.text = [NSString stringWithFormat:@"￥ %@",price];
}


- (void)setTitleArray:(NSMutableArray *)titleArray{
    _titleArray = titleArray;
    label = [titleArray firstObject];
}


- (void)setDetailModel:(lwCommodityDetailModel *)detailModel{
    priceLabel.text = [NSString stringWithFormat:@"￥ %@",detailModel.price];
    inventoryLabel.text = [NSString stringWithFormat:@"库存：%@",detailModel.num];
}


- (void)tapClick:(UITapGestureRecognizer *)tap{
    
    if (tap.view.tag == 10) {
        [self endEditing:YES];
    }else{
        if ([_delegate respondsToSelector:@selector(removeWindow)]) {
            [UIView animateWithDuration:0.3 animations:^{
                backView.frame = CGRectMake(0, lH, lW, lH);
            }completion:^(BOOL finished) {
                if (finished) {
                    [self hidden];
                }
            }];
        }
    }
}

- (void)selectWindowButtonClick:(UIButton *)btn{
    if ([_delegate respondsToSelector:@selector(removeWindow)]) {
        [UIView animateWithDuration:0.3 animations:^{
            backView.frame = CGRectMake(0, lH, lW, lH);
        }completion:^(BOOL finished) {
            if (finished) {
                [self hidden];
            }
        }];
    }
    
    NSString *price = [priceLabel.text stringByReplacingOccurrencesOfString:@"￥" withString:@""];
    NSString *inventory = [inventoryLabel.text stringByReplacingOccurrencesOfString:@"库存：" withString:@""];
//    NSString *norm = [NSString new];
    for (int i = 0; i<_normModelArray.count; i++) {
        lwCommodityNormModel *model = _normModelArray[i];
        if ([[info firstObject] isEqualToString:model.format] && [[info lastObject] isEqualToString:model.color]) {
            NSLog(@"\n颜色ID：%@",model.pid);
        }else{
            NSLog(@"标准款");
        }
    }
    
    if (_normModelArray.count == 0) {
        NSLog(@"标准款");
    }
    
    
    NSLog(@"\n\n\n -----表单提交开始-----\n\n\n价格：%@\n库存：%@\n规格:%@\n颜色：%@\n积分：%@\n数量：%@\n\n\n -----表单提交开始-----\n\n\n",price,inventory,normLabel.text,normLabel.text,scoreTextFiled.text,numberTextFiled.text);
    
    
//    NSMutableDictionary *commodity = [NSMutableDictionary new];
//    [commodity setObject:price forKey:@"price"];
//    [commodity setObject:inventory forKey:@"inventory"];
//    [commodity setObject:<#(nonnull id)#> forKey:<#(nonnull id<NSCopying>)#>]
    
}


#pragma mark - hidden
- (void)hidden{
    [self endEditing:YES];
    [_delegate removeWindow];
    [self removeFromSuperview];
}

@end










