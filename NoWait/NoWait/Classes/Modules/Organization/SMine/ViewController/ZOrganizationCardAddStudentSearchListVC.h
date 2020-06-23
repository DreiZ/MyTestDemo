//
//  ZOrganizationCardAddStudentSearchListVC.h
//  NoWait
//
//  Created by zhuang zhang on 2020/6/23.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZSearchClickVC.h"
#import "ZOriganizationLessonModel.h"
#import "ZOriganizationModel.h"


@interface ZOrganizationCardAddStudentSearchListVC : ZSearchClickVC
@property (nonatomic,strong) void (^handleBlock)(NSArray *);
@end

