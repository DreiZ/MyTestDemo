//
//  ZStudentOrganizationDetailBannerCell.h
//  NoWait
//
//  Created by zhuang zhang on 2020/1/8.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZBaseCell.h"
#import "ZStudentDetailModel.h"

@interface ZStudentOrganizationDetailBannerCell : ZBaseCell
@property (nonatomic,strong) NSArray <ZStudentDetailBannerModel *>*list;
@property (nonatomic,strong) void (^bannerBlock)(ZStudentDetailBannerModel *);
@end

