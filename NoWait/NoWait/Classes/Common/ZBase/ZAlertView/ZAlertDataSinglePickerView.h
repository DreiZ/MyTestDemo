//
//  ZAlertDataSinglePickerView.h
//  NoWait
//
//  Created by zhuang zhang on 2020/2/20.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZAlertDataModel.h"

@interface ZAlertDataSinglePickerView : UIView
+ (void)setAlertName:(NSString *)title items:(NSArray <ZAlertDataItemModel *>*)data handlerBlock:(void(^)(NSInteger))handleBlock ;
@end


