//
//  ZAlertLesssonNumPickerView.h
//  NoWait
//
//  Created by zhuang zhang on 2020/9/9.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZAlertLesssonNumPickerView : UIView

+ (void)setAlertName:(NSString *)title items:(NSInteger)data handlerBlock:(void(^)(NSInteger))handleBlock ;


+ (void)setAlertName:(NSString *)title selectedIndex:(NSInteger)index items:(NSInteger)data handlerBlock:(void(^)(NSInteger))handleBlock;
@end

NS_ASSUME_NONNULL_END
