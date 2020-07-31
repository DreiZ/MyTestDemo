//
//  ZStudentOrganizationDetailDesVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/8.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentOrganizationDetailDesVC.h"
#import "ZStudentEvaListCell.h"
#import "ZStudentTitleStarCell.h"
#import "ZStudentOrganizationDetailIntroCell.h"
#import "ZStudentOrganizationLessonListCell.h"
#import "ZStudentOrganizationPersonnelMoreCell.h"
#import "ZStudentOrganizationPersonnelListCell.h"
#import "ZOrganizationDetailBottomView.h"
#import "ZStudentOrganizationBannerCell.h"
#import "ZStudentMainOrganizationExperienceCell.h"
#import "ZStudentMineSettingBottomCell.h"
#import "ZOrganizationNoDataCell.h"

#import "ZStudentOrganizationDetailIntroVC.h"

#import "ZStudentLessonSelectMainOrderView.h"
#import "ZStudentMainViewModel.h"
#import "ZOriganizationOrderViewModel.h"
#import "ZOriganizationCardViewModel.h"
#import "ZStudentCollectionViewModel.h"
#import "ZCouponListView.h"
#import "ZAlertMoreView.h"
#import <NSDate+YYAdd.h>
#import "ZUMengShareManager.h"
#import "ZPhoneAlertView.h"
#import "ZAlertStoreInfoView.h"

@interface ZStudentOrganizationDetailDesVC ()<UIScrollViewDelegate>
@property (nonatomic,strong) UIButton *navRightBtn;
@property (nonatomic,strong) UIButton *dynamicBtn;
@property (nonatomic,strong) ZOrganizationDetailBottomView *bottomView;
@property (nonatomic,strong) ZStudentLessonSelectMainOrderView *selectView;
@property (nonatomic,strong) ZStoresDetailModel *detailModel;
@property (nonatomic,strong) NSMutableDictionary *param;
@end

@implementation ZStudentOrganizationDetailDesVC

- (void)viewWillAppear:(BOOL)animated {
    self.zChain_block_setNotShouldDecompressImages(^{

    });
    
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self refreshDetailData];
    self.zChain_reload_Net();
}

- (void)viewDidLoad {
    [super viewDidLoad];

    __weak typeof(self) weakSelf = self;
    self.zChain_addLoadMoreFooter()
    .zChain_addEmptyDataDelegate()
    .zChain_resetMainView(^{
        weakSelf.isHidenNaviBar = NO;
        [self.navigationItem setTitle:self.listModel.name];
        [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:self.navRightBtn]];
        
        [self.view addSubview:self.bottomView];
        [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.view);
            make.height.mas_equalTo(CGFloatIn750(88) + safeAreaBottom());
        }];
        
        [self.view addSubview:self.dynamicBtn];
        [self.dynamicBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.view.mas_right).offset(-CGFloatIn750(30));
            make.width.height.mas_equalTo(CGFloatIn750(90));
            make.bottom.equalTo(self.bottomView.mas_top).offset(CGFloatIn750(-30));
        }];
        
        [self.iTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(self.view);
            make.bottom.equalTo(self.bottomView.mas_top);
        }];
    }).zChain_updateDataSource(^{
        self.loading = YES;
    }).zChain_block_setUpdateCellConfigData(^(void (^update)(NSMutableArray *)) {
        [weakSelf initCellConfigArr];
    }).zChain_block_setRefreshMoreNet(^{
        [weakSelf refreshMoreData];
    }).zChain_block_setRefreshHeaderNet(^{
        [weakSelf refreshData];
    }).zChain_block_setCellConfigForRowAtIndexPath(^(UITableView *tableView, NSIndexPath *indexPath, UITableViewCell *cell, ZCellConfig *cellConfig) {
        if([cellConfig.title isEqualToString:@"ZStudentOrganizationBannerCell"]){
               ZStudentOrganizationBannerCell *lcell = (ZStudentOrganizationBannerCell *)cell;
               lcell.bannerBlock = ^(ZImagesModel * model) {
                   ZStudentOrganizationDetailIntroVC *ivc = [[ZStudentOrganizationDetailIntroVC alloc] initWithTitle:weakSelf.detailModel.images_list];
                   ivc.imageModel = model;
                   ivc.detailModel = weakSelf.detailModel;
                   [weakSelf.navigationController pushViewController:ivc animated:YES];
               };
       }else if ([cellConfig.title isEqualToString:@"starStudent"]){
           ZStudentOrganizationPersonnelListCell *lcell = (ZStudentOrganizationPersonnelListCell *)cell;
           lcell.menuBlock = ^(ZStudentDetailPersonnelModel *model) {
               routePushVC(ZRoute_main_studentDetail, model.account_id, nil);
           };
    
       }else if ([cellConfig.title isEqualToString:@"starCoach"]){
           ZStudentOrganizationPersonnelListCell *lcell = (ZStudentOrganizationPersonnelListCell *)cell;
           lcell.menuBlock = ^(ZStudentDetailPersonnelModel *model) {
               routePushVC(ZRoute_main_teacherDetail, @{@"teacher_id":SafeStr(model.account_id),@"stores_id":SafeStr(weakSelf.detailModel.schoolID)}, nil);
           };
       }else if ([cellConfig.title isEqualToString:@"ZStudentOrganizationDetailIntroCell"]){
           ZStudentOrganizationDetailIntroCell *lcell = (ZStudentOrganizationDetailIntroCell *)cell;
           lcell.handleBlock = ^(NSInteger index) {
               if (index == 1) {
                   routePushVC(ZRoute_main_mapAddress, weakSelf.detailModel, nil);
               }else if (index == 2){
                   [ZCouponListView setAlertWithTitle:@"领取优惠券" type:@"school" stores_id:weakSelf.detailModel.schoolID course_id:nil teacher_id:nil handlerBlock:^(ZOriganizationCardListModel * model) {
                       [[ZUserHelper sharedHelper] checkLogin:^{
                           if ([model.received intValue] == 1) {
                               [ZOriganizationCardViewModel receiveCoupons:@{@"stores_id":SafeStr(weakSelf.detailModel.schoolID),@"coupons_id":SafeStr(model.couponsID)} completeBlock:^(BOOL isSuccess, id data) {
                                   if (isSuccess) {
                                       [[ZCouponListView sharedManager] refreshData];
                                       [TLUIUtility showSuccessHint:data];
                                   }else{
                                       [TLUIUtility showErrorHint:data];
                                   }
                               }];
                           }
                       }];
                   }];
               }else if (index == 3){
                   [ZAlertStoreInfoView setAlertName:@"校区简介" data:weakSelf.detailModel.info];
               }else if (index == 4){
                   NSString *time = @"音乐月份：全年";
                   if (ValidArray(weakSelf.detailModel.months)) {
                       if (weakSelf.detailModel.months.count == 12) {
                           time = @"营业月份：全年";
                       }else{
                           time = @"营业月份:";
                           for (int i = 0; i < weakSelf.detailModel.months.count; i++) {
                               if (i == 0) {
                                   time = [NSString stringWithFormat:@"%@ %@月",time,weakSelf.detailModel.months[i]];
                               }else{
                                   time = [NSString stringWithFormat:@"%@, %@月",time,weakSelf.detailModel.months[i]];
                               }
                           }
                       }
                   }
                   
                   if (ValidArray(weakSelf.detailModel.week_days)) {
                       if (weakSelf.detailModel.week_days.count == 7) {
                           time = [NSString stringWithFormat:@"%@\n%@月",time,@"星期一~星期天"];
                       }else{
                           for (int i = 0; i < weakSelf.detailModel.week_days.count; i++) {
                               if (i == 0) {
                                   time = [NSString stringWithFormat:@"%@\n%@",time,[weakSelf.detailModel.week_days[i] zz_indexToWeek]];
                               }else{
                                   time = [NSString stringWithFormat:@"%@, %@",time,[weakSelf.detailModel.week_days[i] zz_indexToWeek]];
                               }
                           }
                       }
                   }
                   time = [NSString stringWithFormat:@"%@\n%@~%@",time,weakSelf.detailModel.opend_start,weakSelf.detailModel.opend_end];
                   [ZAlertStoreInfoView setAlertName:@"营业时间" data:time];
               }
           };
       }else if([cellConfig.title isEqualToString:[ZStudentMainOrganizationExperienceCell className]]){
           ZStudentMainOrganizationExperienceCell *lcell = (ZStudentMainOrganizationExperienceCell *)cell;
           lcell.lessonBlock = ^(ZOriganizationLessonListModel *model) {
               routePushVC(ZRoute_main_orderLessonDetail, model, nil);
           };
       }else if ([cellConfig.title isEqualToString:@"allLesson"]){
           ZStudentMineSettingBottomCell *lcell = (ZStudentMineSettingBottomCell *)cell;
           lcell.titleLabel.font = [UIFont fontSmall];
       }else if([cellConfig.title isEqualToString:@"evaTitle"]){
           ZStudentTitleStarCell *lcell = (ZStudentTitleStarCell *)cell;
           lcell.score = @"3";
       }
    }).zChain_block_setConfigDidSelectRowAtIndexPath(^(UITableView *tableView, NSIndexPath *indexPath, ZCellConfig *cellConfig) {
        if ([cellConfig.title isEqualToString:@"ZStudentOrganizationLessonListCell"]) {
            routePushVC(ZRoute_main_orderLessonDetail, cellConfig.dataModel, nil);
        }else if ([cellConfig.title isEqualToString:@"moreStarStudent"]){
            routePushVC(ZRoute_main_starStudentList, @{@"type":@"0", @"stores_id":weakSelf.listModel.stores_id}, nil);
        }else if ([cellConfig.title isEqualToString:@"moreStarCoach"]){
            routePushVC(ZRoute_main_starStudentList, @{@"type":@"1", @"stores_id":weakSelf.listModel.stores_id}, nil);
        }else if ([cellConfig.title isEqualToString:@"allLesson"]){
            routePushVC(ZRoute_main_lessonList, weakSelf.detailModel, nil);
        }else if ([cellConfig.title isEqualToString:@"allExperienceLesson"]){
            routePushVC(ZRoute_main_orderLessonList, weakSelf.detailModel.schoolID, nil);
        }
        
    });
}

#pragma mark - lazy loading
-(ZOrganizationDetailBottomView *)bottomView {
    if (!_bottomView) {
        __weak typeof(self) weakSelf = self;
        _bottomView = [[ZOrganizationDetailBottomView alloc] init];
        _bottomView.handleBlock = ^(NSInteger index) {
            if (index == 0) {
                [ZPhoneAlertView setAlertName:@"联系我时，请说是在似锦APP看到的，谢谢！"  tel:SafeStr(weakSelf.detailModel.phone) handlerBlock:^(NSInteger index) {
                    if (index == 1) {
//                        [ZPublicTool callTel:SafeStr(weakSelf.detailModel.phone)];
                    }
                }];
            }else if (index == 2){
                [[ZUserHelper sharedHelper] checkLogin:^{
                    if ([weakSelf.detailModel.collection intValue] == 1) {
                        [weakSelf collectionStore:NO];
                    }else{
                        [weakSelf collectionStore:YES];
                    }
                }];
            }else {
                [[ZUserHelper sharedHelper] checkLogin:^{
                    [weakSelf.selectView showSelectViewWithModel:weakSelf.detailModel];
                }];
            }
        };
    }
    return _bottomView;
}

- (ZStudentLessonSelectMainOrderView *)selectView {
    if (!_selectView) {
        __weak typeof(self) weakSelf = self;
        _selectView = [[ZStudentLessonSelectMainOrderView alloc] init];
        _selectView.completeBlock = ^(ZOriganizationLessonListModel *lessonModel, ZOriganizationLessonExperienceTimeModel *timeModel) {
            ZOrderDetailModel *detailModel = [[ZOrderDetailModel alloc] init];
            detailModel.order_type = ZStudentOrderTypeForPay;
            detailModel.course_id = lessonModel.lessonID;
            detailModel.stores_id = weakSelf.detailModel.schoolID;
            detailModel.store_name = weakSelf.detailModel.name;
            detailModel.course_name = lessonModel.name;
            detailModel.pay_amount = lessonModel.experience_price;
            detailModel.order_amount = lessonModel.experience_price;
            detailModel.experience_price = lessonModel.experience_price;
            detailModel.experience_duration = lessonModel.experience_duration;
            detailModel.course_image_url = weakSelf.detailModel.image;
            NSDate *date = [[NSDate alloc] initWithTimeIntervalSince1970:[timeModel.date doubleValue]];
            NSString *time = [NSString stringWithFormat:@"%lu-%lu-%lu %@",(unsigned long)date.year,date.month,date.day,timeModel.time];
            detailModel.schedule_time = [NSString stringWithFormat:@"%f",[[NSDate dateWithString:time format:@"yyyy-MM-dd HH:mm"] timeIntervalSince1970]];
//            order.detailModel = detailModel;
            detailModel.type = @"1";
            
            routePushVC(ZRoute_main_subSureOrder, detailModel, nil);
        };
    }
    return _selectView;
}


- (UIButton *)navRightBtn {
    if (!_navRightBtn) {
        __weak typeof(self) weakSelf = self;
        _navRightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, CGFloatIn750(90), CGFloatIn750(50))];
        [_navRightBtn setTitle:@"..." forState:UIControlStateNormal];
        [_navRightBtn setTitleColor:adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]) forState:UIControlStateNormal];
        [_navRightBtn.titleLabel setFont:[UIFont boldFontMax2Title]];
        [_navRightBtn bk_addEventHandler:^(id sender) {
            NSArray *weekArr = @[@[@"分享",@"peoples_hint",@"share"],@[@"举报",@"peoples_hint",@"report"]];
//            NSArray *weekArr = @[@[@"举报",@"peoples_hint",@"report"]];
            [ZAlertMoreView setMoreAlertWithTitleArr:weekArr handlerBlock:^(NSString *index) {
                if ([index isEqualToString:@"report"]) {
                    [[ZUserHelper sharedHelper] checkLogin:^{
                        routePushVC(ZRoute_main_report, @{@"sTitle":SafeStr(weakSelf.detailModel.name),@"stores_id":SafeStr(weakSelf.detailModel.schoolID)}, nil);
                    }];
                }else{
                    routePushVC(ZRoute_main_organizationShare, weakSelf.detailModel, nil);
                }
            }];
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _navRightBtn;
}


- (UIButton *)dynamicBtn {
    if (!_dynamicBtn) {
        __weak typeof(self) weakSelf = self;
        _dynamicBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, CGFloatIn750(90), CGFloatIn750(90))];
        [_dynamicBtn setImage:[UIImage imageNamed:@"schoolDynamic"] forState:UIControlStateNormal];
        [_dynamicBtn bk_addEventHandler:^(id sender) {
            routePushVC(ZRoute_circle_recommend, @{@"stores_id":SafeStr(weakSelf.detailModel.schoolID),@"stores_name":SafeStr(weakSelf.detailModel.name)}, nil);
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _dynamicBtn;
}


- (NSMutableDictionary *)param {
    if (!_param) {
        _param = @{}.mutableCopy;
    }
    return _param;
}

- (void)initCellConfigArr {
    [self.cellConfigArr removeAllObjects];
    
    ZCellConfig *bannerCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentOrganizationBannerCell className] title:[ZStudentOrganizationBannerCell className] showInfoMethod:@selector(setImages_list:) heightOfCell:[ZStudentOrganizationBannerCell z_getCellHeight:self.detailModel.images_list] cellType:ZCellTypeClass dataModel:self.detailModel.images_list];
    [self.cellConfigArr addObject:bannerCellConfig];
    
    ZCellConfig *desCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentOrganizationDetailIntroCell className] title:[ZStudentOrganizationDetailIntroCell className] showInfoMethod:@selector(setModel:) heightOfCell:[ZStudentOrganizationDetailIntroCell z_getCellHeight:self.detailModel] cellType:ZCellTypeClass dataModel:self.detailModel];
    [self.cellConfigArr addObject:desCellConfig];
    {
        [self.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(20))];
        ZStudentDetailOrderSubmitListModel *model = [[ZStudentDetailOrderSubmitListModel alloc] init];
        model.leftTitle = @"体验课程";
        model.rightTitle = @"更多体验课程";
        model.cellTitle = @"allExperienceLesson";
        ZCellConfig *lessonMoreCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentOrganizationPersonnelMoreCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZStudentOrganizationPersonnelMoreCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:model];
        [self.cellConfigArr addObject:lessonMoreCellConfig];
    }
    if (ValidArray(self.detailModel.appointment_courses)) {
        
        ZCellConfig *lessonCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentMainOrganizationExperienceCell className] title:[ZStudentMainOrganizationExperienceCell className] showInfoMethod:@selector(setAppointment_courses:) heightOfCell:[ZStudentMainOrganizationExperienceCell z_getCellHeight:self.detailModel.appointment_courses] cellType:ZCellTypeClass dataModel:self.detailModel.appointment_courses];
        [self.cellConfigArr addObject:lessonCellConfig];
    }else{
        ZCellConfig *coachCellConfig = [ZCellConfig cellConfigWithClassName:[ZOrganizationNoDataCell className] title:@"ZOrganizationNoDataCell" showInfoMethod:@selector(setType:) heightOfCell:[ZOrganizationNoDataCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:@"1"];
        [self.cellConfigArr addObject:coachCellConfig];
    }
    
    {
        [self.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(20))];
        ZLineCellModel *model = ZLineCellModel.zz_lineCellModel_create(@"type")
        .zz_titleLeft(@"热门课程")
        .zz_fontLeft([UIFont boldFontTitle])
        .zz_lineHidden(YES)
        .zz_cellHeight(CGFloatIn750(50));
        
        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZBaseLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZBaseLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];

        [self.cellConfigArr addObject:menuCellConfig];
        if (ValidArray(self.detailModel.courses_list)) {
            for (int i = 0; i < self.detailModel.courses_list.count; i++) {
                ZCellConfig *lessonCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentOrganizationLessonListCell className] title:[ZStudentOrganizationLessonListCell className] showInfoMethod:@selector(setModel:) heightOfCell:[ZStudentOrganizationLessonListCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:self.detailModel.courses_list[i]];
                [self.cellConfigArr addObject:lessonCellConfig];
            }
            ZCellConfig *allLessonCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentMineSettingBottomCell className] title:@"allLesson" showInfoMethod:@selector(setTitle:) heightOfCell:CGFloatIn750(70) cellType:ZCellTypeClass dataModel:@"全部课程 >"];
            [self.cellConfigArr addObject:allLessonCellConfig];
            [self.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(10))];
        }else{
            ZCellConfig *coachCellConfig = [ZCellConfig cellConfigWithClassName:[ZOrganizationNoDataCell className] title:@"ZOrganizationNoDataCell" showInfoMethod:@selector(setType:) heightOfCell:[ZOrganizationNoDataCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:@"1"];
            [self.cellConfigArr addObject:coachCellConfig];
        }
    
        
        {
            [self.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(20))];

            ZStudentDetailOrderSubmitListModel *moreModel = [[ZStudentDetailOrderSubmitListModel alloc] init];
            moreModel.leftTitle = @"教师团队";
            ZCellConfig *lessonMoreCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentOrganizationPersonnelMoreCell className] title:@"moreStarCoach" showInfoMethod:@selector(setModel:) heightOfCell:[ZStudentOrganizationPersonnelMoreCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:moreModel];
            [self.cellConfigArr addObject:lessonMoreCellConfig];
            
            if (self.detailModel.teacher_list && self.detailModel.teacher_list.count > 0){
                NSMutableArray *peoples = @[].mutableCopy;
                for (int i = 0; i < self.detailModel.teacher_list.count; i++) {
                    ZOriganizationTeacherListModel *teacherModel = self.detailModel.teacher_list[i];
                    ZStudentDetailPersonnelModel *model = [[ZStudentDetailPersonnelModel alloc] init];
                    model.account_id = teacherModel.teacherID;
                    model.image = teacherModel.image;
                    model.name = teacherModel.nick_name;
//                    model.skill = [teacherModel.c_level intValue] == 1 ? @"普通教师":@"明星教师";
                    model.position = teacherModel.position;
                    model.data = teacherModel;
                    [peoples addObject:model];
                }
                
                ZCellConfig *coachCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentOrganizationPersonnelListCell className] title:@"starCoach" showInfoMethod:@selector(setPeopleslList:) heightOfCell:[ZStudentOrganizationPersonnelListCell z_getCellHeight:peoples] cellType:ZCellTypeClass dataModel:peoples];
                [self.cellConfigArr addObject:coachCellConfig];
            }else{
                ZCellConfig *coachCellConfig = [ZCellConfig cellConfigWithClassName:[ZOrganizationNoDataCell className] title:@"ZOrganizationNoDataCell" showInfoMethod:@selector(setType:) heightOfCell:[ZOrganizationNoDataCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:@"2"];
                [self.cellConfigArr addObject:coachCellConfig];
            }
        }
        
        if (self.detailModel.star_students && self.detailModel.star_students.count > 0) {
            [self.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(20))];
            
            ZStudentDetailOrderSubmitListModel *moreModel = [[ZStudentDetailOrderSubmitListModel alloc] init];
            moreModel.leftTitle = @"明星学员";
            ZCellConfig *lessonMoreCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentOrganizationPersonnelMoreCell className] title:@"moreStarStudent" showInfoMethod:@selector(setModel:) heightOfCell:[ZStudentOrganizationPersonnelMoreCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:moreModel];
            [self.cellConfigArr addObject:lessonMoreCellConfig];
            
            NSMutableArray *peoples = @[].mutableCopy;
            for (int i = 0; i < self.detailModel.star_students.count; i++) {
                ZOriganizationTeacherListModel *teacherModel = self.detailModel.star_students[i];
                ZStudentDetailPersonnelModel *model = [[ZStudentDetailPersonnelModel alloc] init];
                model.account_id = teacherModel.teacherID;
                model.image = teacherModel.image;
                model.name = teacherModel.name;
                model.position = teacherModel.stores_courses_name;
                model.data = teacherModel;
                [peoples addObject:model];
            }
            
            ZCellConfig *coachCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentOrganizationPersonnelListCell className] title:@"starStudent" showInfoMethod:@selector(setPeopleslList:) heightOfCell:[ZStudentOrganizationPersonnelListCell z_getCellHeight:peoples] cellType:ZCellTypeClass dataModel:peoples];
            [self.cellConfigArr addObject:coachCellConfig];
        }
        
        {
            [self.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(20))];
            ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentTitleStarCell className] title:@"evaTitle" showInfoMethod:@selector(setTitle:) heightOfCell:CGFloatIn750(50) cellType:ZCellTypeClass dataModel:@"校区评价"];
            [self.cellConfigArr addObject:menuCellConfig];
            
        }
        
        if (self.dataSources.count > 0) {
            for (ZOrderEvaListModel *evaModel in self.dataSources) {
                ZCellConfig *evaCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentEvaListCell className] title:[ZStudentEvaListCell className] showInfoMethod:@selector(setModel:) heightOfCell:[ZStudentEvaListCell z_getCellHeight:evaModel] cellType:ZCellTypeClass dataModel:evaModel];
                [self.cellConfigArr addObject:evaCellConfig];
                [self.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(20))];
            }
        }else{
            ZCellConfig *coachCellConfig = [ZCellConfig cellConfigWithClassName:[ZOrganizationNoDataCell className] title:@"ZOrganizationNoDataCell" showInfoMethod:@selector(setType:) heightOfCell:[ZOrganizationNoDataCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:@"3"];
            [self.cellConfigArr addObject:coachCellConfig];
        }
    }
    _bottomView.isBuy = NO;
    _bottomView.isCollection = [self.detailModel.collection intValue] == 1 ? YES:NO;
}

#pragma mark - refresha
- (void)refreshDetailData {
    __weak typeof(self) weakSelf = self;
    [ZStudentMainViewModel getStoresDetail:@{@"stores_id":SafeStr(self.listModel.stores_id)} completeBlock:^(BOOL isSuccess, id data) {
        weakSelf.loading = NO;
        if (isSuccess) {
            weakSelf.detailModel = data;
            [weakSelf initCellConfigArr];
            [weakSelf.iTableView reloadData];
        }else{
            [TLUIUtility showErrorHint:data];
        }
    }];
}

#pragma mark - 数据处理
- (void)refreshData {
    self.currentPage = 1;
    self.loading = YES;
    [self setPostCommonData];
    [self refreshHeadData:_param];
}

- (void)refreshHeadData:(NSDictionary *)param {
    __weak typeof(self) weakSelf = self;
    [ZOriganizationOrderViewModel getMerchantsCommentListList:param completeBlock:^(BOOL isSuccess, ZOrderEvaListNetModel *data) {
        weakSelf.loading = NO;
        if (isSuccess && data) {
            [weakSelf.dataSources removeAllObjects];
            [weakSelf.dataSources addObjectsFromArray:data.list];
            [weakSelf initCellConfigArr];
            [weakSelf.iTableView reloadData];
            
            [weakSelf.iTableView tt_endRefreshing];
            if (data && [data.total integerValue] <= weakSelf.currentPage * 10) {
                [weakSelf.iTableView tt_removeLoadMoreFooter];
            }else{
                [weakSelf.iTableView tt_endLoadMore];
            }
        }else{
            [weakSelf.iTableView reloadData];
            [weakSelf.iTableView tt_endRefreshing];
            [weakSelf.iTableView tt_removeLoadMoreFooter];
        }
    }];
}

- (void)refreshMoreData {
    self.currentPage++;
    self.loading = YES;
    [self setPostCommonData];
    
    __weak typeof(self) weakSelf = self;
    [ZOriganizationOrderViewModel getMerchantsCommentListList:self.param completeBlock:^(BOOL isSuccess, ZOrderEvaListNetModel *data) {
        weakSelf.loading = NO;
        if (isSuccess && data) {
            [weakSelf.dataSources addObjectsFromArray:data.list];
            [weakSelf initCellConfigArr];
            [weakSelf.iTableView reloadData];
            
            [weakSelf.iTableView tt_endRefreshing];
            if (data && [data.total integerValue] <= weakSelf.currentPage * 10) {
                [weakSelf.iTableView tt_removeLoadMoreFooter];
            }else{
                [weakSelf.iTableView tt_endLoadMore];
            }
        }else{
            [weakSelf.iTableView reloadData];
            [weakSelf.iTableView tt_endRefreshing];
            [weakSelf.iTableView tt_removeLoadMoreFooter];
        }
    }];
}

- (void)refreshAllData {
    self.loading = YES;
    
    [self setPostCommonData];
    [_param setObject:@"1" forKey:@"page"];
    [_param setObject:[NSString stringWithFormat:@"%ld",self.currentPage * 10] forKey:@"page_size"];
    
    [self refreshHeadData:_param];
}

- (void)setPostCommonData {
    [self.param setObject:[NSString stringWithFormat:@"%ld",self.currentPage] forKey:@"page"];
    [self.param setObject:self.listModel.stores_id forKey:@"stores_id"];
}


- (void)collectionStore:(BOOL)isCollection {
    [TLUIUtility showLoading:@""];
    __weak typeof(self) weakSelf = self;
    [ZStudentCollectionViewModel collectionStore:@{@"store":SafeStr(self.detailModel.schoolID),@"type":isCollection ? @"1":@"2"} completeBlock:^(BOOL isSuccess, id data) {
        [TLUIUtility hiddenLoading];
        if (isSuccess) {
            if ([weakSelf.detailModel.collection intValue] == 1) {
                weakSelf.detailModel.collection = @"0";
            }else{
                weakSelf.detailModel.collection = @"1";
            }
            weakSelf.bottomView.isCollection = [weakSelf.detailModel.collection intValue] == 1 ? YES:NO;
            [TLUIUtility showSuccessHint:data];
        }else{
            [TLUIUtility showInfoHint:data];
        }
    }];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    DLog(@"begin && scrollViewWillBeginDragging");
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [self.dynamicBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view.mas_right).offset(-CGFloatIn750(30));
            make.width.height.mas_equalTo(CGFloatIn750(90));
            make.bottom.equalTo(self.bottomView.mas_top).offset(CGFloatIn750(-30));
        }];
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        
    }];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    DLog(@"end && scrollViewDidEndDecelerating");
    [UIView animateWithDuration:0.8 delay:0.5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [self.dynamicBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.view.mas_right).offset(-CGFloatIn750(30));
            make.width.height.mas_equalTo(CGFloatIn750(90));
            make.bottom.equalTo(self.bottomView.mas_top).offset(CGFloatIn750(-30));
        }];
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        
    }];
}
@end

#pragma mark - RouteHandler
@interface ZStudentOrganizationDetailDesVC (RouteHandler)<SJRouteHandler>

@end

@implementation ZStudentOrganizationDetailDesVC (RouteHandler)

+ (NSString *)routePath {
    return ZRoute_main_organizationDetail;
}

+ (void)handleRequest:(SJRouteRequest *)request topViewController:(UIViewController *)topViewController completionHandler:(SJCompletionHandler)completionHandler {
    ZStudentOrganizationDetailDesVC *routevc = [[ZStudentOrganizationDetailDesVC alloc] init];
    routevc.listModel = request.prts;
    [topViewController.navigationController pushViewController:routevc animated:YES];
}
@end
