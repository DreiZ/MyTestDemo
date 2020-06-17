//
//  ZUMengShareManager.h
//  ZBigHealth
//
//  Created by zzz on 2018/12/17.
//  Copyright © 2018 zzz. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ZUMengShareManager : NSObject

+ (ZUMengShareManager *)sharedManager ;

- (void)umengShare;


- (void)shareUIWithType:(NSInteger)index image:(UIImage *)image vc:(UIViewController *)vc ;

- (void)shareUIWithType:(NSInteger)index Title:(NSString *)title detail:(NSString *)detail image:(UIImage *)image url:(NSString *)url  vc:(UIViewController *)vc;


@end


