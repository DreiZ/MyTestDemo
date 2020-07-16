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
//    @{@"type":@"8",@"imageKey":@{@"file":image}
    NSMutableArray *tasklist = @[].mutableCopy;
    if ([params objectForKey:@"imageKey"] && [params[@"imageKey"] isKindOfClass:[NSDictionary class]] && [params objectForKey:@"type"]) {
        NSDictionary *tempDict = params[@"imageKey"];
        if ([tempDict objectForKey:@"file"] && [tempDict[@"file"] isKindOfClass:[UIImage class]]) {
            ZFileUploadDataModel *dataModel = [[ZFileUploadDataModel alloc] init];
            dataModel.image = tempDict[@"file"];
            dataModel.taskType = ZUploadTypeImage;
            dataModel.taskState = ZUploadStateWaiting;
            dataModel.type = params[@"type"];
            [tasklist addObject:dataModel];
        }
    }
    
    if (!ValidArray(tasklist)) {
        completeBlock(NO, @"没有要上传的图片");
        return;
    }
    
    [[ZFileUploadManager sharedInstance] asyncSerialUpload:tasklist progress:^(CGFloat p, NSInteger index) {
        
    } completion:^(id obj) {
        if (obj && [obj isKindOfClass:[NSArray class]]) {
            NSArray *arr = obj;
            NSMutableArray *images = @[].mutableCopy;
            for (int i = 0; i < arr.count; i++) {
                if ([arr[i] isKindOfClass:[ZBaseNetworkBackModel class]]) {
                    ZBaseNetworkBackModel *dataModel = arr[i];
                    if (ValidDict(dataModel.data)) {
                        ZBaseNetworkImageBackModel *imageModel = [ZBaseNetworkImageBackModel mj_objectWithKeyValues:dataModel.data];
                        if ([dataModel.code integerValue] == 0 ) {
                            [images addObject:SafeStr(imageModel.url)];
                        }
                    }
                }else if([arr[i] isKindOfClass:[NSString class]]){
                    [images addObject:SafeStr(arr[i])];
                }
            }
            if (ValidArray(images)) {
                completeBlock(YES, images[0]);
                return;
            }
            
            completeBlock(NO, @"上传的图片失败");
        }
    }];
    
    return;
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
