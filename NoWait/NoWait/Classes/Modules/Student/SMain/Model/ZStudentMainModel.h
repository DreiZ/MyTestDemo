//
//  ZStudentMainModel.h
//  NoWait
//
//  Created by zhuang zhang on 2020/1/6.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZMainClassifyOneModel : NSObject
@property (nonatomic,assign) BOOL isSelected;
@property (nonatomic,strong) NSString *imageName;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *classify_id;
@property (nonatomic,strong) NSString *superClassify_id;
@property (nonatomic,strong) NSMutableArray <ZMainClassifyOneModel *>*secondary;
@end

@interface ZMainClassifyNetModel : NSObject
@property (nonatomic,strong) NSArray *list;
@end

@interface ZStudentPhotoWallItemModel : NSObject
@property (nonatomic,strong) NSString *imageName;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) id data;
@end

@interface ZStudentEnteryItemModel : NSObject
@property (nonatomic,strong) NSString *imageName;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *sid;
@property (nonatomic,strong) id data;
@end

@interface ZStudentBannerModel : NSObject
@property (nonatomic,strong) NSString *image;
@property (nonatomic,strong) id data;
@end

@interface ZStudentOrganizationListModel : NSObject
@property (nonatomic,strong) NSString *image;
@end

@interface ZStudentLessonListModel : NSObject
@property (nonatomic,strong) NSString *image;
@end

@interface ZComplaintModel : NSObject
@property (nonatomic,strong) NSString *complaintId;
@property (nonatomic,strong) NSString *type;
@end

@interface ZComplaintNetModel : NSObject
@property (nonatomic,strong) NSArray *list;
@end

@interface ZStudentMainModel : NSObject

@end
