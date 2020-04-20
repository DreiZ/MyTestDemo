//
//  ZUMengShareManager.m
//  ZBigHealth
//
//  Created by 承希-开发 on 2018/12/17.
//  Copyright © 2018 承希-开发. All rights reserved.
//

#import "ZUMengShareManager.h"
// U-Share核心SDK
#import <UMShare/UMShare.h>

// U-Share分享面板SDK，未添加分享面板SDK可将此行去掉
#import <UShareUI/UShareUI.h>
#import <UMCommon/UMCommon.h>

//微信好友和朋友圈
#import <WXApi.h>
#import "ZNetworking.h"
#import "ZBaseNetworkBackModel.h"

static ZUMengShareManager *sharedManager;

@interface ZUMengShareManager ()
@property (nonatomic,strong) ZUMengShareManager *player;


@end

@implementation ZUMengShareManager

+ (ZUMengShareManager *)sharedManager {
    @synchronized (self) {
        if (!sharedManager) {
            sharedManager = [[ZUMengShareManager alloc] init];
        }
    }
    return sharedManager;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    
}

- (void)umengShare {
    [UMConfigure initWithAppkey:UMengKey channel:@"App Store"];

    /* 设置微信的appKey和appSecret */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:kAppKey_Wechat appSecret:kAppKey_Wechat redirectURL:@"http://mobile.umeng.com/social"];
    
    [MobClick setCrashReportEnabled:YES];//Crash收集
    
    [UMConfigure setLogEnabled:YES];//设置打开日志
}

- (void)shareUIWithType:(NSInteger)index image:(NSString *)image vc:(UIViewController *)vc {
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    messageObject.text = @"似锦";
    [UMSocialGlobal shareInstance].isUsingHttpsWhenShareContent = NO;
    
    UMShareImageObject *imageObject = [UMShareImageObject shareObjectWithTitle:@"似锦" descr:@"邀请好友" thumImage:[UIImage imageNamed:@"iconCommon"]] ;
    [imageObject setShareImage:image];
    //分享消息对象设置分享内容对象
    messageObject.shareObject = imageObject;
    
    UMSocialPlatformType platformType;
    if (index == 0) {
        platformType = UMSocialPlatformType_WechatSession;
    }else{
        platformType = UMSocialPlatformType_WechatTimeLine;
    }
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:vc completion:^(id data, NSError *error) {
        if (error) {
            DLog(@"************Share fail with error %@*********",error);
        }else{
            DLog(@"response data is %@",data);
        }
    }];
}

- (void)shareUIWithType:(NSInteger)index Title:(NSString *)title detail:(NSString *)detail image:(UIImage *)image url:(NSString *)url  vc:(UIViewController *)vc {
    //@"微信好友", @"朋友圈"
//    if(sender.tag == 0){
//    if (![WXApi isWXAppInstalled]){
//        [TLUIUtility showErrorHint:@"未安装微信"];
//        return;
//    }

    if (index == 0) {
        [self shareToPlatformType:UMSocialPlatformType_WechatSession title:title detail:detail image:image url:url  vc:vc];
    }else{
        [self shareToPlatformType:UMSocialPlatformType_WechatTimeLine title:title detail:detail image:image url:url  vc:vc];
    }
}


- (void)shareToPlatformType:(UMSocialPlatformType)platformType title:(NSString *)title detail:(NSString *)detail image:(UIImage *)image url:(NSString *)url vc:(UIViewController *)vc
{
    UIImage *tImage = image ? image : [UIImage imageNamed:@"iconCommon"];
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    messageObject.text = @"幻轻";
    //创建网页内容对象
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:title ? title : @"" descr:detail ? detail : @"" thumImage:tImage];
    //设置网页地址
    shareObject.webpageUrl = url ? url : @"";
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:vc completion:^(id data, NSError *error) {
        if (error) {
            DLog(@"************Share fail with error %@*********",error);
        }else{
            DLog(@"response data is %@",data);
        }
    }];
}


@end
