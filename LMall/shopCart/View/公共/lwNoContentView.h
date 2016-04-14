//
//  lwNoContentView.h
//  shopCart
//
//  Created by lw on 16/4/6.
//  Copyright © 2016年 lw. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    lwAlertTypeNoOrder = 0,
    lwAlertTypeNoCommodity,
    lwAlertTypeOther
} lwAlertType;


@protocol lwNoContentViewDelegate <NSObject>

- (void)noContentButtonClick:(UIButton *)btn;

@end

@interface lwNoContentView : UIView

/**提醒类型*/
@property (assign, nonatomic) lwAlertType alertType;

@property (assign, nonatomic) id<lwNoContentViewDelegate>delegate;


- (id)initWithFrame:(CGRect)frame withDelegate:(id)Delegate;

@end
