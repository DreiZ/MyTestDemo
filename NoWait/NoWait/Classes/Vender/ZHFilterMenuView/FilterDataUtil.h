//
//  FilterDataUtil.h
//  ZHFilterMenuView
//
//  Created by 周亚楠 on 2019/12/19.
//  Copyright © 2019 Zhou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"

/** 筛选类型 */
typedef NS_ENUM(NSUInteger, FilterType) {
    FilterTypeIsNewHouse = 1,  //
    FilterTypeFilterMain,      //机构筛选
    FilterTypeISRent,          //
};


@interface FilterDataUtil : NSObject
- (NSMutableArray *)getTabDataByType:(FilterType)type;
@end

