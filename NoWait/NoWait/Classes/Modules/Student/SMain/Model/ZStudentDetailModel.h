//
//  ZStudentDetailModel.h
//  NoWait
//
//  Created by zhuang zhang on 2020/1/8.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
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

