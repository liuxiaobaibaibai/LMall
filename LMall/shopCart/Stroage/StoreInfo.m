//
//  StoreInfo.m
//  
//
//  Created by lw on 16/4/27.
//
//

#import "StoreInfo.h"

static AppDelegate *app;
@implementation StoreInfo

// Insert code here to add functionality to your managed object subclass

+ (void)insertStoreInfo:(StoreInfo *)store Completion:(coreBlcok)completion{
    app = [[UIApplication sharedApplication] delegate];
    StoreInfo *s = (StoreInfo *)[NSEntityDescription insertNewObjectForEntityForName:@"StoreInfo" inManagedObjectContext:app.managedObjectContext];
    s = store;

    NSError *error = nil;
    
    BOOL success = [app.managedObjectContext save:&error];
    
    if (success) {
        NSLog(@"插入成功");
    }else{
        NSLog(@"失败：%@",error.userInfo);

    }

    
}

+ (void)deleteStoreInfo:(StoreInfo *)store Completion:(coreBlcok)completion{
    
}

+ (void)updateStoreInfo:(StoreInfo *)store Completion:(coreBlcok)completion{
    
}

+ (void)searchStoreInfo:(StoreInfo *)store Completion:(coreBlcok)completion{
    
}



- (void)insertStoreInfo:(StoreInfo *)store Completion:(coreBlcok)completion{
    
}

- (void)deleteStoreInfo:(StoreInfo *)store Completion:(coreBlcok)completion{
    
}

- (void)updateStoreInfo:(StoreInfo *)store Completion:(coreBlcok)completion{
    
}

- (void)searchStoreInfo:(StoreInfo *)store Completion:(coreBlcok)completion{
    
}


@end
