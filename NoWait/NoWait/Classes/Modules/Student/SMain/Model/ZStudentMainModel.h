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

@interface ZComplaintModel : ZBaseModel
@property (nonatomic,strong) NSString *complaintId;
@property (nonatomic,strong) NSString *type;
@end

@interface ZComplaintNetModel : NSObject
@property (nonatomic,strong) NSArray *list;
@end



@interface ZRegionLatLngModel : ZBaseModel
@property (nonatomic,strong) NSString *longitude;
@property (nonatomic,strong) NSString *latitude;
@end

@interface ZRegionDataModel : ZBaseModel
@property (nonatomic,strong) NSString *re_id;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) ZRegionLatLngModel *latLng;
@property (nonatomic,strong) NSString *num;
//最小单位用
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *type;
@end


@interface ZRegionNetModel : ZBaseNetworkBackModel
@property (nonatomic,strong) ZRegionDataModel *city;
@property (nonatomic,strong) NSArray <ZRegionDataModel *>*region;
@property (nonatomic,strong) NSArray <ZRegionDataModel *>*schools;
@end

@interface ZStudentMainModel : NSObject

@end
