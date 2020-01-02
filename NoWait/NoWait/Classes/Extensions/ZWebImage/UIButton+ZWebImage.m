//
//  UIButton+ZWebImage.m
//  ZBigHealth
//
//  Created by zhuang zhang on 2018/10/16.
//  Copyright © 2018年 zhuang zhang. All rights reserved.
//

#import "UIButton+ZWebImage.h"
#import <SDWebImage/UIButton+WebCache.h>

@implementation UIButton (ZWebImage)

- (void)tt_setImageWithURL:(NSURL *)url forState:(UIControlState)state
{
    [self tt_setImageWithURL:url forState:state placeholderImage:nil];
}

- (void)tt_setImageWithURL:(NSURL *)url forState:(UIControlState)state placeholderImage:(UIImage *)placeholder
{
    [self tt_setImageWithURL:url forState:state placeholderImage:placeholder completed:nil];
}

- (void)tt_setImageWithURL:(NSURL *)url forState:(UIControlState)state placeholderImage:(UIImage *)placeholder options:(ZWebImageOptions)options
{
    [self tt_setImageWithURL:url forState:state placeholderImage:placeholder options:options completed:nil];
}

- (void)tt_setImageWithURL:(NSURL *)url forState:(UIControlState)state completed:(ZWebImageDownloadCompleteBlock)completedBlock
{
    [self tt_setImageWithURL:url forState:state placeholderImage:nil completed:completedBlock];
}

- (void)tt_setImageWithURL:(NSURL *)url forState:(UIControlState)state placeholderImage:(UIImage *)placeholder completed:(ZWebImageDownloadCompleteBlock)completedBlock
{
    [self tt_setImageWithURL:url forState:state placeholderImage:placeholder options:ZWebImageRetryFailed completed:completedBlock];
}

- (void)tt_setImageWithURL:(NSURL *)url forState:(UIControlState)state placeholderImage:(UIImage *)placeholder options:(ZWebImageOptions)options completed:(ZWebImageDownloadCompleteBlock)completedBlock
{
    [self sd_setImageWithURL:url forState:state placeholderImage:placeholder options:(SDWebImageOptions)options completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if (completedBlock) {
            completedBlock(image, error, (ZImageCacheType)cacheType, imageURL);
        }
    }];
}

- (void)tt_cancelImageLoadForState:(UIControlState)state
{
    [self sd_cancelImageLoadForState:state];
}

#pragma mark - # BackgroundImage

- (void)tt_setBackgroundImageWithURL:(NSURL *)url forState:(UIControlState)state
{
    [self tt_setBackgroundImageWithURL:url forState:state placeholderImage:nil options:0 completed:nil];
}

- (void)tt_setBackgroundImageWithURL:(NSURL *)url forState:(UIControlState)state placeholderImage:(UIImage *)placeholder
{
    [self tt_setBackgroundImageWithURL:url forState:state placeholderImage:placeholder options:0 completed:nil];
}

- (void)tt_setBackgroundImageWithURL:(NSURL *)url forState:(UIControlState)state placeholderImage:(UIImage *)placeholder options:(ZWebImageOptions)options
{
    [self tt_setBackgroundImageWithURL:url forState:state placeholderImage:placeholder options:options completed:nil];
}

- (void)tt_setBackgroundImageWithURL:(NSURL *)url forState:(UIControlState)state completed:(ZWebImageDownloadCompleteBlock)completedBlock
{
    [self tt_setBackgroundImageWithURL:url forState:state placeholderImage:nil options:0 completed:completedBlock];
}

- (void)tt_setBackgroundImageWithURL:(NSURL *)url forState:(UIControlState)state placeholderImage:(UIImage *)placeholder completed:(ZWebImageDownloadCompleteBlock)completedBlock
{
    [self tt_setBackgroundImageWithURL:url forState:state placeholderImage:placeholder options:0 completed:completedBlock];
}

- (void)tt_setBackgroundImageWithURL:(NSURL *)url forState:(UIControlState)state placeholderImage:(UIImage *)placeholder options:(ZWebImageOptions)options completed:(ZWebImageDownloadCompleteBlock)completedBlock
{
    [self sd_setBackgroundImageWithURL:url forState:state placeholderImage:placeholder options:(SDWebImageOptions)options completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if (completedBlock) {
            completedBlock(image, error, (ZImageCacheType)cacheType, imageURL);
        }
    }];
}

- (void)tt_cancelBackgroundImageLoadForState:(UIControlState)state
{
    [self sd_cancelBackgroundImageLoadForState:state];
}

@end
