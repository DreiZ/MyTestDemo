//
//  ZOriganizationLessonModel.m
//  NoWait
//
//  Created by zhuang zhang on 2020/2/27.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOriganizationLessonModel.h"

@implementation ZOriganizationLessonModel

@end


@implementation ZOriganizationLessonListModel


@end


@implementation ZOriganizationLessonListNetModel


@end

@implementation ZOriganizationLessonAddModel
- (instancetype)init {
    self = [super init];
    if (self) {
        self.lessonName = @"";
        self.lessonIntro = @"";
        self.lessonDetail = @[].mutableCopy;
        self.lessonPrice= @"";
        self.lessonImages = @[].mutableCopy;
        self.school = @"";
        self.level = @"";
        self.singleTime = @"";
        self.lessonNum = @"";
        self.lessonPeoples=  @"";
        self.orderPrice = @"";//预约价格
        self.orderMin = @"";//预约时间
        self.orderTimeBegin = @"";//预约时间段
        self.orderTimeEnd = @"";//预约时间段结束

        self.validity = @"";//有效期
        self.isGu = @"";//0：固定时间 1:人满开课
        self.guTimeArr = @[].mutableCopy;//固定时间
    }
    return self;
}
@end
