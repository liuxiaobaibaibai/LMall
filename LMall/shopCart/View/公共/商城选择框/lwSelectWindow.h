//
//  lwSelectWindow.h
//  shopCart
//
//  Created by lw on 16/4/15.
//  Copyright © 2016年 lw. All rights reserved.
//

#import <UIKit/UIKit.h>

@class lwCommodityDetailModel;
@class lwCommodityNormModel;

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

@property (retain, nonatomic) lwCommodityDetailModel *detailModel;

@property (retain, nonatomic) NSMutableArray *normArray;
@property (retain, nonatomic) NSMutableArray *titleArray;

- (void)updateInfo:(NSString *)param Sign:(NSString *)sign;

@end
