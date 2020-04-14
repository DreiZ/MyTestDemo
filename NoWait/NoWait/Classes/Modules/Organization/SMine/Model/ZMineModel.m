//
//  ZMineModel.m
//  NoWait
//
//  Created by zhuang zhang on 2020/3/3.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZMineModel.h"

@implementation ZMineModel

@end

@implementation ZMineFeedBackModel

- (instancetype)init {
    self = [super init];
    if (self) {
        self.des = @"";
        self.phone = @"";
        self.name = @"";
        self.images = @[].mutableCopy;
    }
    return self;
}

@end


@implementation ZQRCodeMode
@end


@implementation ZQRCodeAddStudentMode
@end

@implementation ZMineMessageModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"message_id" : @"id",
            };
}

- (NSArray<ZMineMessageReceiveModel *> *)receiveArr {
    if (ValidStr(self.receive)) {
          NSArray *temp = [self.receive zz_JSONValue];
        NSArray *ss =  [ZMineMessageReceiveModel mj_objectArrayWithKeyValuesArray:temp];
        return ss;
    }
    return nil;
}
@end

@implementation ZMineMessageReceiveModel

@end

@implementation ZMineMessageNetModel
+ (NSDictionary *)mj_objectClassInArray {
    return @{@"list":@"ZMineMessageModel"};
}

@end

@implementation ZQRCodeStudentSignMode

@end
