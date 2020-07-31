//
//  ZLocationManager.m
//  NoWait
//
//  Created by zhuang zhang on 2020/4/13.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZLocationManager.h"
#import <AMapSearchKit/AMapSearchKit.h>

static ZLocationManager *shareManager = NULL;

@interface ZLocationManager ()<MAMapViewDelegate,AMapSearchDelegate,AMapLocationManagerDelegate>

@property (nonatomic,strong) MAMapView *iMapView;
@property (nonatomic,strong) AMapSearchAPI *search;
@property (nonatomic,strong) AMapLocationManager *locationManager;
@end

@implementation ZLocationManager
+ (ZLocationManager *)shareManager
{
    static ZLocationManager *helper;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        helper = [[ZLocationManager alloc] init];
        [helper configLocationManager];
    });
    return helper;
}
- (void)configLocationManager
{
    self.locationManager = [[AMapLocationManager alloc] init];

    [self.locationManager setDelegate:self];
    
    [self.locationManager setDistanceFilter:1000];

    [self.locationManager setPausesLocationUpdatesAutomatically:NO];

    [self.locationManager setAllowsBackgroundLocationUpdates:NO];
}

- (void)startLocation
{
    //开始定位
    [self.locationManager startUpdatingLocation];
}

- (void)stopSerialLocation
{
    //停止定位
    [self.locationManager stopUpdatingLocation];
}

- (void)amapLocationManager:(AMapLocationManager *)manager didFailWithError:(NSError *)error
{
    //定位错误
    DLog(@"%s, amapLocationManager = %@, error = %@", __func__, [manager class], error);
}

- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location
{
    self.location = location;
    if (self.locationMainBlock) {
        self.locationMainBlock(location);
    }
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:location
                   completionHandler:^(NSArray <CLPlacemark *>*placemarks, NSError *error) {
        if (!error) {
            for (CLPlacemark *place in placemarks) {
                DLog(@"name,%@",place.name); // 位置名
                DLog(@"thoroughfare,%@",place.thoroughfare);// 街道
                DLog(@"subThoroughfare,%@",place.subThoroughfare);// 子街道
                DLog(@"locality,%@",place.locality);// 市                          NSLog(@"subLocality,%@",place.subLocality);        // 区
                DLog(@"country,%@",place.country); // 国家
                self.city = place.locality;
                
            }
            [self stopSerialLocation];
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:KNotificationPoiBack object:nil];
    }];
    //定位结果
    DLog(@"location:{lat:%f; lon:%f; accuracy:%f}", location.coordinate.latitude, location.coordinate.longitude, location.horizontalAccuracy);
}

@end
