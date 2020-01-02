//
//  ZBaseViewModel.m
//  ZBigHealth
//
//  Created by zhuang zhang on 2018/10/29.
//  Copyright © 2018 zhuang zhang. All rights reserved.
//

#import "ZBaseViewModel.h"

@implementation ZBaseViewModel

- (void)cacelTask {
    [self.dataTask cancel];
}
- (void)suspendTask {
    [self.dataTask suspend];
}
- (void)resumeTask {
    [self.dataTask resume];
}
- (NSMutableArray *)dataMArr {
    if (!_dataMArr) {
        _dataMArr = [NSMutableArray new];
    }
    return _dataMArr;
}
@end
