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
    
    [self.locationManager setLocatingWithReGeocode:YES];

    [self.locationManager setPausesLocationUpdatesAutomatically:NO];

    [self.locationManager setAllowsBackgroundLocationUpdates:NO];
    
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
}

- (void)startLocation
{
    //开始定位
//    [self.locationManager startUpdatingLocation];
    [self locateAction];
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
    DLog(@"update---%@",self.location);
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

- (void)locateAction
{
    //带逆地理的单次定位
    [self.locationManager requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {

        if (error)
        {
            DLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);

            if (error.code == AMapLocationErrorLocateFailed)
            {
                return;
            }
        }

        //定位信息
        DLog(@"location:%@", location);
        self.location = location;
        //逆地理信息
        if (regeocode)
        {
            DLog(@"reGeocode:%@", regeocode);
            self.city = regeocode.city;
            self.citycode = regeocode.citycode;
            self.district = regeocode.district;
            self.adcode = regeocode.adcode;
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:KNotificationPoiBack object:nil];
    }];
}

@end
