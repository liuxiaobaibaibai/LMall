//
//  UIKeyboardView.m
//  skyCar
//
//  Created by lw on 14-12-3.
//  Copyright (c) 2014年 liuWei. All rights reserved.
//

#import "UIKeyboardView.h"


@implementation UIKeyboardView

@synthesize delegate = _delegate;

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        keyboardToolbar = [[UIToolbar alloc] initWithFrame:frame];
        
        keyboardToolbar.barStyle = UIBarStyleDefault;
        
        UIBarButtonItem *previousBarItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"上一项", @"")
                                                                            style:UIBarButtonItemStylePlain
                                                                           target:self
                                                                           action:@selector(toolbarButtonTap:)];
        previousBarItem.tag=1;
        
        UIBarButtonItem *nextBarItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"下一项", @"")
                                                                        style:UIBarButtonItemStylePlain
                                                                       target:self
                                                                       action:@selector(toolbarButtonTap:)];
        nextBarItem.tag=2;
        
        UIBarButtonItem *spaceBarItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                                      target:nil
                                                                                      action:nil];
        
        UIBarButtonItem *doneBarItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"完成", @"")
                                                                        style:UIBarButtonItemStyleDone
                                                                       target:self
                                                                       action:@selector(toolbarButtonTap:)];
        doneBarItem.tag=3;
        
        [keyboardToolbar setItems:[NSArray arrayWithObjects:previousBarItem,nextBarItem,spaceBarItem,doneBarItem, nil]];
        [self addSubview:keyboardToolbar];
        
    }
    return self;
}

- (void)toolbarButtonTap:(UIButton *)button {
    if ([self.delegate respondsToSelector:@selector(toolbarButtonTap:)]) {
        [self.delegate toolbarButtonTap:button];
    }
}

@end

@implementation UIKeyboardView (UIKeyboardViewAction)

//根据index找出对应的UIBarButtonItem
- (UIBarButtonItem *)itemForIndex:(NSInteger)itemIndex {
    if (itemIndex < [[keyboardToolbar items] count]) {
        return [[keyboardToolbar items] objectAtIndex:itemIndex];
    }
    return nil;
}

@end