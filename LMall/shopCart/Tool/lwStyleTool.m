//
//  lwStyleTool.m
//  shopCart
//
//  Created by 刘威 on 16/4/4.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "lwStyleTool.h"

static lwStyleTool *style = nil;
@implementation lwStyleTool

+ (instancetype)colorInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        style = [[self alloc] init];
    });
    return style;
}

+ (void)setStyleColor:(UIColor *)aColor TitleColor:(UIColor *)bColor{
    [[UINavigationBar appearance] setTintColor:bColor];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]}];
    [[UINavigationBar appearance] setBarTintColor:aColor];
    [[UITabBar appearance] setBackgroundColor:aColor];
    [[UITabBar appearance] setBarTintColor:aColor];
    [[UITabBar appearance] setTintColor:bColor];
}



- (id)init{
    self = [super init];
    if (self) {
        [self initDatasource];
    }
    return self;
}

/**初始化预设值*/
- (void)initDatasource{
    _JDColor = RGB(239, 42, 47);
    _DZClolor = RGB(30, 34, 55);
}

@end
