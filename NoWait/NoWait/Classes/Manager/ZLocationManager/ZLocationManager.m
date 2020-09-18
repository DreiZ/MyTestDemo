//
//  ZLocationManager.m
//  NoWait
//
//  Created by zhuang zhang on 2020/4/13.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZLocationManager.h"
#import <AMapSearchKit/AMapSearchKit.h>
#import "ZAlertView.h"

static ZLocationManager *shareManager = NULL;

@implementation ZLocationDataModel

@end

@interface ZLocationManager ()<MAMapViewDelegate,AMapSearchDelegate,AMapLocationManagerDelegate>

@property (nonatomic,strong) MAMapView *iMapView;
@property (nonatomic,strong) AMapSearchAPI *search;
@property (nonatomic,strong) AMapLocationManager *locationManager;
@property (nonatomic,strong) CLLocationManager *zlocationManager;
@property (nonatomic,assign) BOOL askAuth;
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


#pragma mark - Cache
- (void)readCacheData {
    ZLocationDataModel *locationModel = (ZLocationDataModel *)[ZDefaultCache() objectForKey:[ZLocationDataModel className]];
    
    _location = [[CLLocation alloc] initWithLatitude:[locationModel.latitude doubleValue] longitude:[locationModel.longitude doubleValue]];
    _city = locationModel.city;
    _district = locationModel.district;
    _citycode = locationModel.citycode;
    _adcode = locationModel.adcode;
}

- (void)writeDataToCache {
    ZLocationDataModel *locationModel = [[ZLocationDataModel alloc] init];
    locationModel.city = _city;
    locationModel.district = _district;
    locationModel.citycode = _citycode;
    locationModel.adcode = _adcode;
    locationModel.latitude = [NSString stringWithFormat:@"%f",_location.coordinate.latitude];
    locationModel.longitude = [NSString stringWithFormat:@"%f",_location.coordinate.longitude];
    
    [ZDefaultCache() setObject:locationModel forKey:[ZLocationDataModel className]];
}

- (void)configLocationManager
{
    [self readCacheData];
    
    self.locationManager = [[AMapLocationManager alloc] init];

    [self.locationManager setDelegate:self];
    
    [self.locationManager setDistanceFilter:100];
    
    [self.locationManager setLocatingWithReGeocode:YES];

    [self.locationManager setPausesLocationUpdatesAutomatically:NO];

    [self.locationManager setAllowsBackgroundLocationUpdates:NO];
    
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
}

- (CLLocationManager *)zlocationManager {
    if (!_zlocationManager) {
        _zlocationManager = [[CLLocationManager alloc] init];
    }
    return _zlocationManager;
}

- (void)startLocationing{
    if (@available(iOS 14.0, *)) {
        
        if (self.zlocationManager.accuracyAuthorization == CLAccuracyAuthorizationReducedAccuracy) {
        
            [self.zlocationManager requestTemporaryFullAccuracyAuthorizationWithPurposeKey:@"wantZoning" completion:^(NSError *error) {
                
                //开始定位单次定位
                [self.locationManager startUpdatingLocation];
            }];
            
        }else{
            
            //开始定位单次定位
            [self.locationManager startUpdatingLocation];
        }
    }else{
        
        //开始定位单次定位
        [self.locationManager startUpdatingLocation];
    }
    
}

- (void)startLocation {
    DLog(@"-------ssss");
    if (@available(iOS 14.0, *)) {
        if (self.zlocationManager.accuracyAuthorization == CLAccuracyAuthorizationReducedAccuracy) {
            if (self.citycode && self.city && self.location) {
                DLog(@"--------已有数据");
                return;
            }
            [self.zlocationManager requestTemporaryFullAccuracyAuthorizationWithPurposeKey:@"wantZoning" completion:^(NSError *error) {
                [self locateAction];
//                if (!self.askAuth) {
//                    [self performSelector:@selector(locateAction) withObject:nil afterDelay:5.0];
//                }
//                self.askAuth = YES;
            }];
            return;
        }
    }
    [self locateAction];
}


- (void)startDetailLocation {
    if (@available(iOS 14.0, *)) {
        if (self.zlocationManager.accuracyAuthorization == CLAccuracyAuthorizationReducedAccuracy) {
        
            [self.zlocationManager requestTemporaryFullAccuracyAuthorizationWithPurposeKey:@"wantZoning" completion:^(NSError *error) {
                [self locateAction];
//                if (!self.askAuth) {
//                    [self performSelector:@selector(locateAction) withObject:nil afterDelay:5.0];
//                }
//                self.askAuth = YES;
            }];
            return;
        }
    }
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
//            [self stopSerialLocation];
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:KNotificationPoiBack object:nil];
    }];
    //定位结果
    DLog(@"location:{lat:%f; lon:%f; accuracy:%f}", location.coordinate.latitude, location.coordinate.longitude, location.horizontalAccuracy);
}

- (void)locateAction {
    //带逆地理的单次定位
    [self configLocationManager];
    DLog(@"------ 一次性定位");
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
        DLog(@"citycode location:%@", location);
        self.location = location;
        //逆地理信息
        if (regeocode)
        {
            DLog(@"reGeocode:%@", regeocode);
            self.city = regeocode.city;
            self.citycode = regeocode.citycode;
            self.district = regeocode.district;
            self.adcode = regeocode.adcode;
            [self writeDataToCache];
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:KNotificationPoiBack object:nil];
    }];
}

@end
