//
//  UIButton+ZWebImage.h
//  ZBigHealth
//
//  Created by zhuang zhang on 2018/10/16.
//  Copyright © 2018年 zhuang zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+ZWebImage.h"


@interface UIButton (ZWebImage)

- (void)tt_setImageWithURL:(NSURL *)url forState:(UIControlState)state;
- (void)tt_setImageWithURL:(NSURL *)url forState:(UIControlState)state placeholderImage:(UIImage *)placeholder;
- (void)tt_setImageWithURL:(NSURL *)url forState:(UIControlState)state placeholderImage:(UIImage *)placeholder options:(ZWebImageOptions)options;
- (void)tt_setImageWithURL:(NSURL *)url forState:(UIControlState)state completed:(ZWebImageDownloadCompleteBlock)completedBlock;
- (void)tt_setImageWithURL:(NSURL *)url forState:(UIControlState)state placeholderImage:(UIImage *)placeholder completed:(ZWebImageDownloadCompleteBlock)completedBlock;
- (void)tt_setImageWithURL:(NSURL *)url
                  forState:(UIControlState)state
          placeholderImage:(UIImage *)placeholder
                   options:(ZWebImageOptions)options
                 completed:(ZWebImageDownloadCompleteBlock)completedBlock;

- (void)tt_cancelImageLoadForState:(UIControlState)state;

#pragma mark - # BackgroundImage
- (void)tt_setBackgroundImageWithURL:(NSURL *)url forState:(UIControlState)state;
- (void)tt_setBackgroundImageWithURL:(NSURL *)url forState:(UIControlState)state placeholderImage:(UIImage *)placeholder;
- (void)tt_setBackgroundImageWithURL:(NSURL *)url forState:(UIControlState)state placeholderImage:(UIImage *)placeholder options:(ZWebImageOptions)options;
- (void)tt_setBackgroundImageWithURL:(NSURL *)url forState:(UIControlState)state completed:(ZWebImageDownloadCompleteBlock)completedBlock;
- (void)tt_setBackgroundImageWithURL:(NSURL *)url forState:(UIControlState)state placeholderImage:(UIImage *)placeholder completed:(ZWebImageDownloadCompleteBlock)completedBlock;
- (void)tt_setBackgroundImageWithURL:(NSURL *)url forState:(UIControlState)state placeholderImage:(UIImage *)placeholder options:(ZWebImageOptions)options completed:(ZWebImageDownloadCompleteBlock)completedBlock;

- (void)tt_cancelBackgroundImageLoadForState:(UIControlState)state;
@end

