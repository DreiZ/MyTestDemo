//
//  ZOrganizationMineVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/3.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationMineVC.h"

#import "ZOrganizationMineHeaderView.h"
#import "ZOriganizationClubSelectedCell.h"
#import "ZOriganizationStatisticsCell.h"
#import "ZOrganizationMenuCell.h"

#import "ZOrganizationCampusManagementVC.h"
#import "ZOrganizationLessonManageVC.h"

#import "ZStudentMineOrderListVC.h"
#import "ZStudentMineCardListVC.h"
#import "ZStudentMineSignListVC.h"
#import "ZStudentMineSettingVC.h"
#import "ZOrganizationTeacherManageVC.h"
#import "ZOrganizationStudentManageVC.h"
#import "ZOrganizationTeachingScheduleVC.h"
#import "ZOrganizationClassManageVC.h"
#import "ZOrganizationAccountVC.h"
#import "ZMineSwitchRoleVC.h"
#import "ZOrganizationMineEvaManageVC.h"
#import "ZOrganizationCardMainVC.h"
#import "ZOrganizationPhotoManageVC.h"
#import "ZOrganizationMineOrderManageVC.h"
#import "ZOrganizationOrderRefuseVC.h"
#import "ZOrganizationTeachingScheduleLessonVC.h"
#import "ZOrganizationSchoolAccountVC.h"
#import "ZStudentMineSettingMineVC.h"
#import "ZOrganizationLessonDetailListVC.h"
#import "ZRewardCenterVC.h"
#import "ZOriganizationViewModel.h"

#define kHeaderHeight CGFloatIn750(270)

@interface ZOrganizationMineVC ()
@property (nonatomic,strong) ZOrganizationMineHeaderView *headerView;
@property (nonatomic,strong) ZStoresStatisticalModel *statisticalModel;

@property (nonatomic,strong) NSMutableArray *topchannelList;

@end

@implementation ZOrganizationMineVC
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.isHidenNaviBar = YES;
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    //更新用户信息
//        [[ZUserHelper sharedHelper] updateUserInfoWithCompleteBlock:^(BOOL isSuccess) {
//            if (!isSuccess) {
//                [[ZLaunchManager sharedInstance] showSaveUserInfo];
//            }
//        }];
    [self getSchoolList];
    [self.headerView updateData];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTableViewGaryBack];
    [self initCellConfigArr];
    [self.iTableView reloadData];
    
}

- (void)setDataSource {
    [super setDataSource];
    _topchannelList = @[].mutableCopy;
    
    __weak typeof(self) weakSelf = self;
    [[kNotificationCenter rac_addObserverForName:KNotificationLoginStateChange object:nil] subscribeNext:^(NSNotification *notfication) {
        [weakSelf.topchannelList removeAllObjects];
        [weakSelf getSchoolList];
        [weakSelf initCellConfigArr];
        [weakSelf.iTableView reloadData];
    }];
}

- (void)setupMainView {
    [super setupMainView];
    
    [self.iTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self.iTableView setContentInset:UIEdgeInsetsMake(kHeaderHeight+[ZOrganizationMineHeaderView getNameOffset]+kStatusBarHeight, 0, 0, 0)];
    [self.iTableView addSubview:self.headerView];
}

#pragma mark - lazy loading...
- (ZOrganizationMineHeaderView *)headerView {
    if (!_headerView) {
        __weak typeof(self) weakSelf = self;
        _headerView = [[ZOrganizationMineHeaderView alloc] initWithFrame:CGRectMake(0, -kHeaderHeight-kStatusBarHeight-[ZOrganizationMineHeaderView getNameOffset], KScreenWidth, kHeaderHeight+kStatusBarHeight+[ZOrganizationMineHeaderView getNameOffset])];
        _headerView.userType = @"8";
        _headerView.topHandleBlock = ^(NSInteger index) {
            [[ZUserHelper sharedHelper] checkLogin:^{
                if (index == 1) {
                    ZStudentMineSettingVC *svc = [[ZStudentMineSettingVC alloc] init];
                    [weakSelf.navigationController pushViewController:svc animated:YES];
                }else if (index == 3){
                    ZMineSwitchRoleVC *avc = [[ZMineSwitchRoleVC alloc] init];
                    [weakSelf.navigationController pushViewController:avc animated:YES];
                }else if (index == 5){
                    ZOrganizationAccountVC *svc = [[ZOrganizationAccountVC alloc] init];
                    [weakSelf.navigationController pushViewController:svc animated:YES];
                }else if(index == 10){
                    ZStudentMineSettingMineVC *mvc = [[ZStudentMineSettingMineVC alloc] init];
                    
                    [weakSelf.navigationController pushViewController:mvc animated:YES];
                }else if(index == 12){
                    ZRewardCenterVC *mvc = [[ZRewardCenterVC alloc] init];
                    
                    [weakSelf.navigationController pushViewController:mvc animated:YES];
                }
            }];
        };
    }
    return _headerView;
}


#pragma mark - tableView -------datasource-----
- (void)zz_tableView:(UITableView *)tableView cell:(UITableViewCell *)cell cellForRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
    __weak typeof(self) weakSelf = self;
   if ([cellConfig.title isEqualToString:@"ZOrganizationMenuCell"]){
        ZOrganizationMenuCell *lcell = (ZOrganizationMenuCell *)cell;
        lcell.menuBlock = ^(ZBaseUnitModel * model) {
            [[ZUserHelper sharedHelper] checkLogin:^{
                if (![ZUserHelper sharedHelper].school.schoolID) {
                    [TLUIUtility showErrorHint:@"获取校区信息出错"];
                    return ;
                }
                if ([model.uid isEqualToString:@"lesson"]) {
                    ZOrganizationLessonManageVC *mvc = [[ZOrganizationLessonManageVC alloc] init];
                    [self.navigationController pushViewController:mvc animated:YES];
                    
                }else if ([model.uid isEqualToString:@"school"]){
                    ZOrganizationCampusManagementVC *mvc = [[ZOrganizationCampusManagementVC alloc] init];
                    [self.navigationController pushViewController:mvc animated:YES];
                }else if ([model.uid isEqualToString:@"teacher"]){
                    ZOrganizationTeacherManageVC *mvc = [[ZOrganizationTeacherManageVC alloc] init];
                    [self.navigationController pushViewController:mvc animated:YES];
                }else if ([model.uid isEqualToString:@"student"]){
                    ZOrganizationStudentManageVC *mvc = [[ZOrganizationStudentManageVC alloc] init];
                    [self.navigationController pushViewController:mvc animated:YES];
                }else if ([model.uid isEqualToString:@"manageLesson"]){
                    ZOrganizationTeachingScheduleLessonVC *lvc = [[ZOrganizationTeachingScheduleLessonVC alloc] init];
                    [self.navigationController pushViewController:lvc animated:YES];
                    //                ZOrganizationTeachingScheduleVC *svc = [[ZOrganizationTeachingScheduleVC alloc] init];
                    //                [self.navigationController pushViewController:svc animated:YES];
                }else if ([model.uid isEqualToString:@"class"]){
                    ZOrganizationClassManageVC *svc = [[ZOrganizationClassManageVC alloc] init];
                    [self.navigationController pushViewController:svc animated:YES];
                }else if ([model.uid isEqualToString:@"account"]){
                    ZOrganizationSchoolAccountVC *svc = [[ZOrganizationSchoolAccountVC alloc] init];
                    svc.stores_id = [ZUserHelper sharedHelper].school.schoolID;
                    [self.navigationController pushViewController:svc animated:YES];
                }else if ([model.uid isEqualToString:@"order"]){
                    ZOrganizationMineOrderManageVC *elvc = [[ZOrganizationMineOrderManageVC alloc] init];
                    [weakSelf.navigationController pushViewController:elvc animated:YES];
                }else if ([model.uid isEqualToString:@"eva"]){
                    ZOrganizationMineEvaManageVC *elvc = [[ZOrganizationMineEvaManageVC alloc] init];
                    [weakSelf.navigationController pushViewController:elvc animated:YES];
                }else if ([model.uid isEqualToString:@"cart"]){
                    ZOrganizationCardMainVC *elvc = [[ZOrganizationCardMainVC alloc] init];
                    [weakSelf.navigationController pushViewController:elvc animated:YES];
                }else if ([model.uid isEqualToString:@"photo"]){
                    ZOrganizationPhotoManageVC *lvc = [[ZOrganizationPhotoManageVC alloc] init];
                    [weakSelf.navigationController pushViewController:lvc animated:YES];
                }else if ([model.uid isEqualToString:@"refund"]){
                    ZOrganizationOrderRefuseVC *lvc = [[ZOrganizationOrderRefuseVC alloc] init];
                    [weakSelf.navigationController pushViewController:lvc animated:YES];
                }else if([model.uid isEqualToString:@"teacher_lesson"]){
                    ZOrganizationLessonDetailListVC *lvc = [[ZOrganizationLessonDetailListVC alloc] init];
                    [weakSelf.navigationController pushViewController:lvc animated:YES];
                }
            }];
            
        };
   }else if ([cellConfig.title isEqualToString:@"ZOriganizationClubSelectedCell"]){
       ZOriganizationClubSelectedCell *lcell = (ZOriganizationClubSelectedCell *)cell;
       lcell.menuBlock = ^(ZBaseUnitModel * model) {
           [[ZUserHelper sharedHelper] checkLogin:^{
               ZOriganizationSchoolListModel *smodel = [[ZOriganizationSchoolListModel alloc] init];
               smodel.schoolID = model.uid;
               smodel.name = model.name;
               smodel.statistical_type = [model.subName intValue];
               for (ZOriganizationSchoolListModel *listModel in self.topchannelList) {
                   if ([listModel.schoolID isEqualToString:model.uid]) {
                       listModel.statistical_type = smodel.statistical_type;
                       [ZUserHelper sharedHelper].school = listModel;
                   }
               }
               
               [weakSelf initCellConfigArr];
               [weakSelf getStoresStatistical];
           }];
       };
   }else if ([cellConfig.title isEqualToString:@"ZOriganizationStatisticsCell"]){
       ZOriganizationStatisticsCell *lcell = (ZOriganizationStatisticsCell *)cell;
       lcell.selectedIndex = [ZUserHelper sharedHelper].school.statistical_type;
       lcell.handleBlock = ^(NSInteger index) {
           [[ZUserHelper sharedHelper] checkLogin:^{
               [ZUserHelper sharedHelper].school.statistical_type = index;
               [weakSelf getStoresStatistical];
           }];
           
       };
   }
}


#pragma mark - scrollview delegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // 获取到tableView偏移量
    CGFloat Offset_y = scrollView.contentOffset.y;
    // 下拉 纵向偏移量变小 变成负的
    if ( Offset_y < -(kTopHeight)) {
        // 拉伸后图片的高度
        CGFloat totalOffset = - Offset_y;
        // 拉伸后图片位置
        _headerView.frame = CGRectMake(0, Offset_y, KScreenWidth, totalOffset);
    }else{
      _headerView.frame = CGRectMake(0, Offset_y, KScreenWidth, kTopHeight);
    }
    
    [_headerView updateSubViewFrame];
}


#pragma mark - set cell config
- (void)initCellConfigArr {
    [super initCellConfigArr];
    
    if([ZUserHelper sharedHelper].user && [[ZUserHelper sharedHelper].user.type intValue] == 8){
        NSMutableArray *channnliset = @[].mutableCopy;
        for (int i = 0; i < _topchannelList.count; i++) {
            ZOriganizationSchoolListModel *listModel = _topchannelList[i];
            ZBaseUnitModel *model = [[ZBaseUnitModel alloc] init];
            model.name = SafeStr(listModel.name);
            model.uid = SafeStr(listModel.schoolID);
            model.subName = [NSString stringWithFormat:@"%ld",listModel.statistical_type];
            if ([model.uid isEqualToString:[ZUserHelper sharedHelper].school.schoolID]) {
                model.isSelected = YES;
            }
            [channnliset addObject:model];
        }
        ZCellConfig *channelCellConfig = [ZCellConfig cellConfigWithClassName:[ZOriganizationClubSelectedCell className] title:[ZOriganizationClubSelectedCell className] showInfoMethod:@selector(setChannelList:) heightOfCell:[ZOriganizationClubSelectedCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:channnliset];
        [self.cellConfigArr addObject:channelCellConfig];
    }
    
    
    ZCellConfig *statisticsCellConfig = [ZCellConfig cellConfigWithClassName:[ZOriganizationStatisticsCell className] title:[ZOriganizationStatisticsCell className] showInfoMethod:@selector(setModel:) heightOfCell:[ZOriganizationStatisticsCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:self.statisticalModel];
    [self.cellConfigArr addObject:statisticsCellConfig];
    NSArray *menuArr = @[@[@"财务管理",
  @[@[@"账户",isDarkModel() ? @"stores_account_dark":@"stores_account",@"account"],
    @[@"订单",isDarkModel() ? @"stores_order_dark":@"stores_order",@"order"],
    @[@"退款",isDarkModel() ? @"refund_money_dark":@"refund_money",@"refund"],
    @[@"卡券",isDarkModel() ? @"stores_card_dark":@"stores_card",@"cart"]]],
                         @[@"人事管理",
  @[@[@"学员管理",isDarkModel() ? @"store_student":@"store_student",@"student"],
  @[@"教师管理",isDarkModel() ? @"store_teacher":@"store_teacher",@"teacher"],
  @[@"校区管理",isDarkModel() ? @"store_school":@"store_school",@"school"]]],
                         @[@"后勤管理",
  @[@[@"相册管理",isDarkModel() ? @"store_photo_dark":@"store_photo",@"photo"],
    @[@"班级管理",isDarkModel() ? @"store_class_dark":@"store_class",@"class"],
    @[@"排课管理",isDarkModel() ? @"store_pai_dark":@"store_pai",@"manageLesson"],
    @[@"课程管理",isDarkModel() ? @"store_lesson_dark":@"store_lesson",@"lesson"],
    @[@"评价管理",isDarkModel() ? @"store_eva_dark":@"store_eva",@"eva"],
    @[@"教师课表",isDarkModel() ? @"teacherLessonDark":@"teacherLesson",@"teacher_lesson"]]]];
    
    for (int i = 0; i < menuArr.count; i++) {
        ZBaseMenuModel *model = [[ZBaseMenuModel alloc] init];
        model.name = menuArr[i][0];
        
        
        NSMutableArray *menulist = @[].mutableCopy;
        NSArray *tempArr = menuArr[i][1];
        for (int j = 0; j < tempArr.count; j++) {
            ZBaseUnitModel *model = [[ZBaseUnitModel alloc] init];
            model.name = tempArr[j][0];
            model.imageName = tempArr[j][1];
            model.uid = tempArr[j][2];
            if(i==1){
                model.istransformDark = YES;
            }
            [menulist addObject:model];
        }
        
        model.units = menulist;
        
        ZCellConfig *progressCellConfig = [ZCellConfig cellConfigWithClassName:[ZOrganizationMenuCell className] title:[ZOrganizationMenuCell className] showInfoMethod:@selector(setModel:) heightOfCell:[ZOrganizationMenuCell z_getCellHeight:menulist] cellType:ZCellTypeClass dataModel:model];
        [self.cellConfigArr addObject:progressCellConfig];
    }

    
    [self.iTableView reloadData];
}

- (void)getSchoolList {
    __weak typeof(self) weakSelf = self;
    [ZOriganizationViewModel getSchoolList:@{} completeBlock:^(BOOL isSuccess, id data) {
        if (isSuccess && data && [data isKindOfClass:[ZOriganizationSchoolListNetModel class]]) {
            ZOriganizationSchoolListNetModel *model = data;
            if (model && model.list) {
                [weakSelf.topchannelList removeAllObjects];
                [weakSelf.topchannelList addObjectsFromArray:model.list];
                if (ValidArray(model.list) && ![ZUserHelper sharedHelper].school) {
                    ZOriganizationSchoolListModel *listModel = model.list[0];
                    [ZUserHelper sharedHelper].school = listModel;
                }
                [weakSelf initCellConfigArr];
                [weakSelf.iTableView reloadData];
                [weakSelf getStoresStatistical];
            }
        }
    }];
}


- (void)getStoresStatistical {
    __weak typeof(self) weakSelf = self;
    [ZOriganizationViewModel getStoresStatistical:@{@"stores_id":SafeStr([ZUserHelper sharedHelper].school.schoolID),@"statistical_type":[NSString stringWithFormat:@"%ld",[ZUserHelper sharedHelper].school.statistical_type]} completeBlock:^(BOOL isSuccess, id data) {
        if (isSuccess && data && [data isKindOfClass:[ZStoresStatisticalModel class]]) {
            weakSelf.statisticalModel = data;
            [weakSelf initCellConfigArr];
            [weakSelf.iTableView reloadData];
        }
    }];
}

#pragma mark - dark
- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    [self initCellConfigArr];
    [self.iTableView reloadData];
}
@end

