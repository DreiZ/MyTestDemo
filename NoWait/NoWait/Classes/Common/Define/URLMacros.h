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

// 表情服务器
#define     IEXPRESSION_HOST_URL        @"http://123.57.155.230/ibiaoqing/admin/"


#define sign_graphic_appKey             @"!zmr*9Wxa80Mhj&lBioWpmNC^d&KXK86"
#define sign_login_appKey               @"rKWGxV7jZeyihoSRY8!8lcxhf!3#D@C^"
#define sign_account_appKey             @"$NtQa!A*3ChRo9OeqErJJ2x8Q!qSeu1l"
#define sign_upload_appKey              @"NBTP&XU&yvRiRQOC^^!i4ov62WcjOca^"

#if DevelopSever

#pragma mark - /**开发服务器*/
//验证码服务器@"http://api.xiangcenter.com"
#define URL_code                        @"http://apitest.xiangcenter.com"
//用户服务器
#define URL_user                        @"http://apitest.xiangcenter.com"
//订单服务
#define URL_order                       @"http://apitest.xiangcenter.com"
//文件服务器
#define URL_file                        @"http://apitest.xiangcenter.com"
//教师服务器
#define URL_coach                       @"http://apitest.xiangcenter.com"
//机构服务器
#define URL_organization                @"http://apitest.xiangcenter.com"


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
#define AliYunAccessKeyId               @"LTAI4G1hwMQeE5DsGuUJdWDA"
#define AliYunAccessKeySecret           @"9YXqCwWloJXdVKqcMElFijjmGvhKUu"
#define AliYunImageServer               @"account/v1/oss/sts/token"
#define AliYunBucketName                @"xiangcenter-test"
#define AliYunBucketIMName              @"xiangcenter-test"
#define AliYunendpoint                  @"https://oss-cn-beijing.aliyuncs.com"
#define AliYunendpointPath              @"oss-cn-beijing.aliyuncs.com"

#define AliYunPath(name,type)                [NSString stringWithFormat:@"app/%@/%@/%@/%@",name,type,[[NSDate new] stringWithFormat:@"yyyyMMdd"],[[NSString stringWithFormat:@"%.0f%u",[[NSDate new] timeIntervalSince1970],arc4random() % 10000] md5String]]


#define AliYunImagePath(type)           AliYunPath(@"user_image",type)
#define AliYunVoicePath                 AliYunPath(@"user_audio",@"IM")
#define AliYunVideoPath(type)           AliYunPath(@"user_video",type)
#define AliYunFilePath                  AliYunPath(@"user_file",@"file")
#define AliYunUserFilePath              AliYunPath(@"user_avatar",@"user")

#define ImageCacheFolderOfVideo      @"videoFolder"

#define AliYunSnapshotOfVideo        @"?x-oss-process=video/snapshot,t_1000,m_fast,ar_auto"
#elif TestSever

#pragma mark - /**开发服务器*/
//验证码服务器@"http://api.xiangcenter.com"
#define URL_code                        @"http://api.xiangcenter.com"
//用户服务器
#define URL_user                        @"http://api.xiangcenter.com"
//订单服务
#define URL_order                       @"http://api.xiangcenter.com"
//文件服务器
#define URL_file                        @"http://api.xiangcenter.com"
//教师服务器
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
//阿里云上传图片地址
#define AliYunAccessKeyId               @"LTAI4G1hwMQeE5DsGuUJdWDA"
#define AliYunAccessKeySecret           @"9YXqCwWloJXdVKqcMElFijjmGvhKUu"
#define AliYunImageServer               @"account/v1/oss/sts/token"
#define AliYunBucketName                @"xiangcenter"
#define AliYunBucketIMName              @"xiangcenter"
#define AliYunendpoint                  @"https://oss-cn-beijing.aliyuncs.com"
#define AliYunendpointPath              @"oss-cn-beijing.aliyuncs.com"


#define AliYunPath(name,type)                [NSString stringWithFormat:@"app/%@/%@/%@/%@",name,type,[[NSDate new] stringWithFormat:@"yyyyMMdd"],[[NSString stringWithFormat:@"%.0f%u",[[NSDate new] timeIntervalSince1970],arc4random() % 10000] md5String]]

#define AliYunImagePath(type)           AliYunPath(@"user_image",type)
#define AliYunVoicePath                 AliYunPath(@"user_audio",@"IM")
#define AliYunVideoPath(type)           AliYunPath(@"user_video",type)
#define AliYunFilePath                  AliYunPath(@"user_file",@"file")
#define AliYunUserFilePath              AliYunPath(@"user_avatar",@"user")

#define ImageCacheFolderOfVideo  @"videoFolder"
#define AliYunSnapshotOfVideo        @"?x-oss-process=video/snapshot,t_1000,m_fast,ar_auto"
#endif


#pragma mark --------------------------- 详细接口地址 ---------------------------

#define URL_Service                     @"api/"

#define URL_Test                                    @"/api/cast/home/start"
#pragma mark ---------------------------启动相关 ----------------------------
//营销配置，用于广告宣传
#define URL_V1_beginning_marketing                  @"V1.Beginning.Marketing"
//用户第一次打开app，进行引导
#define URL_V1_beginning_guidance                   @"V1.Beginning.Guidance"

#pragma mark ---------------------------验证码相关 URL_code---------------------------
//图形验证码接口
#define URL_sms_v1_captcha                          @"account/v1/captcha"
//获取验证码
#define URL_sms_v1_send_code                        @"account/v1/send_code"


#pragma mark -------------------------登录---URL_user----------------------------
//注册接口
#define URL_account_v1_register                     @"account/v1/register"
//登录接口
#define URL_account_v1_login                        @"account/v1/login_by_code"
//密码登录
#define URL_account_v1_loginPwd                     @"account/v1/login"
//更新密码
#define URL_account_v1_updatePwd                    @"account/v1/update_password"
//刷新token接口
#define URL_account_v1_refresh                      @"account/v1/refresh"

#define URL_account_v1_logout                       @"account/v1/logout"

#define URL_account_v1_get_account_list                       @"account/v1/get_account_list"

#define URL_version_v1_version_info                  @"version/v1/version/info"
//意见反馈
#define URL_account_v1_add_feedback                  @"account/v1/add_feedback"

//更新用户信息
#define URL_account_v1_update_account                @"account/v1/update_account"
#define URL_account_v1_get_account_info               @"account/v1/get_account_info"

#pragma mark ---------------------上传图片----URL_file---------------------------------
#define URL_file_v1_upload                           @"file/v1/upload"

#define URL_file_v1_multi_upload                     @"file/v1/multi_upload"

#define URL_file_v1_delete                           @"file/v1/delete_file"


#pragma mark ---------------------机构----URL_file---------------------------------
//校区门店
#define URL_merchants_stores_list                    @"merchants/v1/get_stores_list"
//获取校区详情
#define URL_merchants_stores_info                    @"merchants/v1/merchants_stores_info"
//编辑校区门店
#define URL_merchants_edit_merchants_store           @"merchants/v1/edit_merchants_store"

#pragma mark - 课程
//添加课程
#define URL_merchants_add_courses                    @"merchants/v1/add_courses"
//编辑课程
#define URL_merchants_edit_courses                   @"merchants/v1/edit_courses"

//课程详情
#define URL_merchants_get_courses_info               @"merchants/v1/get_courses_info"

//课程list
#define URL_merchants_get_courses_list               @"merchants/v1/get_courses_list"

//课程list
#define URL_merchants_get_all_courses_list               @"merchants/v1/get_all_courses_by_name"

//关闭课程
#define URL_merchants_close_courses                  @"merchants/v1/update_courses_status"

//删除课程 开启
#define URL_merchants_del_courses                    @"merchants/v1/del_courses"

//搜索课程
#define URL_merchants_search_courses                 @"merchants/v1/search_courses"

//排课课程list
#define URL_merchants_get_class_courses_list               @"merchants/v1/get_class_courses_list"


//排课课程list
#define URL_merchants_get_class_courses_list               @"merchants/v1/get_class_courses_list"


//预约课程list
#define URL_merchants_get_experience_courses               @"merchants/v1/get_experience_courses"

#define URL_merchants_get_courses_curriculum               @"merchants/v1/get_courses_curriculum"

#define URL_merchants_get_week_courses_curriculum               @"merchants/v1/get_week_courses_curriculum"
#pragma mark - 学员------------------------------------------------
//添加学员
#define URL_account_add_student                     @"account/v1/add_student"

//编辑学员
#define URL_account_edit_student                     @"account/v1/edit_student"


//学员详情
#define URL_account_get_student_info                @"account/v1/get_student_info"

#define URL_account_get_stores_student_info                @"account/v1/get_stores_student_info"

//学员list
#define URL_account_get_student_list                @"account/v1/get_student_list"

//来源渠道
#define URL_account_get_source_list                 @"account/v1/get_source_list"

//排课列表
#define URL_account_get_arrang_student_list          @"account/v1/get_arrang_student_list"

//删除学员
#define URL_account_del_student                    @"account/v1/del_student"


//明星学员list
#define URL_account_get_star_student_list          @"account/v1/get_star_student_list"


//明星教师list
#define URL_account_get_star_student_list          @"account/v1/get_star_student_list"

//明星学员
#define URL_account_add_star_student                 @"account/v1/add_star_student"


//扫码添加班级学员
#define URL_account_add_student_by_qrcode                 @"account/v1/add_student_by_qrcode"

//设置扫码学员进度
#define URL_account_set_qrcode_progress                 @"account/v1/set_qrcode_progress"


//学员进度列表
#define URL_account_get_student_progress                 @"account/v1/get_student_progress"

//生成班级二维码
#define URL_account_get_class_qrcode                 @"account/v1/get_class_qrcode"

//根据code_id 搜索学员
#define URL_merchants_v1_get_account_info           @"merchants/v1/get/account/info"

//学员列表
#define URL_account_v1_get_student_list             @"account/v1/get/student/list"

#pragma mark - 教师------------------------------------------------
//教师list
#define URL_account_get_teacher_list                  @"account/v1/get_teacher_list"
//教师添加
#define URL_account_add_teacher                       @"account/v1/add_teacher"
//教师详情
#define URL_account_get_teacher_info                  @"account/v1/get_stores_teacher_info"

//教师详情
#define URL_account_get_stores_teacher_info                  @"account/v1/get_teacher_info"

//教师编辑
#define URL_account_edit_teacher                      @"account/v1/edit_teacher"
//教师编辑
#define URL_account_del_teacher                       @"account/v1/del_teacher"
//课程教师list
#define URL_account_get_teacher_by_courses            @"account/v1/get_teacher_by_courses"

//教师获取机构信息
#define URL_account_get_store_info_by_teacher            @"account/v1/get_store_info_by_teacher"


#pragma mark - 卡券------------------------------------------------
//添加卡券
#define URL_coupons_v1_add_coupons                   @"coupons/v1/add_coupons"
//赠送卡券
#define URL_coupons_v1_add_give_coupons             @"coupons/v1/add_give_coupons"

//编辑卡券
#define URL_coupons_v1_edit_coupons                  @"coupons/v1/edit_coupons"

//卡券详情
#define URL_coupons_v1_get_coupons_info              @"coupons/v1/get_coupons_info"

//卡券list
#define URL_coupons_v1_get_coupons_list              @"coupons/v1/get_coupons_list"


//我的卡券list
#define URL_coupons_v1_get_my_coupons_list            @"coupons/v1/get_my_coupons_list"

//开启关闭卡券
#define URL_coupons_v1_update_coupons_status              @"coupons/v1/update_coupons_status"

//获取卡券可使用的课程列表
#define URL_coupons_v1_get_courses_list_by_coupons_id              @"coupons/v1/get_courses_list_by_coupons_id"

#define URL_coupons_v1_receive_coupons              @"coupons/v1/receive_coupons"

#define URL_coupons_v1_get_coupons_by_stores        @"coupons/v1/get_coupons_by_stores"

#define URL_coupons_v1_get_courses_coupons_list        @"coupons/v1/get_courses_coupons_list"

#pragma mark - 排课------------------------------------------------
//班级列表
#define URL_merchants_v1_get_courses_class_list                   @"merchants/v1/get_courses_class_list"
 
//班级搜索
#define URL_merchants_v1_search_courses_class                   @"merchants/v1/search_courses_class"

//班级详情
#define URL_merchants_v1_get_courses_class_info                   @"merchants/v1/get_courses_class_info"
 
//添加排课
#define URL_merchants_v1_add_course_class                   @"merchants/v1/add_course_class"
 

//编辑班级
#define URL_merchants_v1_edit_courses_class                   @"merchants/v1/edit_courses_class"
 

//学员列表
#define URL_merchants_v1_get_courses_class_students_list                   @"merchants/v1/get_courses_class_students_list"
 
//班级删除
#define URL_merchants_v1_del_courses_class                   @"merchants/v1/del_courses_class"
 
//开课接口
#define URL_merchants_v1_courses_class_start                   @"merchants/v1/add_class_sign"

//班级添加学员
#define URL_merchants_v1_add_courses_class_students                   @"merchants/v1/add_courses_class_students"

//班级删除学员
#define URL_merchants_v1_del_courses_class_students                   @"merchants/v1/del_courses_class_students"

//我的班级
#define URL_merchants_v1_get_my_courses_class_list                   @"merchants/v1/get_my_courses_class_list"
 
//教师我的班级 签课
#define URL_merchants_v1_get_teacher_courses_class_list                   @"merchants/v1/get_teacher_courses_class_list"
 
//班级未设置进度学员列表
#define URL_account_v1_get_qrcode_student_list                   @"account/v1/get_qrcode_student_list"
 

#pragma mark - 订单------------------------------------------------
//创建订单
#define URL_order_v1_create_order                   @"order/v1/create_order"
//订单详情
#define URL_order_v1_get_order_info                 @"order/v1/get_order_info"
//创建订单
#define URL_order_v1_create_appointment_oreder      @"order/v1/create_appointment_oreder"
//订单支付接口
#define URL_order_v1_pay_order                      @"order/v1/pay_order"
//检测付款状态
#define URL_order_v1_check_pay_status               @"order/v1/check_pay_status"
//取消订单
#define URL_order_v1_close_order                    @"order/v1/close_order"
//订单列表
#define URL_order_v1_order_list                     @"order/v1/order_list"
//删除订单
#define URL_order_v1_del_order                      @"order/v1/del_order"
//接受拒绝预约
#define URL_order_v1_update_appointment_order              @"order/v1/update_appointment_order"
//退款确定 拒绝
#define URL_order_v1_refund_confirm                 @"order/v1/refund_confirm"
//退款
#define URL_order_v1_refund_order                   @"order/v1/refund_order"
//退款查询
#define URL_order_v1_refund_query                   @"order/v1/refund_query"
//退款订单列表
#define URL_order_v1_refund_order_list              @"order/v1/refund_order_list"
//协商退款
#define URL_order_v1_refund_order_again              @"order/v1/refund_order_again"
//校区退款
#define URL_order_v1_refund_order_pay                @"order/v1/refund_by_store"

//协商退款取消
#define URL_order_v1_refund_order_cancle             @"order/v1/cancle_refund_order"

//退款详情
#define URL_order_v1_get_refund_order_info            @"order/v1/get_refund_order_info"

#pragma mark - 相册------------------------------------------------
//相册类型列表
#define URL_coupons_v1_get_stores_image_type_list                   @"merchants/v1/get_stores_image_type_list"

#define URL_coupons_v1_add_stores_image                   @"merchants/v1/add_stores_image"

#define URL_coupons_v1_get_stores_image_list_by_type                   @"merchants/v1/get_stores_image_list_by_type"

#define URL_coupons_v1_del_stores_image                   @"merchants/v1/del_stores_image"



#pragma mark - 评价------------------------------------------------
//添加评论
#define URL_account_v1_add_comment                   @"account/v1/add_comment"

//获取评价列表(学员)
#define URL_account_v1_get_account_comment_list      @"account/v1/get_account_comment_list"

//评论详情
#define URL_account_v1_get_comment_info              @"account/v1/get_comment_info"

//获取机构评论列表
#define URL_account_v1_get_merchants_comment_list   @"account/v1/get_merchants_comment_list"

//获取课程评论列表
#define URL_account_v1_get_courses_comment_list   @"account/v1/get_courses_comment_list"

//获取教师评论列表
#define URL_account_v1_get_teacher_comment_list              @"account/v1/get_teacher_comment_list"

//回复
#define URL_account_v1_reply_commen                   @"account/v1/reply_comment"


#pragma mark - 首页门店
#define URL_merchants_v1_index                        @"merchants/v1/index"

#define URL_merchants_v1_get_ad_list                  @"merchants/v1/get_ad_list"

#define URL_merchants_v1_stores_deteail_info          @"merchants/v1/stores_deteail_info"

#define URL_account_v1_add_complaint                  @"account/v1/add_complaint"

#define URL_account_v1_get_complaint_type             @"account/v1/get_complaint_type"

#define URL_merchants_v1_get_merchants_account             @"merchants/v1/get_merchants_account"

#define URL_merchants_v1_search_course                @"merchants/v1/search/course"

#define URL_merchants_v1_get_category_list            @"merchants/v1/get/category/list"

//账户信息
#define URL_merchants_v1_get_merchants_account             @"merchants/v1/get_merchants_account"
//账单明细
#define URL_merchants_v1_get_merchants_account_list             @"merchants/v1/get_merchants_account_list"
//校区统计相关
#define URL_merchants_v1_get_stores_statistical             @"merchants/v1/get_stores_statistical"
//账单明细详情（订单明细）
#define URL_merchants_v1_get_merchants_account_order_list             @"merchants/v1/get_merchants_account_order_list"


#pragma mark - 签课
//教师签课
#define URL_account_v1_add_class_sign                  @"account/v1/add_class_sign"
//学员签到
#define URL_account_v1_add_student_sign                @"account/v1/add_student_sign"
//签到详情
#define URL_account_v1_get_sign_info                   @"account/v1/get_sign_info"
//班级签到详情
#define URL_account_v1_get_class_num_sign_info         @"account/v1/get_class_num_sign_info"
//教师帮忙签课
#define URL_account_v1_add_sign_by_teacher             @"account/v1/add_sign_by_teacher"
//获取签到二维码
#define URL_account_v1_get_sign_qrcode                 @"account/v1/get_sign_qrcode"

//签到二维码
#define URL_account_v1_get_sign_qrcode                 @"account/v1/get_sign_qrcode"

//添加学员二维码
#define URL_account_v1_get_add_student_qrcode          @"account/v1/get_add_student_qrcode"

//添加班级二维码
#define URL_account_v1_get_new_class_qrcode          @"account/v1/get_new_class_qrcode"

#define URL_account_v1_upload_sign_image          @"account/v1/upload/sign/image"

#pragma mark - 消息
#define URL_account_v1_get_news_list                    @"account/v1/get/news/list"

#define URL_account_v1_send_student_news                @"account/v1/send/student/news"

#define URL_account_v1_get_news_info                    @"account/v1/get/news/info"


#define URL_account_v1_get_news_del                    @"account/v1/get/news/del"




#pragma mark - device_token
#define URL_message_v1_add_device_token                 @"account/v1/add_device_token"

#define URL_message_v1_get_device_token_info                 @"account/v1/get_device_token_info"

#define URL_message_v1_unbind_device_token                 @"account/v1/unbind_device_token"


#pragma mark - 奖励中心
//奖励中心详情
#define URL_message_v1_rewardCenterInfo                 @"account/v1/reward/center/info"

//提现
#define URL_message_v1_cashOut               @"account/v1/account/cash/out"

//提现记录
#define URL_message_v1_cashOutRecord               @"account/v1/account/cash/out/record"

//奖励明细
#define URL_message_v1_getRewardDetails               @"account/v1/getRewardDetails"

//奖励中心排行榜
#define URL_message_v1_rewardRankList               @"account/v1/reward/center/rank/list"

//团队列表
#define URL_message_v1_rewardTeamList               @"account/v1/reward/center/team/list"

#pragma mark - 收藏
//添加课程收藏
#define URL_message_v1_collectionCourse            @"account/v1/collection/course"

//收藏列表
#define URL_message_v1_collectionCourseList       @"account/v1/collection/course/list"

//添加机构收藏
#define URL_message_v1_collectionStoreList         @"account/v1/collection/store/list"

//添加机构收藏
#define URL_message_v1_collectionStore            @"account/v1/collection/store"

#pragma mark - 动态
//个人信息
#define URL_account_v1_personal_center_info       @"account/v1/personal/center/info"

//发布动态
#define URL_account_v1_release_dynamics           @"account/v1/release/dynamics"

//动态列表
#define URL_account_v1_dynamics_list              @"account/v1/account/dynamics"

//动态详情
#define URL_account_v1_dynamics_info              @"account/v1/dynamics/info"

//删除动态
#define URL_account_v1_dynamics_remove            @"account/v1/dynamics/remove"

//喜欢动态
#define URL_account_v1_enjoy_dynamics             @"account/v1/enjoy/dynamics"

//喜欢动态列表
#define URL_account_v1_enjoy_dynamics_list        @"account/v1/enjoy/dynamics/list"

//取消喜欢
#define URL_account_v1_cancel_enjoy               @"account/v1/cancel/enjoy"

//关注
#define URL_account_v1_add_follow                 @"account/v1/add/follow"

//取消关注
#define URL_account_v1_cancel_follow              @"account/v1/cancel/follow"

//关注列表
#define URL_account_v1_follow_list                @"account/v1/follow/list"

//粉丝列表
#define URL_account_v1_fans_list                  @"account/v1/fans/list"

//新增粉丝列表
#define URL_account_v1_new_fans_list              @"account/v1/new/fans/list"

//推荐动态标签
#define URL_account_v1_recommend_dynamic_tags    @"account/v1/recommend/dynamic/tags"


//编辑签名
#define URL_account_v1_personal_edit_autograph              @"account/v1/personal/edit/autograph"

//发现 动态
#define URL_account_v1_recommond_dynamics_list    @"account/v1/dynamics/list"

//发现 关注
#define URL_account_v1_follow_account_dynamic_list    @"account/v1/follow/account/dynamic/list"


//动态喜欢列表
#define URL_account_v1_dynamics_enjoy_list    @"account/v1/dynamics/enjoy/list"


//动态评论列表
#define URL_account_v1_dynamic_comment_list    @"account/v1/dynamic/comment/list"

//动态评论
#define URL_account_v1_comment_dynamic    @"account/v1/comment/dynamic"

//打卡校区
#define URL_account_v1_search_store_list    @"account/v1/search/store/list"

//动态消息列表
#define URL_account_v1_dynamic_news_list    @"account/v1/dynamic/news/list"

//喜欢动态消息列表
#define URL_account_v1_enjoy_dynamic_news_list    @"account/v1/enjoy/dynamic/news/list"

//评论动态消息列表
#define URL_account_v1_comment_dynamic_news_list    @"account/v1/comment/dynamic/news/list"
//举报
#define URL_account_v1_complaint_dynamic         @"account/v1/complaint/dynamic"

//删除动态
#define URL_account_v1_dynamics_remove           @"account/v1/dynamics/remove"
#endif /* URLMacros_h */
