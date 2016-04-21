//
//  lwLocation.h
//  OrderingFood
//
//  Created by lw on 15/12/17.
//  Copyright © 2015年 lw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MAMapKit/MAMapKit.h>


@interface lwLocation : NSObject<CLLocationManagerDelegate>{
    @private
    CLLocationManager *locationManager;
}

@property (nonatomic) CLLocationCoordinate2D coordinate;

@property (nonatomic) double lwLatitude;
@property (nonatomic) double lwLongitude;

// 单例
+ (lwLocation *)sharedInstance;

- (void)startLocation;

@end
