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
        self.stores_id = @"";
        self.lessonID = @"";
        self.image_net_url = @"";
        self.is_experience = @"2";
        self.name = @"";
        self.short_name = @"";
        self.info = @"";
        self.price = @"";
        self.images = @[].mutableCopy;
        self.net_images = @[].mutableCopy;
        self.school = @"";
        self.level = @"1";
        self.course_min = @"";
        self.course_number = @"";
        self.course_class_number =  @"";
        self.orderPrice = @"";//预约价格
        self.orderMin = @"";//预约时间
        self.orderTimeBegin = @"00:00";//预约时间段
        self.orderTimeEnd = @"00:00";//预约时间段结束

        self.experience_time = @[].mutableCopy;
        self.valid_at = @"";//有效期
        self.type = @"1";//1：固定时间 2:人满开课
        self.fix_time = @[].mutableCopy;//固定时间
        self.p_information = @"";
    }
    return self;
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"schoolID" : @"id",
            };
}
@end
