//
//  ZIMManager.h
//  NoWait
//
//  Created by zhuang zhang on 2020/5/6.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ZIMManager : NSObject
+ (ZIMManager *)shareManager;

- (void)setupNIMSDK;

- (void)registerIM;

//登录
- (void)loginIMComplete:(void(^)(BOOL))complete;
@end

