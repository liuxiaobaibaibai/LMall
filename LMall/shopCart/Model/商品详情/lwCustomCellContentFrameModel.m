//
//  lwCustomCellContentFrameModel.m
//  shopCart
//
//  Created by lw on 16/4/7.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "lwCustomCellContentFrameModel.h"
#import "lwCustomModel.h"

#define padding 8

@implementation lwCustomCellContentFrameModel : NSObject

- (void)setCustomModel:(lwCustomModel *)customModel{
    
    _customModel = customModel;
    
    _titleRect = CGRectMake(padding, padding, 30, 30);
    
    _cellHeight = 0;
    
    
    for (int i = 1; i<[customModel.subArray count]+1; i++) {
        _cellHeight += 30;
    }
    _cellHeight += (customModel.subArray.count+1)*padding;
}


@end
