//
//  UIKeyboardView.h
//  skyCar
//
//  Created by lw on 14-12-3.
//  Copyright (c) 2014年 liuWei. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UIKeyboardViewDelegate;

@interface UIKeyboardView : UIView {
    id <UIKeyboardViewDelegate> delegate;
    UIToolbar *keyboardToolbar;
}

@property (nonatomic, assign) id <UIKeyboardViewDelegate> delegate;

@end

@interface UIKeyboardView (UIKeyboardViewAction)

- (UIBarButtonItem *)itemForIndex:(NSInteger)itemIndex;

@end

@protocol UIKeyboardViewDelegate <NSObject>

- (void)toolbarButtonTap:(UIButton *)button;

@optional

@end