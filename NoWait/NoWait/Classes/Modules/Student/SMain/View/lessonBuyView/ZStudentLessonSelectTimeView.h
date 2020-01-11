//
//  ZStudentLessonSelectTimeView.h
//  NoWait
//
//  Created by zhuang zhang on 2020/1/9.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZStudentDetailModel.h"


@interface ZStudentLessonSelectTimeView : UIView
@property (nonatomic,assign) ZLessonBuyType buyType;
@property (nonatomic,strong) NSArray <ZStudentDetailLessonTimeModel *>*list;
@property (nonatomic,strong) void (^timeBlock)(ZStudentDetailLessonTimeModel *);
@property (nonatomic,strong) void (^closeBlock)(void);
@property (nonatomic,strong) void (^bottomBlock)(void);
@property (nonatomic,strong) void (^lastStepBlock)(void);
@end

