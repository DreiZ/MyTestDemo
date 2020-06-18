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

- (void)setCropRect:(CGSize)cropRect SelectMenu:(ZSelectImageBackBlock)complete;

- (void)setImagesWithMaxCount:(NSInteger)maxCount  SelectMenu:(ZSelectImageBackBlock)complete;


- (void)setSelectMenu:(ZSelectImageBackBlock)complete;


- (void)showBrowser:(NSArray*)mediaArray withIndex:(NSInteger)index;
@end

