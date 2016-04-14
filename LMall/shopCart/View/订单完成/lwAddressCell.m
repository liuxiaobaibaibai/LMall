//
//  lwAddressCell.m
//  shopCart
//
//  Created by lw on 16/4/8.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "lwAddressCell.h"

#import "lwMall_AddressModel.h"

#define padding 10

@implementation lwAddressCell
{
    UIImageView *imgView;
    UILabel *nameLabel;
    UILabel *mobilLabel;
    UILabel *addressLabel;
}

- (lwAddressCell *)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
        }];
        
        imgView = [[UIImageView alloc] init];
        imgView.image = [UIImage imageNamed:@"iconfont-location"];
        [self addSubview:imgView];
        
        nameLabel = [[UILabel alloc] init];
        nameLabel.font = [UIFont systemFontOfSize:16.0];
        [self addSubview:nameLabel];
        
        mobilLabel = [[UILabel alloc] init];
        mobilLabel.font = [UIFont systemFontOfSize:16.0];
        [self addSubview:mobilLabel];
        
        addressLabel = [[UILabel alloc] init];
        addressLabel.font = [UIFont systemFontOfSize:12.0];
        addressLabel.numberOfLines = 0;
        [self addSubview:addressLabel];
        
        [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY);
            make.left.mas_equalTo(padding);
            make.right.mas_equalTo(nameLabel.mas_left).with.offset(-padding);
            make.right.mas_equalTo(addressLabel.mas_left).with.offset(-padding);
            make.width.mas_equalTo(padding*2);
            make.height.mas_equalTo(padding*2);
        }];
        
        [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(imgView.mas_right).with.offset(padding);
            make.right.mas_equalTo(mobilLabel.mas_left).with.offset(-padding);
            make.top.mas_equalTo(padding);
            make.height.mas_equalTo(21);
            make.width.mas_equalTo(mobilLabel.mas_width);
            make.centerY.mas_equalTo(mobilLabel.mas_centerY);
        }];
        
        [mobilLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(nameLabel.mas_right).with.offset(padding);
            make.right.mas_equalTo(self).with.offset(-padding);
            make.width.mas_equalTo(nameLabel.mas_width);
            make.height.mas_equalTo(nameLabel.mas_height);
        }];
        
        [addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(nameLabel.mas_bottom).with.offset(padding);
            make.left.mas_equalTo(imgView.mas_right).with.offset(padding);
            make.right.mas_equalTo(self).with.offset(-(padding*3));
            make.bottom.mas_equalTo(-padding);
        }];
    }
    return self;
}

- (void)setAddressModel:(lwMall_AddressModel *)addressModel{
    
    if (_addressModel != addressModel) {
        _addressModel = addressModel;
    }
    
    nameLabel.text = addressModel.username;
    mobilLabel.text = addressModel.mobileNo;
    addressLabel.text = addressModel.address;
}

@end
