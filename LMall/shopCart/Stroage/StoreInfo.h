//
//  StoreInfo.h
//  
//
//  Created by lw on 16/4/28.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
@class AppDelegate;

typedef void(^coreBlcok)(id result, NSError *error);

NS_ASSUME_NONNULL_BEGIN


@interface StoreInfo : NSManagedObject
{
    AppDelegate *app;
}

// Insert code here to declare functionality of your managed object subclass

+ (void)insertStoreInfo:(NSDictionary *)store Completion:(coreBlcok)completion;

+ (void)setarchStoreInfo:(NSPredicate *)predicate Completion:(coreBlcok)completion;

@end

NS_ASSUME_NONNULL_END

#import "StoreInfo+CoreDataProperties.h"
