//
//  ZStudentLessonSelectLessonView.h
//  NoWait
//
//  Created by zhuang zhang on 2020/1/9.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZStudentDetailModel.h"

@interface ZStudentLessonSelectLessonView : UIView
@property (nonatomic,strong) NSMutableArray <ZStudentDetailLessonListModel *>*list;
@property (nonatomic,strong) void (^lessonBlock)(ZStudentDetailLessonListModel *);
@property (nonatomic,strong) void (^closeBlock)(void);
@end

