//
//  lwStyleTool.h
//  shopCart
//
//  Created by 刘威 on 16/4/4.
//  Copyright © 2016年 lw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface lwStyleTool : NSObject

/*京东红*/
@property (copy, nonatomic, readonly) UIColor *JDColor;

/**定制蓝*/
@property (copy, nonatomic, readonly) UIColor *DZColor;

/**单例*/
+ (instancetype)colorInstance;

/**设置系统主题颜色*/
+ (void)setStyleColor:(UIColor *)aColor TitleColor:(UIColor *)bColor;


@end
