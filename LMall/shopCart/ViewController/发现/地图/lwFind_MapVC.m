//
//  lwFind_MapVC.m
//  shopCart
//
//  Created by lw on 16/4/21.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "lwFind_MapVC.h"
#import "lwCustomAnnotationView.h"

enum {
    AnnotationViewControllerAnnotationTypeRed = 0,
    AnnotationViewControllerAnnotationTypeGreen,
    AnnotationViewControllerAnnotationTypePurple
};


@interface lwFind_MapVC ()

<
    MAMapViewDelegate
>

{
    MAMapView *_mapView;
}
@property (nonatomic, strong) NSMutableArray *annotations;

@end

@implementation lwFind_MapVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self initMapView];
    [self initAnnotations];
}

- (void)viewWillAppear:(BOOL)animated{
    [[lwLocation sharedInstance] startLocation];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [_mapView addAnnotations:self.annotations];
    [_mapView showAnnotations:self.annotations edgePadding:UIEdgeInsetsMake(20, 20, 20, 80) animated:YES];
}


- (void)initMapView{
    _mapView = [[MAMapView alloc]initWithFrame:CGRectMake(0, 0, lW, self.view.frame.size.height)];
    _mapView.delegate = self;
    _mapView.userTrackingMode = MAUserTrackingModeFollow;
    _mapView.showsUserLocation = YES;
    _mapView.zoomEnabled = YES;
    _mapView.showsCompass = YES;
    _mapView.zoomLevel = 13.0;
    [_mapView setCenterCoordinate:CLLocationCoordinate2DMake(31.5844729142,120.3313552955) animated:YES];
    [self.view addSubview:_mapView];
}

- (void)initAnnotations
{
    self.annotations = [NSMutableArray array];
    
    CLLocationCoordinate2D coordinates[10] = {
        {31.5844729142,120.3313552955},
        {31.52447,120.3213},
        {31.54447,120.3313},
        {31.55447,120.3413},
        {31.56447,120.3513},
        {31.57447,120.3613},
        {31.58447,120.3713},
        {31.59447,120.3813},
        {31.50447,120.3913},
        {31.51447,120.3013}};
    
    for (int i = 0; i < 10; ++i)
    {
        MAPointAnnotation *a1 = [[MAPointAnnotation alloc] init];
        a1.coordinate = coordinates[i];
        a1.title      = [NSString stringWithFormat:@"anno: %d", i];
        a1.subtitle   = @"不变啊是哦啊华盛顿";
        [self.annotations addObject:a1];
    }
}

#pragma mark - MAMapViewDelegate

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *reuseIndetifier = @"annotationReuseIndetifier";
        lwCustomAnnotationView *annotationView = (lwCustomAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseIndetifier];
        if (annotationView == nil)
        {
            annotationView = [[lwCustomAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:reuseIndetifier];
        }
        annotationView.image = [UIImage imageNamed:@"find_map"];
        // 设置为NO，用以调用自定义的calloutView
        annotationView.canShowCallout = NO;
        // 设置中心点偏移，使得标注底部中间点成为经纬度对应点
        annotationView.centerOffset = CGPointMake(0, -18);
        return annotationView;
    }
    return nil;
}

- (void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view{
    [mapView setCenterCoordinate:view.annotation.coordinate animated:YES];
}

- (void)dealloc{
    _mapView = nil;
    [_mapView removeFromSuperview];
}



@end
