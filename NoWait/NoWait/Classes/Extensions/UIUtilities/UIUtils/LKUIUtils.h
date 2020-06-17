//
//  LKUIUtils.h
//  Live
//
//  Created by Laka on 16/3/8.
//  Copyright © 2016年 Heller. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LKUIUtils : NSObject

/**
  翻倍动画

 @param imageView 需要做翻倍动画的ImageView
 @param toImage 目标图片
 @param duration 动画时间
 @param animations 动画执行
 @param completion 执行结束
 */
+ (void)doubleAnimaitonWithImageView:(UIImageView *)imageView
                             toImage:(UIImage *)toImage
                            duration:(NSTimeInterval)duration
                          animations:(void (^)(void))animations
                          completion:(void (^)(void))completion;

+ (void)doubleAnimaitonWithButton:(UIButton *)button
                             toImage:(UIImage *)toImage
                            duration:(NSTimeInterval)duration
                          animations:(void (^)(void))animations
                          completion:(void (^)(void))completion;

/**
 生成新的图片
 
 @param image 原始图片
 @param newSize 新的尺寸
 @return 新的图片
 */
+ (UIImage *)imageWithImage:(UIImage*)image
               scaledToSize:(CGSize)newSize;

/**
 压缩图片到1080p 以内
 
 @param image 待压缩图片
 @return 压缩后的图片
 */
+ (UIImage *)compressByImage:(UIImage *)image;

/**
 要模糊化的图片，先做压缩处理
 
 @param image 要模糊化的图片
 @return 压缩后的图片
 */
+ (UIImage *)compressForBlurByImage:(UIImage *)image;

/**
 给图片添加空白区域

 @param image 图片
 @param extraEdgeInset 图片的额外区域
 */
+ (UIImage *)resizeImage:(UIImage *)image extraEdgeInset:(UIEdgeInsets)extraEdgeInset;

/**
 对图片做尺寸和质量压缩，并返回
 
 @param image 原始图片
 @param defaultSize 默认压缩到尺寸容器
 @param compressRate 质量压缩率 0.0 - 1.0
 @return 压缩后的图片
 */
+ (UIImage *)compressByImage:(UIImage *)image
               containerSize:(CGSize)defaultSize
                compressRate:(CGFloat)compressRate;

+ (UIImage *)getRoundImageWithCutOuter:(BOOL)isCutOuter
                               corners:(UIRectCorner)corners
                                  size:(CGSize)size
                                radius:(CGFloat)radius
                       backgroundColor:(UIColor *)backgroundColor;

/**
 创建背景色PlaceHolderImage
 
 @param  size 大小
 @return UIImage
 */
+ (UIImage *)createPlaceHolderWithImage:(UIImage *)centerPlaceHolder
                                   size:(CGSize)size
                                bgColor:(UIColor *)color;

/**
 创建固定颜色(0xeeeeee)的PlaceHolderImage, 会缓存内存中
 
 @param  centerPlaceHolderName 中间默认名称
 @param  size 大小
 @return UIImage
 */
+ (UIImage *)createPlaceHolderWithImage:(NSString *)centerPlaceHolderName
                                   size:(CGSize)size;

/**
 *  只下载,不设置图片
 *
 *  @param imageURL 图片地址
 *  @param height   指定高度
 *  @param complete 回调block
 */

+ (void)downloadImage:(NSString *)imageURL
               height:(NSInteger)height
             complete:(void (^)(UIImage * image))complete;


/**
 *  分享下载,不设置图片
 *
 *  @param imageURL 图片地址
 *  @param complete 回调block
 */
+ (void)downloadShareImage:(NSString *)imageURL
                  complete:(void (^)(UIImage * image))complete;

/**
 显示textFeid的动画
 
 @param textField UITextField
 @param completion 动画完成的block
 */
+ (void)showTextFieldShakeAnimation:(UITextField *)textField completion:(void(^)(void))completion;
@end
