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
@property (nonatomic,strong) ZOriganizationStudentCodeAddModel *codeAddModel;


+ (void)getStudentList:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock;

+ (void)getStarStudentList:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock;

+ (void)editStudent:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock ;

+ (void)getStudentDetail:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock;


+ (void)getStudentFromList:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock ;


+ (void)getStoresStudentDetail:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock ;

+ (void)getStudentLessonFromList:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock;

+ (void)addStudent:(NSDictionary *)params
     completeBlock:(resultDataBlock)completeBlock;

+ (void)starStudent:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock;
//删除课程
+ (void)deleteStudent:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock;


+ (void)addStudentQrcode:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock;


+ (void)getStudentCodeInfo:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock ;

//发送消息
+ (void)addMessage:(NSDictionary *)params
     completeBlock:(resultDataBlock)completeBlock ;


+ (void)getMessageList:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock;


+ (void)getSendMessageInfo:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock;


+ (void)addClassStudent:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock;


+ (void)delMessage:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock;
@end


