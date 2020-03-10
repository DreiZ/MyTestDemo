//
//  ZOriganizationModel.h
//  NoWait
//
//  Created by zhuang zhang on 2020/3/4.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZBaseModel.h"
#import "ZBaseNetworkBackModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ZOriganizationModel : ZBaseModel

@end

@interface ZOriganizationLessonOrderListModel : ZBaseModel
@property (nonatomic,copy) NSString *lessonName;
@property (nonatomic,copy) NSString *lessonDes;
@property (nonatomic,copy) NSString *lessonNum;
@property (nonatomic,copy) NSString *lessonHadNum;
@property (nonatomic,copy) NSString *teacherName;
@property (nonatomic,copy) NSString *lessonImage;
@property (nonatomic,copy) NSString *validity;
@property (nonatomic,assign) BOOL isSelected;
@property (nonatomic,assign) BOOL isEdit;
@end

@interface ZOriganizationAddClassModel : NSObject
@property (nonatomic,strong) NSMutableArray *lessonTimeArr;
@property (nonatomic,strong) NSMutableArray *lessonOrderArr;
@property (nonatomic,strong) NSString *className;
@property (nonatomic,assign) NSString *singleTime;
@end

@interface ZOriganizationLessonOrderListNetModel : ZBaseNetworkBackDataModel
@property (nonatomic,strong) NSArray <ZOriganizationLessonOrderListModel *>*list;
@property (nonatomic,copy) NSString *pages;
@end


@interface ZOriganizationClassListModel : ZBaseNetworkBackDataModel
@property (nonatomic,strong) NSString *status;
@property (nonatomic,strong) NSString *type;
@property (nonatomic,strong) NSString *isu;
@property (nonatomic,strong) NSString *className;
@property (nonatomic,strong) NSString *classDes;
@property (nonatomic,strong) NSString *teacherName;
@property (nonatomic,strong) NSString *teacherImage;
@property (nonatomic,strong) NSString *num;
@end

@interface ZOriganizationClassListNetModel : ZBaseNetworkBackDataModel
@property (nonatomic,strong) NSArray <ZOriganizationClassListModel *>*list;
@property (nonatomic,copy) NSString *pages;
@end

@interface ZOriganizationSchoolListModel : NSObject
@property (nonatomic,strong) NSString *status;
@property (nonatomic,strong) NSString *schoolID;
@property (nonatomic,strong) NSString *name;
@end

@interface ZOriganizationSchoolListNetModel : ZBaseNetworkBackDataModel
@property (nonatomic,strong) NSArray <ZOriganizationSchoolListModel *>*list;

@end

@interface ZOriganizationSchoolDetailModel : NSObject
@property (nonatomic,strong) NSString *address;
@property (nonatomic,strong) NSString *brief_address;
@property (nonatomic,strong) NSString *city;
@property (nonatomic,strong) NSString *county;
@property (nonatomic,strong) NSString *province;
@property (nonatomic,strong) NSString *hash_update_address;
@property (nonatomic,strong) NSString *hash_update_name;
@property (nonatomic,strong) NSString *hash_update_store_type_id;
@property (nonatomic,strong) NSString *schoolID;
@property (nonatomic,strong) NSString *image;
@property (nonatomic,strong) NSString *landmark;
@property (nonatomic,strong) NSString *latitude;
@property (nonatomic,strong) NSString *longitude;
@property (nonatomic,strong) NSString *merchants_id;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *opend_end;
@property (nonatomic,strong) NSString *opend_start;
@property (nonatomic,strong) NSString *phone;
@property (nonatomic,strong) NSString *place;
@property (nonatomic,strong) NSString *regional_id;
@property (nonatomic,strong) NSString *status;
@property (nonatomic,strong) NSString *store_type_id;

@property (nonatomic,strong) NSMutableArray *months;
@property (nonatomic,strong) NSMutableArray *stores_info;
@property (nonatomic,strong) NSMutableArray *week_days;
@property (nonatomic,strong) NSMutableArray *merchant_stores_tags;


@end

NS_ASSUME_NONNULL_END
