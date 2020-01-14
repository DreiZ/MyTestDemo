//
//  ZStudentLessonDetailLessonListCell.h
//  NoWait
//
//  Created by zhuang zhang on 2020/1/9.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZBaseCell.h"
#import "ZStudentDetailModel.h"


@interface ZStudentLessonDetailLessonListCell : ZBaseCell
@property (nonatomic,strong) NSArray <ZStudentDetailDesListModel *>*list;
@property (nonatomic,strong) NSArray <ZStudentDetailDesListModel *>*noSpacelist;
@property (nonatomic,assign) BOOL isHiddenBottomLine;
@end


