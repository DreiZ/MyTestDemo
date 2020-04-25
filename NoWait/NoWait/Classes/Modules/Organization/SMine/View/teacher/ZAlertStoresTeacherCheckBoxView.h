//
//  ZAlertStoresTeacherCheckBoxView.h
//  NoWait
//
//  Created by zhuang zhang on 2020/4/25.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZAlertDataCheckBoxView.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZAlertStoresTeacherCheckBoxView : ZAlertDataCheckBoxView
@property (nonatomic,strong) NSString *stores_id;
+ (void)setAlertName:(NSString *)title stores_id:(NSString *)stores_id handlerBlock:(void(^)(NSInteger,id))handleBlock ;
@end

NS_ASSUME_NONNULL_END
