//
//  ZOriganizationLessonModel.h
//  NoWait
//
//  Created by zhuang zhang on 2020/2/27.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZBaseModel.h"
#import "ZBaseNetworkBackModel.h"

//课程管理 课程类别
typedef NS_ENUM(NSInteger, ZOrganizationLessonType) {
    ZOrganizationLessonTypeOpen  =   0,   //开放
    ZOrganizationLessonTypeClose,         //未开放
    ZOrganizationLessonTypeExamine,       //审核中
    ZOrganizationLessonTypeExamineFail,   //审核失败
    ZOrganizationLessonTypeAll,           //全部
};

@interface ZOriganizationLessonModel : ZBaseModel

@end

@interface ZOriganizationLessonListModel : ZBaseModel
@property (nonatomic,strong) NSString *state;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *price;
@property (nonatomic,strong) NSString *sale;
@property (nonatomic,strong) NSString *score;
@property (nonatomic,strong) NSString *image;
@property (nonatomic,strong) NSString *fail;
@property (nonatomic,assign) ZOrganizationLessonType type;

@end

@interface ZOriganizationLessonListNetModel : ZBaseNetworkBackDataModel
@property (nonatomic,strong) NSArray <ZOriganizationLessonListModel *>*list;
@property (nonatomic,copy) NSString *pages;
@end


