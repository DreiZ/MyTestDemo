//
//  ZBaseViewModel.h
//  ZBigHealth
//
//  Created by zhuang zhang on 2018/10/29.
//  Copyright © 2018 zhuang zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZBaseNetworkBackModel.h"
#import "ZNetworkingManager.h"

typedef void(^completionHandler)(NSError *error);
typedef void(^resultDataBlock)(BOOL isSuccess, id data);

@protocol BaseViewModelDelegate <NSObject>
@optional
/** 获取数据 */
- (void)getDataFromNetCompletionHandler:(completionHandler)completionHandler;
/** 刷新 */
- (void)refreshDataCompletionHandler:(completionHandler)completionHandler;
/** 获取更多 */
- (void)getMoreDataCompletionHandler:(completionHandler)completionHandler;

@end

@interface ZBaseViewModel : NSObject<BaseViewModelDelegate>

@property (strong, nonatomic) NSMutableArray *dataMArr;
@property (strong, nonatomic) NSURLSessionDataTask *dataTask;

/** 取消任务 */
- (void)cacelTask;
/** 暂停任务 */
- (void)suspendTask;
/** 继续任务 */
- (void)resumeTask;


+ (void)uploadImageList:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock;


+ (void)deleteImageList:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock;
@end


