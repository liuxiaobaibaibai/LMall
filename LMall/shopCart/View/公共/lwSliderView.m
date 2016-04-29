//
//  lwSliderView.m
//  shopCart
//
//  Created by lw on 16/4/29.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "lwSliderView.h"

#define left 30
#define right 30

#define labelWidth 50


@implementation lwSliderView

{
    CALayer *nodeLayer;
    UILabel *titleLabel;
    NSMutableArray *labelArray;
}

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = CGRectMake(frame.origin.x, frame.origin.y, lW, 50);
        self.backgroundColor = [UIColor whiteColor];
        self.layer.borderColor = [UIColor lightGrayColor].CGColor;
        self.layer.borderWidth = 1.0;
        self.layer.cornerRadius = 5.0;
        self.layer.masksToBounds = YES;
        _nodeCount = 5;
        _nodeIndex = 1;
        labelArray = [NSMutableArray new];
    }
    return self;
}

- (void)drawRect:(CGRect)rect{
    CGContextRef lineContext = UIGraphicsGetCurrentContext();

    CGContextMoveToPoint(lineContext, lW-right, 30);
    CGContextAddLineToPoint(lineContext, left, 30);
    [[UIColor lightGrayColor] set];
    CGContextStrokePath(lineContext);
    
    CGContextRef ellipseContext = UIGraphicsGetCurrentContext();
    
    int spacew = (lW-left*2)/(_nodeCount-1);
    for (int i = 0 ; i<5; i++) {
        CGContextFillEllipseInRect(ellipseContext, CGRectMake(left+(i*spacew), 25, 10, 10));
    }
    [[UIColor lightGrayColor] set];
    
    CGContextStrokePath(ellipseContext);
}

- (void)setTitleArray:(NSArray *)titleArray{
    _titleArray = titleArray;
    int spacew = (lW-left*2)/(_nodeCount-1);
    for (int i = 0; i<titleArray.count; i++) {
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake((left+(i*spacew)+5)-(labelWidth/2), 0, labelWidth, 20)];
        titleLabel.text = titleArray[i];
        titleLabel.font = [UIFont systemFontOfSize:12.0];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.tag = i;
        [labelArray addObject:titleLabel];
        [self addSubview:titleLabel];
    }
}

- (void)setNodeCount:(int)nodeCount{
    _nodeCount = nodeCount;
}

- (void)setNodeIndex:(int)nodeIndex{
    NSAssert(_nodeCount, @"nodeCount is can't be nil,please set nodeCount's value");
    int spacew = (lW-left*2)/(_nodeCount-1);
    nodeLayer = [[CALayer alloc] initWithLayer:self.layer];
    nodeLayer.frame = CGRectMake(left+(nodeIndex*spacew)-10, 20, 20, 20);
    nodeLayer.backgroundColor = [UIColor whiteColor].CGColor;
    nodeLayer.cornerRadius = 10;
    nodeLayer.borderColor = [UIColor lightGrayColor].CGColor;
    nodeLayer.borderWidth = 1.0;
    [self.layer addSublayer:nodeLayer];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGFloat x = [touches.anyObject locationInView:self].x;
    // 如果小于最小边界值，那么 X = 最小边界值
    if (x<left) {
        x = left;
    }
    // 如果大于最大边界值，那么 X = 最大边界值
    if (x>lW-left) {
        x = lW - left;
    }
    [self setProgress:x Duration:0.5];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGFloat x = [touches.anyObject locationInView:self].x;
    
    // 如果小于最小边界值，那么 X = 最小边界值
    if (x<left) {
        x = left;
    }
    
    // 如果大于最大边界值，那么 X = 最大边界值
    if (x>lW-left) {
        x = lW - left;
    }
    [self setProgress:x Duration:0];
}

- (void)setProgress:(CGFloat)progress Duration:(NSTimeInterval)duration{
    int spacew = (lW-left*2)/(_nodeCount-1);
    
    int index = progress/spacew;
    

    [UIView animateWithDuration:duration animations:^{
        nodeLayer.frame = CGRectMake(progress-10, 20, 20, 20);
        for (UILabel *label in labelArray) {
            if (label.tag == index) {
                label.font = [UIFont systemFontOfSize:14.0];
                label.textColor = [UIColor redColor];
            }else{
                label.font = [UIFont systemFontOfSize:12.0];
                label.textColor = [UIColor blackColor];
            }
        }
    }];
    
}


@end
