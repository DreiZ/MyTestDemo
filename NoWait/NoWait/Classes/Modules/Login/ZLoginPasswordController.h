//
//  ZLoginPasswordController.h
//  NoWait
//
//  Created by zhuang zhang on 2020/3/4.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZTableViewViewController.h"


@interface ZLoginPasswordController : ZTableViewViewController
@property (nonatomic, assign) BOOL isSwitch;
@property (nonatomic, copy) void (^loginSuccess)(void);
@property (nonatomic, assign) NSInteger type;

@end

