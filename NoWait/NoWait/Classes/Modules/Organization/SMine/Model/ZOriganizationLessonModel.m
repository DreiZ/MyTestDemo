//
//  ZOriganizationLessonModel.m
//  NoWait
//
//  Created by zhuang zhang on 2020/2/27.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOriganizationLessonModel.h"
#import "ZBaseUnitModel.h"

@implementation ZOriganizationLessonModel

@end

@implementation ZOriganizationLessonExperienceTimeSubModel

@end

@implementation ZOriganizationLessonExperienceTimeModel
- (NSArray *)timeArr {
    if (!_timeArr) {
        NSMutableArray *tempList = @[].mutableCopy;
        NSMutableArray *beEndArr = @[].mutableCopy;
        
        NSArray *tempArr = [self.time zz_JSONValue];
        for (int i = 0; i < tempArr.count; i++) {
            
            if (ValidStr(tempArr[i])) {
                NSArray *array = [tempArr[i] componentsSeparatedByString:@"~"];
                if (array.count == 2) {
                    NSArray *start = [array[0] componentsSeparatedByString:@":"];
                    NSArray *end = [array[1] componentsSeparatedByString:@":"];
                    if (start && start.count == 2 && end && end.count == 2) {
                        NSInteger begin = [start[0] intValue];
                        NSInteger comptle = [end[0] intValue];
                        
                        for (NSInteger k = begin; k <= comptle; k++) {
                            [beEndArr addObject:[NSString stringWithFormat:@"%ld",(long)k]];
                        }
                    }
                }
            }
        }
        NSMutableArray *sortArr  = [self handleArr:beEndArr];
        for (int kk = 0; kk < sortArr.count; kk++) {
           ZOriganizationLessonExperienceTimeSubModel *model = [[ZOriganizationLessonExperienceTimeSubModel alloc] init];
           if ([sortArr[kk] intValue] < 10) {
               model.time = [NSString stringWithFormat:@"0%@:00",sortArr[kk]];
           }else{
               model.time = [NSString stringWithFormat:@"%@:00",sortArr[kk]];
           }
           model.isSubTimeSelected = NO;
           [tempList addObject:model];
        }
        _timeArr = tempList;
    }
    
    return _timeArr;
}

- (NSMutableArray *)handleArr:(NSMutableArray *)array1 {

    NSMutableArray *array2 = @[].mutableCopy;
    for (NSString *str in array1) {
        if (![array2 containsObject:str]) {
            [array2 addObject:str];
        }
    }
    [self sortArrWithInsertSort:array2];
    return array2;
}

//直接插入排序
- (void)sortArrWithInsertSort:(NSMutableArray *)arr{
    int currentLocation = 1; //记录当前位置(哨兵)
    //从第1个元素开始取，第0个元素默认为有序的序列
    for (int i = 1; i < arr.count ; i++) {
        int tempNum = [[arr objectAtIndex:i] intValue];
        currentLocation = i;
        for (int j = i-1; (tempNum < [[arr objectAtIndex:j] intValue])&&j>=0; j--) {
                [arr exchangeObjectAtIndex:j withObjectAtIndex:currentLocation];
                currentLocation = j;
        }
    }
}
@end

@implementation ZOriganizationLessonListModel
+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"experience_time" : @"ZOriganizationLessonExperienceTimeModel"
             };
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"lessonID" : @"id",
            };
}

- (NSString *)statusStr {
    switch ([self.status intValue]) {
        case 0:
            return @"其它";
            break;
            case 1:
            return @"开放课程";
            break;
            case 2:
            return @"未开放课程";
            break;
            case 3:
            return @"课程审核中";
            break;
            case 4:
            return @"课程审核失败";
            break;
            
        default:
            break;
    }
    return @"其它";
}

- (ZOrganizationLessonType)type {
    switch ([self.status intValue]) {
        case 0:
            return ZOrganizationLessonTypeAll;
            break;
            case 1:
            return ZOrganizationLessonTypeOpen;
            break;
            case 2:
            return ZOrganizationLessonTypeClose;
            break;
            case 3:
            return ZOrganizationLessonTypeExamine;
            break;
            case 4:
            return ZOrganizationLessonTypeExamineFail;
            break;
            
        default:
            break;
    }
    return ZOrganizationLessonTypeClose;
}

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
        self.experience_price = @"";//预约价格
        self.experience_duration = @"";//预约时间

        self.experience_time = @[].mutableCopy;
        self.valid_at = @"";//有效期
        self.type = @"1";//1：固定时间 2:人满开课
        self.fix_time = @[].mutableCopy;//固定时间
        self.p_information = @"";
    }
    return self;
}

- (NSString *)statusStr {
    switch ([self.status intValue]) {
        case 0:
            return @"其它";
            break;
            case 1:
            return @"开放课程";
            break;
            case 2:
            return @"未开放课程";
            break;
            case 3:
            return @"课程审核中";
            break;
            case 4:
            return @"课程审核失败";
            break;
            
        default:
            break;
    }
    return @"其它";
}

- (ZOrganizationLessonType)lessonType {
    switch ([self.status intValue]) {
        case 0:
            return ZOrganizationLessonTypeAll;
            break;
            case 1:
            return ZOrganizationLessonTypeOpen;
            break;
            case 2:
            return ZOrganizationLessonTypeClose;
            break;
            case 3:
            return ZOrganizationLessonTypeExamine;
            break;
            case 4:
            return ZOrganizationLessonTypeExamineFail;
            break;
            
        default:
            break;
    }
    return ZOrganizationLessonTypeClose;
}


+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"lessonID" : @"id",
             @"fix_time_net" : @"fix_time",
             @"experience_time_net" : @"experience_time",
            };
}
@end

@implementation ZOriganizationLessonListNetModel
+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"list" : @"ZOriganizationLessonListModel"
             };
}

@end

@implementation ZOriganizationLessonScheduleListModel
- (NSMutableArray *)fix_timeArr {
    if (!_fix_timeArr) {
        _fix_timeArr = @[].mutableCopy;
        
        if (ValidDict(self.fix_time)) {
            id tempDict1 = self.fix_time;
            if (ValidDict(tempDict1)) {
                NSArray *allKey = [tempDict1 allKeys];
                for (int i = 0; i < allKey.count; i++) {
                    
                    if ([allKey[i] intValue] <= 7 && [allKey[i] intValue] > 0) {
                        ZBaseMenuModel *menuModel = [[ZBaseMenuModel alloc] init];
                        menuModel.name = SafeStr([allKey[i] zz_indexToWeek]);
                        menuModel.uid = allKey[i];
                        
                        NSMutableArray *unit = @[].mutableCopy;
                        
                        if (ValidStr(tempDict1[allKey[i]])) {
                            NSArray *dataArr = [tempDict1[allKey[i]] zz_JSONValue];
                            for (int k = 0; k < dataArr.count; k++) {
                                if (ValidStr(dataArr[k])) {
                                    NSString *str = dataArr[k];
                                    NSArray *array = [str componentsSeparatedByString:@"~"];
                                    if (ValidArray(array) && array.count == 2) {
                                        NSString *hour = array[0];
                                        NSArray *hourArray = [hour componentsSeparatedByString:@":"];
                                        if (ValidArray(hourArray) && hourArray.count == 2) {
                                            ZBaseUnitModel *umodel = [[ZBaseUnitModel alloc] init];
                                            umodel.data = hour;
                                            umodel.name = [NSString stringWithFormat:@"%d",[hourArray[0] intValue]];
                                            umodel.subName = [NSString stringWithFormat:@"%d",[hourArray[1] intValue]];
                                            [unit addObject:umodel];
                                        }
                                    }
                                }
                            }
                        }
                        
                        menuModel.units = unit;
                        
                        [_fix_timeArr addObject:menuModel];
                    }
                }
            }
        }
    }
    
    return _fix_timeArr;
}
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"lessonID" : @"id",
             @"fixType" : @"type",
            };
}
@end


@implementation ZOriganizationLessonTeacherModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"teacher_id" : @"id",
            };
}
@end

@implementation ZOriganizationLessonDetailModel
+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"teacher_list" : @"ZOriganizationLessonTeacherModel",
             @"coupons_list" : @"ZOriganizationCardListModel"
             };
}
@end


@implementation ZOriganizationLessonScheduleListNetModel
+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"list" : @"ZOriganizationLessonScheduleListModel"
             };
}
@end
