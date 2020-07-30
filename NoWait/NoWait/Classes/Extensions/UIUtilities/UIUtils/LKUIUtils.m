//
//  LKUIUtils.m
//  Live
//
//  Created by Laka on 16/3/8.
//  Copyright © 2016年 Heller. All rights reserved.
//

#import "LKUIUtils.h"
#import "Masonry.h"
#import "YYKit.h"
#import "UIImage+YYAdd.h"
#import "SDWebImageManager.h"
#import "SDWebImageDownloader.h"
#import "UIImage+YYAdd.h"

/**
 *  圆角蒙版Image 缓存
 */
@interface LVRoundMarkCacheKey : NSObject
@property (nonatomic, assign)CGSize size;
@property (nonatomic, assign)CGFloat radius;
@property (nonatomic, strong)UIColor *color;
@property (nonatomic, strong)UIImage *image;
@end

@implementation LVRoundMarkCacheKey
@end

/**
 *  用于拉伸的UIImage图 缓存
 */
@interface LVLineImageCacheKey : NSObject
@property (nonatomic, assign)BOOL isVertical;
@property (nonatomic, assign)BOOL isFirstPixelOpaque;
@property (nonatomic, strong)UIColor *highlightColor;
@property (nonatomic, strong)UIImage *image;
@end
@implementation LVLineImageCacheKey
@end

NSString *const LKAvatarPlacehodlerBlurImage =  @"LKAvatarPlacehodlerBlurImage"; //头像默认图模糊化图片

@implementation LKUIUtils

+ (NSCache *)cahce
{
    static NSCache *cache;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cache = [[NSCache alloc] init];
    });
    return cache;
}

/**
 *  生成用于拉伸的UIImage图 (2x1 Or 1*2)像素永久保存内存
 *
 *  @param isVertical      是否垂直拉伸
 *  @param isFirstOpaque   是否第一像素不透明
 *  @param highlightColor  显示的颜色
 *
 *  @return image
 */
+ (UIImage *)getLineImageWithIsVertical:(BOOL)isVertical
                     isFirstPixelOpaque:(BOOL)isFirstOpaque
                         highlightColor:(UIColor *)highlightColor
{
    static NSMutableArray *cacheArray = nil;
    
    UIImage *retImage = nil;
    LVLineImageCacheKey *cacheKey = nil;
    
    if(cacheArray) cacheArray = [NSMutableArray new];
    
    for(LVLineImageCacheKey *tmp in cacheArray)
    {
        if((tmp.isVertical == isVertical) &&
           (tmp.highlightColor == highlightColor) &&
           (tmp.isFirstPixelOpaque == isFirstOpaque))
        {
            cacheKey = tmp;
            break;
        }
    }
    
    if(!cacheKey)
    {
        CGSize vSize = isVertical?(CGSize){2, 1}:(CGSize){1, 2};
        
        UIGraphicsBeginImageContext(vSize);
        
        //创建路径并获取句柄
        CGMutablePathRef path = CGPathCreateMutable();
        
        CGFloat leftMargin = isVertical&&!isFirstOpaque ? 1:0;
        CGFloat topMargin = !isVertical&&!isFirstOpaque ? 1:0;
        
        //指定矩形
        CGRect rectangle = (CGRect){leftMargin,topMargin, 1, 1};
        
        //将矩形添加到路径中
        CGPathAddRect(path,NULL, rectangle);
        
        //获取上下文
        CGContextRef currentContext = UIGraphicsGetCurrentContext();
        
        //将路径添加到上下文
        CGContextAddPath(currentContext,path);
        
        //设置矩形填充色
        [highlightColor setFill];
        
        //矩形边框颜色
        [[UIColor clearColor] setStroke];
        
        //绘制
        CGContextDrawPath(currentContext,kCGPathFillStroke);
        
        CGPathRelease(path);
        
        retImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        cacheKey = [LVLineImageCacheKey new];
        cacheKey.isVertical = isVertical;
        cacheKey.isFirstPixelOpaque = isFirstOpaque;
        cacheKey.highlightColor = highlightColor;
        cacheKey.image = retImage;
        
        [cacheArray addObject:cacheKey];
    }
    else
    {
        retImage = cacheKey.image;
    }
    
    return retImage;
}

+ (UIColor *)getColorOfPercent:(CGFloat)percent between:(UIColor *)color1 and:(UIColor *)color2
{
    CGFloat red1, green1, blue1, alpha1;
    [color1 getRed:&red1 green:&green1 blue:&blue1 alpha:&alpha1];
    
    CGFloat red2, green2, blue2, alpha2;
    [color2 getRed:&red2 green:&green2 blue:&blue2 alpha:&alpha2];
    
    CGFloat p1 = percent;
    CGFloat p2 = 1.0 - percent;
    UIColor *mid = [UIColor colorWithRed:red1*p1+red2*p2 green:green1*p1+green2*p2 blue:blue1*p1+blue2*p2 alpha:1.0f];
    return mid;
}

/**
 *  获得某个范围内的屏幕图像
 *
 *  @param theView View
 *  @param frame   frame
 *
 *  @return Image
 */
+ (UIImage *)getImageFromView:(UIView *)theView atFrame:(CGRect)frame
{
    NSParameterAssert(theView);
    
    UIGraphicsBeginImageContextWithOptions(theView.frame.size, NO, [UIScreen mainScreen].scale);
    //    if (IOS7) {
    //        [theView drawViewHierarchyInRect:theView.bounds afterScreenUpdates:YES];
    //    }else {
    //        theView.layer.contentsScale = [UIScreen mainScreen].scale;
    //        [theView.layer renderInContext:UIGraphicsGetCurrentContext()];
    //    }
    
    theView.layer.contentsScale = [UIScreen mainScreen].scale;
    [theView.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    theImage = [self clipRoundImageWithImage:theImage
                                       frame:CGRectMake(0, 0, frame.size.width, frame.size.height)
                                      Radius:theView.layer.cornerRadius
                                 StrokeColor:[UIColor clearColor]];
    
    return theImage;
}

/**
 *  UIView提取Image
 *
 *  @param theView View
 *
 *  @return Image
 */
+ (UIImage *)getImageFromView:(UIView *)theView
{
    UIImage *img = nil;
    if(!CGSizeEqualToSize(theView.frame.size, CGSizeZero))
    {
        UIGraphicsBeginImageContextWithOptions(theView.frame.size, NO, [UIScreen mainScreen].scale);
        if(![theView drawViewHierarchyInRect:theView.bounds afterScreenUpdates:YES]) {
            theView.layer.contentsScale = [UIScreen mainScreen].scale;
            [theView.layer renderInContext:UIGraphicsGetCurrentContext()];
        }
        img = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    
    return img;
}

+ (UIImage *)getImageFromView:(UIView *)theView scale:(CGFloat)scale
{
    UIImage *img = nil;
    if(!CGSizeEqualToSize(theView.frame.size, CGSizeZero))
    {
        UIGraphicsBeginImageContextWithOptions(theView.frame.size, NO, scale);
        if(![theView drawViewHierarchyInRect:theView.bounds afterScreenUpdates:YES]) {
            theView.layer.contentsScale = scale;
            [theView.layer renderInContext:UIGraphicsGetCurrentContext()];
        }
        img = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    
    return img;
}

+ (UIImage*) clipRoundImageWithImage:(UIImage*)origImage
                               frame:(CGRect)frame
                              Radius:(CGFloat)r
                         StrokeColor:(UIColor *)strokeColor
{
    if (!origImage || CGSizeEqualToSize(origImage.size, CGSizeZero)) {
        return nil;
    }
    
    UIBezierPath *clipPath = [UIBezierPath bezierPathWithRoundedRect:frame cornerRadius:r];
    UIBezierPath *roundPath = clipPath;
    
    UIGraphicsBeginImageContextWithOptions(frame.size, NO, 0.0);
    {
        clipPath.usesEvenOddFillRule = YES;
        
        if (strokeColor) {
            [roundPath setLineWidth:1.0f];
            [strokeColor set];
            [roundPath stroke];
        }
    }
    [clipPath addClip];
    
    [origImage drawInRect:CGRectMake(0, 0, origImage.size.width, origImage.size.height)];
    UIImage* result = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return result;
}

+ (void)doubleAnimaitonWithImageView:(UIImageView *)imageView
                             toImage:(UIImage *)toImage
                            duration:(NSTimeInterval)duration
                          animations:(void (^)(void))animations
                          completion:(void (^)(void))completion
{
    [UIView transitionWithView:imageView  duration:duration
                       options:UIViewAnimationOptionTransitionFlipFromLeft
                    animations:^ {
                        imageView.image  = toImage;
                        if(animations) {
                            animations();
                        }
                    }
                    completion:^(BOOL finished){
                        
                        if(completion) {
                            completion();
                        }
                    }];
}

+ (void)doubleAnimaitonWithButton:(UIButton *)button
                          toImage:(UIImage *)toImage
                         duration:(NSTimeInterval)duration
                       animations:(void (^)(void))animations
                       completion:(void (^)(void))completion
{
    [UIView transitionWithView:button  duration:duration
                       options:UIViewAnimationOptionTransitionFlipFromLeft
                    animations:^ {
                        
                        [button setImage:toImage forState:UIControlStateNormal];
                        if(animations) {
                            animations();
                        }
                    }
                    completion:^(BOOL finished){
                        
                        if(completion) {
                            completion();
                        }
                    }];
}

+ (UIImage *)imageWithImage:(UIImage*)image
               scaledToSize:(CGSize)newSize;
{
    UIGraphicsBeginImageContextWithOptions(newSize, NO, image.scale);
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

+ (UIImage *)compressByImage:(UIImage *)image
{
    CGSize compareSize = CGSizeMake(1280.0, 1280.0);
    if (image.scale <= 1) {
        compareSize = CGSizeMake(1280.0, 1280.0);
    }else if (image.scale == 2) {
        compareSize = CGSizeMake(640.0, 640.0);
    }else if (image.scale >= 3) {
        compareSize = CGSizeMake(480.0, 480.0);
    }
    
    return [self compressByImage:image containerSize:compareSize compressRate:0.5];
}

+ (UIImage *)compressForBlurByImage:(UIImage *)image
{
    return [self compressByImage:image containerSize:CGSizeMake(320.0, 568.0) compressRate:0.5];
}

+ (UIImage *)resizeImage:(UIImage *)image extraEdgeInset:(UIEdgeInsets)extraEdgeInset;
{
    CGFloat width = extraEdgeInset.left + image.size.width + extraEdgeInset.right;
    CGFloat height = extraEdgeInset.top + image.size.height + extraEdgeInset.bottom;
    
    // 绘制透明图的图片
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(width, height), NO, 0.0f);
    CGRect area = CGRectMake(extraEdgeInset.left, extraEdgeInset.top, image.size.width, image.size.height);
    [image drawInRect:area];
    UIImage *extraEdgeInsetImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return extraEdgeInsetImage;
}

+ (UIImage *)compressByImage:(UIImage *)image
               containerSize:(CGSize)boundarySize
                compressRate:(CGFloat)compressRate
{
    if (!image) {
        return nil;
    }
    
    UIImage *retImage = nil;
    NSData *imageData = nil;
    
    CGSize imageSize = image.size;
    CGFloat boundaryWidth  = boundarySize.width;
    CGFloat boundaryHeight = boundarySize.height;
    
    if(imageSize.width < boundaryWidth || imageSize.height < boundaryHeight) {
        imageData = UIImageJPEGRepresentation(image, 0.5);
        retImage = [UIImage imageWithData:imageData];
        return image;
    }
    
    CGFloat compressW    = compressRate;
    CGFloat compressH    = compressRate;
    CGFloat compress     = 1.0f;
    
    if (imageSize.width >= boundaryWidth && imageSize.height >= boundaryHeight) {
        
        compressW = boundaryWidth/image.size.width;
        compressH = boundaryHeight/image.size.height;
        compress = MIN(compressW, compressH);
        
    } else if (imageSize.width >= boundaryHeight && imageSize.height >= boundaryWidth) {
        
        compressW = boundaryHeight/image.size.width;
        compressH = boundaryWidth/image.size.height;
        compress = MIN(compressW, compressH);
        
    } else if (imageSize.width >= boundaryWidth || imageSize.width >= boundaryHeight ||
               imageSize.height >= boundaryWidth || imageSize.height >= boundaryHeight) {
        compress = 0.5;
    }
    
    imageSize = CGSizeMake(imageSize.width * compress, imageSize.height * compress);
    
    //体积压缩
    retImage = [LKUIUtils imageWithImage:image scaledToSize:imageSize];
    
    imageData = UIImageJPEGRepresentation(retImage, 0.5);
    retImage = [UIImage imageWithData:imageData];
    
    return retImage;
}

+ (UIImage *)getRoundImageWithCutOuter:(BOOL)isCutOuter
                               corners:(UIRectCorner)corners
                                  size:(CGSize)size
                                radius:(CGFloat)radius
                       backgroundColor:(UIColor *)backgroundColor
{
    NSString *saveKey = [NSString stringWithFormat:@"RoundImage:%@_%@_%@_%@_%@_%@",
                         NSStringFromCGSize(size),
                         @(isCutOuter),
                         @(radius),
                         @(corners),
                         @(radius),
                         [backgroundColor hexString]];
    
    UIImage *retImage = (UIImage *) [[self cahce] objectForKey:saveKey];
    if (retImage) {
        return retImage;
    }else {
        UIView *roundView = [UIView new];
        roundView.backgroundColor = backgroundColor;
        [roundView setFrame:(CGRect){0,0,size.width+2, size.height+2}];
        
        retImage = [LKUIUtils getImageFromView:roundView atFrame:(CGRect){0, 0, size}];
        retImage = [self clipImageWithOriginalImage:retImage
                                           cutOuter:isCutOuter
                                            corners:corners
                                             radius:radius
                                        strokeColor:nil
                                          lineWidth:0];
        
        [[self cahce] setObject:retImage forKey:saveKey];
    }
    
    return retImage;
}

+ (UIImage *)clipImageWithOriginalImage:(UIImage *)origImage
                               cutOuter:(BOOL)isCutOuter
                                corners:(UIRectCorner)corners
                                 radius:(CGFloat)radius
                            strokeColor:(UIColor *)strokeColor
                              lineWidth:(CGFloat)lineWidth
{
    if (!origImage || CGSizeEqualToSize(origImage.size, CGSizeZero)) {
        return nil;
    }
    
    CGRect rect = (CGRect){CGPointZero, origImage.size};
    
    UIBezierPath *roundPath = nil;
    UIBezierPath *clipPath = nil;
    
    if (isCutOuter) {
        clipPath = [UIBezierPath bezierPathWithRoundedRect:rect
                                         byRoundingCorners:corners
                                               cornerRadii:CGSizeMake(radius, radius)];
        roundPath = clipPath;
    }else{
        clipPath = [UIBezierPath bezierPathWithRect:CGRectInfinite];
        roundPath = [UIBezierPath bezierPathWithRoundedRect:rect
                                          byRoundingCorners:corners
                                                cornerRadii:CGSizeMake(radius, radius)];
        [clipPath appendPath:roundPath];
    }
    
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0.0);
    {
        clipPath.usesEvenOddFillRule = YES;
        
        if (!isCutOuter) {
            [UIColor.clearColor setFill];
            [roundPath fill];
        }
        
        if (strokeColor) {
            [roundPath setLineWidth:2.0f];
            [strokeColor set];
            [roundPath stroke];
        }
    }
    [clipPath addClip];
    
    [origImage drawInRect:rect];
    UIImage* result = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return result;
}


+ (UIImage *)createPlaceHolderWithImage:(UIImage *)centerPlaceHolder
                                   size:(CGSize)size
                                bgColor:(UIColor *)color
{
    if(size.width <= 1.0 || size.height < 1.0){
        return nil;
    }
    
    CGSize originSize = centerPlaceHolder.size;
    
    CGFloat originX = (size.width - originSize.width)/2;
    CGFloat originY = (size.height - originSize.height)/2;
    
    CGRect retRect = CGRectMake(0, 0, size.width, size.height);
    CGRect originRect = CGRectMake(originX, originY, originSize.width, originSize.height);
    
    UIImage *bgImage = [UIImage imageWithColor:color size:size];
    
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    
    [bgImage drawInRect:retRect];
    [centerPlaceHolder drawInRect:originRect];
    
    UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return resultingImage;
}

+ (UIImage *)createPlaceHolderWithImage:(NSString *)centerPlaceHolderName
                                   size:(CGSize)size
{
    static NSMutableDictionary *cachePlaceholderImages = nil;
    
    UIImage *resultingImage = nil;
    NSString *cacheKey = [NSString stringWithFormat:@"LKUIPlaceHolder_%@_Size_%@",centerPlaceHolderName, NSStringFromCGSize(size)];
    
    if (cachePlaceholderImages) {
        resultingImage = cachePlaceholderImages[cacheKey];
    }else {
        cachePlaceholderImages = [NSMutableDictionary dictionary];
    }
    
    if (!resultingImage) {
        resultingImage = [self createPlaceHolderWithImage:[UIImage imageNamed:centerPlaceHolderName]
                                                     size:size
                                                  bgColor:UIColorHex(0xF4F4F4)];
        if (resultingImage) {
            [cachePlaceholderImages setObject:resultingImage forKey:cacheKey];
        }
    }
    
    return resultingImage;
}

+ (void)downloadImage:(NSString *)imageURLstr
               height:(NSInteger)height
             complete:(void (^)(UIImage *image))complete
{
    NSString *processURLString = [NSString stringWithFormat:@"%@?x-oss-process=image/resize,h_%@", imageURLstr, @(height)];
    
    NSURL *imageURL = [NSURL URLWithString:processURLString];
    
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    
    [manager downloadImageWithURL:imageURL options:0 progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {

        if(complete) {
            complete(image);
        }
    }];
}

+ (void)downloadShareImage:(NSString *)imageURLStr
                  complete:(void (^)(UIImage *image))complete
{
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    
    NSURL *imageURL = [NSURL URLWithString:imageURLStr];
    [manager downloadImageWithURL:imageURL options:0 progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {

        UIImage *effectImage = [UIImage imageNamed:@"about_app_icon"];
        if(image) {
            effectImage = image;
        }
        
        if(complete) {
            complete(effectImage);
        }
    }];
}

+ (void)showTextFieldShakeAnimation:(UITextField *)textField completion:(void(^)(void))completion
{
    CGFloat t = 4.0;
    
    CGAffineTransform translateRight = CGAffineTransformTranslate(CGAffineTransformIdentity, t, 0.0);
    CGAffineTransform translateLeft = CGAffineTransformTranslate(CGAffineTransformIdentity, -t, 0.0);
    textField.transform = translateLeft;
    
    [UIView animateWithDuration:0.07 delay:0.0 options:UIViewAnimationOptionAutoreverse | UIViewAnimationOptionRepeat animations:^{
        
        [UIView setAnimationRepeatCount:2.0];
        textField.transform = translateRight;
        
    } completion:^(BOOL finished){
        
        [UIView animateWithDuration:0.05 delay:0.0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            textField.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            completion();
        }];
    }];
}

@end
