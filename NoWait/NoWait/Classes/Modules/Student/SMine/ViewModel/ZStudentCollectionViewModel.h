//
//  ZStudentCollectionViewModel.h
//  NoWait
//
//  Created by zhuang zhang on 2020/5/14.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZBaseViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZStudentCollectionViewModel : ZBaseViewModel

+ (void)getCollectionOrganizationList:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock;


+ (void)getCollectionLessonList:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock;


+ (void)collectionStore:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock ;

+ (void)collectionLesson:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock ;

@end

NS_ASSUME_NONNULL_END
