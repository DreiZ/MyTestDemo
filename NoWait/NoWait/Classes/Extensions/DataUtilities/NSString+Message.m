//
//  NSString+Message.m
//  ZBigHealth
//
//  Created by zhuang zhang on 2018/10/16.
//  Copyright © 2018年 zhuang zhang. All rights reserved.
//

#import "NSString+Message.h"

@implementation NSString (Message)

- (NSAttributedString *)zz_toMessageString;
{
    //1、创建一个可变的属性字符串
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:self];
    [attributeString addAttribute:NSFontAttributeName value:[UIFont fontTextMessageText] range:NSMakeRange(0, self.length)];
    //2、通过正则表达式来匹配字符串
    NSString *regex_emoji = @"\\[[a-zA-Z0-9\\/\\u4e00-\\u9fa5+:]+\\]"; //匹配表情
    
    NSError *error = nil;
    NSRegularExpression *re = [NSRegularExpression regularExpressionWithPattern:regex_emoji options:NSRegularExpressionCaseInsensitive error:&error];
    if (!re) {
        NSLog(@"[NSString toMessageString]: %@", [error localizedDescription]);
        return attributeString;
    }
    
    NSArray *resultArray = [re matchesInString:self options:0 range:NSMakeRange(0, self.length)];
    //3、获取所有的表情以及位置
    //用来存放字典，字典中存储的是图片和图片对应的位置
    NSMutableArray *imageArray = [NSMutableArray arrayWithCapacity:resultArray.count];
    //根据匹配范围来用图片进行相应的替换
    for(NSTextCheckingResult *match in resultArray) {
        //获取数组元素中得到range
        NSRange range = [match range];
        //获取原字符串中对应的值
        NSString *subStr = [self substringWithRange:range];
      
    }
    
    //4、从后往前替换，否则会引起位置问题
    for (int i = (int)imageArray.count -1; i >= 0; i--) {
        NSRange range;
        [imageArray[i][@"range"] getValue:&range];
        //进行替换
        [attributeString replaceCharactersInRange:range withAttributedString:imageArray[i][@"image"]];
    }
    return attributeString;
}


- (NSDictionary *)zz_JSONStringToDictionary
{
    if (self == nil) {
        return nil;
    }

    NSData *jsonData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err)
    {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

-(id)zz_JSONValue {
    NSData* data = [self dataUsingEncoding:NSUTF8StringEncoding];
    __autoreleasing NSError* error = nil;
    id result = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    if (error != nil) return self;
    
    if (result && [result isKindOfClass:[NSDictionary class]]) {
        NSMutableDictionary *tempDict = [[NSMutableDictionary alloc] initWithDictionary:result];
        NSArray *allKey = [tempDict allKeys];
        for (NSString *key in allKey) {
            id subTemp = tempDict[key];
            if ([subTemp isKindOfClass:[NSString class]]) {
                [tempDict setObject:[subTemp zz_JSONValue] forKey:key];
            }
        }
        result = tempDict;
    }else if (result && [result isKindOfClass:[NSArray class]]) {
        NSMutableArray *tempArr = [[NSMutableArray alloc] initWithArray:result];
        for (int i = 0;i < tempArr.count; i++) {
            id temp = tempArr[i];
            if ([temp isKindOfClass:[NSString class]]) {
                [tempArr replaceObjectAtIndex:i withObject:[temp zz_JSONValue]];
            }
        }
        result = tempArr;
    }
    return result;
}

- (NSString *)zz_weekToIndex {
    NSArray *titleArr = @[@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六",@"星期天"];
    for (int i = 0; i < titleArr.count; i++) {
        if ([self isEqualToString:titleArr[i]]) {
            return [NSString stringWithFormat:@"%d",i + 1];
        }
    }
    return @"1";
}

- (NSString *)zz_indexToWeek {
    NSArray *titleArr = @[@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六",@"星期天"];
    if ([self intValue] <= titleArr.count && [self intValue] > 0) {
        return titleArr[[self intValue]-1];
    }
    return @"星期一";
}

@end
