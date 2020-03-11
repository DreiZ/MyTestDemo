//
//  ZOriganizationLessonViewModel.h
//  NoWait
//
//  Created by zhuang zhang on 2020/2/27.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZBaseViewModel.h"
#import "ZOriganizationLessonModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ZOriganizationLessonViewModel : ZBaseViewModel
@property (nonatomic,strong) ZOriganizationLessonAddModel *addModel;

+ (void)getLessonlist:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock ;

+ (void)uploadImageList:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock;

+ (void)deleteImageList:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock;

+ (void)addLesson:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock;
@end

NS_ASSUME_NONNULL_END
