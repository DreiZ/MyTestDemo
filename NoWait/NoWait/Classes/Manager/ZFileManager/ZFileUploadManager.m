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

#import <AliyunOSSiOS/OSSService.h>
#import <AliyunOSSiOS/OSSModel.h>

NSString * const FBAttachmentUploadSuccessNumber = @"successNumber";
NSString * const FBAttachmentUploadFailureNumber = @"failureNumber";
int32_t _longInt = 1;
static NSInteger reAccess  = 3;


@implementation ZAliYunAccess

@end

static ZFileUploadManager *fileUploadManager;

@interface ZFileUploadManager ()
@property (nonatomic,strong) ZAliYunAccess *aliYunAccess;
@property (nonatomic,strong) OSSClient *client;

@property (nonatomic,assign) NSInteger uploadIndex;
@property (nonatomic,strong) NSMutableArray *uploadArr;

@end

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
        
        _aliYunAccess = [[ZAliYunAccess alloc] init];
        _aliYunAccess.AccessKeyId = AliYunAccessKeyId;
        _aliYunAccess.AccessKeySecret = AliYunAccessKeySecret;
    }
    return self;
}


#pragma mark - upload task data
+ (void)addTaskDataToUploadWith:(ZFileUploadDataModel *)taskData {
    [[ZFileUploadManager sharedInstance].taskModelList insertObject:taskData atIndex:0];
}

+ (void)addTaskDatasToUploadWith:(NSArray <ZFileUploadDataModel *>*)taskData_list {
    for (int i = 0; i < taskData_list.count; i++) {
        [[ZFileUploadManager sharedInstance].taskModelList insertObject:taskData_list[i] atIndex:0];
    }
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
- (void)asyncConcurrentConstUpload:(NSMutableArray <ZFileUploadDataModel *>*)dataArray uploading:(void (^)(CGFloat p, NSInteger index))uploading completion:(void (^)(id))completion {

    self.uploading = YES;
    [ZFileUploadManager asyncConcurrentConstUploadArray:dataArray uploading:^(CGFloat p, NSInteger index) {
        if (uploading) {
            uploading(p, index);
        }
    } completion:^(id obj) {
        self.uploading = NO;
        DLog(@"异步并行(常量)-所有的任务都完成了...");
        if (completion) {
            completion(obj);
        }
    }];
}


+ (void)asyncConcurrentConstUploadArray:(NSArray<ZFileUploadDataModel *> *)modelArray uploading:(void (^)(CGFloat p, NSInteger index))uploading completion:(void (^)(id))completion {
    
    if (!modelArray || modelArray.count<1) {
        return ;
    }
    
    NSAssert((modelArray && modelArray.count>0), @"图片model数组nil");
    
    NSMutableArray *dataArr = @[].mutableCopy;
    void (^endBlock)(int32_t,id) = ^(int32_t x, id obj){
        if (obj) {
            [dataArr addObject:obj];
        }
        if (x == 1) {
            if (completion) { completion(dataArr); }
        }
    };
    
    for (int i = 0; i < modelArray.count; i++) {
        ZFileUploadDataModel *model = modelArray[i];
        if (!model.image) { continue; }
        if (model.taskState != ZUploadStateWaiting) { continue; }
        
        OSAtomicIncrement32(&_longInt);
        ZFileUploadTask *task = [ZFileUploadManager asyncConcurrentUploadWithModel:model Success:^(id obj) {
            OSAtomicDecrement32(&_longInt);
            endBlock(_longInt, obj);
        } progress:^(int64_t p, int64_t a) {
            if (uploading) { uploading(1.0 *p/a, i); }
        } failure:^(NSError *error) {
            OSAtomicDecrement32(&_longInt);
            endBlock(_longInt,nil);
        }];
        
        [[ZFileUploadManager sharedInstance].taskList addObject:task];
    }
}

#pragma mark - 上传图片-异步并行
/**
 异步并行
 上传图片-用dispatch_group监控所有上传完成动作-缺点是不能实时往group里添加任务
 */
- (void)asyncConcurrentGroupUpload:(NSMutableArray <ZFileUploadDataModel *>*)dataArray uploading:(void(^)(CGFloat p, NSInteger index))uploading completion:(void (^)(id))completion {
    self.uploading = YES;
    [ZFileUploadManager asyncConcurrentGroupUploadArray:dataArray uploading:^(CGFloat p, NSInteger index) {
        if (uploading) {
            uploading(p, index);
        }
    } completion:^(id obj) {
        DLog(@"异步并行(dispatch_group)-所有的任务都完成了...");
        self.uploading = NO;
        if (completion) {
            completion(obj);
        }
    } ];
}


/**
 异步并行上传多张图片（用dispatch_group_t上传）
 @param modelArray 图片model数组
 @param uploading 上传中的状态回调
 @param completion 上传完成回调
 */
+ (void)asyncConcurrentGroupUploadArray:(NSArray<ZFileUploadDataModel *> *)modelArray uploading:(void(^)(CGFloat p, NSInteger index))uploading completion:(void (^)(id))completion {
    
    if (!modelArray || modelArray.count<1) {
        return;
    }
    NSAssert((modelArray && modelArray.count>0), @"图片model数组nil");
    
    //创建group
    dispatch_group_t uploadGroup = dispatch_group_create();
    
    for (int i = 0; i < modelArray.count; i++) {
        ZFileUploadDataModel *model = modelArray[i];
        if (!model.image) { continue; }
        if (model.taskState != ZUploadStateWaiting) { continue; }
        

        dispatch_group_enter(uploadGroup);
        
        ZFileUploadTask *task = [ZFileUploadManager asyncConcurrentUploadWithModel:model Success:^(id obj) {
            dispatch_group_leave(uploadGroup);
        } progress:^(int64_t p, int64_t a) {
            if (uploading) { uploading(1.0*p/a, i); }
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

#pragma mark - networking 上传图片
+ (ZFileUploadTask *)uploadFileWithModel:(ZFileUploadDataModel *)model success:(void(^)(id obj))success progress:(void(^)(int64_t p, int64_t a))progress failure:(void(^)(NSError *error))failure {
    return [ZNetworkingManager postImageWithModel:model success:success progress:progress failure:failure];
}

//
//+ (ZFileUploadTask *)postFileWithModel:(ZFileUploadDataModel*)fileModel success:(void(^)(id obj))success progress:(void(^)(int64_t p, int64_t a))progress failure:(void(^)(NSError *error))failure {
//    
//    return task;
//}
//

#pragma mark -阿里云
- (OSSClient *)client {
    if (!_client) {
        NSString *endpoint = AliYunendpoint;
        NSString *accessKeyid = self.aliYunAccess.AccessKeyId ;
        NSString *secretKeyId = self.aliYunAccess.AccessKeySecret;
        NSString *securityToken = self.aliYunAccess.SecurityToken;// 可空 看后台
        id<OSSCredentialProvider> credential = [[OSSStsTokenCredentialProvider alloc] initWithAccessKeyId:accessKeyid secretKeyId:secretKeyId securityToken:securityToken];
        
//        id<OSSCredentialProvider> credential = [[OSSAuthCredentialProvider alloc] initWithAuthServerUrl:AliYunImageServer];
        
        // 初始化OSSClientConfiguration
        OSSClientConfiguration *config = [OSSClientConfiguration new];
        
        config.maxRetryCount = 5;// 网络请求遇到异常失败后的重试次数
        config.timeoutIntervalForRequest = 30; // 网络请求的超时时间
        config.timeoutIntervalForResource = 24 * 60 * 60; // 允许资源传输的最长时间
        // 设置后台上传
        config.enableBackgroundTransmitService = YES;
        // 设置session唯一标识
        config.backgroundSesseionIdentifier = accessKeyid;
        
//        _client = [[OSSClient alloc] initWithEndpoint:endpoint credentialProvider:credential];
        _client = [[OSSClient alloc] initWithEndpoint:endpoint credentialProvider:credential clientConfiguration:config];
    }
    return _client;
}

- (void)getAccessKey:(void(^)(BOOL))completeBlock {
    reAccess--;
//    __weak typeof(self) weakSelf = self;
//    [ZNetworking singlePostServerUrl:AliYunImageServer params:@{} completionHandler:^(id data, NSError * error) {
//        if (data && [data objectForKey:@"StatusCode"] && [data[@"StatusCode"] integerValue] == 200) {
//            weakSelf.aliYunAccess = [ZAliYunAccess mj_objectWithKeyValues:data];
//
            
            NSString *endpoint = AliYunendpoint;
            NSString *accessKeyid = self.aliYunAccess.AccessKeyId ;
            NSString *secretKeyId = self.aliYunAccess.AccessKeySecret;
            NSString *securityToken = self.aliYunAccess.SecurityToken;// 可空 看后台
            
            id<OSSCredentialProvider> credential = [[OSSStsTokenCredentialProvider alloc] initWithAccessKeyId:accessKeyid secretKeyId:secretKeyId securityToken:securityToken];
            
            [self.client setEndpoint:endpoint];
            [self.client setCredentialProvider:credential];
            
            
            completeBlock(YES);
//            return ;
//        }
//        completeBlock(NO);
//    }];
}


#pragma mark 上传文件
- (void)aliYunUploadType:(ZAliYunType)type file:(ZFileUploadDataModel *)file progress:(void(^)(CGFloat p, CGFloat a))progress complete:(void(^)(NSString *, NSString *))completeBlock {
    [self aliYunUploadType:type file:file callbackUrl:nil callbackBody:nil callbackVar:nil callbackVarKey:nil progress:progress complete:completeBlock];
}

- (void)aliYunUploadType:(ZAliYunType)type file:(ZFileUploadDataModel *)file callbackUrl:(NSString *)callbackUrl  callbackBody:(NSString *)callbackBody callbackVar:(NSDictionary *)callbackVar callbackVarKey:(NSString *)fileKey progress:(void(^)(CGFloat p, CGFloat a))progress complete:(void(^)(NSString *, NSString *))completeBlock {
    
    OSSPutObjectRequest * put = [OSSPutObjectRequest new];
    if (type == ZAliYunTypeIM) {
        put.bucketName = AliYunBucketIMName;
    }else {
        put.bucketName = AliYunBucketName;
    }
    
    // objectKey为云服储存的文件名
    put.objectKey = file.fileName;
    
    if (file.taskType == ZUploadTypeImage ) {
        UIImage *testImage = file.image;
        NSData *testData = UIImageJPEGRepresentation(testImage, 0.2);
        put.uploadingData = testData;
    }else{
        NSString *testPath = file.filePath;
        put.uploadingFileURL = [NSURL URLWithString:testPath];
    }
    ZFileUploadTask *task = [[ZFileUploadTask alloc] init];
    task.model = file;
    task.model.taskState = ZUploadStateOnGoing;
    file.taskState = ZUploadStateOnGoing;

    // 可选字段，可不设置
    put.uploadProgress = ^(int64_t bytesSent, int64_t totalByteSent, int64_t totalBytesExpectedToSend) {
        // 当前上传段长度、当前已经上传总长度、一共需要上传的总长度
        DLog(@"%lld, %lld, %lld", bytesSent, totalByteSent, totalBytesExpectedToSend);
        if (progress) {
            progress(totalByteSent,totalBytesExpectedToSend);
        }
        
        if (file.progressBlock) {
            file.progressBlock(totalByteSent, totalBytesExpectedToSend);
        }
    };
    // 以下可选字段的含义参考： https://docs.aliyun.com/#/pub/oss/api-reference/object&PutObject
    // put.contentType = @"";
    // put.contentMd5 = @"";
    // put.contentEncoding = @"";
    // put.contentDisposition = @"";
    // put.objectMeta = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"value1", @"x-oss-meta-name1", nil]; // 可以在上传时设置元信息或者其他HTTP头部
    //    request.uploadingFileURL = [NSURL fileURLWithPath:@<filepath>"];
    
    
    //返回值
    if (callbackUrl) {
        //设置回调参数
        NSMutableDictionary *callBackParam = @{}.mutableCopy;
        [callBackParam setObject:callbackUrl forKey:@"callbackUrl"];
        
        if (callbackBody) {
            [callBackParam setObject:callbackBody forKey:@"callbackBody"];
        }
        
        put.callbackParam = callBackParam;
        
        if (callbackVar) {
            // 设置自定义变量
            NSMutableDictionary *callbackVarDict = [[NSMutableDictionary alloc] initWithDictionary:callbackVar];
            NSString *url = [NSString stringWithFormat:@"http://%@.%@/%@",put.bucketName,AliYunendpointPath,put.objectKey];
            DLog(@"-----------------path %@",url);
            if (fileKey) {
                [callbackVarDict setObject:url forKey:fileKey];
            }
            
            put.callbackVar = callbackVarDict;
        }
    }
    
    OSSTask * putTask = [self.client putObject:put];
    task.aliYunUploadTask = putTask;
    
    [putTask continueWithBlock:^id(OSSTask *task) {
        if (!task.error) {
            DLog(@"upload object success!");
            // 1.拼接url
            // 2.调用后台接 口
            OSSPutObjectResult * result = task.result;
            DLog(@"Result - requestId: %@, headerFields: %@, servercallback: %@",
                  result.requestId,
                  result.httpResponseHeaderFields,
                  result.serverReturnJsonString);
            //图片url
            NSString *url = [NSString stringWithFormat:@"http://%@.%@/%@",put.bucketName,AliYunendpointPath,put.objectKey];
            NSString *Content_MD5 = nil;
            if ([result.httpResponseHeaderFields objectForKey:@"Content-MD5"]) {
                Content_MD5 = result.httpResponseHeaderFields[@"Content-MD5"];
            }
            if (completeBlock) {
                completeBlock(url, Content_MD5);
            }
            file.taskState = ZUploadStateFinished;
            if (file.completeBlock) {
                file.completeBlock(url);
            }
            return nil;
        } else {
            DLog(@"upload object failed, error: %ld" , task.error.code);
            if (task.error.code == -403 || task.error.code == 6) { //key -- 错误
                if (reAccess > 0) {
                    [self getAccessKey:^(BOOL state) {
                        if (state) {
                            [self aliYunUploadType:type file:file callbackUrl:callbackUrl callbackBody:callbackBody callbackVar:callbackVar callbackVarKey:fileKey progress:progress complete:completeBlock];
                        }else{
                            if (completeBlock) {
                                completeBlock(nil, nil);
                            }
                            
                            file.taskState = ZUploadStateError;
                            if (file.errorBlock) {
                                file.errorBlock(task.error);
                            }
                        }
                    }];
                    return nil;
                }
            }
        }
        file.taskState = ZUploadStateError;
        if (file.errorBlock) {
            file.errorBlock(task.error);
        }
        if (completeBlock) {
            completeBlock(nil, nil);
        }
        return nil;
    }];
    [[ZFileUploadManager sharedInstance].taskList addObject:task];
    //   // 可以等待任务完成
    //    [putTask waitUntilFinished];
}

#pragma mark 上传图片
//普通上传图片
- (void)uploadFile:(ZFileUploadDataModel *)uFile progress:(void(^)(CGFloat p, CGFloat a))progress complete:(void(^)(NSString *, NSString *))completeBlock {
    [self uploadFileType:ZAliYunTypeApi file:uFile progress:progress complete:completeBlock];
}

- (void)uploadFile:(ZFileUploadDataModel *)uFile callbackUrl:(NSString *)callbackUrl  callbackBody:(NSString *)callbackBody callbackVar:(NSDictionary *)callbackVar callbackVarKey:(NSString *)callbackVarKey progress:(void(^)(CGFloat p, CGFloat a))progress complete:(void(^)(NSString *, NSString *))completeBlock {
    [self uploadFileType:ZAliYunTypeApi file:uFile callbackUrl:callbackUrl callbackBody:callbackBody callbackVar:callbackVar callbackVarKey:callbackVarKey progress:progress complete:completeBlock];
}

//IM上传图片
- (void)uploadIMFile:(ZFileUploadDataModel *)uFile progress:(void(^)(CGFloat p, CGFloat a))progress complete:(void(^)(NSString *, NSString *))completeBlock {
    [self uploadFileType:ZAliYunTypeIM file:uFile progress:progress complete:completeBlock];
}

- (void)uploadIMFile:(ZFileUploadDataModel *)uFile callbackUrl:(NSString *)callbackUrl  callbackBody:(NSString *)callbackBody callbackVar:(NSDictionary *)callbackVar callbackVarKey:(NSString *)callbackVarKey progress:(void(^)(CGFloat p, CGFloat a))progress complete:(void(^)(NSString *, NSString *))completeBlock {
    [self uploadFileType:ZAliYunTypeIM file:uFile callbackUrl:callbackUrl callbackBody:callbackBody callbackVar:callbackVar callbackVarKey:callbackVarKey progress:progress complete:completeBlock];
}


//上出图片
- (void)uploadFileType:(ZAliYunType)type file:(ZFileUploadDataModel *)uFile progress:(void(^)(CGFloat p, CGFloat a))progress complete:(void(^)(NSString *, NSString *))completeBlock {
    if (self.aliYunAccess.AccessKeyId  && self.aliYunAccess.AccessKeySecret) {
        reAccess = 3;
        [self aliYunUploadType:type file:uFile progress:progress complete:completeBlock];
        return;
    }
    [[ZFileUploadManager sharedInstance] getAccessKey:^(BOOL isSuccess) {
        if (isSuccess) {
            reAccess = 3;
            [self aliYunUploadType:type file:uFile progress:progress complete:completeBlock];
        }else{
            if (completeBlock) {
                completeBlock(nil,nil);
            }
        }
    }];
}

- (void)uploadFileType:(ZAliYunType)type file:(ZFileUploadDataModel *)uFile callbackUrl:(NSString *)callbackUrl  callbackBody:(NSString *)callbackBody callbackVar:(NSDictionary *)callbackVar callbackVarKey:(NSString *)callbackVarKey progress:(void(^)(CGFloat p, CGFloat a))progress complete:(void(^)(NSString *, NSString *))completeBlock {

    if (self.aliYunAccess.AccessKeyId  && self.aliYunAccess.AccessKeySecret) {
        reAccess = 3;
        [self aliYunUploadType:type file:uFile callbackUrl:callbackUrl callbackBody:callbackBody callbackVar:callbackVar callbackVarKey:callbackVarKey progress:progress complete:completeBlock];
        return;
    }
    [[ZFileUploadManager sharedInstance] getAccessKey:^(BOOL isSuccess) {
        if (isSuccess) {
            reAccess = 3;
            [self aliYunUploadType:type file:uFile callbackUrl:callbackUrl callbackBody:callbackBody callbackVar:callbackVar callbackVarKey:callbackVarKey progress:progress complete:completeBlock];
        }else{
            if (completeBlock) {
                completeBlock(nil,nil);
            }
        }
    }];
}


#pragma mark - 批量上传
//IM 批量上传
- (void)uploadIMGroupFile:(NSArray <ZFileUploadDataModel *>*)fileArr  uploadProgress:(void(^)(float, NSInteger))uploadProgress groupComplete:(void(^)(NSArray <NSDictionary *>*))groupCompleteBlock {
    [self uploadGroupType:ZAliYunTypeIM file:fileArr uploadProgress:uploadProgress groupComplete:groupCompleteBlock];
}

//普通批量上传
- (void)uploadSampleGroupFile:(NSArray <ZFileUploadDataModel *>*)fileArr  uploadProgress:(void(^)(float ,NSInteger))uploadProgress  groupComplete:(void(^)(NSArray <NSDictionary *>*))groupCompleteBlock {
    [self uploadGroupType:ZAliYunTypeApi file:fileArr uploadProgress:uploadProgress groupComplete:groupCompleteBlock];
}

/**
 批量上传
 @param fileArr <NSDictionary> image:图片 fileName:图片名称
 @param groupCompleteBlock <NSDictionary> imageUrl:图片url Content_MD5:图片md5 fileName:图片名称
 */
- (void)uploadGroupType:(ZAliYunType)type file:(NSArray <ZFileUploadDataModel *>*)fileArr  uploadProgress:(void(^)(float, NSInteger))uploadProgress  groupComplete:(void(^)(NSArray <NSDictionary *>*))groupCompleteBlock {
    if (self.aliYunAccess.AccessKeyId  && self.aliYunAccess.AccessKeySecret) {
        reAccess = 3;
        _uploadIndex = 0;
        _uploadArr = @[].mutableCopy;
        [self uploadGroupFileType:type one:fileArr uploadProgress:uploadProgress groupComplete:groupCompleteBlock];
        return;
    }
    
    [[ZFileUploadManager sharedInstance] getAccessKey:^(BOOL isSuccess) {
        if (isSuccess) {
            reAccess = 3;
            self.uploadIndex = 0;
            self.uploadArr = @[].mutableCopy;
            [self uploadGroupFileType:type one:fileArr uploadProgress:uploadProgress groupComplete:groupCompleteBlock];
        }else{
            if (groupCompleteBlock) {
                groupCompleteBlock(nil);
            }
        }
    }];
}

//批量上传图片第一步
- (void)uploadGroupFileType:(ZAliYunType)type one:(NSArray <ZFileUploadDataModel *>*)fileArr  uploadProgress:(void(^)(float, NSInteger))uploadProgress groupComplete:(void(^)(NSArray <NSDictionary *>*))groupCompleteBlock  {
    if (_uploadIndex < fileArr.count) {
        ZFileUploadDataModel *fileModel = fileArr[_uploadIndex];
        
        [self uploadFileType:type stepTwo:fileModel progress:^(CGFloat p, CGFloat a) {
            if (uploadProgress) {
                uploadProgress(p/a,self.uploadIndex);
            }
        } complete:^(NSString *url, NSString *Content_MD5) {
            if (url && Content_MD5) {
                [self.uploadArr addObject:@{@"fileUrl":url, @"Content_MD5":Content_MD5, @"fileName":fileModel.fileName}];
            }else{
                if (groupCompleteBlock) {
                    groupCompleteBlock(nil);
                }
            }
            
            self.uploadIndex++;
            if (uploadProgress) {
                uploadProgress(1,self.uploadIndex);
            }
            [self uploadGroupFileType:type one:fileArr uploadProgress:uploadProgress groupComplete:groupCompleteBlock];
        }];
    }else{
        if (groupCompleteBlock) {
            groupCompleteBlock(_uploadArr);
        }
    }
}

//批量上传图片第二步
- (void)uploadFileType:(ZAliYunType)type stepTwo:(ZFileUploadDataModel *)uFile progress:(void(^)(CGFloat p, CGFloat a))progress complete:(void(^)(NSString *, NSString *))completeBlock {
    [self uploadFileType:type file:uFile progress:progress complete:completeBlock];
}

#pragma mark 上传语音
- (void)uploadVoice:(ZFileUploadDataModel *)voice progress:(void(^)(CGFloat p, CGFloat a))progress complete:(void(^)(NSString *, NSString *))completeBlock {
    if (self.aliYunAccess.AccessKeyId  && self.aliYunAccess.AccessKeySecret) {
        reAccess = 3;
        [self aliYunUploadType:ZAliYunTypeIM file:voice progress:progress complete:completeBlock];
        return;
    }
    [[ZFileUploadManager sharedInstance] getAccessKey:^(BOOL isSuccess) {
        if (isSuccess) {
            reAccess = 3;
            [self aliYunUploadType:ZAliYunTypeIM file:voice progress:progress complete:completeBlock];
        }else{
            if (completeBlock) {
                completeBlock(nil,nil);
            }
        }
    }];
    
}

- (void)uploadVoice:(ZFileUploadDataModel *)voice callbackUrl:(NSString *)callbackUrl callbackBody:(NSString *)callbackBody callbackVar:(NSDictionary *)callbackVar callbackVarKey:(NSString *)callbackVarKey progress:(void(^)(CGFloat p, CGFloat a))progress complete:(void(^)(NSString *, NSString *))completeBlock {

    if (self.aliYunAccess.AccessKeyId  && self.aliYunAccess.AccessKeySecret) {
        reAccess = 3;
        [self aliYunUploadType:ZAliYunTypeIM file:voice callbackUrl:callbackUrl callbackBody:callbackBody callbackVar:callbackVar callbackVarKey:callbackVarKey progress:progress complete:completeBlock];
        return;
    }
    [[ZFileUploadManager sharedInstance] getAccessKey:^(BOOL isSuccess) {
        if (isSuccess) {
            reAccess = 3;
            [self aliYunUploadType:ZAliYunTypeIM file:voice callbackUrl:callbackUrl callbackBody:callbackBody callbackVar:callbackVar callbackVarKey:callbackVarKey progress:progress complete:completeBlock];
        }else{
            if (completeBlock) {
                completeBlock(nil,nil);
            }
        }
    }];
}
@end
