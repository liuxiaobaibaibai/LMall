//
//  NSString+lwString.h
//  sixApp
//
//  Created by lw on 16/1/27.
//  Copyright © 2016年 lw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (lwString)

/**获取当前时间戳*/
+ (NSString *)nowTime;

/**MD5（大写加密）*/
- (NSString *)MD5;

/**MD5（小写加密）*/
- (NSString *)md5;

NSString * gen_guid();

/**sha1加密*/
- (NSString *) sha1;

/**添加删除线*/
- (NSAttributedString *)strikethrough;

/**
 *  修改部分字体颜色
 *  @param  str 要修改的字符串
 *  @return 返回修改后的字符串
 */
+ (NSAttributedString *)strikethrough:(NSString *)str;

/**
 *  修改部分字体颜色
 *  @param  str     要修改的字符串
 *  @param  color   默认的字体颜色
 *  @return 返回修改后的字符串
 */
+ (NSAttributedString *)strikethrough:(NSString *)str CurrentColor:(UIColor *)color;

/**添加下划线*/
- (NSAttributedString *)underline;

/**判断字符串是否为空*/
- (BOOL)isNull;

/**
 *  转义html字符串
 *  @param  html    要转义的html字符串
 *  @return 返回转义后的html字符串
 */
+ (NSString *)escapeHTMLStr:(NSString *)html;

/**
 *  获取当前字符串的尺寸
 *  @parma  content 当前字符串
 *  @param  font    字体
 *  @return 返回当前字符串的尺寸
 */
+ (CGSize)computedSize:(NSString *)content Font:(UIFont *)font;

/**
 *  获取当前字符串的尺寸
 *  @parma  size 尺寸的限制
 *  @param  font    字体
 *  @return 返回当前字符串的尺寸
 */
- (CGSize)computedSize:(CGSize)size Font:(UIFont *)font;
@end
