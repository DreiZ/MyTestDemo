//
//  ZStudentOrganizationDetailDesVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/8.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentOrganizationDetailDesVC.h"
#import "ZStudentEvaListCell.h"

#import "ZStudentOrganizationDetailIntroCell.h"
#import "ZStudentOrganizationLessonListCell.h"
#import "ZStudentOrganizationPersonnelMoreCell.h"
#import "ZStudentOrganizationPersonnelListCell.h"
#import "ZOrganizationDetailBottomView.h"
#import "ZStudentOrganizationBannerCell.h"

#import "ZStudentStarStudentListVC.h"

#import "ZStudentOrganizationDetailIntroVC.h"
#import "ZStudentOrganizationLessonListVC.h"
#import "ZStudentOrganizationMapAddressVC.h"
#import "ZStudentTeacherDetailVC.h"
#import "ZStudentStudentDetailVC.h"
#import "ZStudentLessonDetailVC.h"
#import "ZStudentLessonSubscribeSureOrderVC.h"
#import "ZOriganizationReportVC.h"

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

@interface ZStudentOrganizationDetailDesVC ()
@property (nonatomic,strong) UIButton *navRightBtn;

@property (nonatomic,strong) ZOrganizationDetailBottomView *bottomView;
@property (nonatomic,strong) ZStudentLessonSelectMainOrderView *selectView;
@property (nonatomic,strong) ZStoresDetailModel *detailModel;
@property (nonatomic,strong) NSMutableDictionary *param;
@end

@implementation ZStudentOrganizationDetailDesVC

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self refreshDetailData];
    [self refreshData];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.loading = YES;
    [self setTableViewRefreshFooter];
    [self setTableViewEmptyDataDelegate];
}

- (void)setupMainView {
    [super setupMainView];
    
    [self.view addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.mas_equalTo(CGFloatIn750(88) + safeAreaBottom());
    }];
    
    [self.iTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.bottom.equalTo(self.bottomView.mas_top);
    }];
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
            ZStudentLessonSubscribeSureOrderVC *order = [[ZStudentLessonSubscribeSureOrderVC alloc] init];
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
            order.detailModel = detailModel;
            [weakSelf.navigationController pushViewController:order animated:YES];
        };
    }
    return _selectView;
}


- (UIButton *)navRightBtn {
    if (!_navRightBtn) {
        __weak typeof(self) weakSelf = self;
        _navRightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, CGFloatIn750(90), CGFloatIn750(50))];
        [_navRightBtn setTitle:@"举报" forState:UIControlStateNormal];
        [_navRightBtn setTitleColor:adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]) forState:UIControlStateNormal];
        [_navRightBtn.titleLabel setFont:[UIFont fontContent]];
        [_navRightBtn bk_addEventHandler:^(id sender) {
            [[ZUserHelper sharedHelper] checkLogin:^{
                ZOriganizationReportVC *rvc = [[ZOriganizationReportVC alloc] init];
                rvc.sTitle = self.detailModel.name;
                rvc.stores_id = self.detailModel.schoolID;
                [weakSelf.navigationController pushViewController:rvc animated:rvc];
            }];
//            NSArray *weekArr = @[@[@"分享",@"peoples_hint",@"share"],@[@"举报",@"peoples_hint",@"report"]];
//            NSArray *weekArr = @[@[@"举报",@"peoples_hint",@"report"]];
//            [ZAlertMoreView setMoreAlertWithTitleArr:weekArr handlerBlock:^(NSString *index) {
//                if ([index isEqualToString:@"report"]) {
//                    ZOriganizationReportVC *rvc = [[ZOriganizationReportVC alloc] init];
//                    rvc.sTitle = self.detailModel.name;
//                    rvc.stores_id = self.detailModel.schoolID;
//                    [weakSelf.navigationController pushViewController:rvc animated:rvc];
//                }else{
//                    [[ZUMengShareManager sharedManager] shareUIWithType:1 Title:@"似锦" detail:@"测试" image:[UIImage imageNamed:@"logo"] url:@"www.baidu.com" vc:self];
//                }
//            }];
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _navRightBtn;
}

- (NSMutableDictionary *)param {
    if (!_param) {
        _param = @{}.mutableCopy;
    }
    return _param;
}

#pragma mark - set cell config
- (void)setNavigation {
    self.isHidenNaviBar = NO;
    [self.navigationItem setTitle:self.listModel.name];
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:self.navRightBtn]];
}


- (void)initCellConfigArr {
    [super initCellConfigArr];
    
    {
        ZCellConfig *bannerCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentOrganizationBannerCell className] title:[ZStudentOrganizationBannerCell className] showInfoMethod:@selector(setImages_list:) heightOfCell:[ZStudentOrganizationBannerCell z_getCellHeight:self.detailModel.images_list] cellType:ZCellTypeClass dataModel:self.detailModel.images_list];
        [self.cellConfigArr addObject:bannerCellConfig];
        
    }
    
    
    ZCellConfig *desCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentOrganizationDetailIntroCell className] title:[ZStudentOrganizationDetailIntroCell className] showInfoMethod:@selector(setModel:) heightOfCell:[ZStudentOrganizationDetailIntroCell z_getCellHeight:self.detailModel] cellType:ZCellTypeClass dataModel:self.detailModel];
    [self.cellConfigArr addObject:desCellConfig];
    
    if (self.detailModel.teacher_list && self.detailModel.teacher_list.count > 0) {
        [self.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(20))];
//        [self.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(20))];
        ZStudentDetailOrderSubmitListModel *moreModel = [[ZStudentDetailOrderSubmitListModel alloc] init];
        moreModel.leftTitle = @"教师团队";
        ZCellConfig *lessonMoreCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentOrganizationPersonnelMoreCell className] title:@"moreStarCoach" showInfoMethod:@selector(setModel:) heightOfCell:[ZStudentOrganizationPersonnelMoreCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:moreModel];
        [self.cellConfigArr addObject:lessonMoreCellConfig];
        
        
        NSMutableArray *peoples = @[].mutableCopy;
        for (int i = 0; i < self.detailModel.teacher_list.count; i++) {
            ZOriganizationTeacherListModel *teacherModel = self.detailModel.teacher_list[i];
            ZStudentDetailPersonnelModel *model = [[ZStudentDetailPersonnelModel alloc] init];
            model.account_id = teacherModel.teacherID;
            model.image = teacherModel.image;
            model.name = teacherModel.nick_name;
            model.skill = [teacherModel.c_level intValue] == 1 ? @"普通教师":@"明星教师";
            model.data = teacherModel;
            [peoples addObject:model];
        }
        
        ZCellConfig *coachCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentOrganizationPersonnelListCell className] title:@"starCoach" showInfoMethod:@selector(setPeopleslList:) heightOfCell:[ZStudentOrganizationPersonnelListCell z_getCellHeight:peoples] cellType:ZCellTypeClass dataModel:peoples];
        [self.cellConfigArr addObject:coachCellConfig];
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
            model.skill = teacherModel.stores_courses_name;
            model.data = teacherModel;
            [peoples addObject:model];
        }
        
        ZCellConfig *coachCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentOrganizationPersonnelListCell className] title:@"starStudent" showInfoMethod:@selector(setPeopleslList:) heightOfCell:[ZStudentOrganizationPersonnelListCell z_getCellHeight:peoples] cellType:ZCellTypeClass dataModel:peoples];
        [self.cellConfigArr addObject:coachCellConfig];
    }
    
    {
        [self.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(20))];
        ZStudentDetailOrderSubmitListModel *model = [[ZStudentDetailOrderSubmitListModel alloc] init];
        model.leftTitle = @"热门课程";
        model.rightTitle = @"全部课程";
        model.cellTitle = @"allLesson";
        ZCellConfig *lessonMoreCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentOrganizationPersonnelMoreCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZStudentOrganizationPersonnelMoreCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:model];
        [self.cellConfigArr addObject:lessonMoreCellConfig];
        
        
        for (int i = 0; i < self.detailModel.courses_list.count; i++) {
            ZCellConfig *lessonCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentOrganizationLessonListCell className] title:[ZStudentOrganizationLessonListCell className] showInfoMethod:@selector(setModel:) heightOfCell:[ZStudentOrganizationLessonListCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:self.detailModel.courses_list[i]];
            [self.cellConfigArr addObject:lessonCellConfig];
        }
        
        if (self.dataSources.count > 0) {
            [self.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(20))];
            ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
            model.leftTitle = @"机构评价";
            model.leftFont = [UIFont boldFontTitle];
            model.cellHeight = CGFloatIn750(50);
            model.isHiddenLine = YES;
            
            ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
            [self.cellConfigArr addObject:menuCellConfig];
        }
        if (self.dataSources.count > 0) {
            for (ZOrderEvaListModel *evaModel in self.dataSources) {
                ZCellConfig *evaCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentEvaListCell className] title:[ZStudentEvaListCell className] showInfoMethod:@selector(setModel:) heightOfCell:[ZStudentEvaListCell z_getCellHeight:evaModel] cellType:ZCellTypeClass dataModel:evaModel];
                [self.cellConfigArr addObject:evaCellConfig];
                [self.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(20))];
            }
        }
    }
    
    _bottomView.isCollection = [self.detailModel.collection intValue] == 1 ? YES:NO;
}

#pragma mark - tableView -------datasource-----
- (void)zz_tableView:(UITableView *)tableView cell:(UITableViewCell *)cell cellForRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig
{
    __weak typeof(self) weakSelf = self;
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
            ZStudentStudentDetailVC *dvc = [[ZStudentStudentDetailVC alloc] init];
            dvc.student_id = model.account_id;
            [self.navigationController pushViewController:dvc animated:YES];
        };
 
    }else if ([cellConfig.title isEqualToString:@"starCoach"]){
        ZStudentOrganizationPersonnelListCell *lcell = (ZStudentOrganizationPersonnelListCell *)cell;
        lcell.menuBlock = ^(ZStudentDetailPersonnelModel *model) {
            ZStudentTeacherDetailVC *mvc = [[ZStudentTeacherDetailVC alloc] init];
            mvc.teacher_id = model.account_id;
            mvc.stores_id = weakSelf.detailModel.schoolID;
            [weakSelf.navigationController pushViewController:mvc animated:YES];
        };
    }else if ([cellConfig.title isEqualToString:@"ZStudentOrganizationDetailIntroCell"]){
        ZStudentOrganizationDetailIntroCell *lcell = (ZStudentOrganizationDetailIntroCell *)cell;
        lcell.handleBlock = ^(NSInteger index) {
            if (index == 1) {
                ZStudentOrganizationMapAddressVC *avc = [[ZStudentOrganizationMapAddressVC alloc] init];
                avc.detailModel = weakSelf.detailModel;
                [weakSelf.navigationController pushViewController:avc animated:YES];
            }else if (index == 2){
                [ZCouponListView setAlertWithTitle:@"领取优惠券" type:@"school" stores_id:self.detailModel.schoolID course_id:nil teacher_id:nil handlerBlock:^(ZOriganizationCardListModel * model) {
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
            }
        };
    }
}

- (void)zz_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
    if ([cellConfig.title isEqualToString:@"ZStudentOrganizationLessonListCell"]) {
        ZStudentLessonDetailVC *dvc = [[ZStudentLessonDetailVC alloc] init];
        dvc.model = cellConfig.dataModel;
        [self.navigationController pushViewController:dvc animated:YES];
    }else if ([cellConfig.title isEqualToString:@"moreStarStudent"]){
        ZStudentStarStudentListVC *lvc = [[ZStudentStarStudentListVC alloc] init];
        lvc.type = 0;
        lvc.stores_id = self.listModel.stores_id;
        [self.navigationController pushViewController:lvc animated:YES];
    }else if ([cellConfig.title isEqualToString:@"moreStarCoach"]){
        ZStudentStarStudentListVC *lvc = [[ZStudentStarStudentListVC alloc] init];
        lvc.type = 1;
        lvc.stores_id = self.listModel.stores_id;
        [self.navigationController pushViewController:lvc animated:YES];
    }else if ([cellConfig.title isEqualToString:@"allLesson"]){
        ZStudentOrganizationLessonListVC *lvc = [[ZStudentOrganizationLessonListVC alloc] init];
        lvc.detailModel = self.detailModel;
        [self.navigationController pushViewController:lvc animated:YES];
    }
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
@end
