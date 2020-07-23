//
//  ZVideoPlayerManager.h
//  ZBigHealth
//
//  Created by zhuang zhang on 2019/6/11.
//  Copyright © 2019 zhuang zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SJVideoPlayer.h"

@interface ZVideoPlayerManager : NSObject
+ (ZVideoPlayerManager *)sharedInstance;
@property (nonatomic,strong) SJVideoPlayer *player;

- (void)playVideoWithUrl:(NSString *)url title:(NSString *)title;

- (void)compressVideoWithUrl:(NSString *)url oldUrl:(NSString *)oldUrl;

- (UIImage*)thumbnailImageForVideo:(NSURL *)videoURL atTime:(NSTimeInterval)time;

- (void)getVideoPreViewImageURL:(NSURL *)path placeHolderImage:(UIImage *)placeHolder placeHolderBlock:(void(^)(UIImage *))placeHolderBlock complete:(void(^)(UIImage *))completeBlock;
@end

