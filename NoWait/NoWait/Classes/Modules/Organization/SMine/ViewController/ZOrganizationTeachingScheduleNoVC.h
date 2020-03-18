//
//  ZOrganizationTeachingScheduleNoVC.h
//  NoWait
//
//  Created by zhuang zhang on 2020/2/25.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZTableViewViewController.h"
#import "ZOriganizationModel.h"

@interface ZOrganizationTeachingScheduleNoVC : ZTableViewViewController
@property (nonatomic,assign) BOOL isBu;
@property (nonatomic,assign) BOOL isEdit;
@property (nonatomic,strong) void (^editChangeBlock)(BOOL);
@property (nonatomic,strong) ZOriganizationSchoolListModel *school;
@end
