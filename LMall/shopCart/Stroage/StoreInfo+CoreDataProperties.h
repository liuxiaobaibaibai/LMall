//
//  StoreInfo+CoreDataProperties.h
//  
//
//  Created by lw on 16/4/27.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "StoreInfo.h"

NS_ASSUME_NONNULL_BEGIN

@interface StoreInfo (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *storeID;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *shortName;
@property (nullable, nonatomic, retain) NSString *account;
@property (nullable, nonatomic, retain) NSString *province;
@property (nullable, nonatomic, retain) NSString *city;
@property (nullable, nonatomic, retain) NSString *district;
@property (nullable, nonatomic, retain) NSString *address;
@property (nullable, nonatomic, retain) NSString *coordinates;
@property (nullable, nonatomic, retain) NSString *headaerpic;
@property (nullable, nonatomic, retain) NSString *logo;
@property (nullable, nonatomic, retain) NSString *mail;
@property (nullable, nonatomic, retain) NSString *telephone;
@property (nullable, nonatomic, retain) NSString *idNumber;
@property (nullable, nonatomic, retain) NSString *idCardFont;
@property (nullable, nonatomic, retain) NSString *idCardBack;
@property (nullable, nonatomic, retain) NSString *creditCode;
@property (nullable, nonatomic, retain) NSString *businessLicense;
@property (nullable, nonatomic, retain) NSString *mainIndustry;
@property (nullable, nonatomic, retain) NSString *subIndustry;
@property (nullable, nonatomic, retain) NSString *bankName;
@property (nullable, nonatomic, retain) NSString *bankUsername;
@property (nullable, nonatomic, retain) NSString *bankNo;
@property (nullable, nonatomic, retain) NSString *provinceID;
@property (nullable, nonatomic, retain) NSString *cityID;
@property (nullable, nonatomic, retain) NSString *districtID;
@property (nullable, nonatomic, retain) NSString *mainIndustryID;
@property (nullable, nonatomic, retain) NSString *subIndustryID;

@end

NS_ASSUME_NONNULL_END
