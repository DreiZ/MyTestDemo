//
//  HNDebug.m
//  zzz
//
//  Created by zzz on 2018/4/25.
//  Copyright © 2018年 zzz. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "ZDebug.h"
#import "AFHTTPSessionManager.h"

#ifdef DEBUG

#ifdef LogImageNameErrorIfNil
@implementation UIImage (Debug)

+(void)load
{
    [self swizzleClassMethod:@selector(imageNamed:) with:@selector(zz_imageNamed:)];
}

+ (UIImage *)zz_imageNamed:(NSString *)name
{
    if(!ValidStr(name)) {
        DLog(@"【imageNmae】：图片名字为空,请检查");
        return nil;
    }
    return [self zz_imageNamed:name];
}
@end
#endif


#ifdef LogViewDidLoadAndDealloc
@implementation UIViewController (Debug)

+(void)load
{
    [self swizzleInstanceMethod:@selector(viewDidLoad) with:@selector(zz_viewDidLoad)];
    [self swizzleInstanceMethod:NSSelectorFromString(@"dealloc") with:@selector(zz_dealloc)];
}

- (void)zz_viewDidLoad
{
    DLog(@"【viewDidLoad】: %@", NSStringFromClass([self class]));
    [self zz_viewDidLoad];
}

- (void)zz_dealloc
{
    DLog(@"【dealloc】: %@", NSStringFromClass([self class]));
    [self zz_dealloc];
}
@end
#endif

#endif
