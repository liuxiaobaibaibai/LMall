//
//  lwStepper.m
//  testView
//
//  Created by lw on 16/3/5.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "lwStepper.h"

#define w self.frame.size.width
#define h self.frame.size.height

#define btnWidth 30

#define RGBA(r,g,b,a)   [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

@implementation lwStepper
{
    UIButton    *addBtn;
    UITextField *valueText;
    UIButton    *subBtn;
    UIView      *line1;
    UIView      *line2;
}

// 由于划线会导致线条时而显示 时而不显示，所以相改用view当做线条
- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 第一条直线
    CGContextMoveToPoint(context, btnWidth, 0);
    CGContextAddLineToPoint(context, btnWidth, h);
    // 第二条直线
    CGContextMoveToPoint(context, w-btnWidth, 0);
    CGContextAddLineToPoint(context, w-btnWidth, h);
    
    [_tintColor set];
    
    CGContextStrokePath(context);
}

- (id)init{
    self = [super init];
    if (self) {
        self.layer.borderWidth = 1.0;
        self.layer.borderColor = RGBA(53, 166, 248, 1.0).CGColor;
        self.layer.cornerRadius = 3.0f;
        self.backgroundColor = [UIColor whiteColor];
        self.clipsToBounds = YES;
        
        [self addObserver];
        [self setupUI];
        [self initDataSource];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = CGRectMake(frame.origin.x, frame.origin.y, 100, 30);
        self.layer.borderWidth = 1.0;
        self.layer.borderColor = _tintColor.CGColor;
        self.layer.cornerRadius = 3.0f;
        self.backgroundColor = [UIColor whiteColor];
        self.clipsToBounds = YES;
        // 这个地方的加载顺序不能乱了！
        [self addObserver];
        [self setupUI];
        [self initDataSource];
        
    }
    return self;
}

/**
 *  初始化方法
 *  @param  frmae           当前视图的尺寸
 *  @param  maxValue        当前的最大值
 *  @param  minValue        当前的最小值
 *  @param  currentValue    当前的默认值
 */
- (id)initWithFrame:(CGRect)frame MaxValue:(NSInteger)maxValue MinValue:(NSInteger)minValue CurrentValue:(NSInteger)currentValue{
    if (self = [super initWithFrame:frame]) {
        self.frame = CGRectMake(frame.origin.x, frame.origin.y, 100, 30);
        self.layer.borderWidth = 1.0;
        self.layer.borderColor = _tintColor.CGColor;
        self.layer.cornerRadius = 3.0f;
        self.backgroundColor = [UIColor whiteColor];
        self.clipsToBounds = YES;
        [self addObserver];
        [self setupUI];
        self.MaxValue = maxValue;
        self.MinValue = minValue;
        self.value = currentValue;
    }
    return self;
}


/**设置当前控件的UI*/
- (void)setupUI{
    subBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, btnWidth, h)];
    [subBtn setTitle:@"-" forState:UIControlStateNormal];
    [subBtn setTitleColor:RGBA(32, 68, 209, 1.0) forState:UIControlStateNormal];
    [subBtn.titleLabel setFont:[UIFont systemFontOfSize:30.0]];
    [subBtn.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [subBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [subBtn setContentVerticalAlignment:UIControlContentVerticalAlignmentBottom];
    [subBtn setTag:lwStepperButtonTypeSub];
    [subBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    addBtn = [[UIButton alloc] initWithFrame:CGRectMake(w-btnWidth, 0, btnWidth, h)];
    [addBtn setTitle:@"+" forState:UIControlStateNormal];
    [addBtn setTitleColor:RGBA(32, 68, 209, 1.0) forState:UIControlStateNormal];
    [addBtn.titleLabel setFont:[UIFont systemFontOfSize:30.0]];
    [addBtn.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [addBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [addBtn setContentVerticalAlignment:UIControlContentVerticalAlignmentBottom];
    [addBtn setTag:lwStepperButtonTypeAdd];
    [addBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    valueText = [[UITextField alloc] initWithFrame:CGRectMake(btnWidth, 0, w-btnWidth*2, h)];
    [valueText setFont:[UIFont systemFontOfSize:14.0]];
    valueText.textAlignment = NSTextAlignmentCenter;
    valueText.delegate = self;
    self.value = [valueText.text integerValue];
    
    line1 = [[UIView alloc] initWithFrame:CGRectMake(btnWidth, 0, 1, h)];
    line1.backgroundColor = _tintColor;
    
    line2 = [[UIView alloc] initWithFrame:CGRectMake(w-btnWidth, 0, 1, h)];
    line2.backgroundColor = _tintColor;
    
//    [self addSubview:line1];
//    [self addSubview:line2];
    
    [self addSubview:addBtn];
    [self addSubview:subBtn];
    [self addSubview:valueText];
}

#pragma mark - 相关代理
/**键盘点击return事件处理*/
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    if ([textField.text integerValue] >= _MaxValue) {
        textField.text = [NSString stringWithFormat:@"%ld",(long)_MaxValue];
        self.value = _MaxValue;
        return YES;
    }
    if ([textField.text integerValue] <= _MinValue) {
        textField.text = [NSString stringWithFormat:@"%ld",(long)_MinValue];
        self.value = _MinValue;
        return YES;
    }
    valueText.text = textField.text;
    self.value = [valueText.text integerValue];
    return YES;
}

/**键盘收起时也要处理--收起键盘的时候一定要发送通知，告知当前的value 已经发生改变！*/
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    if ([textField.text integerValue] >= _MaxValue) {
        textField.text = [NSString stringWithFormat:@"%ld",(long)_MaxValue];
        self.value = _MaxValue;
        
        [self addNotification];
        
        return YES;
    }
    if ([textField.text integerValue] <= _MinValue) {
        textField.text = [NSString stringWithFormat:@"%ld",(long)_MinValue];
        self.value = _MinValue;
        
        [self addNotification];
        
        return YES;
    }
    valueText.text = textField.text;
    self.value = [valueText.text integerValue];
    
    [self addNotification];
    
    return YES;
}

#pragma mark - 监听事件开始
- (void)addNotification{
    NSDictionary *info = [NSDictionary dictionaryWithObjectsAndKeys:_stag,@"tag",[NSNumber numberWithInteger:_value],@"value", nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"changeValue" object:nil userInfo:info];
}


/**添加监听*/
- (void)addObserver{
//    NSLog(@"1");
    [self addObserver:self forKeyPath:@"value" options:NSKeyValueObservingOptionNew context:nil];
    [self addObserver:self forKeyPath:@"tintColor" options:NSKeyValueObservingOptionNew context:nil];
}
/**移除监听*/
- (void)removeObserver{
    [self removeObserver:self forKeyPath:@"value" context:nil];
    [self removeObserver:self forKeyPath:@"tintColor" context:nil];
}
#pragma mark 监听事件结束

#pragma mark - 监听事件处理开始
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"value"]) {

        if ([valueText.text integerValue] != _MinValue && [valueText.text integerValue] != _MaxValue) {
            [self setUIStatus:lwStepperTypeOther];
            return;
        }
        
        if ([valueText.text integerValue] <= _MinValue) {
            // 小于等于最小值，不能再减了
            valueText.text = [NSString stringWithFormat:@"%ld",(long)_MinValue];
            [self setUIStatus:lwStepperTypeMin];
            return;
        }
        
        if ([valueText.text integerValue] >= _MaxValue) {
            // 大于等于最大值，不能再加了
            valueText.text = [NSString stringWithFormat:@"%ld",(long)_MaxValue];
            [self setUIStatus:lwStepperTypeMax];
            return;
        }
    }
    
    if ([keyPath isEqualToString:@"tintColor"]) {
        [self setUIColor:_tintColor];
    }
}
#pragma mark 监听事件处理结束

#pragma mark - 初始数值的处理开始
- (void)initDataSource{
    self.MinValue = 1;
    self.MaxValue = 999;
    self.step = 1;
    self.value = 0;
    self.tintColor = RGBA(42, 98, 254, 1.0);
}
#pragma mark 初始数值的处理结束

#pragma mark - 重写的Setter方法开始
- (void)setTintColor:(UIColor *)tintColor{
    _tintColor = tintColor;
}

- (void)setStep:(NSInteger)step{
//    _step = step;
    _step = step < 0 ? 0:step;
}

- (void)setMaxValue:(NSInteger)MaxValue{
//    _MaxValue = MaxValue;
    _MaxValue = MaxValue > 999?999:MaxValue;
}

- (void)setMinValue:(NSInteger)MinValue{
    _MinValue = MinValue <= 0?0:MinValue;
}

- (void)setValue:(NSInteger)value{
    _value = value;
    valueText.text = [NSString stringWithFormat:@"%ld",(long)value];
}

#pragma mark 重写的Setter方法结束

#pragma mark - 其他事件开始
- (void)setUIColor:(UIColor *)color{
    [self.layer setBorderColor:color.CGColor];
    line1.backgroundColor = color;
    line2.backgroundColor = color;

    if (_value > _MinValue || _value < _MaxValue) {
        [addBtn setTitleColor:color forState:UIControlStateNormal];
    }

}

- (void)setUIStatus:(lwStepperType)type{
    switch (type) {
        case lwStepperTypeMax:
        {
            // 加号，不能点，要保证减号可以点
            [addBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            [addBtn setUserInteractionEnabled:NO];
            
            [subBtn setUserInteractionEnabled:YES];
            [subBtn setTitleColor:_tintColor forState:UIControlStateNormal];
        }
            break;
        case lwStepperTypeMin:
        {
            // 减号，不能点，要保证加号可以点
            [subBtn setUserInteractionEnabled:NO];
            [subBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            
            [addBtn setUserInteractionEnabled:YES];
            [addBtn setTitleColor:_tintColor forState:UIControlStateNormal];
        }
            break;
        default:
        {
            // 都能点
            [addBtn setUserInteractionEnabled:YES];
            [addBtn setTitleColor:_tintColor forState:UIControlStateNormal];
            
            [subBtn setUserInteractionEnabled:YES];
            [subBtn setTitleColor:_tintColor forState:UIControlStateNormal];
        }
            break;
    }
}
#pragma mark 其他事件结束

#pragma mark - 事件的处理开始
- (void)btnClick:(UIButton *)btn{
    [valueText resignFirstResponder];
    [self changeValue:btn.tag];
}

/**
 *  改变value
 *  @param  btnType 判断button 是加还是减
 */
- (void)changeValue:(lwStepperButtonType)btnType{
    switch (btnType) {
        case lwStepperButtonTypeSub:
        {
            if ([valueText.text integerValue] <= _MinValue) {
                // 值已经等于最小值了,不能再小了
                valueText.text = [NSString stringWithFormat:@"%ld",(long)_MinValue];
                self.value = _MinValue;
                return;
            }
            valueText.text = [NSString stringWithFormat:@"%ld",(long)([valueText.text integerValue]-_step<=0?0:[valueText.text integerValue]-_step)];
            self.value = [valueText.text integerValue];
        }
            break;
        case lwStepperButtonTypeAdd:
        {
            if ([valueText.text integerValue] >= _MaxValue) {
                // 值已经等于最大值了，不能再大了
                valueText.text = [NSString stringWithFormat:@"%ld",(long)_MaxValue];
                self.value = _MaxValue;
                return;
            }
            
            valueText.text = [NSString stringWithFormat:@"%ld",(long)[valueText.text integerValue]+_step];
            self.value = [valueText.text integerValue];

        }
            break;
        default:
            break;
    }
    [self addNotification];
}



#pragma mark 事件的处理结束

#pragma mark - 生命周期开始
- (void)dealloc{
    [self removeObserver];
}
#pragma mark 生命周期结束

@end
