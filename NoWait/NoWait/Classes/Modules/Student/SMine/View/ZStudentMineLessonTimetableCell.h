//
//  ZStudentMineLessonTimetableCell.h
//  NoWait
//
//  Created by zhuang zhang on 2020/3/27.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZBaseCell.h"
#import "ZOriganizationModel.h"


@interface ZStudentMineLessonTimetableCell : ZBaseCell
@property (nonatomic,strong) NSArray<ZOriganizationLessonListModel*> *list;
@property (nonatomic,strong) void (^moreBlock)(NSInteger);
@end


