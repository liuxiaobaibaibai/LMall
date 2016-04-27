//
//  StoreInfo.h
//  
//
//  Created by lw on 16/4/27.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "AppDelegate.h"


NS_ASSUME_NONNULL_BEGIN

typedef void(^coreBlcok)(id result, NSError *error);

@interface StoreInfo : NSManagedObject
{
    AppDelegate *app;
}

// Insert code here to declare functionality of your managed object subclass

+ (void)insertStoreInfo:(StoreInfo *)store Completion:(coreBlcok)completion;

+ (void)updateStoreInfo:(StoreInfo *)store Completion:(coreBlcok)completion;

+ (void)searchStoreInfo:(StoreInfo *)store Completion:(coreBlcok)completion;

+ (void)deleteStoreInfo:(StoreInfo *)store Completion:(coreBlcok)completion;

- (void)insertStoreInfo:(StoreInfo *)store Completion:(coreBlcok)completion;

- (void)updateStoreInfo:(StoreInfo *)store Completion:(coreBlcok)completion;

- (void)searchStoreInfo:(StoreInfo *)store Completion:(coreBlcok)completion;

- (void)deleteStoreInfo:(StoreInfo *)store Completion:(coreBlcok)completion;

@end

NS_ASSUME_NONNULL_END

#import "StoreInfo+CoreDataProperties.h"
