//
//  lwEntity.m
//  shopCart
//
//  Created by 刘威 on 16/4/4.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "lwEntity.h"
#import <objc/runtime.h>


static lwEntity *entity = nil;

@implementation lwEntity

+ (instancetype)entitySingleton{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        entity = [[self alloc] init];
    });
    return entity;
}


- (id)init{
    self = [super init];
    if (self) {
        [self setValueProperty];
    }
    return self;
}

// 运行时动态给所有变量赋值
- (void)setValueProperty{
    unsigned int numIvars; //成员变量个数
    Ivar *vars = class_copyIvarList(NSClassFromString(@"lwEntity"), &numIvars);
    NSString *key = nil;
    NSString *type = nil;
    for(int i = 0; i < numIvars; i++) {
        Ivar thisIvar = vars[i];
        key = [NSString stringWithUTF8String:ivar_getName(thisIvar)];  //获取成员变量的名字
        object_setIvar(self, thisIvar, key); // 运行时动态给变量赋值
        type = [NSString stringWithUTF8String:ivar_getTypeEncoding(thisIvar)]; //获取成员变量的数据类型
    }
    // 释放内存
    free(vars);
}


@end
