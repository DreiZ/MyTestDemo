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
@end


@interface ZQRCodeAddStudentMode : ZBaseModel
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
@end


