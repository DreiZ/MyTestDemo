//
//  ZFileUploadManager.m
//  NoWait
//
//  Created by zhuang zhang on 2020/6/19.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZFileUploadManager.h"
#import <libkern/OSAtomic.h>
#import "ZNetworkingManager.h"

NSString * const FBAttachmentUploadSuccessNumber = @"successNumber";
NSString * const FBAttachmentUploadFailureNumber = @"failureNumber";
int32_t _longInt = 1;


static ZFileUploadManager *fileUploadManager;


@implementation ZFileUploadManager

+ (ZFileUploadManager *)sharedInstance
{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        fileUploadManager = [[ZFileUploadManager alloc] init];
    });
    return fileUploadManager;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _taskList = @[].mutableCopy;
        _taskModelList = @[].mutableCopy;
        _longInt = 1;
    }
    return self;
}


#pragma mark - upload task data
+ (void)addTaskDataToUploadWith:(ZFileUploadDataModel *)taskData {
    [[ZFileUploadManager sharedInstance].taskModelList insertObject:taskData atIndex:0];
}

//添加task 到队列
+ (void)addTaskToUploadWith:(ZFileUploadTask *)task {
    [[ZFileUploadManager sharedInstance].taskList insertObject:task atIndex:0];
}

+ (void)addTasksToUploadWith:(NSArray <ZFileUploadTask *>*)task_list {
    for (int i = 0; i < task_list.count; i++) {
        [[ZFileUploadManager sharedInstance].taskList insertObject:task_list[i] atIndex:0];
    }
}

#pragma mark -上传图片异步串行-
- (void)asyncSerialUpload:(NSMutableArray <ZFileUploadDataModel *>*)dataArray progress:(void(^)(CGFloat p, NSInteger index))progress completion:(void(^)(id obj))completion{
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1. * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        for (ZFileUploadDataModel *model in dataArray) {
            if (model.image_url.length>0) {
                model.taskState = ZUploadStateFinished;
            }
        }
        [ZFileUploadManager asyncSerialUploadArray:dataArray progress:^(CGFloat p, NSInteger index) {
            self.uploading = YES;
            DLog(@"%.4f----%ld",p,(long)index);
            if (progress) {
                progress(p, index);
            }
        } completion:^(id obj) {
            DLog(@"数量：%@",obj);
            self.uploading = NO;
            DLog(@"异步串行-所有的任务都完成了...");
            if (completion) {
                completion(obj);
            }
        }];
    });
}

+ (void)asyncSerialUploadArray:(NSArray<ZFileUploadDataModel *> *)modelArray progress:(void(^)(CGFloat p, NSInteger index))progress completion:(void(^)(id obj))completion {
    
    if (!modelArray || modelArray.count<1) {
        dispatch_async(dispatch_get_main_queue(), ^{
            !completion?:completion(nil);
        });
        return ;
    }
    NSAssert((modelArray && modelArray.count>0), @"upload model数组nil");
    
    NSMutableArray *mutDic = [NSMutableArray array];
    __block NSInteger successInt=0,failureInt=0;
    
    //创建异步串行队列
    dispatch_async(dispatch_queue_create("com.fb_upload.queue", DISPATCH_QUEUE_SERIAL), ^{
        
        //用信号量sema保证一次只上传一个
        dispatch_semaphore_t sema = dispatch_semaphore_create(0);
        NSInteger shouldUploadNumber = 0;
        for (int i = 0;i<modelArray.count;i++) {
            ZFileUploadDataModel *model = modelArray[i];
            if (!model) { continue; }
            if (model.taskState != ZUploadStateWaiting) { continue; }
            if (![model isKindOfClass:[ZFileUploadDataModel class]]) { continue; }
            shouldUploadNumber += 1;
            ZFileUploadTask *task = [ZFileUploadManager uploadFileWithModel:model success:^(id obj) {
                successInt += 1;

                //单个任务的
                dispatch_semaphore_signal(sema);
                //单个model的成功回调
                if (model.completeBlock) {
                    model.completeBlock(obj);
                }
                [mutDic addObject:obj];
            } progress:^(int64_t p, int64_t a) {
                //单个model的进度
                if (model.progressBlock) { model.progressBlock(p, a); }
                //总的进度
                if (progress) {
                    progress(1.0 * p/a,i);
                }
            } failure:^(NSError *error) {
                failureInt += 1;
                
                dispatch_semaphore_signal(sema);
                if (model.errorBlock) {
                    model.errorBlock(error);
                    
                }
            }] ;
            [ZFileUploadManager addTaskToUploadWith:task];
            dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
        }
        
        if (shouldUploadNumber<1) {
            dispatch_async(dispatch_get_main_queue(), ^{
                !completion?:completion(nil);
            });
        }
        
        //总的完成以后的回调
//        [mutDic setObject:[NSNumber numberWithInteger:successInt] forKey:FBAttachmentUploadSuccessNumber];
//        [mutDic setObject:[NSNumber numberWithInteger:failureInt] forKey: FBAttachmentUploadFailureNumber];
        if (completion) {
            completion(mutDic);
        }
    });
}

#pragma mark - 上传图片-异步并行 一张一张
/**
异步并行上传多张图片（用常量监控上传）
*/
- (void)asyncConcurrentConstUpload:(NSMutableArray <ZFileUploadDataModel *>*)dataArray {

    self.uploading = YES;
    [ZFileUploadManager asyncConcurrentConstUploadArray:dataArray uploading:nil completion:^(id obj) {
        self.uploading = NO;
        DLog(@"异步并行(常量)-所有的任务都完成了...");
    }];
}


+ (void)asyncConcurrentConstUploadArray:(NSArray<ZFileUploadDataModel *> *)modelArray uploading:(void (^)(void))uploading completion:(void (^)(id))completion {
    
    if (!modelArray || modelArray.count<1) {
        return ;
    }
    
    NSAssert((modelArray && modelArray.count>0), @"图片model数组nil");
    
    void (^endBlock)(int32_t) = ^(int32_t x){
        if (x == 1) {
            if (completion) { completion(nil); }
        }
    };
    
    for (ZFileUploadDataModel *model in modelArray) {
        if (!model.image) { continue; }
        if (model.taskState != ZUploadStateWaiting) { continue; }
        
        OSAtomicIncrement32(&_longInt);
        ZFileUploadTask *task = [ZFileUploadManager asyncConcurrentUploadWithModel:model Success:^(id obj) {
            OSAtomicDecrement32(&_longInt);
            endBlock(_longInt);
        } progress:^(int64_t p, int64_t a) {
            if (uploading) { uploading(); }
        } failure:^(NSError *error) {
            OSAtomicDecrement32(&_longInt);
            endBlock(_longInt);
        }];
        
        [[ZFileUploadManager sharedInstance].taskList addObject:task];
    }
}

#pragma mark - 上传图片-异步并行
/**
 异步并行
 上传图片-用dispatch_group监控所有上传完成动作-缺点是不能实时往group里添加任务
 */
- (void)asyncConcurrentGroupUpload:(NSMutableArray <ZFileUploadDataModel *>*)dataArray {
    self.uploading = YES;
    [ZFileUploadManager asyncConcurrentGroupUploadArray:dataArray uploading:^{
    
    } completion:^(id obj) {
        DLog(@"异步并行(dispatch_group)-所有的任务都完成了...");
        self.uploading = NO;
    }];
}


/**
 异步并行上传多张图片（用dispatch_group_t上传）
 @param modelArray 图片model数组
 @param uploading 上传中的状态回调
 @param completion 上传完成回调
 */
+ (void)asyncConcurrentGroupUploadArray:(NSArray<ZFileUploadDataModel *> *)modelArray uploading:(void(^)(void))uploading completion:(void (^)(id))completion {
    
    if (!modelArray || modelArray.count<1) {
        return;
    }
    NSAssert((modelArray && modelArray.count>0), @"图片model数组nil");
    
    //创建group
    dispatch_group_t uploadGroup = dispatch_group_create();
    
    for (ZFileUploadDataModel *model in modelArray) {
        if (!model.image) { continue; }
        if (model.taskState != ZUploadStateWaiting) { continue; }
        

        dispatch_group_enter(uploadGroup);
        
        ZFileUploadTask *task = [ZFileUploadManager asyncConcurrentUploadWithModel:model Success:^(id obj) {
            dispatch_group_leave(uploadGroup);
        } progress:^(int64_t p, int64_t a) {
            
        } failure:^(NSError *error) {
            dispatch_group_leave(uploadGroup);
        }];
        
        [[ZFileUploadManager sharedInstance].taskList addObject:task];
    }
    
    dispatch_group_notify(uploadGroup, dispatch_get_main_queue(), ^{
        if (completion) {
            completion(nil);
        }
    });
}

#pragma mark - 上传--
/**
 异步并行上传图片（一次只上传一张）
 
 @param success 每个model成功回调
 @param progress 每个model进度条回调
 @param failure 每个model失败回调
 */
+ (ZFileUploadTask *)asyncConcurrentUploadWithModel:(ZFileUploadDataModel *)model Success:(void (^)(id))success progress:(void (^)(int64_t, int64_t))progress failure:(void (^)(NSError *))failure {

    __block ZFileUploadTask *task = nil;
    
    dispatch_async(dispatch_queue_create("com.fb_upload.queue", DISPATCH_QUEUE_CONCURRENT), ^{

        task = [ZFileUploadManager uploadFileWithModel:model success:^(id obj) {
            if (success) { success(obj); }
        } progress:^(int64_t p, int64_t a) {
            if (progress) { progress(p, a); }
        } failure:^(NSError *error) {
            if (failure) { failure(error); }
        }];

    });
    
    return task;
}
/**
 抽取的公共的上传方法
 @param model 每个图片model
 @param success 成功回调
 @param progress 进度回调
 @param failure 失败回调
 */
//+ (ZFileUploadTask *)uploadFileWithModel:(ZFileUploadDataModel *)model success:(void(^)(id obj))success progress:(void(^)(int64_t p, int64_t a))progress failure:(void(^)(NSError *error))failure {
//    if (!model) { return nil; }
//    NSAssert(model, @"model为nil");
//    
//    ZFileUploadTask *task = [[ZFileUploadTask alloc] init];
//    task.model = model;
//    task.model.taskState = ZUploadStateOnGoing;
//    for (; task.progress<=1.0f; ) {
//        CGFloat per = (arc4random() % 100)/1000.0f;
//        task.progress += per;
//        dispatch_async(dispatch_get_main_queue(), ^{
//            //DLog(@"index：%@----进度：%.2f",self.index,self.progress);
//            //模拟上传中的状态
//            if (progress) { progress(task.progress*1000, 1000); }
//            if (task.model.progressBlock) { task.model.progressBlock(task.progress * 1000, 1000); }
//            //模拟上传完成的状态
//            if (task.progress>=1.) {
//                task.model.taskState = ZUploadStateFinished;
//                if (success) { success(@{}); }
//                if (task.model.completeBlock) { task.model.completeBlock(@{}); }
//                return ;
//            }
//            //模拟上传失败的状态
//            if (task.progress<0) {
//                task.model.taskState = ZUploadStateError;
//                if (failure) { failure(nil); }
//                if (task.model.errorBlock) { task.model.errorBlock(nil); }
//            }
//        });
//        usleep(500000);
//    }
//    
//    return task;
//}

#pragma mark -znetworking 上传图片
+ (ZFileUploadTask *)uploadFileWithModel:(ZFileUploadDataModel *)model success:(void(^)(id obj))success progress:(void(^)(int64_t p, int64_t a))progress failure:(void(^)(NSError *error))failure {
    return [ZNetworkingManager postImageWithModel:model success:success progress:progress failure:failure];
}

@end
