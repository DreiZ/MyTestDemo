//
//  ZFileUploadTask.m
//  NoWait
//
//  Created by zhuang zhang on 2020/6/19.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZFileUploadTask.h"

@implementation ZFileUploadTask

- (instancetype)init {
    self = [super init];
    
    if (self) {
        _model = [[ZFileUploadDataModel alloc] init];
    }
    
    return self;
}
@end
