//
//  ZStudentMainTableViewVC.h
//  NoWait
//
//  Created by zhuang zhang on 2020/5/23.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZViewController.h"
#import "ZStudentMainTopSearchView.h"

#import "ZNoDataCell.h"
#import "ZStudentBannerCell.h"
#import "ZStudentMainEnteryCell.h"
#import "ZStudentMainPhotoWallCell.h"
#import "ZStudentOrganizationListCell.h"
#import "ZStudentMainFiltrateSectionView.h"
#import "ZStudentOrganizationListCell.h"

#import "ZStudentOrganizationDetailDesVC.h"
#import "ZStudentClassificationListVC.h"

#import "ZPhoneAlertView.h"
#import "ZServerCompleteAlertView.h"
#import "ZAlertUpdateAppView.h"
#import "ZAlertView.h"
#import "ZAlertImageView.h"

#import "ZStudentMainViewModel.h"
#import "ZMianSearchVC.h"
#import "ZLocationManager.h"
#import "ZRouteManager.h"
#import "ZDBMainStore.h"
#import "ZAlertClassifyPickerView.h"

#define KSearchTopViewHeight  CGFloatIn750(88)

@interface ZStudentMainTableViewVC : ZTableViewViewController
@property (nonatomic,strong) ZStudentMainTopSearchView *searchView;
@property (nonatomic,strong) ZStudentMainFiltrateSectionView *sectionView;
@property (nonatomic,strong) UIView *hintFooterView;

@property (nonatomic,strong) NSMutableArray *enteryArr;
@property (nonatomic,strong) NSMutableArray *photoWallArr;

@property (nonatomic,strong) NSMutableArray *enteryDataArr;
@property (nonatomic,strong) NSMutableArray *AdverArr;
@property (nonatomic,strong) NSMutableArray *placeholderArr;
@property (nonatomic,strong) NSMutableArray *classifyArr;
@property (nonatomic,strong) NSMutableDictionary *param;
@property (nonatomic,assign) BOOL isLoacation;
@end


