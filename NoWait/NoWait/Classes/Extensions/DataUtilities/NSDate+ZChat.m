//
//  NSDate+ZChat.m
//  ZBigHealth
//
//  Created by 承希-开发 on 2018/10/16.
//  Copyright © 2018年 承希-开发. All rights reserved.
//

#import "NSDate+ZChat.h"
#import "NSDate+Extensions.h"

@implementation NSDate (ZChat)

- (NSString *)chatTimeInfo
{
    if ([self isToday]) {       // 今天
        return self.formatHM;
    }
    else if ([self isYesterday]) {      // 昨天
        return [NSString stringWithFormat:@"昨天 %@", self.formatHM];
    }
    else if ([self isThisWeek]){        // 本周
        return [NSString stringWithFormat:@"%@ %@", self.formatWeekday, self.formatHM];
    }
    else {
        return [NSString stringWithFormat:@"%@ %@", self.formatYMD, self.formatHM];
    }
}

- (NSString *)conversaionTimeInfo
{
    if ([self isToday]) {       // 今天
        return self.formatHM;
    }
    else if ([self isYesterday]) {      // 昨天
        return @"昨天";
    }
    else if ([self isThisWeek]){        // 本周
        return self.formatWeekday;
    }
    else {
        return [self formatYMDWithSeparate:@"/"];
    }
}

- (NSString *)chatFileTimeInfo
{
    if ([self isThisWeek]) {
        return @"本周";
    }
    else if ([self isThisMonth]) {
        return @"这个月";
    }
    else {
        return [NSString stringWithFormat:@"%ld年%ld月", (long)self.year, (long)self.month];
    }
}



- (NSInteger)getAge {
    NSDateFormatter*df = [[NSDateFormatter alloc] init];//格式化
    [df setDateFormat:@"yyyy/MM/dd"];
    //    NSString *dateStr = @"2001/01/01";
    NSTimeInterval dateDiff = [self timeIntervalSinceNow];
    long age = fabs(dateDiff/(60*60*24))/365;
    NSLog(@"年龄是:%@",[NSString stringWithFormat:@"%ld岁",age]);
    
    //    NSString *year = [dateStr substringWithRange:NSMakeRange(0, 4)];
    //    NSString *month = [dateStr substringWithRange:NSMakeRange(5, 2)];
    //    NSString *day = [dateStr substringWithRange:NSMakeRange(dateStr.length-2, 2)];
    NSString *year = [NSString stringWithFormat:@"%lu",(unsigned long)self.year];
    NSString *month = [NSString stringWithFormat:@"%lu",(unsigned long)self.month];
    NSString *day = [NSString stringWithFormat:@"%lu",(unsigned long)self.day];
//    NSLog(@"出生于%@年%@月%@日", year, month, day);
    
    NSDate *nowDate = [NSDate date];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierISO8601];
    NSDateComponents *compomemts = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitWeekday | NSCalendarUnitDay fromDate:nowDate];
    NSInteger nowYear = compomemts.year;
    NSInteger nowMonth = compomemts.month;
    NSInteger nowDay = compomemts.day;
//    NSLog(@"今天是%ld年%ld月%ld日", nowYear, nowMonth, nowDay);
    
    // 计算年龄
    NSInteger userAge = nowYear - year.intValue - 1;
    if ((nowMonth > month.intValue) || (nowMonth == month.intValue && nowDay >= day.intValue)) {
        userAge++;
    }
//    NSLog(@"用户年龄是%ld",userAge);
    
    return userAge;
}

+ (NSInteger)calcDaysFromBegin:(NSDate *)beginDate end:(NSDate *)endDate
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents *dateCom = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth| NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond fromDate:beginDate];
    
    NSDateComponents *dateEndCom = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth| NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond fromDate:endDate];
    
    
    return dateEndCom.day - dateCom.day;
}
@end
