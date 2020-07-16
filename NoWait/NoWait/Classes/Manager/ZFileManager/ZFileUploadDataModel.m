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
- (instancetype)init {
    self = [super init];
    if (self) {
        self.type = @"9";
//        /1：机构【资质、环境、教练、学员、校区封面】2. 课程 3. 学员【学员详情、明星学员相册】
        // 4. 教师【教师详情、教师相册】5. 头像【用户头像】6. 广告 7. 评价 8. 意见反馈 9. 其他 10.发现
    }
    return self;
}

-(void)getFilePath:(void(^)(NSString *))success {
    if (!_filePath) {
        // 打开这段代码发送视频
        [[TZImageManager manager] getVideoOutputPathWithAsset:self.asset presetName:AVAssetExportPresetMediumQuality success:^(NSString *outputPath) {
            // NSData *data = [NSData dataWithContentsOfFile:outputPath];
            DLog(@"视频导出到本地完成,沙盒路径为:%@",outputPath);
            // 导出完成，在这里写上传代码，通过路径或者通过NSData上传
            self.filePath = [[NSURL fileURLWithPath:outputPath] absoluteString];
            if (success) {
                success(self.filePath);
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
            _fileName = [NSString stringWithFormat:@"%@.jpg",AliYunImagePath(self.type)];
        }else{
            _fileName = [NSString stringWithFormat:@"%@.mp4",AliYunVideoPath(self.type)];
        }
    }
    return _fileName;
}
@end
