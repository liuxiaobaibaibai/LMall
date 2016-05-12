//
//  lwCommodityDetailModel.h
//  shopCart
//
//  Created by 刘威 on 16/4/4.
//  Copyright © 2016年 lw. All rights reserved.
//

#import <Foundation/Foundation.h>

@class lwCommodityNormModel;

typedef void(^commodityBlock)(id result, NSError *error);

@interface lwCommodityDetailModel : NSObject

@property (copy, nonatomic) NSString *commodityTitle;

@property (copy, nonatomic) NSString *alert;

@property (copy, nonatomic) NSString *ZX;

//@property (copy, nonatomic) NSString *price;

@property (copy, nonatomic) NSString *KC;

/********/


@property (copy, nonatomic) NSString *gid;
@property (copy, nonatomic) NSString *intro;
@property (retain, nonatomic) NSMutableArray *catNorms;
@property (retain, nonatomic) NSMutableArray<__kindof lwCommodityNormModel *> *detailArray;
@property (retain, nonatomic) NSMutableArray *imgArray;
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *price;
@property (copy, nonatomic) NSString *oPirce;
@property (copy, nonatomic) NSString *XG;
@property (copy, nonatomic) NSString *num;

- (id)initWithDict:(NSDictionary *)dict;


+ (void)getProduct:(NSString *)gid Completion:(commodityBlock)completion;

@end

