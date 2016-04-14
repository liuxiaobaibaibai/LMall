//
//  UIWebView+lwWebView.m
//  shopCart
//
//  Created by lw on 16/4/6.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "UIWebView+lwWebView.h"

@implementation UIWebView (lwWebView)

- (void)addUsuallyGestures{
    UISwipeGestureRecognizer *leftSwipe  = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(goForwardOperation:)];
    leftSwipe.direction = UISwipeGestureRecognizerDirectionLeft;
    
    
    UISwipeGestureRecognizer *rightSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(goBackOperation:)];
    rightSwipe.direction = UISwipeGestureRecognizerDirectionRight;
    
    UISwipeGestureRecognizer *topSwipe   = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(topOperation:)];
    topSwipe.direction = UISwipeGestureRecognizerDirectionUp;
    
    UISwipeGestureRecognizer *downSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(downOperation:)];
    downSwipe.direction = UISwipeGestureRecognizerDirectionDown;
    
    
    [self addGestureRecognizer:leftSwipe];
    [self addGestureRecognizer:rightSwipe];
    [self addGestureRecognizer:topSwipe];
    [self addGestureRecognizer:downSwipe];
}

- (void)goBackOperation:(id)sender{
    if ([self canGoBack]) {
        [self goBack];
    }
}

- (void)goForwardOperation:(id)sender{
    if ([self canGoForward]) {
        [self goForward];
    }
}

- (void)topOperation:(id)sender{
    NSLog(@"向上滑");
}

- (void)downOperation:(id)sender{
    NSLog(@"向下滑");
}

@end
