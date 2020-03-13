//
//  ZAlertLessonCheckBoxView.h
//  NoWait
//
//  Created by zhuang zhang on 2020/3/13.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZAlertDataCheckBoxView.h"


@interface ZAlertLessonCheckBoxView : ZAlertDataCheckBoxView
@property (nonatomic,strong) NSString *schoolID;

+ (void)setAlertName:(NSString *)title schoolID:(NSString *)schoolID handlerBlock:(void(^)(NSInteger,id))handleBlock ;
@end

