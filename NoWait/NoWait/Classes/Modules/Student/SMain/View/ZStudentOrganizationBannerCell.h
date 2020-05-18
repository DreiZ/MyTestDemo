//
//  ZStudentOrganizationBannerCell.h
//  NoWait
//
//  Created by zhuang zhang on 2020/5/18.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZBaseCell.h"
#import "ZOriganizationModel.h"
#import "SDCycleScrollView.h"

@interface ZStudentOrganizationBannerCell : ZBaseCell
@property (nonatomic,strong) void (^bannerBlock)(ZImagesModel *);
@property (nonatomic,strong) NSArray <ZImagesModel *>*images_list;
@end

