//
//  ZTeacherMineVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/2/28.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZTeacherMineVC.h"
#import "ZOrganizationMineHeaderView.h"
#import "ZOriganizationLessonViewModel.h"

#import "ZTableViewListCell.h"
#import "ZStudentMineLessonTimetableCell.h"
#import "ZTeacherMineEntryStoresCell.h"

#import "ZTeacherMineEvaListVC.h"
#import "ZTeacherMineSignListVC.h"
#import "ZStudentMineSettingVC.h"

#import "ZMineSwitchRoleVC.h"
#import "DIYScanViewController.h"
#import "ZTeacherViewModel.h"
#import "ZStudentOrganizationDetailDesVC.h"
#import "ZTeacherLessonDetailListVC.h"
#import "ZStudentMineSettingMineVC.h"

#define kHeaderHeight (CGFloatIn750(270))

@interface ZTeacherMineVC ()
@property (nonatomic,strong) ZOrganizationMineHeaderView *headerView;
@property (nonatomic,strong) NSMutableArray *lessonList;
@end

@implementation ZTeacherMineVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.isHidenNaviBar = YES;
    [self getStoresStatistical];
    [self refreshCurriculumList];
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
     [self.headerView updateData];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupMainView];
    [self initCellConfigArr];
    [self.iTableView reloadData];
}

- (void)setDataSource {
    [super setDataSource];
    _lessonList = @[].mutableCopy;
    
    __weak typeof(self) weakSelf = self;
    [[kNotificationCenter rac_addObserverForName:KNotificationLoginStateChange object:nil] subscribeNext:^(NSNotification *notfication) {
        
        [weakSelf.lessonList removeAllObjects];
        [weakSelf getStoresStatistical];
        [weakSelf refreshCurriculumList];
        [weakSelf initCellConfigArr];
        [weakSelf.iTableView reloadData];
    }];
    
}

- (void)setupMainView {
    [super setupMainView];
    
    [self.iTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self.iTableView setContentInset:UIEdgeInsetsMake(kHeaderHeight+kStatusBarHeight, 0, 0, 0)];
    [self.iTableView addSubview:self.headerView];
}

#pragma mark - lazy loading...
- (ZOrganizationMineHeaderView *)headerView {
    if (!_headerView) {
        __weak typeof(self) weakSelf = self;
        _headerView = [[ZOrganizationMineHeaderView alloc] initWithFrame:CGRectMake(0, -kHeaderHeight-kStatusBarHeight, KScreenWidth, kHeaderHeight+kStatusBarHeight)];
        _headerView.userType = @"2";
        _headerView.topHandleBlock = ^(NSInteger index) {
            [[ZUserHelper sharedHelper] checkLogin:^{
                if (index == 1) {
                    ZStudentMineSettingVC *svc = [[ZStudentMineSettingVC alloc] init];
                    [weakSelf.navigationController pushViewController:svc animated:YES];
                }else if (index == 3){
                    ZMineSwitchRoleVC *avc = [[ZMineSwitchRoleVC alloc] init];
                    [weakSelf.navigationController pushViewController:avc animated:YES];
                }else if (index == 8){
                    DIYScanViewController *dvc = [[DIYScanViewController alloc] init];
                    [weakSelf.navigationController pushViewController:dvc animated:YES];
                }else if(index == 10){
                    ZStudentMineSettingMineVC *mvc = [[ZStudentMineSettingMineVC alloc] init];
                    
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
    
    if ([cellConfig.title isEqualToString:@"ZTableViewListCell"]){
        ZTableViewListCell *lcell = (ZTableViewListCell *)cell;
        lcell.handleBlock = ^(ZCellConfig *scellConfig) {
            [[ZUserHelper sharedHelper] checkLogin:^{
                if ([scellConfig.title isEqualToString:@"eva"]) {
                    ZTeacherMineEvaListVC *elvc = [[ZTeacherMineEvaListVC alloc] init];
                    [weakSelf.navigationController pushViewController:elvc animated:YES];
                }else if ([scellConfig.title isEqualToString:@"sign"]) {
                    ZTeacherMineSignListVC *lvc = [[ZTeacherMineSignListVC alloc] init];
                    [weakSelf.navigationController pushViewController:lvc animated:YES];
                }else if ([scellConfig.title isEqualToString:@"ZTeacherMineEntryStoresCell"]) {
                    ZStudentOrganizationDetailDesVC *dvc = [[ZStudentOrganizationDetailDesVC alloc] init];
                    ZOriganizationDetailModel *detailModel = scellConfig.dataModel;
                    ZStoresListModel *lmodel = [[ZStoresListModel alloc] init];
                    lmodel.stores_id = detailModel.stores_id;
                    lmodel.name = detailModel.stores_name;
                    dvc.listModel = lmodel;
                    [weakSelf.navigationController pushViewController:dvc animated:YES];
                }
            }];
        };
    }else if ([cellConfig.title isEqualToString:@"ZStudentMineLessonTimetableCell"]){
        ZStudentMineLessonTimetableCell *tcell = (ZStudentMineLessonTimetableCell *)cell;
        tcell.moreBlock = ^(NSInteger index) {
            ZTeacherLessonDetailListVC *lvc = [[ZTeacherLessonDetailListVC alloc] init];
            [self.navigationController pushViewController:lvc animated:YES];
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


- (void)initCellConfigArr {
    [super initCellConfigArr];
    NSArray *tempArr = @[@[isDarkModel() ? @"sign_teacher_dark":@"sign_teacher",@"sign", @"我的签课", @"rightBlackArrowN"],
                         @[isDarkModel() ? @"eva_teacher_dark":@"eva_teacher",@"eva", @"我的评价", @"rightBlackArrowN"]];
    NSMutableArray *configArr = @[].mutableCopy;
    for (NSArray *tArr in tempArr) {
        ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
        model.leftImage = tArr[0];
        model.leftTitle = tArr[2];
        model.rightImage = tArr[3];
        model.cellTitle = tArr[1];
        model.isHiddenLine = YES;
        model.cellHeight = CGFloatIn750(96);
        model.leftFont = [UIFont fontContent];
        
        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
        
        [configArr addObject:menuCellConfig];
    }
    ZCellConfig *bottomCellConfig = [ZCellConfig cellConfigWithClassName:[ZTableViewListCell className] title:[ZTableViewListCell className] showInfoMethod:@selector(setConfigList:) heightOfCell:[ZTableViewListCell z_getCellHeight:configArr] cellType:ZCellTypeClass dataModel:configArr];
    [self.cellConfigArr addObject:bottomCellConfig];
    
//    for (int i = 0; i < 10; i++) {
//        ZOriganizationLessonListModel *limo = [[ZOriganizationLessonListModel alloc] init];
//        limo.time = @"11:21~12:12";
//        limo.course_name = @"感受感受";
//        [_lessonList addObject:limo];
//    }
    if (_lessonList.count > 0) {
        ZCellConfig *timeCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentMineLessonTimetableCell className] title:[ZStudentMineLessonTimetableCell className] showInfoMethod:@selector(setList:) heightOfCell:[ZStudentMineLessonTimetableCell z_getCellHeight:_lessonList] cellType:ZCellTypeClass dataModel:_lessonList];
        [self.cellConfigArr addObject:timeCellConfig];
    }
    
    
    
    if([ZUserHelper sharedHelper].stores){
        NSMutableArray *configArr = @[].mutableCopy;
        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZTeacherMineEntryStoresCell className] title:@"ZTeacherMineEntryStoresCell" showInfoMethod:@selector(setModel:) heightOfCell:[ZTeacherMineEntryStoresCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:[ZUserHelper sharedHelper].stores];
        
        [configArr addObject:menuCellConfig];
        
        ZCellConfig *bottomCellConfig = [ZCellConfig cellConfigWithClassName:[ZTableViewListCell className] title:[ZTableViewListCell className] showInfoMethod:@selector(setConfigList:) heightOfCell:[ZTableViewListCell z_getCellHeight:configArr] cellType:ZCellTypeClass dataModel:configArr];
        [self.cellConfigArr addObject:bottomCellConfig];
    }
    
    [self.iTableView reloadData];
}


- (void)getStoresStatistical {
    __weak typeof(self) weakSelf = self;
    [ZTeacherViewModel getStoresInfo:@{} completeBlock:^(BOOL isSuccess, id data) {
        if (isSuccess && data && [data isKindOfClass:[ZOriganizationDetailModel class]]) {
            self.loading = NO;
            [ZUserHelper sharedHelper].stores = data;
            [weakSelf initCellConfigArr];
            [weakSelf.iTableView reloadData];
        }
    }];
}


- (void)refreshCurriculumList {
    __weak typeof(self) weakSelf = self;
    [ZOriganizationLessonViewModel getCurriculumList:@{} completeBlock:^(BOOL isSuccess, ZOriganizationLessonScheduleListNetModel *data) {
        weakSelf.loading = NO;
        if (isSuccess && data) {
            [weakSelf.lessonList removeAllObjects];
            [weakSelf.lessonList addObjectsFromArray:data.list];
            [weakSelf initCellConfigArr];
            [weakSelf.iTableView reloadData];
        }else{
            [weakSelf.iTableView reloadData];
        }
    }];
}

@end


