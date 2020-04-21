//
//  ZMineModel.h
//  NoWait
//
//  Created by zhuang zhang on 2020/3/3.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZBaseModel.h"


@interface ZMineModel : ZBaseModel

@end

@interface ZMineFeedBackModel : ZBaseModel
@property (nonatomic,strong) NSString *des;
@property (nonatomic,strong) NSString *phone;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSMutableArray *images;
@end

@interface ZQRCodeMode : ZBaseModel
//qrcode_type    二维码类型 1：扫码签到 2：扫码加学员
@property (nonatomic,strong) NSString *qrcode_type;
@property (nonatomic,strong) NSString *source_type;
@property (nonatomic,strong) NSString *timestamp;

@end


@interface ZQRCodeAddStudentMode : ZQRCodeMode
@property (nonatomic,strong) NSString *course_id;
@property (nonatomic,strong) NSString *teacher_id;
@property (nonatomic,strong) NSString *stores_id;
@property (nonatomic,strong) NSString *course_number;

@property (nonatomic,strong) NSString *course_image;
@property (nonatomic,strong) NSString *course_name;
@property (nonatomic,strong) NSString *stores_name;
@property (nonatomic,strong) NSString *teacher_image;
@property (nonatomic,strong) NSString *teacher_name;
@property (nonatomic,strong) NSString *teacher_nick_name;

@property (nonatomic,strong) NSString *courses_class_id;
@end


@interface ZQRCodeStudentSignMode : ZQRCodeMode
@property (nonatomic,strong) NSString *courses_class_id;
@property (nonatomic,strong) NSString *account_id;
@property (nonatomic,strong) NSString *student_id;
@property (nonatomic,strong) NSString *nums;

@property (nonatomic,strong) NSString *type;
@property (nonatomic,strong) NSString *course_name;
@property (nonatomic,strong) NSString *stores_name;
@property (nonatomic,strong) NSString *teacher_image;
@property (nonatomic,strong) NSString *teacher_name;
@property (nonatomic,strong) NSString *teacher_nick_name;
@end

@interface ZMineMessageReceiveModel : ZBaseModel
@property (nonatomic,strong) NSString *account_id;
@property (nonatomic,strong) NSString *title;
@end

@interface ZMineMessageModel : ZBaseModel
@property (nonatomic,strong) NSString *message_id;
@property (nonatomic,strong) NSString *account_id;
@property (nonatomic,strong) NSString *content;
@property (nonatomic,strong) NSString *create_at;
@property (nonatomic,strong) NSDictionary *extra;
@property (nonatomic,strong) NSString *is_read;
@property (nonatomic,strong) NSString *sender1;
@property (nonatomic,strong) NSString *sender2;
@property (nonatomic,strong) NSString *stores_id;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *type;
@property (nonatomic,strong) NSString *type_msg;
@property (nonatomic,strong) NSString *update_at;
@property (nonatomic,strong) NSString *send_num;

@property (nonatomic,strong) NSArray <ZMineMessageReceiveModel *>*receiveArr;

@property (nonatomic,strong) NSString *receive;
@end


@interface ZMineMessageNetModel :  ZBaseNetworkBackDataModel
@property (nonatomic,strong) NSArray <ZMineMessageModel *>*list;
@property (nonatomic,copy) NSString *total;
@end

