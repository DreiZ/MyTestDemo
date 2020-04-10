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
