//
//  ZStudentLessonSelectTimeSubCell.h
//  NoWait
//
//  Created by zhuang zhang on 2020/1/10.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZBaseCell.h"
#import "ZStudentDetailModel.h"

@interface ZStudentLessonSelectTimeSubCell : ZBaseCell
@property (nonatomic,strong) NSArray <ZStudentDetailLessonTimeSubModel *>*list;
@property (nonatomic,strong) void (^timeBlock)(NSInteger);
@end

