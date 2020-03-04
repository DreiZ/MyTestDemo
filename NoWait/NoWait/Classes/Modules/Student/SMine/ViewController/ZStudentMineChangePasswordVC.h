//
//  ZStudentMineChangePasswordVC.h
//  NoWait
//
//  Created by zhuang zhang on 2020/1/16.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZTableViewViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZStudentMineChangePasswordVC : ZTableViewViewController
@property (nonatomic, assign) BOOL isSwitch;

@property (nonatomic, copy) void (^loginSuccess)(void);
@end

NS_ASSUME_NONNULL_END
