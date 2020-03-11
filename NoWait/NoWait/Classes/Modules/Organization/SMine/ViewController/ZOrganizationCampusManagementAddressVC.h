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
@property (nonatomic,strong) void (^addressBlock)(NSString *province,NSString *city,NSString *county,NSString *brief_address,NSString *address,double latitude, double longitude);
@end

NS_ASSUME_NONNULL_END
