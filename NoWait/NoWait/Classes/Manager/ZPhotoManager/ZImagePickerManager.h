//
//  ZImagePickerManager.h
//  NoWait
//
//  Created by zhuang zhang on 2020/6/18.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZImagePickerModel.h"

typedef enum : NSUInteger {
    ZImageTypePhotoAndCamera,// 本地相机和图片
    ZImageTypePhoto,// 本地图片
    ZImageTypeCamera,// 相机拍摄
    ZImageTypeVideoTape,// 录像
    ZImageTypeVideo,// 视频
    ZImageTypeAll,// 所有资源
    ZImageTypeCardIDFontPhotoAndCamera,// 身份证本地相机和图片
    ZImageTypeCardIDBackPhotoAndCamera,// 身份证本地相机和图片
} ZImageType;

typedef void(^ZSelectImageBackBlock)(NSArray<ZImagePickerModel *> *list);

@interface ZImagePickerManager : NSObject
+ (ZImagePickerManager *)sharedManager;

//头像
- (void)setAvatarSelectMenu:(ZSelectImageBackBlock)complete;

//身份证
- (void)setCardIDSelectMenu:(ZSelectImageBackBlock)complete;

//选择剪切图片\单张
- (void)setCropRect:(CGSize)cropRect SelectMenu:(ZSelectImageBackBlock)complete;

//选择图片
- (void)setImagesWithMaxCount:(NSInteger)maxCount  SelectMenu:(ZSelectImageBackBlock)complete;

//选择视频
- (void)setVideoWithMaxCount:(NSInteger)maxCount  SelectMenu:(ZSelectImageBackBlock)complete;


//选择图片and视频
- (void)setPhotoWithMaxCount:(NSInteger)maxCount  SelectMenu:(ZSelectImageBackBlock)complete;

//展示图片
- (void)showBrowser:(NSArray*)mediaArray withIndex:(NSInteger)index;
- (void)showPhotoBrowser:(NSArray *)mediaArray withIndex:(NSInteger)index;

//播放视频 asset
- (void)showVideoBrowser:(PHAsset *)asset;

//获取 视频导出到本地沙盒路径为
- (void)getVideoOutputPathWith:(PHAsset *)asset success:(void (^)(NSString *))success failure:(void (^)(NSString *, NSError*))failure;
@end
