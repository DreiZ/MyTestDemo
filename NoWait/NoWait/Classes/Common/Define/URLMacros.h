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
#define ProductSever    1

// 表情服务器
#define     IEXPRESSION_HOST_URL        @"http://123.57.155.230/ibiaoqing/admin/"


#if DevelopSever

#pragma mark - /**开发服务器*/

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

#define URL_Service                     @"?s="

//测试接口
//NSString *const URL_Test = @"api/recharge/price/list";
#define URL_Test                                    @"/api/cast/home/start"
#pragma mark ---------------------------启动相关 ----------------------------
//营销配置，用于广告宣传
#define URL_V1_beginning_marketing                  @"V1.Beginning.Marketing"
//用户第一次打开app，进行引导
#define URL_V1_beginning_guidance                   @"V1.Beginning.Guidance"

#pragma mark ---------------------------用户相关 ---------------------------
//短信接口
#define URL_sms_send_app_login                      @"Sms.Send_App.Login"
//登录接口
#define URL_account_login_smg                       @"Account.Login.Smg"
//退出登录接口
#define URL_account_logout_secede                   @"Account.Logout.Secede"



//协议相关
#define URL_app_page_getInfo                        @"App.Page.GetInfo"

//协议相关
#define URL_V1_tips_getTips                         @"V1.Tips.GetTips"


#pragma mark ---------------------------IM相关---------------------------
//im登录im服务器
#define URL_IM_user_login                @"IM.User.Login"

//根据会员ID可获得：我的信息、好友列表、群组列表。直接赋值列表数据
#define URL_IM_user_getList              @"IM.User.GetList"

//发送消息
#define URL_IM_msg_sendMsg               @"IM.Msg.SendMsg"

//消息回执
#define URL_IM_reported_p2pDelivery      @"IM.Reported.P2pDelivery"

//单点聊天消息批量处理消息送达上报.回执
#define URL_IM_reported_p2pBatching      @"IM.Reported.P2pBatching"

//获取用户离线消息列表
#define URL_IM_offline_getList           @"IM.Offline.GetList"

//获取当前用户发送人相关离线消息列表
#define URL_IM_offline_getsrcidList      @"IM.Offline.GetsrcidList"

//根据会员ID可获得：相关会话信息，如当前用户的顾问信息等
#define URL_IM_user_getCounselorInfo    @"IM.User.GetCounselorInfo"


#pragma mark ---------------------------首页接口-------------------------------
//首页接口
#define URL_V1_index_index                          @"V1.Index.Index"

//----------------------------------身体记录接口------------------------------
//获取历史体脂数据
#define URL_V1_bodyRecord_getBodyHistory            @"V1.BodyRecord.GetBodyHistory"

//获取某一天体脂数据
#define URL_V1_bodyRecord_getBodySomeDay            @"V1.BodyRecord.GetBodySomeDay"

//获取用户历史体重数据
#define URL_V1_bodyRecord_getWeightHistory          @"V1.BodyRecord.GetWeightHistory"

//保存/修改用户历史体脂数据
#define URL_V1_bodyRecord_saveBodyInfo              @"V1.BodyRecord.SaveBodyInfo"

//获取体脂称说明wap
#define URL_V1_wapUrl_scaleWapUrl                   @"V1.WapUrl.ScaleWapUrl"

//体脂称购买
#define URL_V1_wapUrl_buyScaleWapUrl                @"V1.WapUrl.BuyScaleWapUrl"
//----------------------------------健康报告接口--------------------------------
//获取健康报告详情
#define URL_V1_healthReport_getHealReport           @"V1.HealthReport.GetHealReport"

//获取健康报告列表
#define URL_V1_healthReport_getHealReportList       @"V1.HealthReport.GetHealReportList"

//健康报告wap
#define URL_V1_wapUrl_healthWapUrl                  @"V1.WapUrl.HealthWapUrl"


//----------------------------------饮食记录接口------------------------------
//某天饮食数据
#define URL_V1_mealRecord_getMealsHistory           @"V1.MealRecord.GetMealsHistory"

//保存/修改用户饮食数据
#define URL_V1_mealRecord_saveMealsInfo             @"V1.MealRecord.SaveMealsInfo"

//----------------------------------运动记告接口------------------------------
//获取某天运动历史数据
#define URL_V1_sportRecord_getSomedaySports         @"V1.SportRecord.GetSomedaySports"

//获取历史运动列表
#define URL_V1_sportRecord_getSportsList            @"V1.SportRecord.GetSportsList"

//保存/修改用户运动数据
#define URL_V1_sportRecord_saveSportsInfo           @"V1.SportRecord.SaveSportsInfo"

//保存用户步数
#define URL_V1_sportRecord_saveWalkNum              @"V1.SportRecord.SaveWalkNum"

//----------------------------------用户数据接口------------------------------
//保存用户基本信息接口
#define URL_V1_userData_saveInfo                    @"V1.UserData.SaveInfo"
//保存用户基本信息接口
#define URL_V1_userData_updateInfo                  @"V1.UserData.UpdateInfo"

//有则返回用户基本信息
#define URL_V1_userData_getUserInfo                 @"V1.UserData.GetUserInfo"

//保存减脂计划接口
#define URL_V1_userData_savePlan                    @"V1.UserData.SavePlan"

#pragma mark ---------------------------资讯-------------------------------
//资讯首页
#define URL_V1_cms_channel_cmsIndex                 @"V1.Cms_Channel.CmsIndex"
//资讯详情
#define URL_V1_cms_channel_cmsInfo                  @"V1.Cms_Channel.CmsInfo"
//根据标签获取列表
#define URL_V1_cms_channel_cmsFlag                  @"V1.Cms_Channel.CmsFlag"
//某栏目下列表
#define URL_V1_cms_channel_cmsChannel               @"V1.Cms_Channel.CmsChannel"


#pragma mark ---------------------------服务-------------------------------
//获取当前服务
#define URL_V1_ser_SerPack_nowSerPack               @"V1.Ser_SerPack.NowSerPack"

//获取当前服务列表
#define URL_V1_ser_serPack_nowSerPacklist           @"V1.Ser_SerPack.NowSerPacklist"

//取消打卡
#define URL_V1_ser_serPack_cancelMark               @"V1.Ser_SerPack.CancelMark"

//打卡
#define URL_V1_ser_serPack_doMark                   @"V1.Ser_SerPack.DoMark"

//调查问卷
#define URL_V1_question_question_saveAns            @"V1.Question_Question.SaveAns"

//是否填过调查问卷
#define URL_V1_question_question_isAns              @"V1.Question_Question.IsAns"

#pragma mark ---------------------------个人中心接口-------------------------------
//添加建议意见
#define URL_V1_proposal_publishProposal             @"V1.Proposal.PublishProposal"
//服务评价
#define URL_V1_ser_serEvaluate_addEvaluate          @"V1.Ser_SerEvaluate.AddEvaluate"
//获取售后wap地址
#define URL_V1_wapUrl_afterSaleWapUrl               @"V1.WapUrl.AfterSaleWapUrl"

//订单列表
#define URL_Order_order_orderList                   @"Order.Order.OrderList"
//删除订单
#define URL_Order_order_delOrder                    @"Order.Order.DelOrder"

//订单详情
#define URL_Order_order_orderInfo                   @"Order.Order.OrderInfo"


#pragma mark ------------------------分享相关------------------
//分享首页
#define URL_V1_share_shareIndex          @"V1.Share.ShareIndex"

//邀请分享
#define URL_V1_share_shareInvite         @"V1.Share.ShareInvite"

#pragma mark ------------------------更新相关------------------
//根据不同终端获取不同版本更新信息
#define URL_Bug_version_upInfo          @"Bug.Version.UpInfo"


#pragma mark - ---------------------支付相关---------------------
//支付宝支付
#define URL_Pay_alipay_app               @"Pay.Alipay.App"

//微信支付
#define URL_Pay_wechat_app               @"Pay.Wechat.App"

#endif /* URLMacros_h */
