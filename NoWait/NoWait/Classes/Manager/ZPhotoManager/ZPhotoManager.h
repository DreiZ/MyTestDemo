//
//  ZPhotoManager.h
//  ZBigHealth
//
//  Created by zhuang zhang on 2018/11/12.
//  Copyright © 2018 zhuang zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LLImagePickerView.h"

@interface ZPhotoManager : NSObject

/**
 * 需要展示的媒体的资源类型：如仅显示图片等，默认是 LLImageTypePhotoAndCamera
 */
@property (nonatomic,assign) LLImageType type;
/**
 * 预先展示的媒体数组。如果一开始有需要显示媒体资源，可以先传入进行显示，没有的话可以不赋值。
 * 传入的如果是图片类型，则可以是：UIImage，NSString，至于其他的都可以传入 LLImagePickerModel类型
 * 当前只支持图片和视频
 */
@property (nonatomic, strong) NSArray *preShowMedias;
/**
 * 最大资源选择个数,（包括 preShowMedias 预先展示数据）. default is 9
 */
@property (nonatomic, assign) NSInteger maxImageSelected;
/**
 * 是否显示删除按钮. Defaults is YES
 */
@property (nonatomic, assign) BOOL showDelete;

/**
 * 是否需要显示添加按钮. Defaults is YES
 */
@property (nonatomic, assign) BOOL showAddButton;
/// Single selection mode, valid when maxImagesCount = 1
/// 单选模式,maxImagesCount为1时才生效
@property (nonatomic, assign) BOOL showSelectBtn;        ///< 在单选模式下，照片列表页中，显示选择按钮,默认为NO
@property (nonatomic, assign) BOOL allowCrop;            ///< 允许裁剪,默认为YES，showSelectBtn为NO才生效
@property (nonatomic, assign) CGRect cropRect;

/**
 * 是否允许 在选择图片的同时可以选择视频文件. default is NO
 */
@property (nonatomic, assign) BOOL allowPickingVideo;

/**
 * 是否允许 同个图片或视频进行多次选择. default is YES
 */
@property (nonatomic, assign) BOOL allowMultipleSelection;

@property (nonatomic,strong) UIViewController *viewController;

+ (ZPhotoManager *)sharedManager;

//选择照片
- (void)showSelectMenu:(LLSelecttImageBackBlock)complete;

- (void)showSelectMenu:(LLSelecttImageBackBlock)complete navgation:(UIViewController *)viewController;

//单次选择照片
- (void)showOriginalSelectMenu:(LLSelecttImageBackBlock)complete;
- (void)showOriginalSelectMenu:(LLSelecttImageBackBlock)complete navgation:(UIViewController *)viewController ;


//单次选择剪切照片
- (void)showCropOriginalSelectMenu:(LLSelecttImageBackBlock)complete;
- (void)showCropOriginalSelectMenuWithCropSize:(CGSize)cropSize complete:(LLSelecttImageBackBlock)complete;
- (void)showCropOriginalSelectMenu:(LLSelecttImageBackBlock)complete navgation:(UIViewController *)viewController ;


//图片浏览器
- (void)showBrowser:(NSArray *)mediaArray withIndex:(NSInteger)index;
- (void)showPhotoBrowser:(NSArray *)mediaArray withIndex:(NSInteger)index;

/** 相机 */
- (void)openCameraWithComplete:(LLSelecttImageBackBlock)complete;

/** 相册 */
- (void)openAlbumWithComplete:(LLSelecttImageBackBlock)complete;

@end

