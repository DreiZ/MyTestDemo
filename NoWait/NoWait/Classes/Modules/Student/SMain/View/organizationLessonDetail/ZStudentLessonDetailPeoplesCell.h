//
//  ZStudentLessonDetailPeoplesCell.h
//  NoWait
//
//  Created by zhuang zhang on 2020/1/9.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZBaseCell.h"
#import "ZStudentDetailModel.h"

@interface ZStudentLessonDetailPeoplesCell : ZBaseCell
@property (nonatomic,strong) NSArray <ZStudentDetailPersonnelModel *>*list;
@property (nonatomic,strong) void (^selectBlock)(ZStudentDetailPersonnelModel *);
@end
