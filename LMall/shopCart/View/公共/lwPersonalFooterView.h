//
//  lwPersonalFooterView.h
//  livePlayer
//
//  Created by 刘威 on 16/2/25.
//  Copyright © 2016年 lw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface lwPersonalFooterView : UIView
<UIScrollViewDelegate>

@property (strong, nonatomic) NSMutableArray *dataArray;

/**
 *  跳转到轮播图指定页面
 *  @param  pageIndex   分页索引
 */
- (void)jumpToPage:(NSInteger)pageIndex;

@end
