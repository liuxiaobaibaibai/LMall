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
@class UIKeyboardViewController;

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

@property (retain, nonatomic) NSMutableArray *normModelArray;

- (void)updateInfo:(NSString *)param Price:(NSString *)price KC:(NSString *)kc Sign:(NSInteger)sign;

@end
