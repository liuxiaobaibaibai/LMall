//
//  lwSelectWindow.h
//  shopCart
//
//  Created by lw on 16/4/15.
//  Copyright © 2016年 lw. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol lwSelectNormViewDelegate <NSObject>

@required
- (void)removeWindow;

@end

@interface lwSelectWindow : UIWindow

<
UITableViewDataSource,
UITableViewDelegate
>

@property (assign, nonatomic) id<lwSelectNormViewDelegate>delegate;

- (id)initWithFrame:(CGRect)frame Delegate:(id)delegate;

- (void)showInView:(UIView *)aView;

@end
