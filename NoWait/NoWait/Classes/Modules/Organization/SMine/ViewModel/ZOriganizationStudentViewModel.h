//
//  ZOriganizationStudentViewModel.h
//  NoWait
//
//  Created by zhuang zhang on 2020/3/12.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZBaseViewModel.h"
#import "ZOriganizationModel.h"

@interface ZOriganizationStudentViewModel : ZBaseViewModel
@property (nonatomic,strong) ZOriganizationStudentAddModel *addModel;


+ (void)getStudentList:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock;

+ (void)getStudentFromList:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock ;


+ (void)getStudentLessonFromList:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock;


+ (void)addStudent:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock;
@end


