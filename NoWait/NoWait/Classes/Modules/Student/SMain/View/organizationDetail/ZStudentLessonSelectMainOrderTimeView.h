//
//  ZStudentLessonSelectMainOrderTimeView.h
//  NoWait
//
//  Created by zhuang zhang on 2020/6/16.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZStudentLessonSelectMainOrderTimeView : UIView
@property (nonatomic,strong) NSArray *experience_time;
@property (nonatomic,strong) ZOriganizationLessonExperienceTimeModel *timeModel;

@property (nonatomic,strong) void (^completeBlock)(ZOriganizationLessonExperienceTimeModel*);

- (void)showToTime;
@end

NS_ASSUME_NONNULL_END
