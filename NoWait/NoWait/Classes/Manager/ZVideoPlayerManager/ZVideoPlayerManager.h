//
//  ZVideoPlayerManager.h
//  ZBigHealth
//
//  Created by zhuang zhang on 2019/6/11.
//  Copyright © 2019 zhuang zhang. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ZVideoPlayerManager : NSObject
+ (ZVideoPlayerManager *)sharedInstance;


- (void)playVideoWithUrl:(NSString *)url title:(NSString *)title;

- (void)compressVideoWithUrl:(NSString *)url oldUrl:(NSString *)oldUrl;

- (UIImage*)thumbnailImageForVideo:(NSURL *)videoURL atTime:(NSTimeInterval)time;
@end

