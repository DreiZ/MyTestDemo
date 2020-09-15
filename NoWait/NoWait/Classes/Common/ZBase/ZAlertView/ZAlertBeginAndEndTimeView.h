//
//  ZAlertBeginAndEndTimeView.h
//  NoWait
//
//  Created by zhuang zhang on 2020/3/4.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BRPickerView.h"

@interface ZAlertBeginAndEndTimeView : UIView
+ (void)setAlertName:(NSString *)title subName:(NSString *)subTitle pickerMode:(BRDatePickerMode)model handlerBlock:(void(^)(NSDate *,NSDate *))handleBlock;
@end

