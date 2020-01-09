//
//  ZStudentDetailModel.h
//  NoWait
//
//  Created by zhuang zhang on 2020/1/8.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ZStudentDetailDesListModel : NSObject
@property (nonatomic,strong) NSString *desTitle;
@property (nonatomic,strong) NSString *desSub;

@end

@interface ZStudentDetailDesModel : NSObject

@end

@interface ZStudentDetailNoticeModel : NSObject

@end

@interface ZStudentDetailEvaModel : NSObject

@end

@interface ZStudentDetailSectionModel : NSObject
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *right;
@property (nonatomic,assign) BOOL isShowRight;
@end

@interface ZStudentDetailContentListModel : NSObject
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *image;

@end

@interface ZStudentDetailBannerModel : NSObject

@end

@interface ZStudentDetailPersonnelModel : NSObject
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *image;
@property (nonatomic,strong) NSString *skill;

@end

@interface ZStudentDetailModel : NSObject

@end

