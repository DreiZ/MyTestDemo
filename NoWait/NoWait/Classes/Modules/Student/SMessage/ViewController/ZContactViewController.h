//
//  ZContactViewController.h
//  NoWait
//
//  Created by zhuang zhang on 2020/5/7.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZViewController.h"
#import <NIMContactSelectConfig.h>

@interface ZContactViewController : ZTableViewViewController
@property (nonatomic, strong, readonly) id<NIMContactSelectConfig> config;
@end

