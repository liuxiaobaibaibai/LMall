//
//  lwStoreManagerImgCell.m
//  shopCart
//
//  Created by lw on 16/4/28.
//  Copyright © 2016年 lw. All rights reserved.
//

#define padding 8
#define imgW    50
#import "lwStoreManagerImgCell.h"
#import "lwStoreManagerModel.h"
@implementation lwStoreManagerImgCell
{
    UILabel *titleLabel;
    UIImageView *imgView;
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        titleLabel = [[UILabel alloc] init];
        titleLabel.text = @"标题";
        [self addSubview:titleLabel];
        
        imgView = [[UIImageView alloc] init];
        imgView.image = [UIImage imageNamed:@"cry"];
        imgView.contentMode = UIViewContentModeScaleToFill;
        [self addSubview:imgView];
        
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.top.mas_equalTo(padding);
            make.bottom.mas_equalTo(-padding);
            make.right.mas_equalTo(imgView.mas_left).offset(-padding);
        }];
        
        [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(titleLabel.mas_right).with.offset(padding);
            make.centerY.mas_equalTo(titleLabel.mas_centerY);
            make.right.mas_equalTo(-padding);
            make.width.mas_equalTo(imgW);
            make.height.mas_equalTo(imgW);
        }];
        
    }
    return self;
}

- (void)setModel:(lwStoreManagerModel *)model{
    titleLabel.text = model.title;
    imgView.image = [UIImage imageNamed:model.subtitle];
}

@end
