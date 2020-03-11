//
//  ZOrganizationCampusManagementLocalAddressVC.h
//  NoWait
//
//  Created by zhuang zhang on 2020/2/17.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZTableViewViewController.h"


@interface ZOrganizationCampusManagementLocalAddressVC : ZTableViewViewController
@property (nonatomic,strong) void (^addressBlock)(NSString *province,NSString *city,NSString *county,NSString *brief_address,NSString *address,double latitude, double longitude);
@end

