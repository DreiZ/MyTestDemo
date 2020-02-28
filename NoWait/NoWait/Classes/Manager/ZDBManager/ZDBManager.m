//
//  ZDBManager.m
//  ZBigHealth
//
//  Created by zhuang zhang on 2018/10/16.
//  Copyright © 2018年 zhuang zhang. All rights reserved.
//

#import "ZDBManager.h"
#import "ZUserHelper.h"
#import "NSFileManager+ZChat.h"

static ZDBManager *manager;

@implementation ZDBManager

+ (ZDBManager *)sharedInstance
{
    if (manager == nil) {
        //    static dispatch_once_t once;
        NSString *uuid = [ZUserHelper sharedHelper].uuid;
        if (uuid && uuid.length > 0 && !manager) {
            manager = [[ZDBManager alloc] initWithUserID:uuid];
            //        dispatch_once(&once, ^{
            //
            //        });
        }
    }

    return manager;
}

- (void)loginout {
    manager = nil;
}

- (id)initWithUserID:(NSString *)uuid
{
    if (self = [super init]) {
        NSString *commonQueuePath = [NSFileManager pathDBCommon];
        self.commonQueue = [FMDatabaseQueue databaseQueueWithPath:commonQueuePath];
        NSString *messageQueuePath = [NSFileManager pathDBMessage];
        self.messageQueue = [FMDatabaseQueue databaseQueueWithPath:messageQueuePath];
    }
    return self;
}

- (id)init
{
    DLog(@"TLDBManager：请使用 initWithUserID: 方法初始化");
    return nil;
}

@end
