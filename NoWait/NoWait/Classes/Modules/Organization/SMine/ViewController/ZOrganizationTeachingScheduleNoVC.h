//
//  ZOrganizationTeachingScheduleNoVC.h
//  NoWait
//
//  Created by zhuang zhang on 2020/2/25.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZTableViewViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZOrganizationTeachingScheduleNoVC : ZTableViewViewController
@property (nonatomic,assign) BOOL isBu;
@property (nonatomic,assign) BOOL isEdit;
@property (nonatomic,strong) void (^editChangeBlock)(BOOL);
@end

NS_ASSUME_NONNULL_END
