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
@property (nonatomic,assign) lessonBuyType buyType;
@property (nonatomic,strong) NSArray <ZStudentDetailLessonListModel *>*list;
@property (nonatomic,strong) void (^lessonBlock)(ZStudentDetailLessonListModel *);
@property (nonatomic,strong) void (^closeBlock)(void);
@property (nonatomic,strong) void (^bottomBlock)(void);
@end

