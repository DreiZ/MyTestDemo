//
//  ZCircleUploadModel.h
//  NoWait
//
//  Created by zhuang zhang on 2020/7/14.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZBaseModel.h"


typedef NS_ENUM(NSInteger, ZCircleUploadStatus) {
    ZCircleUploadStatusWatting,
    ZCircleUploadStatusZipping,
    ZCircleUploadStatusUploading,
    ZCircleUploadStatusUploadOtherData,
    ZCircleUploadStatusComplete,
    ZCircleUploadStatusError,
};

@interface ZCircleUploadModel : ZBaseModel
@property (nonatomic,strong) NSMutableArray <ZFileUploadDataModel *>*uploadList;
@property (nonatomic,strong) NSMutableDictionary *otherParams;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,assign) CGFloat progress;
@property (nonatomic,assign) ZCircleUploadStatus uploadStatus;

@property (nonatomic, strong) void(^progressBlock)(CGFloat);
@property (nonatomic, strong) void(^errorBlock)(NSError *);
@property (nonatomic, strong) void(^completeBlock)(id);
@end

