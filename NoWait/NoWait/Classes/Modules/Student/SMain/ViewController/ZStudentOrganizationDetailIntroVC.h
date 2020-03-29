//
//  ZStudentOrganizationDetailIntroVC.h
//  NoWait
//
//  Created by zhuang zhang on 2020/3/9.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZViewController.h"
#import <WMPageController.h>
#import "ZOrderModel.h"

@interface ZStudentOrganizationDetailIntroVC : WMPageController
@property (nonatomic,assign) BOOL isHidenNaviBar;
@property (nonatomic,strong) ZImagesModel *imageModel;
@property (nonatomic,strong) ZStoresDetailModel *detailModel;

- (instancetype)initWithTitle:(NSArray *)titleArr;
@end

