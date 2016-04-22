//
//  lwCustomAnnotationView.h
//  shopCart
//
//  Created by lw on 16/4/22.
//  Copyright © 2016年 lw. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>

@class lwCustomCalloutView;

@interface lwCustomAnnotationView : MAAnnotationView

@property (nonatomic, readonly) lwCustomCalloutView *calloutView;

@end
