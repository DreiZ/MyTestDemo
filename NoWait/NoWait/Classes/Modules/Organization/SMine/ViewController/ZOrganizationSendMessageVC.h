//
//  ZOrganizationSendMessageVC.h
//  NoWait
//
//  Created by zhuang zhang on 2020/4/10.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZTableViewViewController.h"
#import "ZOriganizationModel.h"

@interface ZOrganizationSendMessageVC : ZTableViewViewController
@property (nonatomic,strong) NSMutableArray <ZOriganizationStudentListModel *>*studentList;
@property (nonatomic,strong) NSString *lessonName;
@property (nonatomic,strong) NSString *storesName;
@property (nonatomic,strong) NSString *teacherName;
@property (nonatomic,strong) NSString *teacherImage;
@property (nonatomic,strong) NSString *type;

@end

