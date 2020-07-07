//
//  ZCircleReleaseViewModel.m
//  NoWait
//
//  Created by zhuang zhang on 2020/7/7.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZCircleReleaseViewModel.h"

@implementation ZCircleReleaseViewModel
- (instancetype)init {
    self = [super init];
    if (self) {
        _model = [[ZCircleReleaseModel alloc] init];
    }
    return self;
}
@end
