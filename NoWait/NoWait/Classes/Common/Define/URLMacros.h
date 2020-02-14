//
//  URLMacros.h
//  NoWait
//
//  Created by zhuang zhang on 2020/1/2.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//


#ifndef URLMacros_h
#define URLMacros_h


//内部版本号 每次发版递增
#define KVersionCode 1
/*
 
 将项目中所有的接口写在这里,方便统一管理,降低耦合
 
 这里通过宏定义来切换你当前的服务器类型,
 将你要切换的服务器类型宏后面置为真(即>0即可),其余为假(置为0)
 如下:现在的状态为测试服务器
 这样做切换方便,不用来回每个网络请求修改请求域名,降低出错事件
 */

#define DevelopSever    1
#define TestSever       0
#define ProductSever    0

// 表情服务器
#define     IEXPRESSION_HOST_URL        @"http://123.57.155.230/ibiaoqing/admin/"


#define sign_graphic_appKey             @"!zmr*9Wxa80Mhj&lBioWpmNC^d&KXK86"
#define sign_login_appKey               @"rKWGxV7jZeyihoSRY8!8lcxhf!3#D@C^"
#define sign_account_appKey             @"$NtQa!A*3ChRo9OeqErJJ2x8Q!qSeu1l"
#define sign_upload_appKey              @"NBTP&XU&yvRiRQOC^^!i4ov62WcjOca^"

#if DevelopSever

#pragma mark - /**开发服务器*/
//验证码服务器
#define URL_code                        @"http://api.xiangcenter.com"
//用户服务器
#define URL_user                        @"http://api.xiangcenter.com"
//订单服务
#define URL_order                       @"http://api.xiangcenter.com"
//文件服务器
#define URL_file                        @"http://api.xiangcenter.com"
//教练服务器
#define URL_coach                       @"http://api.xiangcenter.com"
//机构服务器
#define URL_organization                @"http://api.xiangcenter.com"

//IM服务器
#define SocketServiceUrl                @"172.17.100.32"
#define SocketServicePort               8085
#define URL_main                        @"http://172.17.100.31:8080"
#define URL_Socket                      @"http://172.17.100.32:8851"
//#define URL_main @"http://192.168.11.122:8090" //展鹏


//开发服app_key ,app_secret,sign
#define SERVICE_APP_KEY                 @"20181120091910000002"
#define SERVICE_APP_SECRET              @"f9590246c56c67b9a9414c9a3121cffbd7fecb38"
#define SERVICE_SIGN                    @"9f34c254a45dabb40009c9b55ef17a4133ee67e2"

//阿里云上传图片地址
#define AliYunImageServer               @"http://172.17.100.31:8081/sts.php"
#define AliYunBucketName                @"cxapp-dev-app"
#define AliYunBucketIMName              @"cxapp-dev-im"
#define AliYunendpoint                  @"https://oss-cn-shanghai.aliyuncs.com"
#define AliYunendpointPath              @"oss-cn-shanghai.aliyuncs.com"

#define AliYunPath(name)                [NSString stringWithFormat:@"app/%@/%@/%@/%@",name,[ZUserHelper sharedHelper].client_id,[[NSDate new] stringWithFormat:@"yyyyMMdd"],[[NSString stringWithFormat:@"%.0f%u",[[NSDate new] timeIntervalSince1970],arc4random() % 1000] md5String]]

#define AliYunMessageImagePath          AliYunPath(@"im_image")
#define AliYunMessageVoicePath          AliYunPath(@"im_audio")
#define AliYunMessageVideoPath          AliYunPath(@"im_audio")
#define AliYunMessageFilePath           AliYunPath(@"im_file")
#define AliYunFoodFilePath              AliYunPath(@"usr_punchcard")
#define AliYunUserFilePath              AliYunPath(@"usr_avatar")


#elif TestSever

#pragma mark - /**测试服务器*/
//IM服务器
#define SocketServiceUrl                @"106.15.91.31"
#define SocketServicePort               8890
#define URL_main                        @"http://106.15.91.31"
#define URL_Socket                      @"http://106.15.91.31:8092"
//测试服app_key ,app_secret
#define SERVICE_APP_KEY                 @"20181120091920000002"
#define SERVICE_APP_SECRET              @"7f13509d577585b1773acab29d470671b8ded32b"
#define SERVICE_SIGN                    @"31d15f81b73fae2d81c61b0ad4793cb9453e3465"


//阿里云上传图片地址
#define AliYunImageServer               @"http://106.15.91.31:8093/sts.php"
#define AliYunBucketName                @"cxapp-test-app"
#define AliYunBucketIMName              @"cxapp-test-im"
#define AliYunendpoint                  @"https://oss-cn-shanghai.aliyuncs.com"
#define AliYunendpointPath              @"oss-cn-shanghai.aliyuncs.com"

#define AliYunPath(name)                [NSString stringWithFormat:@"app/%@/%@/%@/%@",name,[ZUserHelper sharedHelper].client_id,[[NSDate new] stringWithFormat:@"yyyyMMdd"],[[NSString stringWithFormat:@"%.0f%u",[[NSDate new] timeIntervalSince1970],arc4random() % 1000] md5String]]

#define AliYunMessageImagePath          AliYunPath(@"im_image")
#define AliYunMessageVoicePath          AliYunPath(@"im_audio")
#define AliYunMessageVideoPath          AliYunPath(@"im_audio")
#define AliYunMessageFilePath           AliYunPath(@"im_file")
#define AliYunFoodFilePath              AliYunPath(@"usr_punchcard")
#define AliYunUserFilePath              AliYunPath(@"usr_avatar")

#elif ProductSever

#pragma mark - /**生产服务器*/
//IM服务器
#define SocketServiceUrl                @"cimapp.chengxiguoji.com"  //socket 服务器
#define SocketServicePort               8890
#define URL_main                        @"http://api.chengxiguoji.com"
#define URL_Socket                      @"http://cim.chengxiguoji.com" //会话api
//正式服app_key ,app_secret
#define SERVICE_APP_KEY                 @"20181120091950000002"
#define SERVICE_APP_SECRET              @"1341a770aa2d3e7128e0b8d170da4fcb0b25fa5d"
#define SERVICE_SIGN                    @"bd56bb7de99787483511dbe725e14d54e16696ee"


//阿里云上传图片地址
#define AliYunImageServer               @"http://sts.chengxiguoji.com/sts.php"
#define AliYunBucketName                @"cxapp-pro-app"
#define AliYunBucketIMName              @"cxapp-pro-im"
#define AliYunendpoint                  @"https://oss-cn-shanghai.aliyuncs.com"
#define AliYunendpointPath              @"oss-cn-shanghai.aliyuncs.com"


#define AliYunPath(name)                [NSString stringWithFormat:@"app/%@/%@/%@/%@",name,[ZUserHelper sharedHelper].client_id,[[NSDate new] stringWithFormat:@"yyyyMMdd"],[[NSString stringWithFormat:@"%.0f%u",[[NSDate new] timeIntervalSince1970],arc4random() % 1000] md5String]]

#define AliYunMessageImagePath          AliYunPath(@"im_image")
#define AliYunMessageVoicePath          AliYunPath(@"im_audio")
#define AliYunMessageVideoPath          AliYunPath(@"im_audio")
#define AliYunMessageFilePath           AliYunPath(@"im_file")
#define AliYunFoodFilePath              AliYunPath(@"usr_punchcard")
#define AliYunUserFilePath              AliYunPath(@"usr_avatar")

#endif


#pragma mark --------------------------- 详细接口地址 ---------------------------

#define URL_Service                     @"api/"

//测试接口
//NSString *const URL_Test = @"api/recharge/price/list";
#define URL_Test                                    @"/api/cast/home/start"
#pragma mark ---------------------------启动相关 ----------------------------
//营销配置，用于广告宣传
#define URL_V1_beginning_marketing                  @"V1.Beginning.Marketing"
//用户第一次打开app，进行引导
#define URL_V1_beginning_guidance                   @"V1.Beginning.Guidance"

#pragma mark ---------------------------验证码相关 URL_code---------------------------
//图形验证码接口
#define URL_sms_v1_captcha                          @"sms/v1/captcha"
//获取验证码
#define URL_sms_v1_send_code                        @"sms/v1/send_code"


#pragma mark -------------------------登录---URL_user----------------------------
//注册接口
#define URL_account_v1_register                     @"account/v1/register"
//登录接口
#define URL_account_v1_login                        @"account/v1/login"
//刷新token接口
#define URL_account_v1_refresh                      @"account/v1/refresh"

#define URL_account_v1_logout                       @"account/v1/logout"

#pragma mark ---------------------上传图片----URL_file---------------------------------
#define URL_file_v1_upload                           @"file/v1/upload"

#endif /* URLMacros_h */
