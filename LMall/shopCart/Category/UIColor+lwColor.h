//
//  UIColor+lwColor.h
//  shopCart
//
//  Created by 刘威 on 16/4/4.
//  Copyright © 2016年 lw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (lwColor)

/**
 *  十六进制颜色转换
 *  @param  stringToConvert 需要转换的颜色代码
 *  @param  alpha   透明度
 *  @return 返回UIColor体系下的颜色
 */
+ (UIColor *)colorWithHexString:(NSString *)stringToConvert Alpha:(CGFloat)alpha;

@end
