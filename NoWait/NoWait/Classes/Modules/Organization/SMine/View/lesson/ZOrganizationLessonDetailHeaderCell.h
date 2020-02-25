//
//  ZOrganizationLessonDetailHeaderCell.h
//  NoWait
//
//  Created by zhuang zhang on 2020/2/25.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZBaseCell.h"
#import "SDCycleScrollView.h"
#import "ZStudentMainModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ZOrganizationLessonDetailHeaderCell : ZBaseCell
@property (nonatomic,strong) NSArray <ZStudentBannerModel *>*list;
@property (nonatomic,strong) void (^bannerBlock)(ZStudentBannerModel *);
@end

NS_ASSUME_NONNULL_END
