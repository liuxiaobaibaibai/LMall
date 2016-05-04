//
//  lwPersonalModel.h
//  shopCart
//
//  Created by lw on 16/5/4.
//  Copyright © 2016年 lw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface lwPersonalHeaderModel : NSObject

@property (copy, nonatomic) NSString *headerImgPath;
@property (copy, nonatomic) NSString *nickname;
@property (copy, nonatomic) NSString *mobileNo;
@property (copy, nonatomic) NSString *identity;
// 上级
@property (copy, nonatomic) NSString *superior;
// 上级电话
@property (copy, nonatomic) NSString *superiorMobileNo;



@end



@interface lwPersonalModel : NSObject

@property (copy, nonatomic) NSString *imgPath;

@property (copy, nonatomic) NSString *title;



@end
