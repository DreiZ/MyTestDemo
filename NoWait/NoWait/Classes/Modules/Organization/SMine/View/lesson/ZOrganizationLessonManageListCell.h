//
//  ZOrganizationLessonManageListCell.h
//  NoWait
//
//  Created by zhuang zhang on 2020/2/25.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZBaseCell.h"
#import "ZOriganizationLessonModel.h"


@interface ZOrganizationLessonManageListCell : ZBaseCell
@property (nonatomic,strong) ZOriganizationLessonListModel *model;

@property (nonatomic,strong) void (^handleBlock)(NSInteger,ZOriganizationLessonListModel *);
@end

