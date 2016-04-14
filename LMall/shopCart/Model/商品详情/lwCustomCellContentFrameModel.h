//
//  lwCustomCellContentFrameModel.h
//  shopCart
//
//  Created by lw on 16/4/7.
//  Copyright © 2016年 lw. All rights reserved.
//

#import <Foundation/Foundation.h>
@class lwCustomModel;

@interface lwCustomCellContentFrameModel : NSObject

/**行高*/
@property (assign, nonatomic, readonly) CGFloat cellHeight;

/**标题*/
@property (assign, nonatomic, readonly) CGRect titleRect;

/**子标题尺寸*/
@property (assign, nonatomic, readonly) CGSize subTitlesize;

/**模型*/
@property (retain, nonatomic) lwCustomModel *customModel;


@end
