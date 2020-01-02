//
//  UIImageView+ZWebImage.h
//  ZBigHealth
//
//  Created by zhuang zhang on 2018/10/16.
//  Copyright © 2018年 zhuang zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSUInteger, ZWebImageOptions) {
    /**
     * 失败重试（默认）
     */
    ZWebImageRetryFailed = 1 << 0,
    /**
     * 低优先级的（在scrollView滑动时不下载，减速时开始下载）
     */
    ZWebImageLowPriority = 1 << 1,
    /**
     * 仅内存缓存
     */
    ZWebImageCacheMemoryOnly = 1 << 2,
    /**
     * 渐进式下载（如浏览器，下载一截展示一截）
     */
    ZWebImageProgressiveDownload = 1 << 3,
    /**
     * 重新下载，更新缓存
     */
    ZWebImageRefreshCached = 1 << 4,
    /**
     * 开始后台下载（比如app进入后台，仍然下载）
     */
    ZWebImageContinueInBackground = 1 << 5,
    /**
     * 可以控制存在NSHTTPCookieStore的cookies.
     */
    ZWebImageHandleCookies = 1 << 6,
    /**
     * 允许无效的ssl证书
     */
    ZWebImageAllowInvalidSSLCertificates = 1 << 7,
    /**
     * 高优先级，会放在队头下载
     */
    ZWebImageHighPriority = 1 << 8,
    /**
     * 延时展示占位图（图片下载失败时才展示）
     */
    ZWebImageDelayPlaceholder = 1 << 9,
    /**
     * 动图相关（猜测）
     */
    ZWebImageTransformAnimatedImage = 1 << 10,
    /**
     * 图片下载完成之后不自动给imageView设置
     */
    ZWebImageAvoidAutoSetImage = 1 << 11,
    /**
     * 根据设备屏幕类型，进行放大缩小（@1x, @2x, @3x）
     */
    ZWebImageScaleDownLargeImages = 1 << 12
};

typedef NS_ENUM(NSInteger, ZImageCacheType) {
    /**
     * 无缓存
     */
    ZImageCacheTypeNone,
    /**
     * 磁盘缓存
     */
    ZImageCacheTypeDisk,
    /**
     * 内存缓存
     */
    ZImageCacheTypeMemory
};

typedef void (^ZWebImageDownloadCompleteBlock)(UIImage *image, NSError *error, ZImageCacheType cacheType, NSURL *imageURL);
typedef void (^ZWebImageDownloaderProgressBlock)(NSInteger receivedSize, NSInteger expectedSize, NSURL *targetURL);

@interface UIImageView (ZWebImage)


- (void)tt_setImageWithURL:(NSURL *)url;
- (void)tt_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder;
- (void)tt_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(ZWebImageOptions)options;
- (void)tt_setImageWithURL:(NSURL *)url completed:(ZWebImageDownloadCompleteBlock)completedBlock;
- (void)tt_setImageWithURL:(NSURL *)url options:(ZWebImageOptions)options completed:(ZWebImageDownloadCompleteBlock)completedBlock;
- (void)tt_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder completed:(ZWebImageDownloadCompleteBlock)completedBlock;
- (void)tt_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(ZWebImageOptions)options completed:(ZWebImageDownloadCompleteBlock)completedBlock;
- (void)tt_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(ZWebImageOptions)options progress:(ZWebImageDownloaderProgressBlock)progressBlock completed:(ZWebImageDownloadCompleteBlock)completedBlock;

- (void)tt_cancelCurrentImageLoad;


@end

