//
//  lwPatchTool.m
//  shopCart
//
//  Created by 刘威 on 16/4/23.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "lwPatchTool.h"
static lwPatchTool *patchTool = nil;
@implementation lwPatchTool

+ (lwPatchTool *)patchManager{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        patchTool = [[self alloc] init];
    });
    return patchTool;
}

- (id)init{
    self = [super init];
    if (self) {

    }
    return self;
}


+ (void)createdLocalPatch:(NSString *)serverPath{
    NSAssert(![serverPath isNull],@"serverPath Can't be empty  ServerPath:%@",serverPath);
    
    [JPEngine startEngine];
    
    [JPEngine addExtensions:@[@"JPInclude", @"JPCGTransform"]];
    
    NSURL *url = [NSURL URLWithString:serverPath];
    NSError *error = nil;
    // 服务端的补丁
    NSString *remotePatch = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:&error];
    
    // 文件管理
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    // 获取沙盒路径
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    // 补丁路径
    NSString *patchPath = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"Patch.js"];
    
    //判断服务端是否有补丁
    if ([remotePatch isNull]) {
        return;
    }
    
    // 判断是否存在本地补丁，不存在则把服务端的补丁写入本地沙盒中
    if (![fileManager fileExistsAtPath:patchPath]) {
        [fileManager createFileAtPath:patchPath contents:[remotePatch dataUsingEncoding:NSUTF8StringEncoding] attributes:nil];
    }
    
    // 本地补丁内容
    NSString *localPatch = [NSString stringWithContentsOfFile:patchPath encoding:NSUTF8StringEncoding error:&error];
    
    // 如果存在，将服务端补丁和本地补丁内容相比较如果内容不一样使用服务端补丁，否则使用本地补丁
    if ([remotePatch isEqualToString:localPatch]) {
        NSLog(@"使用本地补丁!");
        [JPEngine evaluateScriptWithPath:patchPath];
    }else{
        NSLog(@"使用服务端补丁!");
        [JPEngine evaluateScript:remotePatch];
        [[remotePatch dataUsingEncoding:NSUTF8StringEncoding] writeToFile:patchPath atomically:YES];
    }
}

@end
