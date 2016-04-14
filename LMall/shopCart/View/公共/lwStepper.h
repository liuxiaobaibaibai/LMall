//
//  lwStepper.h
//  testView
//
//  Created by lw on 16/3/5.
//  Copyright © 2016年 lw. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    lwStepperTypeMax,
    lwStepperTypeMin,
    lwStepperTypeOther,
} lwStepperType;

typedef enum : NSUInteger {
    lwStepperButtonTypeSub = 1,
    lwStepperButtonTypeAdd,
} lwStepperButtonType;

@interface lwStepper : UIView
<UITextFieldDelegate>
{
    /**当前错误类型，是大于最大值，还是小于最大值，还是正常范围内的值*/
    lwStepperType _type;
    /**当前控件的按钮类型*/
    lwStepperButtonType _buttonType;
}
extern NSString *testNotification;

/**加减值得控制*/
@property (assign, nonatomic) NSInteger step;

/**最大值(默认为999)-限制在999以内的正整数*/
@property (assign, nonatomic) NSInteger MaxValue;

/**最小值(默认为0)-限制在大于0的正整数*/
@property (assign, nonatomic) NSInteger MinValue;

/**当前值*/
@property (assign, nonatomic) NSInteger value;

/**设置当前的颜色*/
@property (copy, nonatomic) UIColor *tintColor;

/**当前控件的标识*/
@property (copy, nonatomic) NSString *stag;

/**
 *  初始化方法
 *  @param  frmae           当前视图的尺寸
 *  @param  maxValue        当前的最大值
 *  @param  minValue        当前的最小值
 *  @param  currentValue    当前的默认值
 *  还是有点问题
 */
//- (id)initWithFrame:(CGRect)frame MaxValue:(NSInteger)maxValue MinValue:(NSInteger)minValue CurrentValue:(NSInteger)currentValue;


@end







