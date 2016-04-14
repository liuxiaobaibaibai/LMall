//
//  UIKeyboardViewController.h
//  skyCar
//
//  Created by lw on 14-12-3.
//  Copyright (c) 2014年 liuWei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIKeyboardView.h"

@protocol UIKeyboardViewControllerDelegate;

@interface UIKeyboardViewController : NSObject <UITextFieldDelegate, UIKeyboardViewDelegate, UITextViewDelegate> {
    CGRect keyboardBounds;
    UIKeyboardView *keyboardToolbar;
    id <UIKeyboardViewControllerDelegate>
    boardDelegate;
    UIView *objectView;
}

@property (nonatomic, assign) id <UIKeyboardViewControllerDelegate> boardDelegate;

@end

@interface UIKeyboardViewController (UIKeyboardViewControllerCreation)

- (id)initWithControllerDelegate:(id <UIKeyboardViewControllerDelegate>)delegateObject;


@end

@interface UIKeyboardViewController (UIKeyboardViewControllerAction)

- (void)addToolbarToKeyboard;

@end

@protocol UIKeyboardViewControllerDelegate <NSObject>

@optional

- (void)alttextFieldDidEndEditing:(UITextField *)textField;
- (void)alttextViewDidEndEditing:(UITextView *)textView;

@end
