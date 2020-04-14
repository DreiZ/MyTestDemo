//
//  ZLocationManager.m
//  NoWait
//
//  Created by zhuang zhang on 2020/4/13.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZLocationManager.h"



static ZLocationManager *shareManager = NULL;

@interface ZLocationManager ()<MAMapViewDelegate,AMapSearchDelegate>

@property (nonatomic,strong) MAMapView *iMapView;

@end

@implementation ZLocationManager
+ (ZLocationManager *)shareManager
{
    static ZLocationManager *helper;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        helper = [[ZLocationManager alloc] init];
    });
    return helper;
}

- (void)startLocation {
    // 开启定位
    self.iMapView.showsUserLocation = YES;
    self.iMapView.userTrackingMode = MAUserTrackingModeFollow;
}

- (MAMapView *)iMapView {
    if (!_iMapView) {
        _iMapView = [[MAMapView alloc] init];
        _iMapView.delegate = self;
    }
    return _iMapView;
}


- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation {
    _cureUserLocation = userLocation;
    if (self.locationMainBlock) {
        self.locationMainBlock(userLocation);
    }

}


- (NSString *)getDistanceWithLocation:(CLLocationCoordinate2D)loc1  locationOther:(CLLocationCoordinate2D )loc2{
    MAMapPoint p1 = MAMapPointForCoordinate(loc1);
    MAMapPoint p2 = MAMapPointForCoordinate(loc2);
    
    CLLocationDistance distance =  MAMetersBetweenMapPoints(p1, p2);
    if (distance < 1000) {
        return [NSString stringWithFormat:@"距离您%.0fm",distance];
    }else{
         return [NSString stringWithFormat:@"距离您%.2fkm",distance/1000];
    }
}

@end
