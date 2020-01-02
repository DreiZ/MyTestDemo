//
//  AppDelegate+AppService.h
//  ZBigHealth
//
//  Created by zhuang zhang on 2018/10/27.
//  Copyright © 2018 zhuang zhang. All rights reserved.
//

#import "AppDelegate.h"


@interface AppDelegate (AppService)

- (void)initService;

- (UIViewController *)getCurrentVC;

- (UIViewController *)getCurrentUIVC;
@end


