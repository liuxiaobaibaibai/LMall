//
//  lwFlowLayout.m
//  shopCart
//
//  Created by lw on 16/5/4.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "lwFlowLayout.h"

@implementation lwFlowLayout

- (CGSize)collectionViewContentSize
{
    CGFloat height = ceil([[self collectionView]numberOfItemsInSection:0]/5)*lW/2;
    
    return CGSizeMake(lW, height);
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

//返回每个cell的布局属性
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)path{
    UICollectionViewLayoutAttributes *attribute = [[UICollectionViewLayoutAttributes alloc] init];

    return attribute;
}

-(NSArray*)layoutAttributesForElementsInRect:(CGRect)rect
{
    
    NSArray *array = [super layoutAttributesForElementsInRect:rect];
    
    NSMutableArray* attributes = [NSMutableArray array];
    
    for (NSInteger i=0 ; i < [array count]; i++) {
        
        NSIndexPath* indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        
        [attributes addObject:[self layoutAttributesForItemAtIndexPath:indexPath]];
        
    }
    
    return attributes;
    
}


@end
