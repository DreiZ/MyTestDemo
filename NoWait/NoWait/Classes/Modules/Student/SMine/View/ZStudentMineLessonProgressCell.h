//
//  ZStudentMineLessonProgressCell.h
//  NoWait
//
//  Created by zhuang zhang on 2020/1/4.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZBaseCell.h"
#import "ZOriganizationModel.h"


@interface ZStudentMineLessonProgressCell : ZBaseCell
@property (nonatomic,strong) NSArray<ZOriganizationClassListModel*> *list;
@property (nonatomic,strong) void (^moreBlock)(NSInteger);
@property (nonatomic,strong) void (^handleBlock)(ZOriganizationClassListModel *);
@end

