//
//  ZCircleReleaseModel.h
//  NoWait
//
//  Created by zhuang zhang on 2020/7/7.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZCircleReleaseSchoolModel : ZBaseModel
@property (nonatomic,copy) NSString *distance;
@property (nonatomic,copy) NSString *store_id;
@property (nonatomic,copy) NSString *image;
@property (nonatomic,copy) NSString *name;
@end


@interface ZCircleReleaseSchoolNetModel : ZBaseModel
@property (nonatomic,strong) NSArray *list;
@property (nonatomic,strong) NSString *total;
@end


@interface ZCircleReleaseTagModel : ZBaseModel
@property (nonatomic,copy) NSString *tag_name;
@property (nonatomic,copy) NSString *tag_id;
@property (nonatomic,copy) NSString *is_hot;
@end

@interface ZCircleReleaseTagNetModel : ZBaseModel
@property (nonatomic,strong) NSArray *list;
@end

@interface ZCircleReleaseModel : ZBaseModel
@property (nonatomic,copy) NSString *province;
@property (nonatomic,copy) NSString *city;
@property (nonatomic,copy) NSString *county;
@property (nonatomic,copy) NSString *brief_address;
@property (nonatomic,copy) NSString *address;
@property (nonatomic,assign) double latitude;
@property (nonatomic,assign) double longitude;

@property (nonatomic,copy) NSString *store_id;
@property (nonatomic,copy) NSString *store_name;

@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *content;

@property (nonatomic,strong) NSMutableArray *imageArr;
@property (nonatomic,strong) NSMutableArray *tags;

@property (nonatomic,copy) NSString *cover;
@end

NS_ASSUME_NONNULL_END
