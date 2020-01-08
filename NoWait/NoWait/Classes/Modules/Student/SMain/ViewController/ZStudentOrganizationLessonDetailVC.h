//
//  ZStudentOrganizationLessonDetailVC.h
//  NoWait
//
//  Created by zhuang zhang on 2020/1/8.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZViewController.h"

//tableview偏移类型
typedef NS_ENUM(NSInteger, OffsetType) {
    OffsetTypeMin,
    OffsetTypeCenter,
    OffsetTypeMax,
};

@interface ZStudentOrganizationLessonDetailVC : ZViewController
@property (nonatomic, assign) OffsetType offsetType;
@end

