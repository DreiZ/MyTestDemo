//
//  ZAlertDateHourPickerView.h
//  NoWait
//
//  Created by zhuang zhang on 2020/2/20.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZAlertDataModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ZAlertDateHourPickerView : UIView
+ (void)setAlertName:(NSString *)title handlerBlock:(void(^)(NSInteger))handleBlock ;
@end

NS_ASSUME_NONNULL_END
