//
//  StoreInfo.m
//  
//
//  Created by lw on 16/4/28.
//
//

#import "StoreInfo.h"
#import "AppDelegate.h"

static AppDelegate *app;
@implementation StoreInfo

// Insert code here to add functionality to your managed object subclass
+ (void)insertStoreInfo:(NSDictionary *)store Completion:(coreBlcok)completion{
    app = [[UIApplication sharedApplication] delegate];
    StoreInfo *s = (StoreInfo *)[NSEntityDescription insertNewObjectForEntityForName:@"StoreInfo" inManagedObjectContext:app.managedObjectContext];
    
    [s setStoreID:@"1"];
    [s setName:@"我是商家"];
    [s setShortName:@"商家"];
    [s setAccount:@"18861836885"];
    [s setProvince:@"江苏"];
    [s setCity:@"无锡"];
    [s setDistrict:@"崇安区"];
    [s setAddress:@"北塘区锡澄路274-17 金顺客二楼"];
    [s setCoordinates:@"21.224551,120.264313556"];
    [s setHeadaerpic:@"header"];
    [s setLogo:@"cry"];
    [s setMail:@"123456789@qq.com"];
    [s setTelephone:@"4000510408"];
    [s setIdNumber:@"360430199923121234"];
    [s setIdCardFont:@"commodity_Test"];
    [s setIdCardBack:@"commodity_Test"];
    [s setCreditCode:@"123123123"];
    [s setBusinessLicense:@"cry"];
    [s setMainIndustry:@"IT,软件"];
    [s setSubIndustry:@"金融,信贷"];
    [s setBankName:@"中国建设银行"];
    [s setBankUsername:@"张忠"];
    [s setBankNo:@"6221 822431326564485115"];
    [s setProvinceID:@"12"];
    [s setCityID:@"34"];
    [s setDistrictID:@"56"];
    [s setMainIndustryID:@"78"];
    [s setSubIndustryID:@"90"];
    [s setSetup:5];
    
    NSError *error = nil;
    
    BOOL success = [app.managedObjectContext save:&error];
    
    if (success) {
        
        NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSLog(@"插入成功\n%@",pathArray[0]);
        
        
    }else{
        NSLog(@"失败：%@",error.userInfo);
        
    }
}

+ (void)setarchStoreInfo:(NSPredicate *)predicate Completion:(coreBlcok)completion{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"StoreInfo"];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"StoreInfo" inManagedObjectContext:app.managedObjectContext];
    [request setEntity:entity];
    [request setPredicate:predicate];

    NSError *error = nil;
    NSMutableArray *resultArray = [[app.managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
    
    if (resultArray == nil) {
        NSLog(@"Error:%@",error);
        completion(nil,error);
    }else{
        completion(resultArray,nil);
    }
    
    
    
    
}

@end
















