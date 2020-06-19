//
//  ZVideoHandleManager.h
//  NoWait
//
//  Created by zhuang zhang on 2020/6/17.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WYVideoCompressTools.h"

@interface ZVideoHandleManager : NSObject
+ (ZVideoHandleManager *)sharedInstance;

- (void)videoCompressWithSourceVideoPathString:(NSString *)sourceVideoPathString
                                  CompressType:(NSString *)compressType
                          CompressSuccessBlock:(SuccessBlock)compressSuccessBlock
                              CompressFailedBlock:(FailedBlock)compressFailedBlock
                       CompressNotSupportBlock:(NotSupportBlock)compressNotSupportBlock;
@end

