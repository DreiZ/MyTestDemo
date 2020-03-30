//
//  ZStudentMainModel.h
//  NoWait
//
//  Created by zhuang zhang on 2020/1/6.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZStudentPhotoWallItemModel : NSObject
@property (nonatomic,strong) NSString *imageName;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) id data;

@end

@interface ZStudentEnteryItemModel : NSObject
@property (nonatomic,strong) NSString *imageName;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *sid;

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


@interface ZStudentMainModel : NSObject

@end


