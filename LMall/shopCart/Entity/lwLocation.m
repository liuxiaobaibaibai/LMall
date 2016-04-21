//
//  lwLocation.m
//  OrderingFood
//
//  Created by lw on 15/12/17.
//  Copyright © 2015年 lw. All rights reserved.
//

#import "lwLocation.h"
#import <MapKit/MapKit.h>

static lwLocation *location = nil;
@implementation lwLocation
@synthesize lwLatitude,lwLongitude;

+ (lwLocation *)sharedInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        location = [[self alloc] init];
    });
    return location;
}

- (id)init{
    if (self = [super init]) {
        // 开始定位
        [self startLocation];
    }
    return self;
}

- (void)startLocation{
    locationManager = [[CLLocationManager alloc] init];
    if (![CLLocationManager locationServicesEnabled]) {
        NSLog(@"定位服务未打开");
        return;
    }

    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined) {
        if (systemVersions<8.0) {
            NSLog(@"不处理");
        }else{
            // 如果没有开启，请求开启
            [locationManager requestAlwaysAuthorization];
        }
    }else if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedAlways){
        // 设置代理
        locationManager.delegate = self;
        // 设置定位精确度
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        // 每隔多少米定位一次
        CLLocationDistance distance = 500.0;
        locationManager.distanceFilter = distance;
        // 启动定位
        [locationManager startUpdatingLocation];
    }
}

// 定位授权变更的时候
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    switch (status) {
        case kCLAuthorizationStatusAuthorizedAlways:
        {
            NSLog(@"总是允许");
            [locationManager startUpdatingLocation];
        }
            break;
        case kCLAuthorizationStatusAuthorizedWhenInUse:
        {
            NSLog(@"当我使用的时候");
            [locationManager startUpdatingLocation];
        }
            break;
        case kCLAuthorizationStatusDenied:
        {
            NSLog(@"这个程序已经被明确禁止");
        }
            break;
        case kCLAuthorizationStatusNotDetermined:
        {
            NSLog(@"用户还没有做出选择");
        }
            break;
        case kCLAuthorizationStatusRestricted:
        {
            NSLog(@"APP 没有被授权");
        }
            break;
        default:
            break;
    }
}

// 定位开始更新的时候
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    CLLocation *location = locations.firstObject;
    [lwLocation sharedInstance].lwLatitude = location.coordinate.latitude;
    [lwLocation sharedInstance].lwLongitude = location.coordinate.longitude;
    [lwLocation sharedInstance].coordinate = location.coordinate;
    [locationManager stopUpdatingLocation];
}

@end
