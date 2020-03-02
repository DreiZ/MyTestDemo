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

@end

@interface ZStudentEnteryItemModel : NSObject
@property (nonatomic,strong) NSString *imageName;
@property (nonatomic,strong) NSString *name;

@end

@interface ZStudentBannerModel : NSObject
@property (nonatomic,strong) NSString *image;
@property (nonatomic,strong) id data;
@end

@interface ZStudentMainModel : NSObject

@end


