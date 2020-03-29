//
//  ZStudentOrganizationLessonListVC.h
//  NoWait
//
//  Created by zhuang zhang on 2020/3/9.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZViewController.h"
#import <WMPageController.h>
#import "ZOriganizationModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ZStudentOrganizationLessonListVC : WMPageController
/**
 是否隐藏导航栏
 */
@property (nonatomic, assign) BOOL isHidenNaviBar;
@property (nonatomic,strong) ZStoresDetailModel *detailModel;
@end

NS_ASSUME_NONNULL_END
