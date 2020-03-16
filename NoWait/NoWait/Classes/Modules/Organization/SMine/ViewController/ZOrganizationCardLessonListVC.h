//
//  ZOrganizationCardLessonListVC.h
//  NoWait
//
//  Created by zhuang zhang on 2020/3/16.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZTableViewViewController.h"
#import "ZOriganizationLessonModel.h"

@interface ZOrganizationCardLessonListVC : ZTableViewViewController
@property (nonatomic,strong) NSArray <ZOriganizationLessonListModel *> *lessonList;

@end

