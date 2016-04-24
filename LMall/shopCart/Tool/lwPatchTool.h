//
//  lwPatchTool.h
//  shopCart
//
//  Created by 刘威 on 16/4/23.
//  Copyright © 2016年 lw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface lwPatchTool : NSObject

+ (lwPatchTool *)patchManager;

/**
 *  根据服务端数据创建一个本地的补丁缓存
 *  @param  serverPath  服务端路径
 */
+ (void)createdLocalPatch:(NSString *)serverPath;

@end
