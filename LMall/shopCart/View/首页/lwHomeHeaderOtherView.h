//
//  lwHomeHeaderOtherView.h
//  shopCart
//
//  Created by lw on 16/4/14.
//  Copyright © 2016年 lw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface lwHomeHeaderOtherView : UICollectionReusableView

@property (weak, nonatomic) IBOutlet UIImageView *headerImgView;

@property (weak, nonatomic) IBOutlet UIButton *moreButton;

@property (retain, nonatomic) NSString *headerImgUrlPath;

@end
