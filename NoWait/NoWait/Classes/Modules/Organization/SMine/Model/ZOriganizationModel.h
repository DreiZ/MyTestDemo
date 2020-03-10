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

@interface ZOriganizationSchooleListModel : NSObject
@property (nonatomic,strong) NSString *status;
@property (nonatomic,strong) NSString *schoolID;
@property (nonatomic,strong) NSString *name;
@end

@interface ZOriganizationSchoolListNetModel : ZBaseNetworkBackDataModel
@property (nonatomic,strong) NSArray <ZOriganizationSchooleListModel *>*list;

@end
NS_ASSUME_NONNULL_END
