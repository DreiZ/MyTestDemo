//
//  ZOrganizationTeacherLessonSelectCell.h
//  NoWait
//
//  Created by zhuang zhang on 2020/2/21.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZBaseCell.h"
#import "ZOriganizationModel.h"
#import "ZOriganizationLessonModel.h"

@interface ZOrganizationTeacherLessonSelectCell : ZBaseCell
@property (nonatomic,strong) ZOriganizationLessonListModel *model;

@property (nonatomic,strong) void (^handleBlock)(NSString *);
@property (nonatomic,strong) void (^selectedBlock)(void);
@end

