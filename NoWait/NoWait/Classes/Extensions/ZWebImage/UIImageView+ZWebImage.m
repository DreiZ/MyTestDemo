//
//  UIImageView+ZWebImage.m
//  ZBigHealth
//
//  Created by zhuang zhang on 2018/10/16.
//  Copyright © 2018年 zhuang zhang. All rights reserved.
//

#import "UIImageView+ZWebImage.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation UIImageView (ZWebImage)

- (void)tt_setImageWithURL:(NSURL *)url
{
    [self tt_setImageWithURL:url completed:nil];
}

- (void)tt_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder
{
    [self tt_setImageWithURL:url placeholderImage:placeholder completed:nil];
}

- (void)tt_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(ZWebImageOptions)options
{
    [self tt_setImageWithURL:url placeholderImage:placeholder options:options completed:nil];
}

- (void)tt_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder completed:(ZWebImageDownloadCompleteBlock)completedBlock
{
    [self tt_setImageWithURL:url placeholderImage:placeholder options:ZWebImageRetryFailed completed:completedBlock];
}

- (void)tt_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(ZWebImageOptions)options completed:(ZWebImageDownloadCompleteBlock)completedBlock
{
    [self tt_setImageWithURL:url placeholderImage:placeholder options:options progress:nil completed:completedBlock];
}

- (void)tt_setImageWithURL:(NSURL *)url completed:(ZWebImageDownloadCompleteBlock)completedBlock
{
    [self tt_setImageWithURL:url placeholderImage:nil completed:completedBlock];
}

- (void)tt_setImageWithURL:(NSURL *)url options:(ZWebImageOptions)options completed:(ZWebImageDownloadCompleteBlock)completedBlock
{
    [self tt_setImageWithURL:url placeholderImage:nil options:options progress:nil completed:completedBlock];
}

- (void)tt_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(ZWebImageOptions)options progress:(ZWebImageDownloaderProgressBlock)progressBlock completed:(ZWebImageDownloadCompleteBlock)completedBlock
{
    [self sd_setImageWithURL:url placeholderImage:placeholder options:(SDWebImageOptions)options progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        if (progressBlock) {
            progressBlock(receivedSize, expectedSize, nil);
        }
    } completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if (completedBlock) {
            completedBlock(image, error, (ZImageCacheType)cacheType, imageURL);
        }
    }];
//    [self sd_setImageWithURL:url placeholderImage:placeholder options:(SDWebImageOptions)options progress:^(NSInteger receivedSize, NSInteger expectedSize) {
//        if (progressBlock) {
//            progressBlock(receivedSize, expectedSize, nil);
//        }
//    } completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
//        if (completedBlock) {
//            completedBlock(image, error, (ZImageCacheType)cacheType, imageURL);
//        }
//    }];
}

- (void)tt_cancelCurrentImageLoad
{
    [self tt_cancelCurrentImageLoad];
//    [self sd_cancelCurrentImageLoad];
}

@end
