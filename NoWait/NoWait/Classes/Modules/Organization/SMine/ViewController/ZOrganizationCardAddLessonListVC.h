//
//  ZOrganizationCardAddLessonListVC.h
//  NoWait
//
//  Created by zhuang zhang on 2020/3/3.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZTableViewViewController.h"
#import "ZOriganizationModel.h"
#import "ZOriganizationLessonModel.h"

@interface ZOrganizationCardAddLessonListVC : ZTableViewViewController
@property (nonatomic,strong) void (^handleBlock)(NSArray <ZOriganizationLessonListModel *>*, BOOL);
@property (nonatomic,strong) ZOriganizationSchoolListModel *school;
@end

