//
//  ZCircleUploadModel.m
//  NoWait
//
//  Created by zhuang zhang on 2020/7/14.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZCircleUploadModel.h"

@implementation ZCircleUploadModel
- (instancetype)init {
    self = [super init];
    if (self) {
        _uploadList = @[].mutableCopy;
        _otherParams = @{}.mutableCopy;
        _title = @"上传动态";
        _progress = 0.01;
        _uploadStatus = ZCircleUploadStatusWatting;
    }
    return self;
}
@end
