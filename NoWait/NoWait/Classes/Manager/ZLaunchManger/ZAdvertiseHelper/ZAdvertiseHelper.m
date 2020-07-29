//
//  ZZAdvertiseHelper.m
//  ZProject
//
//  Created by zzz on 2018/6/7.
//  Copyright © 2018年 zzz. All rights reserved.
//

#import "ZAdvertiseHelper.h"
#import "ZDBAdvertiserStore.h"
#import "ZNetworking.h"
#import "ZRouteManager.h"

static NSString *const adImageName = @"adImageName";

@interface ZAdvertiseHelper ()
@property (nonatomic,strong) ZBaseNetworkBannerModel *bannerModel;

@end

@implementation ZAdvertiseHelper

static ZAdvertiseHelper* _instance = nil;
+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(adClick:) name:NotificationContants_Advertise_Key object:nil];
    }
    return self;
}


+ (void)showAdvertiserView:(NSArray<NSString *> *)imageArray {
    // 1.判断沙盒中是否存在广告图片，如果存在，直接显示
    NSString *filePath = [[ZAdvertiseHelper sharedInstance] getFilePathWithImageName:[NSUserDefaults.standardUserDefaults valueForKey:adImageName]];
    
    BOOL isExist = [[ZAdvertiseHelper sharedInstance] isFileExistWithFilePath:filePath];
    ZDBAdvertiserStore *dbStore = [[ZDBAdvertiserStore alloc] init];
    
    [dbStore advertiserByAdvertiserID:nil complete:^(ZBaseNetworkBannerModel *data) {
        [ZAdvertiseHelper sharedInstance].bannerModel = data;
        NSArray *stringArr = [data.image componentsSeparatedByString:@"/"];
        NSString *imageName = stringArr.lastObject;
        
        NSString *modelFilePath = [[ZAdvertiseHelper sharedInstance] getFilePathWithImageName:imageName];
        if ([modelFilePath isEqualToString:filePath] ) {
            if (isExist) {// 图片存在
                ZAdvertiseView *advertiseView = [[ZAdvertiseView alloc] initWithFrame:UIScreen.mainScreen.bounds];
                advertiseView.filePath = filePath;
                [advertiseView show];
            }
        }
    }];
    
    
    
    // 2.无论沙盒中是否存在广告图片，都需要重新调用广告接口，判断广告是否更新
    [[ZAdvertiseHelper sharedInstance] getAdvertisingImage:imageArray];
}

+ (void)updateAdvertiserData {
    [[ZAdvertiseHelper sharedInstance] getAdvertisingImage:nil];
}

/**
 *  初始化广告页面
 */
- (void)getAdvertisingImage:(NSArray<NSString *> *)imageArray
{

//    [ZNetworking postServerType:ZServerTypeApi url:URL_V1_beginning_marketing params:@{} completionHandler:^(id data, NSError * error) {
//        ZAdvertiserModel *adModel = [ZAdvertiserModel mj_objectWithKeyValues:data];
//        if ([adModel.code integerValue] == 0) {
//            if (adModel && adModel.info.count > 0) {
//                ZBaseNetworkBannerModel *bmodel = adModel.info[0];
//                
//                //随机取一张
//                NSString *imageUrl = bmodel.image;
//                NSArray *stringArr = [imageUrl componentsSeparatedByString:@"/"];
//                NSString *imageName = stringArr.lastObject;
//                
//                // 拼接沙盒路径
//                NSString *filePath = [self getFilePathWithImageName:imageName];
//                BOOL isExist = [self isFileExistWithFilePath:filePath];
//                if (!isExist){// 如果该图片不存在，则删除老图片，下载新图片
//                    [self downloadAdImageWithUrl:imageUrl imageName:imageName];
//                    ZDBAdvertiserStore *dbStore = [[ZDBAdvertiserStore alloc] init];
//                    [dbStore deleteAdvertiserByAdvertiserID:nil];
//                    [dbStore addAdvertiser:bmodel];
//                }
//            }
//        }
//    }];
}

/**
 *  判断文件是否存在
 */
- (BOOL)isFileExistWithFilePath:(NSString *)filePath
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDirectory = FALSE;
    return [fileManager fileExistsAtPath:filePath isDirectory:&isDirectory];
}


/**
 *  下载新图片
 */
- (void)downloadAdImageWithUrl:(NSString *)imageUrl imageName:(NSString *)imageName {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]];
        NSString *filePath = [self getFilePathWithImageName:imageName]; // 保存文件的名称
        
        if ([data writeToFile:filePath atomically:YES]) {// 保存成功
            DLog(@"保存成功");
            [self deleteOldImage];
            [NSUserDefaults.standardUserDefaults setObject:imageName forKey:adImageName];
            [NSUserDefaults.standardUserDefaults synchronize];
            // 如果有广告链接，将广告链接也保存下来
        }else{
            DLog(@"保存失败");
        }
        
    });
}

/**
 *  删除旧图片
 */
- (void)deleteOldImage {
    NSString *imageName = [NSUserDefaults.standardUserDefaults valueForKey:adImageName];
    if (imageName) {
        NSString *filePath = [self getFilePathWithImageName:imageName];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        [fileManager removeItemAtPath:filePath error:nil];
    }
}

/**
 *  根据图片名拼接文件路径
 */
- (NSString *)getFilePathWithImageName:(NSString *)imageName {
    if (imageName) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask, YES);

        NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:imageName];
        return filePath;
    }
    return nil;
}

//NotificationContants_Advertise_Key
- (void)adClick:(NSNotification *)noti {
   DLog(@"广告 %@", self.bannerModel.title);
//    ZDBAdvertiserStore *dbStore = [[ZDBAdvertiserStore alloc] init];
//    [ZRouteManager pushToVC:self.bannerModel];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
