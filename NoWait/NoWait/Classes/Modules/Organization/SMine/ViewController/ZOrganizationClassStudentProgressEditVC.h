//
//  ZOrganizationClassStudentProgressEditVC.h
//  NoWait
//
//  Created by zhuang zhang on 2020/4/21.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZTableViewViewController.h"
#import "ZOriganizationModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ZOrganizationClassStudentProgressEditVC : ZTableViewViewController
@property (nonatomic,strong) NSString *courses_class_id;
@property (nonatomic,strong) NSString *total_progress;

@end

NS_ASSUME_NONNULL_END
