//
//  lwFind_MapVC.m
//  shopCart
//
//  Created by lw on 16/4/21.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "lwFind_MapVC.h"

@interface lwFind_MapVC ()

<
    MAMapViewDelegate
>

{
    MAMapView *_mapView;
}

@end

@implementation lwFind_MapVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initMapView];
}

- (void)viewWillAppear:(BOOL)animated{
    [lwLocation sharedInstance];
}


- (void)initMapView{
    _mapView = [[MAMapView alloc]init];
    _mapView.delegate = self;
    [self.view addSubview:_mapView];
    NSLog(@"%.2f%.2f",[lwLocation sharedInstance].lwLatitude,[lwLocation sharedInstance].lwLongitude);
    [_mapView setCenterCoordinate:[lwLocation sharedInstance].coordinate];
    
    [_mapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.right.mas_equalTo(0);
    }];
}



@end
