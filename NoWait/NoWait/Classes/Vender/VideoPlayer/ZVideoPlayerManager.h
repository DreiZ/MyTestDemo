//
//  ZVideoPlayerManager.h
//  ZBigHealth
//
//  Created by 承希-开发 on 2019/6/11.
//  Copyright © 2019 承希-开发. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ZVideoPlayerManager : NSObject
+ (ZVideoPlayerManager *)sharedInstance;


- (void)playVideoWithUrl:(NSString *)url title:(NSString *)title;
@end

