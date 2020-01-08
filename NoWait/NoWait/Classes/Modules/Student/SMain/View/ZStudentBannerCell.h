//
//  ZStudentBannerCell.h
//  NoWait
//
//  Created by zhuang zhang on 2020/1/6.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZBaseCell.h"
#import "ZStudentMainModel.h"
#import "SDCycleScrollView.h"

@interface ZStudentBannerCell : ZBaseCell
@property (nonatomic,strong) SDCycleScrollView *iCycleScrollView;
@property (nonatomic,strong) NSArray <ZStudentBannerModel *>*list;
@property (nonatomic,strong) void (^bannerBlock)(ZStudentBannerModel *);
@end
