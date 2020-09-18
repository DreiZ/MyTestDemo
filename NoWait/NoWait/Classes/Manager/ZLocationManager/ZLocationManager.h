//
//  ZLocationManager.h
//  NoWait
//
//  Created by zhuang zhang on 2020/4/13.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "POIAnnotation.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>

@interface ZLocationDataModel : ZBaseModel
@property (nonatomic,strong) NSString * latitude;
@property (nonatomic,strong) NSString * longitude;
@property (nonatomic,strong) NSString *city;
@property (nonatomic,strong) NSString *district;
@property (nonatomic,strong) NSString *citycode;
@property (nonatomic,strong) NSString *adcode;
@end

@interface ZLocationManager : NSObject
@property (nonatomic,strong) CLLocation *location;
@property (nonatomic,strong) NSString *city;
@property (nonatomic,strong) NSString *district;
@property (nonatomic,strong) NSString *citycode;
@property (nonatomic,strong) NSString *adcode;

@property (nonatomic,strong) void (^locationMainBlock)(CLLocation *);
+ (ZLocationManager *)shareManager;
- (void)startLocation;
- (void)startLocationing;
//精确定位
- (void)startDetailLocation;
//- (NSString *)getDistanceWithLocation:(CLLocationCoordinate2D)loc1  locationOther:(CLLocationCoordinate2D )loc2;
@end


