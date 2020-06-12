//
//  ZAccountFogetPasswordVC.h
//  NoWait
//
//  Created by zhuang zhang on 2020/4/22.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZAccountFogetPasswordVC : ZTableViewController
@property (nonatomic, assign) BOOL isSwitch;

@property (nonatomic, copy) void (^loginSuccess)(void);
@end

NS_ASSUME_NONNULL_END
