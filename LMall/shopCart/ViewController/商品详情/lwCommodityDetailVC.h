//
//  lwAddressInfo.h
//  shopCart
//
//  Created by lw on 16/3/7.
//  Copyright © 2016年 lw. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    lwCommodityDetailBottomTypeDongDong = 0,
    lwCommodityDetailBottomTypeShop,
    lwCommodityDetailBottomTypeFavorite,
    lwCommodityDetailBottomTypeShopCart
} lwCommodityDetailBottomType;

@interface lwCommodityDetailVC : UITableViewController

{
    /**工具栏 按钮类型*/
    lwCommodityDetailBottomType bottomType;
}

@property (copy, nonatomic) NSString *gid;

@end
