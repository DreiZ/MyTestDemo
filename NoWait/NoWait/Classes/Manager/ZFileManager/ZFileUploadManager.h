//
//  ZFileUploadManager.h
//  NoWait
//
//  Created by zhuang zhang on 2020/6/19.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZFileUploadTask.h"
#import "ZFileUploadDataModel.h"
#import "ZCircleUploadModel.h"


typedef NS_ENUM(NSInteger, ZAliYunType) {
    ZAliYunTypeApi,
    ZAliYunTypeIM,
};

@interface ZAliYunAccess : NSObject
@property (nonatomic,copy) NSString *AccessKeyId;
@property (nonatomic,copy) NSString *AccessKeySecret;
@property (nonatomic,copy) NSString *Expiration;
@property (nonatomic,copy) NSString *SecurityToken;
@property (nonatomic,copy) NSString *StatusCode;
@end

@interface ZFileUploadManager : NSObject
@property (nonatomic, assign,getter=isUploading) BOOL uploading;

@property (nonatomic,strong) NSMutableArray *taskList;

@property (nonatomic,strong) NSMutableArray *taskModelList;

@property (nonatomic,strong) NSMutableArray <ZCircleUploadModel *>*uploadCircleArr;

+ (ZFileUploadManager *)sharedInstance;

+ (void)addTaskToUploadWith:(ZFileUploadTask *)task;

+ (void)addTaskDataToUploadWith:(ZFileUploadDataModel *)taskData;

/**
异步串行
*/
- (void)asyncSerialUpload:(NSMutableArray <ZFileUploadDataModel *>*)dataArray progress:(void(^)(CGFloat p, NSInteger index))progress completion:(void(^)(id obj))completion;

/**
异步并行上传多张图片（用常量监控上传）(添加)
*/
- (void)asyncConcurrentConstUpload:(NSMutableArray <ZFileUploadDataModel *>*)dataArray uploading:(void (^)(CGFloat p, NSInteger index))uploading completion:(void (^)(id))completion;

/**
 异步并行
 上传图片-用dispatch_group监控所有上传完成动作-缺点是不能实时往group里添加任务
 */
- (void)asyncConcurrentGroupUpload:(NSMutableArray <ZFileUploadDataModel *>*)dataArray uploading:(void(^)(CGFloat p, NSInteger index))uploading completion:(void (^)(id))completion;



#pragma mark - 阿里云上传
//获取key
- (void)getAccessKey:(void(^)(BOOL))completeBlock;

#pragma mark 上传图片
//普通单张上传
- (ZFileUploadTask *)uploadFile:(ZFileUploadDataModel *)uFile progress:(void(^)(int64_t p, int64_t a))progress complete:(void(^)(NSString *))completeBlock failure:(void(^)(NSError *error))failure;

- (ZFileUploadTask *)uploadFile:(ZFileUploadDataModel *)uFile callbackUrl:(NSString *)callbackUrl callbackBody:(NSString *)callbackBody callbackVar:(NSDictionary *)callbackVar callbackVarKey:(NSString *)callbackVarKey progress:(void(^)(int64_t p, int64_t a))progress complete:(void(^)(NSString *))completeBlock failure:(void(^)(NSError *error))failure;

//IM单张上传
- (ZFileUploadTask *)uploadIMFile:(ZFileUploadDataModel *)uFile progress:(void(^)(int64_t p, int64_t a))progress complete:(void(^)(NSString *))completeBlock failure:(void(^)(NSError *error))failure;

- (ZFileUploadTask *)uploadIMFile:(ZFileUploadDataModel *)uFile callbackUrl:(NSString *)callbackUrl callbackBody:(NSString *)callbackBody callbackVar:(NSDictionary *)callbackVar callbackVarKey:(NSString *)callbackVarKey progress:(void(^)(int64_t p, int64_t a))progress complete:(void(^)(NSString *))completeBlock failure:(void(^)(NSError *error))failure;

/**
 批量上传
 
 @param fileArr <NSDictionary> image:图片 fileName:图片名称
 @param groupCompleteBlock <NSDictionary> fileUrl:图片url Content_MD5:图片md5 fileName:图片名称
 */
//IM 批量上传
- (void)uploadIMGroupFile:(NSArray <ZFileUploadDataModel *>*)fileArr  uploadProgress:(void(^)(float,NSInteger))uploadProgress  groupComplete:(void(^)(NSArray <NSDictionary *>*))groupCompleteBlock;

//I普通批量上传
- (void)uploadSampleGroupFile:(NSArray <ZFileUploadDataModel *>*)fileArr  uploadProgress:(void(^)(float,NSInteger))uploadProgress  groupComplete:(void(^)(NSArray <NSDictionary *>*))groupCompleteBlock;


#pragma mark 上传语音
- (ZFileUploadTask *)uploadVoice:(ZFileUploadDataModel *)voice progress:(void(^)(int64_t p, int64_t a))progress complete:(void(^)(NSString *))completeBlock failure:(void(^)(NSError *error))failure;

- (ZFileUploadTask *)uploadVoice:(ZFileUploadDataModel *)voice callbackUrl:(NSString *)callbackUrl  callbackBody:(NSString *)callbackBody callbackVar:(NSDictionary *)callbackVar callbackVarKey:(NSString *)callbackVarKey progress:(void(^)(int64_t p, int64_t a))progress complete:(void(^)(NSString *))completeBlock failure:(void(^)(NSError *error))failure;
@end

