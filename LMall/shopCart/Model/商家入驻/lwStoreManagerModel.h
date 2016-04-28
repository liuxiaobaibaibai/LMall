//
//  lwStoreManagerModel.h
//  shopCart
//
//  Created by lw on 16/4/28.
//  Copyright © 2016年 lw. All rights reserved.
//

#import <Foundation/Foundation.h>



typedef enum : NSUInteger {
    lwStoreManagerModelTypeText = 0,
    lwStoreManagerModelTypeImg,
    lwStoreManagerModelTypeSelect
} lwStoreManagerModelType;

NS_ASSUME_NONNULL_BEGIN

@interface lwStoreManagerModel : NSObject

/**标题*/
@property (copy, nonatomic) NSString *title;
/**内容类型*/
@property (assign, nonatomic) lwStoreManagerModelType type;
/**副标题*/
@property (copy, nonatomic) NSString *subtitle;

- (id)initWithDict:(NSDictionary *)dict;

@end

@interface lwStoreModel : NSObject

#pragma mark - 商家资料
@property (copy, nonatomic) NSString *merchantTitle;
@property (copy, nonatomic) NSString *merchantSubtitle;
@property (copy, nonatomic) NSString *managerAccount;
@property (copy, nonatomic) NSString *merchantArea;
@property (copy, nonatomic) NSString *detailAddress;
@property (copy, nonatomic) NSString *coordicate;
@property (copy, nonatomic) NSString *headerPic;
@property (copy, nonatomic) NSString *mallLogo;
@property (copy, nonatomic) NSString *merchantMail;

#pragma mark - 店主信息
@property (copy, nonatomic) NSString *merchantTelephone;
@property (copy, nonatomic) NSString *merchantIdCardNo;
@property (copy, nonatomic) NSString *merchantIdCardFront;
@property (copy, nonatomic) NSString *merchantIdCardBack;

#pragma mark - 营业执照
/// 统一社会信用代码
@property (copy, nonatomic) NSString *creditNo;
@property (copy, nonatomic) NSString *businessLicensePic;
@property (copy, nonatomic) NSString *mainIndustry;
@property (copy, nonatomic) NSString *subIndustry;

#pragma mark - 银行信息
@property (copy, nonatomic) NSString *bankName;
@property (copy, nonatomic) NSString *bankUsername;
@property (copy, nonatomic) NSString *bankCradNo;

@end

NS_ASSUME_NONNULL_END



