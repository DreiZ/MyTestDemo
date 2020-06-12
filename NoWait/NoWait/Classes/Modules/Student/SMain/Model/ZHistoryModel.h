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

@interface ZHistoryModel : ZBaseModel
@property (nonatomic,copy) NSString *search_title;
@property (nonatomic,copy) NSString *search_type;
@end

