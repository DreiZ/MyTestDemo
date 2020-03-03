//
//  ZFeedBackViewModel.m
//  NoWait
//
//  Created by zhuang zhang on 2020/3/3.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZFeedBackViewModel.h"

@implementation ZFeedBackViewModel
- (instancetype)init {
    self = [super init];
    if (self) {
        _model = [[ZMineFeedBackModel alloc] init];
    }
    return self;
}
@end
