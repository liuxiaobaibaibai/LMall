//
//  lwStoreManagerImgCell.m
//  shopCart
//
//  Created by lw on 16/4/28.
//  Copyright © 2016年 lw. All rights reserved.
//

#define padding 10
#define imgW    60
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
        imgView.contentMode = UIViewContentModeScaleAspectFill;
        imgView.layer.cornerRadius = 5.0f;
        imgView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        imgView.layer.borderWidth = 1.0f;
        imgView.layer.masksToBounds = YES;
        
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
            make.right.mas_equalTo(-padding*4);
            make.width.mas_equalTo(imgW);
            make.height.mas_equalTo(imgW);
        }];
        
    }
    return self;
}

- (void)setModel:(lwStoreManagerModel *)model{
    titleLabel.text = model.title;
    imgView.image = model.img;
}

- (void)setImg:(UIImage *)img{
    imgView.image = img;
}

@end
