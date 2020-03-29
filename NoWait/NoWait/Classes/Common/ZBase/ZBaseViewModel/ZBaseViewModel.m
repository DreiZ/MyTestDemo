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


+ (void)uploadImageList:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock {
    [ZNetworkingManager postImageServerType:ZServerTypeFile url:URL_file_v1_upload params:params completionHandler:^(id data, NSError *error) {
        ZBaseNetworkBackModel *dataModel = data;
        if (ValidDict(dataModel.data)) {
            ZBaseNetworkImageBackModel *imageModel = [ZBaseNetworkImageBackModel mj_objectWithKeyValues:dataModel.data];
            if ([dataModel.code integerValue] == 0 ) {
                completeBlock(YES, imageModel.url);
                return ;
            }else{
                completeBlock(NO, dataModel.message);
                return;
            }
        }else {
            completeBlock(NO, @"操作失败");
        }
    }];
}


+ (void)deleteImageList:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock {
    [ZNetworkingManager postImageServerType:ZServerTypeFile url:URL_file_v1_upload params:params completionHandler:^(id data, NSError *error) {
        ZBaseNetworkBackModel *dataModel = data;
        if (data) {
            if ([dataModel.code integerValue] == 0 ) {
                completeBlock(YES, dataModel.message);
                return ;
            }else{
                completeBlock(NO, dataModel.message);
                return;
            }
        }else {
            completeBlock(NO, @"操作失败");
        }
    }];
}
@end
