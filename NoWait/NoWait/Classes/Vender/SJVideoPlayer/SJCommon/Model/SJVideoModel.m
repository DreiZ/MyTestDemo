//
//  SJVideoModel.m
//  SJVideoPlayer
//
//  Created by 畅三江 on 2019/6/8.
//  Copyright © 2019 畅三江. All rights reserved.
//

#import "SJVideoModel.h"

@implementation SJVideoModel
- (instancetype)init {
    self = [super init];
    if (self) {
        static NSInteger __id;
        _id = __id++;
    }
    return self;
}
@end
