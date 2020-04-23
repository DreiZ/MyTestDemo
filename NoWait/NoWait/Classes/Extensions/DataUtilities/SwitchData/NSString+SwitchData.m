//
//  NSString+SwitchData.m
//  CGBaseProject
//
//  Created by chrise on 2018/3/15.
//  Copyright © 2018年 chrise. All rights reserved.
//

#import "NSString+SwitchData.h"

@implementation NSString (SwitchData)
/**
 带子节的string转为NSData
 
 @return NSData类型
 */
-(NSData*) convertBytesStringToData {
    NSMutableData* data = [NSMutableData data];
    int idx;
    for (idx = 0; idx+2 <= self.length; idx+=2) {
        NSRange range = NSMakeRange(idx, 2);
        NSString* hexStr = [self substringWithRange:range];
        NSScanner* scanner = [NSScanner scannerWithString:hexStr];
        unsigned int intValue;
        [scanner scanHexInt:&intValue];
        [data appendBytes:&intValue length:1];
    }
    return data;
}
/**
 十进制转十六进制
 
 @return 十六进制字符串
 */
- (NSString *)decimalToHex {
    long long int tmpid = [self intValue];
    NSString *nLetterValue;
    NSString *str = @"";
    long long int ttmpig;
    for (int i = 0; i < 9; i++) {
        ttmpig = tmpid % 16;
        tmpid = tmpid / 16;
        switch (ttmpig) {
            case 10:
                nLetterValue = @"A";
                break;
            case 11:
                nLetterValue = @"B";
                break;
            case 12:
                nLetterValue = @"C";
                break;
            case 13:
                nLetterValue = @"D";
                break;
            case 14:
                nLetterValue = @"E";
                break;
            case 15:
                nLetterValue = @"F";
                break;
            default:
                nLetterValue = [[NSString alloc]initWithFormat:@"%lli", ttmpig];
        }
        str = [nLetterValue stringByAppendingString:str];
        if (tmpid == 0) {
            break;
        }
    }
    return str;
}
/**
 十进制转十六进制
 length   总长度，不足补0
 @return 十六进制字符串
 */
- (NSString *)decimalToHexWithLength:(NSUInteger)length{
    NSString* subString = [self decimalToHex];
    NSUInteger moreL = length - subString.length;
    if (moreL>0) {
        for (int i = 0; i<moreL; i++) {
            subString = [NSString stringWithFormat:@"0%@",subString];
        }
    }
    return subString;
}
/**
 十六进制转十进制
 
 @return 十进制字符串
 */
- (NSString *)hexToDecimal {
    return [NSString stringWithFormat:@"%lu",strtoul([self UTF8String],0,16)];
}
/*
 二进制转十进制
 
 @return 十进制字符串
 */
- (NSString *)binaryToDecimal {
    int ll = 0 ;
    int  temp = 0 ;
    for (int i = 0; i < self.length; i ++) {
        temp = [[self substringWithRange:NSMakeRange(i, 1)] intValue];
        temp = temp * powf(2, self.length - i - 1);
        ll += temp;
    }
    NSString * result = [NSString stringWithFormat:@"%d",ll];
    return result;
}
/**
 十进制转二进制
 
 @return 二进制字符串
 */
- (NSString *)decimalToBinary {
    NSInteger num = [self integerValue];
    NSInteger remainder = 0;      //余数
    NSInteger divisor = 0;        //除数
    NSString * prepare = @"";
    
    while (true) {
        remainder = num%2;
        divisor = num/2;
        num = divisor;
        prepare = [prepare stringByAppendingFormat:@"%d",(int)remainder];
        
        if (divisor == 0) {
            break;
        }
    }
    
    NSString * result = @"";
    for (NSInteger i = prepare.length - 1; i >= 0; i --) {
        result = [result stringByAppendingFormat:@"%@",
                  [prepare substringWithRange:NSMakeRange(i , 1)]];
    }
    return [NSString stringWithFormat:@"%08d",[result intValue]];
}
- (NSString *)timestampToStandardtime {
    NSTimeInterval secs = self.doubleValue;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Shanghai"]];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:secs];
    return [formatter stringFromDate:date];
}

- (NSArray *)timestampToStandardtimes {
    NSString *standardTime = [self timestampToStandardtime];
    return [standardTime componentsSeparatedByString:@" "];
}

- (NSString *)timeStringWithFormatter:(NSString *)formotter{
    // timeStampString 是服务器返回的13位时间戳 修改了10位
    NSString *timeStampString  = self;
    
    // iOS 生成的时间戳是10位
    NSTimeInterval interval    =[timeStampString doubleValue] ;
    NSDate *date               = [NSDate dateWithTimeIntervalSince1970:interval];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:formotter];
    NSString *dateString       = [formatter stringFromDate: date];
//    DLog(@"服务器返回的时间戳对应的时间是:%@",dateString);
    
    return dateString;
}
@end
