//
//  ZFileUploadDataModel.m
//  NoWait
//
//  Created by zhuang zhang on 2020/6/19.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZFileUploadDataModel.h"
#import "TZImageManager.h"

@implementation ZFileUploadDataModel

-(void)getVideo_url:(void(^)(NSString *))success {
    if (!_video_url) {
        // 打开这段代码发送视频
        [[TZImageManager manager] getVideoOutputPathWithAsset:self.asset presetName:AVAssetExportPresetHighestQuality success:^(NSString *outputPath) {
            // NSData *data = [NSData dataWithContentsOfFile:outputPath];
            DLog(@"视频导出到本地完成,沙盒路径为:%@",outputPath);
            // 导出完成，在这里写上传代码，通过路径或者通过NSData上传
            self.video_url = outputPath;
            if (success) {
                success(self.video_url);
            }
        } failure:^(NSString *errorMessage, NSError *error) {
            DLog(@"视频导出失败:%@,error:%@",errorMessage, error);
            if (success) {
                success(nil);
            }
        }];
    }
}

- (NSString *)fileName {
    if (!_fileName) {
        if (_taskType == ZUploadTypeImage) {
            _fileName = [NSString stringWithFormat:@"%@.jpg",AliYunImagePath];
        }else{
            _fileName = [NSString stringWithFormat:@"%@.mp4",AliYunVideoPath];
        }
    }
    return _fileName;
}
@end
