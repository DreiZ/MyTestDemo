//
//  ZOrganizationCampusManagementAddressVC.h
//  NoWait
//
//  Created by zhuang zhang on 2020/2/17.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZTableViewViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZOrganizationCampusManagementAddressVC : ZTableViewViewController
@property (nonatomic,strong) NSString *brief_address;
@property (nonatomic,strong) NSString *address;
@property (nonatomic,strong) NSString *province;
@property (nonatomic,strong) NSString *city;
@property (nonatomic,strong) NSString *county;

@property (nonatomic,assign) double latitude;
@property (nonatomic,assign) double longitude;

@property (nonatomic,strong) void (^addressBlock)(NSString *province,NSString *city,NSString *county,NSString *brief_address,NSString *address,double latitude, double longitude);
@end

NS_ASSUME_NONNULL_END
