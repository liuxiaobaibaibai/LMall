//
//  NSString+lwString.m
//  sixApp
//
//  Created by lw on 16/1/27.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "NSString+lwString.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (lwString)

/**
 *  获取当前时间戳
 */
+ (NSString *)nowTime{
    NSDate *now = [NSDate date];
    return [NSString stringWithFormat:@"%.0f", now.timeIntervalSince1970];
}

NSString * gen_uuid()
{
    CFUUIDRef uuid_ref = CFUUIDCreate(NULL);
    CFStringRef uuid_string_ref= CFUUIDCreateString(NULL, uuid_ref);
    CFRelease(uuid_ref);
    NSString *uuid = [NSString stringWithString:(__bridge NSString*)uuid_string_ref];
    CFRelease(uuid_string_ref);
    return uuid;
}

/**
 *  大写MD5 加密
 */
- (NSString *)MD5{
    const char *cStr = [self UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, (unsigned int)strlen(cStr), digest );
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02X", digest[i]];
    
    return output;
}

/**
 *  小写MD5加密
 */
- (NSString *)md5
{
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (unsigned int)strlen(cStr), result); // This is the md5 call
    
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];;
}


/**
 *  SHA1 加密
 */
- (NSString*) sha1
{
    const char *cstr = [self cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:self.length];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, (int)data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
}

- (BOOL)isNull{
    return  self == nil || [self isEqual:[NSNull null]] || [self isEqualToString:@""];
}


- (NSAttributedString *)strikethrough{
    NSAttributedString *str = [[NSAttributedString alloc]initWithString:self
                                                             attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.f],
                                         NSForegroundColorAttributeName:[UIColor lightGrayColor],
                                      NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle|NSUnderlinePatternSolid),
                                      NSStrikethroughColorAttributeName:[UIColor lightGrayColor]}];
    return str;
}

+ (NSAttributedString *)strikethrough:(NSString *)str{
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:str attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16.0]}];
    
    NSString *temp = nil;
    NSUInteger strLocation = 0;
    NSUInteger strLength = 0;
    for(int i =0; i < [str length]; i++)
    {
        temp = [str substringWithRange:NSMakeRange(i, 1)];
        if ([temp isEqualToString:@"【"]) {
            strLocation = i;
        }
        
        if ([temp isEqualToString:@"】"]) {
            strLength = i+1;
        }
    }
    
    NSRange range = NSMakeRange(strLocation, strLength);
    [attributeString addAttribute:NSForegroundColorAttributeName value:[lwStyleTool colorInstance].JDColor range:range];
    return attributeString;
}

+ (NSAttributedString *)strikethrough:(NSString *)str CurrentColor:(UIColor *)color{
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:str attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16.0],NSForegroundColorAttributeName:color}];
    
    NSString *temp = nil;
    NSUInteger strLocation = 0;
    NSUInteger strLength = 0;
    for(int i =0; i < [str length]; i++)
    {
        temp = [str substringWithRange:NSMakeRange(i, 1)];
        if ([temp isEqualToString:@"【"]) {
            strLocation = i;
        }
        
        if ([temp isEqualToString:@"】"]) {
            strLength = i+1;
        }
    }
    
    NSRange range = NSMakeRange(strLocation, strLength);
    [attributeString addAttribute:NSForegroundColorAttributeName value:[lwStyleTool colorInstance].JDColor range:range];
    return attributeString;
}

- (NSAttributedString *)underline{
    NSAttributedString *str = [[NSAttributedString alloc]initWithString:self
                                                             attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.f],
                                                                          NSForegroundColorAttributeName:[lwStyleTool colorInstance].JDColor,
                                                                          NSUnderlineStyleAttributeName:@(NSUnderlineStyleSingle),
                                                                          NSStrikethroughColorAttributeName:[lwStyleTool colorInstance].JDColor}];
    return str;
}


+ (NSString *)escapeHTMLStr:(NSString *)html{
    NSString *trueStr0 = [html stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
    NSString *trueStr1 = [trueStr0 stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
    NSString *trueStr2 = [trueStr1 stringByReplacingOccurrencesOfString:@"height='100%'" withString:@""];
    NSString *trueStr3 = [trueStr2 stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
    NSString *trueStr4 = [trueStr3 stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@" "];
    NSString *trueStr5 = [trueStr4 stringByReplacingOccurrencesOfString:@"weight: 100%;" withString:@""];
    
    
    
    return trueStr5;
}

+ (CGSize)computedSize:(NSString *)content Font:(UIFont *)font{
    NSDictionary *attributes = @{NSFontAttributeName:font};
    CGSize size = [content boundingRectWithSize:CGSizeMake(lW-16, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    return size;
}

- (CGSize)computedSize:(CGSize)size Font:(UIFont *)font{
    NSDictionary *attributes = @{NSFontAttributeName:font};
    CGSize strSize = [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    return strSize;
}



@end
