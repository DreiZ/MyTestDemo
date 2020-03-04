//
//  ZAlertTimeQuantumView.h
//  NoWait
//
//  Created by zhuang zhang on 2020/3/4.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZAlertTimeQuantumView : UIView
+ (void)setAlertName:(NSString *)title pickerMode:(PGDatePickerMode)model handlerBlock:(void(^)(NSDateComponents *,NSDateComponents *))handleBlock ;
@end

NS_ASSUME_NONNULL_END
