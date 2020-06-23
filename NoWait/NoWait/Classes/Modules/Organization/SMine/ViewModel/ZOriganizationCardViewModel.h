//
//  ZOriganizationCardViewModel.h
//  NoWait
//
//  Created by zhuang zhang on 2020/3/16.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZBaseViewModel.h"
#import "ZOriganizationModel.h"

@interface ZOriganizationCardViewModel : ZBaseViewModel
@property (nonatomic,strong) ZOriganizationCardAddModel *addModel;


+ (void)addCart:(NSDictionary *)params
  completeBlock:(resultDataBlock)completeBlock ;


+ (void)addSengCart:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock;

+ (void)editCart:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock;


+ (void)getCardDetail:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock;

+ (void)getCardList:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock;

+ (void)getLessonCardList:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock;

+ (void)getMyCardList:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock ;

+ (void)deleteCard:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock;


+ (void)getCardLessonList:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock;


+ (void)receiveCoupons:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock ;



+ (void)getUseCardLessonList:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock ;
@end

