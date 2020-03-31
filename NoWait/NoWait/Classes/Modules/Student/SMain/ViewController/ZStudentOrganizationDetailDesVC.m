//
//  ZStudentOrganizationDetailDesVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/8.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentOrganizationDetailDesVC.h"
#import "ZBaseUnitModel.h"
#import "ZStudentEvaListCell.h"

#import "ZStudentOrganizationDetailTopCell.h"
//#import "ZStudentOrganizationDetailBannerCell.h"
#import "ZStudentOrganizationDetailIntroCell.h"
#import "ZStudentOrganizationDetailDesCell.h"
#import "ZStudentOrganizationLessonListCell.h"
#import "ZStudentOrganizationPersonnelMoreCell.h"
#import "ZStudentOrganizationPersonnelListCell.h"
#import "ZOrganizationDetailBottomView.h"

#import "ZStudentOrganizationLessonDetailVC.h"
#import "ZStudentStarStudentListVC.h"
#import "ZStudentStarCoachListVC.h"
#import "ZStudentStarCoachInfoVC.h"
#import "ZStudentStarStudentInfoVC.h"

#import "ZStudentOrganizationDetailIntroVC.h"
#import "ZStudentOrganizationLessonListVC.h"
#import "ZStudentOrganizationMapAddressVC.h"
#import "ZStudentTeacherDetailVC.h"
#import "ZStudentStudentDetailVC.h"
#import "ZStudentLessonDetailVC.h"

#import "ZStudentLessonSureOrderVC.h"
#import "ZStudentLessonSubscribeSureOrderVC.h"

#import "ZOrganizationCouponListView.h"
#import "ZStudentLessonSelectMainOrderView.h"


#import "ZStudentMainViewModel.h"
#import "ZOriganizationOrderViewModel.h"
#import "ZOriganizationCardViewModel.h"
#import "ZCouponListView.h"

@interface ZStudentOrganizationDetailDesVC ()
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

-(ZOrganizationDetailBottomView *)bottomView {
    if (!_bottomView) {
        __weak typeof(self) weakSelf = self;
        _bottomView = [[ZOrganizationDetailBottomView alloc] init];
        _bottomView.handleBlock = ^(NSInteger index) {
            if (index == 0) {
                [ZPublicTool callTel:SafeStr(weakSelf.detailModel.phone)];
            }else{
                [weakSelf.selectView showSelectViewWithModel:weakSelf.detailModel];
            }
//             ZStudentLessonSubscribeSureOrderVC *order = [[ZStudentLessonSubscribeSureOrderVC alloc] init];
//                        [weakSelf.navigationController pushViewController:order animated:YES];
            //
//            ZStudentLessonSureOrderVC *order = [[ZStudentLessonSureOrderVC alloc] init];
//            [weakSelf.navigationController pushViewController:order animated:YES];
        };
    }
    return _bottomView;
}

- (ZStudentLessonSelectMainOrderView *)selectView {
    if (!_selectView) {
        __weak typeof(self) weakSelf = self;
        _selectView = [[ZStudentLessonSelectMainOrderView alloc] init];
        _selectView.completeBlock = ^(ZOrderAddModel *model) {
            ZStudentLessonSubscribeSureOrderVC *order = [[ZStudentLessonSubscribeSureOrderVC alloc] init];
            [weakSelf.navigationController pushViewController:order animated:YES];
//
//            ZStudentLessonSureOrderVC *order = [[ZStudentLessonSureOrderVC alloc] init];
//            [weakSelf.navigationController pushViewController:order animated:YES];
//            if (type == ZLessonBuyTypeBuyInitial || type == ZLessonBuyTypeBuyBeginLesson) {
//                ZStudentLessonSureOrderVC *order = [[ZStudentLessonSureOrderVC alloc] init];
//                [weakSelf.navigationController pushViewController:order animated:YES];
//            }else{
//                ZStudentLessonSubscribeSureOrderVC *order = [[ZStudentLessonSubscribeSureOrderVC alloc] init];
//                [weakSelf.navigationController pushViewController:order animated:YES];
//            }
        };
    }
    return _selectView;
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
}


- (void)initCellConfigArr {
    [super initCellConfigArr];
    
    NSMutableArray *mList = @[].mutableCopy;
    for (int i = 0; i < self.detailModel.images_list.count; i ++) {
        ZImagesModel *imageModel = self.detailModel.images_list[i];
        ZBaseUnitModel *model = [[ZBaseUnitModel alloc] init];
        model.name = imageModel.name;
        model.imageName = imageModel.image;
        model.data = imageModel;
        [mList addObject:model];
    }
    ZCellConfig *bannerCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentOrganizationDetailTopCell className] title:[ZStudentOrganizationDetailTopCell className] showInfoMethod:@selector(setList:) heightOfCell:[ZStudentOrganizationDetailTopCell z_getCellHeight:mList] cellType:ZCellTypeClass dataModel:mList];
    [self.cellConfigArr addObject:bannerCellConfig];
    
    
    ZCellConfig *desCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentOrganizationDetailIntroCell className] title:[ZStudentOrganizationDetailIntroCell className] showInfoMethod:@selector(setModel:) heightOfCell:[ZStudentOrganizationDetailIntroCell z_getCellHeight:self.detailModel] cellType:ZCellTypeClass dataModel:self.detailModel];
    [self.cellConfigArr addObject:desCellConfig];
    
    if (self.detailModel.teacher_list && self.detailModel.teacher_list.count > 0) {
        [self.cellConfigArr addObject:getGrayEmptyCellWithHeight(CGFloatIn750(20))];
        
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
            model.name = teacherModel.teacher_name;
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
        
        {
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
}

#pragma mark tableView -------datasource-----
- (void)zz_tableView:(UITableView *)tableView cell:(UITableViewCell *)cell cellForRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig
{
    __weak typeof(self) weakSelf = self;
    if ([cellConfig.title isEqualToString:@"ZStudentOrganizationDetailTopCell"]){
           ZStudentOrganizationDetailTopCell *lcell = (ZStudentOrganizationDetailTopCell *)cell;
        lcell.selectBlock = ^(ZBaseUnitModel * model) {
            ZStudentOrganizationDetailIntroVC *ivc = [[ZStudentOrganizationDetailIntroVC alloc] initWithTitle:weakSelf.detailModel.images_list];
            ivc.imageModel = model.data;
            ivc.detailModel = weakSelf.detailModel;
            [weakSelf.navigationController pushViewController:ivc animated:YES];
        };
    }else if ([cellConfig.title isEqualToString:@"starStudent"]){
        ZStudentOrganizationPersonnelListCell *lcell = (ZStudentOrganizationPersonnelListCell *)cell;
        lcell.menuBlock = ^(ZStudentDetailPersonnelModel *model) {
            ZStudentStudentDetailVC *dvc = [[ZStudentStudentDetailVC alloc] init];
            dvc.student_id = model.account_id;
            [self.navigationController pushViewController:dvc animated:YES];
//            ZStudentStarStudentInfoVC *ivc = [[ZStudentStarStudentInfoVC alloc] init];
//            [weakSelf.navigationController pushViewController:ivc animated:YES];
        };
 
    }else if ([cellConfig.title isEqualToString:@"starCoach"]){
        ZStudentOrganizationPersonnelListCell *lcell = (ZStudentOrganizationPersonnelListCell *)cell;
        lcell.menuBlock = ^(ZStudentDetailPersonnelModel *model) {
            ZStudentTeacherDetailVC *mvc = [[ZStudentTeacherDetailVC alloc] init];
            mvc.teacher_id = model.account_id;
            mvc.stores_id = weakSelf.detailModel.schoolID;
            [weakSelf.navigationController pushViewController:mvc animated:YES];
//            ZStudentStarCoachInfoVC *ivc = [[ZStudentStarCoachInfoVC alloc] init];
//            [weakSelf.navigationController pushViewController:ivc animated:YES];
        };
    }else if ([cellConfig.title isEqualToString:@"ZStudentOrganizationDetailIntroCell"]){
        ZStudentOrganizationDetailIntroCell *lcell = (ZStudentOrganizationDetailIntroCell *)cell;
        lcell.handleBlock = ^(NSInteger index) {
            if (index == 1) {
                ZStudentOrganizationMapAddressVC *avc = [[ZStudentOrganizationMapAddressVC alloc] init];
                avc.detailModel = weakSelf.detailModel;
                [weakSelf.navigationController pushViewController:avc animated:YES];
            }else if (index == 2){
                [ZCouponListView setAlertWithTitle:@"领取优惠券" type:@"school" stores_id:self.detailModel.schoolID course_id:nil handlerBlock:^(ZOriganizationCardListModel * model) {
                    [ZOriganizationCardViewModel receiveCoupons:@{@"stores_id":SafeStr(weakSelf.detailModel.schoolID),@"coupons_id":SafeStr(model.couponsID)} completeBlock:^(BOOL isSuccess, id data) {
                        if (isSuccess) {
                            [TLUIUtility showSuccessHint:data];
                        }else{
                            [TLUIUtility showErrorHint:data];
                        }
                    }];
                }];
//                [ZOrganizationCouponListView setAlertWithTitle:@"优惠" ouponList:self.detailModel.coupons_list handlerBlock:^(ZOriganizationCardListModel *model) {
//                    [ZOriganizationCardViewModel receiveCoupons:@{@"stores_id":SafeStr(weakSelf.detailModel.schoolID),@"coupons_id":SafeStr(model.couponsID)} completeBlock:^(BOOL isSuccess, id data) {
//                        if (isSuccess) {
//                            [TLUIUtility showSuccessHint:data];
//                        }else{
//                            [TLUIUtility showErrorHint:data];
//                        }
//                    }];
//                }];
            }
        };
    }
}

- (void)zz_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
    if ([cellConfig.title isEqualToString:@"ZStudentOrganizationLessonListCell"]) {
        ZStudentLessonDetailVC *dvc = [[ZStudentLessonDetailVC alloc] init];
        dvc.model = cellConfig.dataModel;
        [self.navigationController pushViewController:dvc animated:YES];
//        ZStudentOrganizationLessonDetailVC *lessond_vc = [[ZStudentOrganizationLessonDetailVC alloc] init];
//        [self.navigationController pushViewController:lessond_vc animated:YES];
    }else if ([cellConfig.title isEqualToString:@"moreStarStudent"]){
        ZStudentStarStudentListVC *lvc = [[ZStudentStarStudentListVC alloc] init];
        lvc.type = 0;
        lvc.listModel = self.listModel;
        [self.navigationController pushViewController:lvc animated:YES];
    }else if ([cellConfig.title isEqualToString:@"moreStarCoach"]){
        ZStudentStarStudentListVC *lvc = [[ZStudentStarStudentListVC alloc] init];
        lvc.type = 1;
        lvc.listModel = self.listModel;
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
@end
