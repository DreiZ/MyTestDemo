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
#import "ZStudentMineLessonNoTimetableCell.h"
#import "UIScrollView+XJJRefresh.h"
#import "XJJRefresh.h"
#import "ZTeacherViewModel.h"

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
     [self.iTableView setContentInset:UIEdgeInsetsMake(kHeaderHeight+[ZOrganizationMineHeaderView getNameOffset]+kStatusBarHeight, 0, 0, 0)];
     [self.headerView updateData];
     [_headerView updateSubViewFrame];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupMainView];
    [self initCellConfigArr];
    [self.iTableView reloadData];
    [self setTableViewGaryBack];
    
    UIImageView *refreshImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, CGFloatIn750(50), CGFloatIn750(50))];
    refreshImage.image = [[UIImage imageNamed:@"resizeApi0"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    refreshImage.tintColor = adaptAndDarkColor([UIColor colorMain], [UIColor colorMain]);
    
    XJJHolyCrazyHeader *crazyRefresh = [XJJHolyCrazyHeader holyCrazyCustomHeaderWithCustomContentView:refreshImage];
    
    crazyRefresh.startPosition = CGPointMake(CGFloatIn750(30), -44.f);
    crazyRefresh.refreshingPosition = CGPointMake(CGFloatIn750(30), 64.f);
    
    __weak typeof(self) weakSelf = self;
    [self.iTableView add_xjj_refreshHeader:crazyRefresh refreshBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [weakSelf.scrollView end_xjj_refresh];
            [weakSelf.iTableView setRefreshState:XJJRefreshStateIdle];
        });
        
        [weakSelf.iTableView replace_xjj_refreshBlock:^{
            [weakSelf updateTableNetData];
        }];
    }];
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
        _headerView = [[ZOrganizationMineHeaderView alloc] initWithFrame:CGRectMake(0, -kHeaderHeight-kStatusBarHeight, KScreenWidth, kHeaderHeight+kStatusBarHeight)];
        _headerView.userType = @"2";
        _headerView.topHandleBlock = ^(NSInteger index) {
            [[ZUserHelper sharedHelper] checkLogin:^{
                if (index == 8) {
                    routePushVC(ZRoute_mine_diyScan, nil, nil);
                }else{
                    if (index == 1) {
                        routePushVC(ZRoute_mine_setting, nil, nil);
                    }else if (index == 3){
                        routePushVC(ZRoute_mine_switchRole, nil, nil);
                    }else if (index == 8){
                        routePushVC(ZRoute_mine_diyScan, nil, nil);
                    }else if(index == 10){
                        routePushVC(ZRoute_mine_settingMineUs, nil, nil);
                    }else if(index == 12){
                        routePushVC(ZRoute_mine_rewardCenter, nil, nil);
                    }
                }
            }];
        };
    }
    return _headerView;
}


#pragma mark - tableView -------datasource-----
- (void)zz_tableView:(UITableView *)tableView cell:(UITableViewCell *)cell cellForRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
    
    if ([cellConfig.title isEqualToString:@"ZTableViewListCell"]){
        ZTableViewListCell *lcell = (ZTableViewListCell *)cell;
        lcell.handleBlock = ^(ZCellConfig *scellConfig) {
            [[ZUserHelper sharedHelper] checkLogin:^{
                if ([scellConfig.title isEqualToString:@"eva"]) {
                    routePushVC(ZRoute_mine_teacherEvaList, nil, nil);
                }else if ([scellConfig.title isEqualToString:@"sign"]) {
                    routePushVC(ZRoute_mine_teacherSignList, nil, nil);
                }else if ([scellConfig.title isEqualToString:@"ZTeacherMineEntryStoresCell"]) {
                    ZOriganizationDetailModel *detailModel = scellConfig.dataModel;
                    
                    routePushVC(ZRoute_main_organizationDetail, @{@"id":detailModel.stores_id}, nil);
                }else if ([scellConfig.title isEqualToString:@"form"]) {
                    routePushVC(ZRoute_mine_classReportForm, nil, nil);
                }
                
            }];
        };
    }else if ([cellConfig.title isEqualToString:@"ZStudentMineLessonTimetableCell"]){
        ZStudentMineLessonTimetableCell *tcell = (ZStudentMineLessonTimetableCell *)cell;
        tcell.moreBlock = ^(NSInteger index) {
            routePushVC(ZRoute_mine_teacherDetailList, nil, nil);
        };
        tcell.handleBlock = ^(ZOriganizationLessonListModel * model) {
            routePushVC(ZRoute_mine_teacherClassDetail, @{@"id":SafeStr(model.courses_class_id)}, nil);
        };
    }else if ([cellConfig.title isEqualToString:@"ZStudentMineLessonNoTimetableCell"]){
        ZStudentMineLessonNoTimetableCell *tcell = (ZStudentMineLessonNoTimetableCell *)cell;
        tcell.moreBlock = ^(NSInteger index) {
            routePushVC(ZRoute_mine_teacherDetailList, nil, nil);
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
                         @[isDarkModel() ? @"eva_teacher_dark":@"eva_teacher",@"eva", @"我的评价", @"rightBlackArrowN"],
    @[isDarkModel() ? @"classForm":@"classForm",@"form", @"班级报表", @"rightBlackArrowN"]];
    
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
 
    if (_lessonList.count > 0) {
        ZCellConfig *timeCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentMineLessonTimetableCell className] title:[ZStudentMineLessonTimetableCell className] showInfoMethod:@selector(setList:) heightOfCell:[ZStudentMineLessonTimetableCell z_getCellHeight:_lessonList] cellType:ZCellTypeClass dataModel:_lessonList];
        [self.cellConfigArr addObject:timeCellConfig];
    }else {
        ZCellConfig *timeCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentMineLessonNoTimetableCell className] title:[ZStudentMineLessonNoTimetableCell className] showInfoMethod:nil heightOfCell:[ZStudentMineLessonNoTimetableCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:nil];
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
            [weakSelf.headerView updateData];
            [weakSelf.headerView updateSubViewFrame];
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.iTableView end_xjj_refresh];
        });
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
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.iTableView end_xjj_refresh];
        });
    }];
}

- (void)updateNetData {
    [self.iTableView begin_xjj_refresh];
}

- (void)updateTableNetData {
    __weak typeof(self) weakSelf = self;
    [self getStoresStatistical];
    [self refreshCurriculumList];
    if ([ZUserHelper sharedHelper].user) {
        [[ZUserHelper sharedHelper] updateUserInfoWithCompleteBlock:^(BOOL isSuccess) {
            if (!isSuccess) {
                
            }else{
                [weakSelf.headerView updateData];
                [weakSelf.headerView updateSubViewFrame];
            }
        }];
    }
}
@end
