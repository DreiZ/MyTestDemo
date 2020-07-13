//
//  ZHistoryModel.h
//  NoWait
//
//  Created by zhuang zhang on 2020/6/8.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZBaseModel.h"

#define kSearchHistoryMainSearch      @"10002"
#define kSearchHistoryLessonSearch    @"10003"
#define kSearchHistoryStudentSearch   @"10004"
#define kSearchHistoryTeacherSearch   @"10005"
#define kSearchHistoryCartSearch      @"10006"
#define kSearchHistoryClassSearch     @"10007"
#define kSearchHistoryOrderSearch     @"10003"
#define kSearchHistoryCircleSearch    @"10008"

@interface ZHistoryModel : ZBaseModel
@property (nonatomic,copy) NSString *search_title;
@property (nonatomic,copy) NSString *search_type;
@end

