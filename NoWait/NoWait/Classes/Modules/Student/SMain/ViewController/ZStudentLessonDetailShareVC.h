//
//  ZStudentLessonDetailShareVC.h
//  NoWait
//
//  Created by zhuang zhang on 2020/6/17.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZTableViewController.h"
#import "ZOriganizationLessonModel.h"

@interface ZStudentLessonDetailShareVC : ZTableViewController
@property (nonatomic,assign) BOOL isOrder;
@property (nonatomic,strong) ZOriganizationLessonDetailModel *addModel;
@end

