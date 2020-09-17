//
//  ZAlertClassCheckBoxView.h
//  NoWait
//
//  Created by zhuang zhang on 2020/9/16.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZAlertDataCheckBoxView.h"


@interface ZAlertClassCheckBoxView : ZAlertDataCheckBoxView

+ (void)setAlertName:(NSString *)title dataSources:(NSArray *)data handlerBlock:(void(^)(NSInteger,id))handleBlock ;

@end

