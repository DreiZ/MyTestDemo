//
//  ZFileUploadDataModel.m
//  NoWait
//
//  Created by zhuang zhang on 2020/6/19.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZFileUploadDataModel.h"
#import "TZImageManager.h"
#import "SDAVAssetExportSession.h"
#import "ZFileManager.h"

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
    CGFloat pixelHeight = _asset.pixelHeight;
    CGFloat pixelWidth = _asset.pixelWidth;
    
    NSInteger maxPixel = 0;
    if (pixelHeight > pixelWidth) {
        maxPixel = pixelHeight;
    }else{
        maxPixel = pixelWidth;
    }
    if (maxPixel <= 720) {
        DLog(@"老----压缩");
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
                NSData *data = [NSData dataWithContentsOfFile:outputPath];
                DLog(@"大小: %@", [self formatByte:data.length]);
            } failure:^(NSString *errorMessage, NSError *error) {
                DLog(@"视频导出失败:%@,error:%@",errorMessage, error);
                if (success) {
                    success(nil);
                }
            }];
        }else{
            success(nil);
        }
    }else {
        DLog(@"新----压缩");
        if (!_filePath) {
            PHVideoRequestOptions *options = [[PHVideoRequestOptions alloc] init];
            options.version = PHImageRequestOptionsVersionCurrent;
            options.deliveryMode = PHVideoRequestOptionsDeliveryModeAutomatic;

            PHImageManager *manager = [PHImageManager defaultManager];
            [manager requestAVAssetForVideo:self.asset options:options resultHandler:^(AVAsset * _Nullable asset, AVAudioMix * _Nullable audioMix, NSDictionary * _Nullable info) {

                AVURLAsset *urlAsset = (AVURLAsset *)asset;
                NSURL *videoURL = urlAsset.URL;

                [self zipVideo:videoURL asset:urlAsset success:^(NSString *url) {
                    DLog(@"videoURL----%@",url);
                    success(url);
                }];
            }];
        }else{
            success(nil);
        }
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


- (void)zipVideo:(NSURL *)outputFileURL asset:(AVAsset *)anAsset success:(void(^)(NSString *))success {
     NSString *root = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString *tempDir = [root stringByAppendingString:@"/temp"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:tempDir isDirectory:nil]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:tempDir withIntermediateDirectories:YES attributes:nil error:nil];
    }
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"yyyy-MM-dd-HH:mm:ss-SSS"];
    NSString *time = [formater stringFromDate:[NSDate date]];
//            NSString *outputPath = [NSHomeDirectory() stringByAppendingFormat:@"/tmp/video-%@.mp4", time];
    NSString *myPathDocs =  [tempDir stringByAppendingPathComponent:[NSString stringWithFormat:@"Video-%@.mp4",time]];
    NSURL *url = [NSURL fileURLWithPath:myPathDocs];
    
    SDAVAssetExportSession *encoder = [SDAVAssetExportSession.alloc initWithAsset:anAsset];
    encoder.outputFileType = AVFileTypeMPEG4;
    encoder.outputURL = url;
    encoder.videoSettings =  [self videoSettingsWithSessionPreset];
    
    encoder.audioSettings = @
    {
        AVFormatIDKey: @(kAudioFormatMPEG4AAC),
        AVNumberOfChannelsKey: @2,
        AVSampleRateKey: @44100,
        AVEncoderBitRateKey: @128000,
    };

    [encoder exportAsynchronouslyWithCompletionHandler:^
    {
        if (encoder.status == AVAssetExportSessionStatusCompleted)
        {
            DLog(@"----Video export succeeded");
            DLog(@"----%@",encoder.outputURL);
//            self.SDvideoUrl = url;
            NSString *urlstring = [[url absoluteString] substringFromIndex:7];
            CGFloat size = [self getFileSize:urlstring];
            DLog(@"1111111视频大小=%f",size);
            NSData *data = [NSData dataWithContentsOfFile:urlstring];
            DLog(@"大小: %@", [self formatByte:data.length]);
            self.filePath = url.absoluteString;
            success(url.absoluteString);
        }
        else if (encoder.status == AVAssetExportSessionStatusCancelled)
        {
            DLog(@"------Video export cancelled");
            success(nil);
        }
        else
        {
            DLog(@"----------Video export failed with error: %@ (%ld)", encoder.error.localizedDescription, (long)encoder.error.code);
            success(nil);
        }
    }];
}

- (NSDictionary *)videoSettingsWithSessionPreset {
    CGFloat pixelHeight = _asset.pixelHeight;
    CGFloat pixelWidth = _asset.pixelWidth;
    
    if (pixelHeight > pixelWidth) {
        if (pixelHeight <= 1080) {
            return [self videoSettingsPreset720];
        }else{
            return [self videoSettingsPreset1080];
        }
    }else{
       if (pixelWidth <= 1080) {
           return [self videoSettingsPreset720];
       }else{
           return [self videoSettingsPreset1080];
       }
    }
}



- (NSDictionary *)videoSettingsPreset720 {
    
    NSMutableDictionary *settings = [NSMutableDictionary dictionary];
    if (@available(iOS 11.0, *)) {
        settings[AVVideoCodecKey] = AVVideoCodecTypeH264;
    } else {
        settings[AVVideoCodecKey] = AVVideoCodecH264;
    }
    CGFloat pixelHeight = _asset.pixelHeight;
    CGFloat pixelWidth = _asset.pixelWidth;
    
    if (pixelHeight > pixelWidth) {
        pixelWidth = (pixelWidth/pixelHeight)*720;
        pixelHeight = 720;
        if ((long)pixelWidth/2 > 0) {
            pixelWidth = (long)pixelWidth + 1;
        }
    }else{
        pixelHeight = (pixelHeight/pixelWidth)*720;
        pixelWidth = 720;
        if ((long)pixelHeight/2 > 0) {
            pixelHeight = (long)pixelHeight + 1;
        }
    }
    pixelHeight = (long)pixelHeight;
    pixelWidth = (long)pixelWidth;
    
    settings[AVVideoHeightKey] = @(pixelHeight);
    settings[AVVideoWidthKey] = @(pixelWidth);
    settings[AVVideoCompressionPropertiesKey] = @{ AVVideoAverageBitRateKey: @(3000000),
                                                   AVVideoExpectedSourceFrameRateKey : @(30),
                                                   AVVideoMaxKeyFrameIntervalKey : @(30),
                                                   AVVideoProfileLevelKey: AVVideoProfileLevelH264MainAutoLevel
                                                   };
    return settings;
}

- (NSDictionary *)videoSettingsPreset1080 {
    
    NSMutableDictionary *settings = [NSMutableDictionary dictionary];
    if (@available(iOS 11.0, *)) {
        settings[AVVideoCodecKey] = AVVideoCodecTypeH264;
    } else {
        settings[AVVideoCodecKey] = AVVideoCodecH264;
    }
    CGFloat pixelHeight = _asset.pixelHeight;
    CGFloat pixelWidth = _asset.pixelWidth;
    if (pixelHeight > pixelWidth) {
        pixelWidth = (pixelWidth/pixelHeight)*1080;
        pixelHeight = 1080;
    }else{
        
        pixelHeight = (pixelHeight/pixelWidth)*1080;
        pixelWidth = 1080;
    }
    settings[AVVideoHeightKey] = @(pixelHeight);
    settings[AVVideoWidthKey] = @(pixelWidth);
    settings[AVVideoCompressionPropertiesKey] =
                                                @{ AVVideoAverageBitRateKey: @(5000000),
                                                   AVVideoExpectedSourceFrameRateKey : @(30),
                                                   AVVideoMaxKeyFrameIntervalKey : @(30),
                                                   AVVideoProfileLevelKey: AVVideoProfileLevelH264MainAutoLevel
                                                   };
    return settings;
}


//获取视频大小单位KB
- (CGFloat) getFileSize:(NSString *)path
{
    NSLog(@"%@",path);
    NSFileManager *fileManager = [NSFileManager defaultManager];
    float filesize = -1.0;
    if ([fileManager fileExistsAtPath:path]) {
        NSDictionary *fileDic = [fileManager attributesOfItemAtPath:path error:nil];//获取文件的属性
        unsigned long long size = [[fileDic objectForKey:NSFileSize] longLongValue];
        filesize = 1.0*size/1024;
    }else{
        NSLog(@"找不到文件");
    }
    return filesize;
}
- (NSString *)formatByte:(unsigned long long)size {
    float f;
    if (size < 1024 * 1024) {
        f = ((float)size / 1024.0);
        return [NSString stringWithFormat:@"%.2fKB", f];
    } else if (size >= 1024 * 1024 && size < 1024 * 1024 * 1024) {
        f = ((float)size / (1024.0 * 1024.0));
        return [NSString stringWithFormat:@"%.2fMB", f];
    }
    f = ((float)size / (1024.0 * 1024.0 * 1024.0));
    return [NSString stringWithFormat:@"%.2fG", f];
}

//视频时长
- (CGFloat) getVideoLength:(NSURL *)URL
{
    
    AVURLAsset *avUrl = [AVURLAsset assetWithURL:URL];
    CMTime time = [avUrl duration];
    int second = ceil(time.value/time.timescale);
    return second;
}
@end
