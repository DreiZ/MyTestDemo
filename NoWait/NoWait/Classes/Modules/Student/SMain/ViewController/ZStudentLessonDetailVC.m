//
//  ZStudentLessonDetailVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/3/21.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentLessonDetailVC.h"
#import "ZOrganizationLessonDetailHeaderCell.h"

#import "ZOrganizationLessonDetailPriceCell.h"
#import "ZTextFieldMultColCell.h"
#import "ZStudentOrganizationDetailIntroLabelCell.h"
#import "ZStudentOrganizationDetailEnteryCell.h"
#import "ZStudentOrganizationPersonnelMoreCell.h"
#import "ZStudentOrganizationPersonnelListCell.h"
#import "ZOrganizationDetailNumAndMinCell.h"
#import "ZBaseUnitModel.h"
#import "ZStudentMineModel.h"
#import "ZStudentEvaListCell.h"
#import "ZStudentLessonSelectMainNewView.h"
#import "ZOriganizationLessonViewModel.h"

#import "ZOriganizationOrderViewModel.h"
#import "ZOrganizationDetailBottomView.h"
#import "ZOrderModel.h"

#import "ZStudentOrganizationDetailDesVC.h"
#import "ZStudentLessonSureOrderVC.h"
#import "ZOriganizationCardViewModel.h"
#import "ZCouponListView.h"
#import "ZStudentTeacherDetailVC.h"
#import "ZStudentLessonCoachListVC.h"
#import "ZAlertMoreView.h"
#import "ZOriganizationReportVC.h"
#import "ZUMengShareManager.h"
#import "ZStudentCollectionViewModel.h"
#import "ZPhoneAlertView.h"

@interface ZStudentLessonDetailVC ()
@property (nonatomic,strong) UIButton *navLeftBtn;
@property (nonatomic,strong) UIButton *navRightBtn;

@property (nonatomic,strong) UIView *topNavView;
@property (nonatomic,strong) ZStudentLessonSelectMainNewView *selectView;
@property (nonatomic,strong) ZOriganizationLessonDetailModel *addModel;
@property (nonatomic,strong) ZOrganizationDetailBottomView *bottomView;
@property (nonatomic,assign) NSInteger k;
@property (nonatomic,strong) NSMutableDictionary *param;

@end

@implementation ZStudentLessonDetailVC


- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.isHidenNaviBar = YES;
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self refreshHeader];
    [self refreshData];
    [self setTableViewRefreshFooter];
    [self setTableViewEmptyDataDelegate];
}

#pragma mark - set data view
- (void)setDataSource {
    [super setDataSource];
    _param = @{}.mutableCopy;
}

- (void)setupMainView {
    [super setupMainView];
    
    [self.view addSubview:self.topNavView];
    [self.topNavView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.height.mas_equalTo(kTopHeight);
    }];
    
    [self.view addSubview:self.navLeftBtn];
    [self.navLeftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(CGFloatIn750(50));
        make.left.equalTo(self.view.mas_left).offset(CGFloatIn750(30));
        make.bottom.equalTo(self.topNavView.mas_bottom).offset(-CGFloatIn750(17));
    }];
    
    [self.view addSubview:self.navRightBtn];
    [self.navRightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(CGFloatIn750(50));
        make.right.equalTo(self.view.mas_right).offset(-CGFloatIn750(30));
        make.bottom.equalTo(self.topNavView.mas_bottom).offset(-CGFloatIn750(17));
    }];
    
    [self.view addSubview:self.bottomView];
    [self.bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.mas_equalTo(CGFloatIn750(88) + safeAreaBottom());
    }];
    
    [self.iTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.bottom.equalTo(self.bottomView.mas_top);
    }];
}

- (UIButton *)navLeftBtn {
    if (!_navLeftBtn) {
        __weak typeof(self) weakSelf = self;
        _navLeftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, CGFloatIn750(50), CGFloatIn750(50))];
        [_navLeftBtn setBackgroundColor:HexAColor(0xffffff, 0.7) forState:UIControlStateNormal];
        [_navLeftBtn setImage:[UIImage imageNamed:@"navleftBack"] forState:UIControlStateNormal];
        ViewRadius(_navLeftBtn, CGFloatIn750(25));
        [_navLeftBtn bk_addEventHandler:^(id sender) {
            [weakSelf.navigationController popViewControllerAnimated:YES];
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _navLeftBtn;
}


- (UIButton *)navRightBtn {
    if (!_navRightBtn) {
        __weak typeof(self) weakSelf = self;
        _navRightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, CGFloatIn750(90), CGFloatIn750(50))];
        [_navRightBtn setTitle:@"举报" forState:UIControlStateNormal];
        _navRightBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, CGFloatIn750(14), 0);
        [_navRightBtn setTitleColor:adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]) forState:UIControlStateNormal];
        [_navRightBtn.titleLabel setFont:[UIFont fontContent]];
        [_navRightBtn setBackgroundColor:HexAColor(0xffffff, 0.7) forState:UIControlStateNormal];
        ViewRadius(_navRightBtn, CGFloatIn750(25));
        [_navRightBtn bk_addEventHandler:^(id sender) {
            [[ZUserHelper sharedHelper] checkLogin:^{
                ZOriganizationReportVC *rvc = [[ZOriganizationReportVC alloc] init];
                rvc.sTitle = self.addModel.name;
                rvc.course_id = self.addModel.lessonID;
                [weakSelf.navigationController pushViewController:rvc animated:rvc];
            }];
            
//            NSArray *weekArr = @[@[@"分享",@"peoples_hint",@"share"],@[@"投诉",@"peoples_hint",@"report"]];
//            NSArray *weekArr = @[@[@"投诉",@"peoples_hint",@"report"]];
//            [ZAlertMoreView setMoreAlertWithTitleArr:weekArr handlerBlock:^(NSString *index) {
//                if ([index isEqualToString:@"report"]) {
//                    ZOriganizationReportVC *rvc = [[ZOriganizationReportVC alloc] init];
//                    rvc.sTitle = self.addModel.name;
//                    rvc.course_id = self.addModel.lessonID;
//                    [weakSelf.navigationController pushViewController:rvc animated:rvc];
//                }else{
//                    [[ZUMengShareManager sharedManager] shareUIWithType:1 Title:@"似锦" detail:@"测试" image:[UIImage imageNamed:@"logo"] url:@"www.baidu.com" vc:self];
//                }
//            }];
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _navRightBtn;
}

- (UIView *)topNavView {
    if (!_topNavView) {
        _topNavView = [[UIView alloc] init];
        _topNavView.backgroundColor = adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]);
        _topNavView.alpha = 0;
    }
    return _topNavView;
}


- (ZStudentLessonSelectMainNewView *)selectView {
    if (!_selectView) {
        __weak typeof(self) weakSelf = self;
        _selectView = [[ZStudentLessonSelectMainNewView alloc] init];
        _selectView.completeBlock = ^(ZOrderAddModel *listModel) {
            ZStudentLessonSureOrderVC *order = [[ZStudentLessonSureOrderVC alloc] init];
            ZOrderDetailModel *detailModel = [[ZOrderDetailModel alloc] init];
            detailModel.order_type = ZStudentOrderTypeForPay;
            detailModel.course_id = weakSelf.addModel.lessonID;
            detailModel.teacher_name = listModel.teacher_name;
            detailModel.teacher_id = listModel.teacher_id;
            detailModel.stores_id = weakSelf.addModel.stores_id;
            detailModel.store_name = weakSelf.addModel.stores_name;
            detailModel.course_name = weakSelf.addModel.name;
            detailModel.pay_amount = listModel.price;
            detailModel.order_amount = listModel.price;
            detailModel.course_number = weakSelf.addModel.course_number;
            detailModel.course_min = weakSelf.addModel.course_min;
            detailModel.valid_at = weakSelf.addModel.valid_at;
            detailModel.course_image_url = weakSelf.addModel.image_url;
            detailModel.course_total_min = [NSString stringWithFormat:@"%d",[weakSelf.addModel.course_number intValue]*[weakSelf.addModel.course_min intValue]];
            
            order.detailModel = detailModel;
            [weakSelf.navigationController pushViewController:order animated:YES];
//            ZStudentLessonSubscribeSureOrderVC *order = [[ZStudentLessonSubscribeSureOrderVC alloc] init];
//            [weakSelf.navigationController pushViewController:order animated:YES];
        };
    }
    return _selectView;
}


-(ZOrganizationDetailBottomView *)bottomView {
    if (!_bottomView) {
        __weak typeof(self) weakSelf = self;
        _bottomView = [[ZOrganizationDetailBottomView alloc] init];
        _bottomView.title = @"立即购买";
        _bottomView.handleBlock = ^(NSInteger index) {
            if (index == 0) {
              [ZPhoneAlertView setAlertName:@"联系我时，请说是在似锦APP看到的，谢谢！"  tel:SafeStr(weakSelf.addModel.phone) handlerBlock:^(NSInteger index) {
                  if (index == 1) {
//                        [ZPublicTool callTel:SafeStr(weakSelf.detailModel.phone)];
                  }
              }];
            }else if (index == 2){
                [[ZUserHelper sharedHelper] checkLogin:^{
                    if ([weakSelf.addModel.collection intValue] == 1) {
                        [weakSelf collectionLesson:NO];
                    }else{
                        [weakSelf collectionLesson:YES];
                    }
                }];
            } else{
                [[ZUserHelper sharedHelper] checkLogin:^{
                    [weakSelf.selectView showSelectViewWithModel:weakSelf.addModel];
                }];
            }
        };
    }
    return _bottomView;
}

#pragma mark - scrollview delegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // 获取到tableView偏移量
    CGFloat Offset_y = scrollView.contentOffset.y;
    // 下拉 纵向偏移量变小 变成负的
   
    if (Offset_y > CGFloatIn750(420)) {
        self.topNavView.alpha = (Offset_y - CGFloatIn750(420))/CGFloatIn750(50);
    }else {
        self.topNavView.alpha = 0;
    }
}

- (void)zz_tableView:(UITableView *)tableView cell:(UITableViewCell *)cell cellForRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
    __weak typeof(self) weakSelf = self;
    if ([cellConfig.title isEqualToString:@"ZStudentOrganizationDetailEnteryCell"]) {
        ZStudentOrganizationDetailEnteryCell *lcell = (ZStudentOrganizationDetailEnteryCell *)cell;
        lcell.handleBlock = ^(NSInteger index) {
            ZStudentOrganizationDetailDesVC *dvc = [[ZStudentOrganizationDetailDesVC alloc] init];
            ZStoresListModel *listModel = [[ZStoresListModel alloc] init];
            listModel.name = self.addModel.stores_name;
            listModel.stores_id = self.addModel.stores_id;
            dvc.listModel = listModel;
            [weakSelf.navigationController pushViewController:dvc animated:YES];
        };
    }else if ([cellConfig.title isEqualToString:@"starCoach"]) {
        ZStudentOrganizationPersonnelListCell *lcell = (ZStudentOrganizationPersonnelListCell *)cell;
        lcell.menuBlock = ^(ZStudentDetailPersonnelModel *model) {
            ZStudentTeacherDetailVC *mvc = [[ZStudentTeacherDetailVC alloc] init];
            mvc.teacher_id = model.account_id;
            mvc.stores_id = weakSelf.addModel.stores_id;
            [weakSelf.navigationController pushViewController:mvc animated:YES];
        };
    }else if([cellConfig.title isEqualToString:@"ZOrganizationLessonDetailHeaderCell"]){
        ZOrganizationLessonDetailHeaderCell *lcell = (ZOrganizationLessonDetailHeaderCell *)cell;
        lcell.bannerBlock = ^(ZStudentBannerModel *model, NSInteger index) {
            [[ZPhotoManager sharedManager] showBrowser:weakSelf.addModel.images withIndex:index];
        };
    }
    
    
}

- (void)zz_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
    if ([cellConfig.title isEqualToString:@"ZStudentOrganizationDetailIntroLabelCell"]){
        __weak typeof(self) weakSelf = self;
        [ZCouponListView setAlertWithTitle:@"领取优惠券" type:@"lesson" stores_id:self.addModel.stores_id course_id:self.addModel.lessonID
                              teacher_id:nil handlerBlock:^(ZOriganizationCardListModel * model) {
            [[ZUserHelper sharedHelper] checkLogin:^{
                if ([model.received intValue] == 1) {
                    [ZOriganizationCardViewModel receiveCoupons:@{@"stores_id":SafeStr(weakSelf.addModel.stores_id),@"coupons_id":SafeStr(model.couponsID)} completeBlock:^(BOOL isSuccess, id data) {
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
    }else if([cellConfig.title isEqualToString:@"moreTeacher"]){
        ZStudentLessonCoachListVC *lvc = [[ZStudentLessonCoachListVC alloc] init];
        lvc.lesson_id = self.model.lessonID;
        lvc.stores_id = self.addModel.stores_id;
        
        lvc.type = 1;
        [self.navigationController pushViewController:lvc animated:YES];
    }
    
    
}

#pragma mark - setDetailData
- (void)initCellConfigArr {
    [super initCellConfigArr];
    
    [self setImagesAndPrice];
    [self setLabelCellConfig];
    [self setLessonName];
    [self setTeacherList];
    [self setLessonDetail];
    [self setTime];
    [self addTimeOrder];
    [self setEva];
    
    if ([self.addModel.status intValue] != 1) {
        _bottomView.title = @"课程已下架";
        _bottomView.handleBtn.enabled = NO;
        _bottomView.handleBtn.backgroundColor = adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGray]);
    }else{
        _bottomView.title = @"立即购买";
        _bottomView.handleBtn.enabled = YES;
        _bottomView.handleBtn.backgroundColor = adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]);
    }
    [self.iTableView reloadData];
    _bottomView.isCollection = [self.addModel.collection intValue] == 1 ? YES:NO;
}

- (void)setTime {
   [self.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(30))];
    
    ZLineCellModel *model = ZLineCellModel.zz_lineCellModel_create(@"title")
    .zz_titleLeft(@"课程有效期")
    .zz_fontLeft([UIFont boldFontContent])
    .zz_lineHidden(YES)
    .zz_cellHeight(CGFloatIn750(50));
    
    ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZBaseLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZBaseLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
    [self.cellConfigArr addObject:menuCellConfig];
    
    ZLineCellModel *model1 = ZLineCellModel.zz_lineCellModel_create(@"title")
    .zz_titleLeft([NSString stringWithFormat:@"%@月",self.addModel.valid_at])
    .zz_fontLeft([UIFont fontSmall])
    .zz_lineHidden(YES)
    .zz_cellHeight(CGFloatIn750(42));
    
    ZCellConfig *menu1CellConfig = [ZCellConfig cellConfigWithClassName:[ZBaseLineCell className] title:model1.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZBaseLineCell z_getCellHeight:model1] cellType:ZCellTypeClass dataModel:model1];
    [self.cellConfigArr addObject:menu1CellConfig];
    
    [self.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(30))];
}

- (void)setLessonName {
    ZLineCellModel *model = ZLineCellModel.zz_lineCellModel_create(@"title")
    .zz_titleLeft(self.addModel.name)
    .zz_fontLeft([UIFont boldFontMax1Title])
    .zz_lineHidden(YES)
    .zz_cellHeight(CGFloatIn750(106))
    .zz_leftMultiLine(YES);
    
    ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZBaseLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZBaseLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
    [self.cellConfigArr addObject:menuCellConfig];
    
    {
        ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
           model.leftTitle = [NSString stringWithFormat:@"%@分钟/节   共%@节",self.addModel.course_min, self.addModel.course_number];;
           model.rightTitle = [NSString stringWithFormat:@"班级人数:%@",self.addModel.course_class_number];
        
        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZOrganizationDetailNumAndMinCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZOrganizationDetailNumAndMinCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
        [self.cellConfigArr addObject:menuCellConfig];
    }
    
    {
        [self.cellConfigArr addObject:getEmptyCellWithHeight(24)];
        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentOrganizationDetailEnteryCell className] title:[ZStudentOrganizationDetailEnteryCell className] showInfoMethod:@selector(setModel:) heightOfCell:[ZStudentOrganizationDetailEnteryCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:self.addModel];
        [self.cellConfigArr addObject:menuCellConfig];
        [self.cellConfigArr addObject:getEmptyCellWithHeight(24)];
    }
}

- (void)setTeacherList {
    if (!ValidArray(self.addModel.teacher_list)) {
        return;
    }
    [self.cellConfigArr addObject:getEmptyCellWithHeight(24)];
    ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
    model.leftTitle = @"课程教师";
    model.cellTitle = @"moreTeacher";
    model.isHiddenLine = YES;
    model.leftFont = [UIFont boldFontContent];
    model.cellHeight = CGFloatIn750(50);
   
   ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentOrganizationPersonnelMoreCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZStudentOrganizationPersonnelMoreCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
   
   [self.cellConfigArr addObject:menuCellConfig];
    
    
    NSMutableArray *peoples = @[].mutableCopy;
    for (int i = 0; i < self.addModel.teacher_list.count; i++) {
        ZOriganizationLessonTeacherModel *listModel = self.addModel.teacher_list[i];
        ZStudentDetailPersonnelModel *model = [[ZStudentDetailPersonnelModel alloc] init];
        model.image = imageFullUrl(listModel.image);
        model.name = listModel.teacher_name;
        model.skill = listModel.position;
        model.account_id = listModel.teacher_id;
        [peoples addObject:model];
    }
    
    ZCellConfig *coachCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentOrganizationPersonnelListCell className] title:@"starCoach" showInfoMethod:@selector(setPeopleslList:) heightOfCell:[ZStudentOrganizationPersonnelListCell z_getCellHeight:peoples] cellType:ZCellTypeClass dataModel:peoples];
    [self.cellConfigArr addObject:coachCellConfig];
}

- (void)setLessonDetail {
    if (ValidStr(self.addModel.info)) {
        [self.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(24))];
        ZLineCellModel *model = ZLineCellModel.zz_lineCellModel_create(@"remark")
        .zz_cellHeight(CGFloatIn750(50))
        .zz_lineHidden(YES)
        .zz_titleLeft(@"课程简介：")
        .zz_fontLeft([UIFont boldFontContent]);
        
        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZBaseLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZBaseLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
        [self.cellConfigArr addObject:menuCellConfig];
        
        {
            ZLineCellModel *model = ZLineCellModel.zz_lineCellModel_create(@"info")
            .zz_cellHeight(CGFloatIn750(62))
            .zz_lineHidden(YES)
            .zz_titleLeft(self.addModel.info)
            .zz_leftMultiLine(YES);
            
            ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZBaseLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZBaseLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
            [self.cellConfigArr addObject:menuCellConfig];
        }
    }
    
    if (ValidStr(self.addModel.p_information)) {
        [self.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(24))];
        ZLineCellModel *model = ZLineCellModel.zz_lineCellModel_create(@"remark")
        .zz_cellHeight(CGFloatIn750(50))
        .zz_lineHidden(YES)
        .zz_titleLeft(@"购买须知：")
        .zz_fontLeft([UIFont boldFontContent]);
        
        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZBaseLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZBaseLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
        [self.cellConfigArr addObject:menuCellConfig];
        
        {
            ZLineCellModel *model = ZLineCellModel.zz_lineCellModel_create(@"p_information")
            .zz_cellHeight(CGFloatIn750(60))
            .zz_lineHidden(YES)
            .zz_titleLeft(self.addModel.p_information)
            .zz_leftMultiLine(YES);
            
            ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZBaseLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZBaseLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
            [self.cellConfigArr addObject:menuCellConfig];
        }
    }
}


- (void)setImagesAndPrice {
    NSMutableArray *images = @[].mutableCopy;
    for (int i = 0; i < self.addModel.images.count; i++) {
        ZStudentBannerModel *model = [[ZStudentBannerModel alloc] init];
        id image =  self.addModel.images[i];
        if ([image isKindOfClass:[NSString class]]) {
            NSString *imageStr = image;
            if (imageStr ) {
                model.data = imageFullUrl(imageStr);
                [images addObject:model];
            }
        }
    }
    ZCellConfig *statisticsCellConfig = [ZCellConfig cellConfigWithClassName:[ZOrganizationLessonDetailHeaderCell className] title:[ZOrganizationLessonDetailHeaderCell className] showInfoMethod:@selector(setList:) heightOfCell:[ZOrganizationLessonDetailHeaderCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:images];
    [self.cellConfigArr addObject:statisticsCellConfig];
    
    ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
    model.leftTitle = self.addModel.price;
    model.rightTitle = [NSString stringWithFormat:@"%@",self.addModel.pay_nums];
    model.data = self.addModel.score;
    
    ZCellConfig *priceCellConfig = [ZCellConfig cellConfigWithClassName:[ZOrganizationLessonDetailPriceCell className] title:[ZOrganizationLessonDetailPriceCell className] showInfoMethod:@selector(setModel:) heightOfCell:[ZOrganizationLessonDetailPriceCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:model];
    [self.cellConfigArr addObject:priceCellConfig];
}

- (void)setLabelCellConfig{
    if (ValidArray(self.addModel.coupons_list)){
        NSMutableArray *coupons = @[].mutableCopy;
        for (ZOriganizationCardListModel *cartModel in self.addModel.coupons_list) {
            [coupons addObject:cartModel.title];
        }
        ZBaseMultiseriateCellModel *mModel = [[ZBaseMultiseriateCellModel alloc] init];
        mModel.rightFont = [UIFont fontContent];
        mModel.rightColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
        mModel.singleCellHeight = CGFloatIn750(40);
        mModel.isHiddenLine = YES;
        mModel.data = coupons;
        mModel.rightColor = [UIColor colorRedForLabel];
        mModel.rightDarkColor = [UIColor colorRedForLabelSub];
        mModel.leftFont = [UIFont boldFontMax1Title];
        mModel.rightImage = @"rightBlackArrowN";
        
        ZCellConfig *textCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentOrganizationDetailIntroLabelCell className] title:@"ZStudentOrganizationDetailIntroLabelCell" showInfoMethod:@selector(setModel:) heightOfCell:[ZStudentOrganizationDetailIntroLabelCell z_getCellHeight:mModel] cellType:ZCellTypeClass dataModel:mModel];
        [self.cellConfigArr addObject:textCellConfig];
    }
}

- (void)addTimeOrder {
    if (ValidArray(self.addModel.fix_time)) {
        ZLineCellModel *model = ZLineCellModel.zz_lineCellModel_create(@"fix_timeTitle")
        .zz_cellHeight(CGFloatIn750(30))
        .zz_lineHidden(YES)
        .zz_fontLeft([UIFont boldFontContent])
        .zz_titleLeft(@"固定开课时间")
        .zz_leftMultiLine(YES);
        
        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZBaseLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZBaseLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
        [self.cellConfigArr addObject:menuCellConfig];
        
        for (ZBaseMenuModel *menu in self.addModel.fix_time) {
            NSString *subTitle = @"";
            for (int k = 0; k < menu.units.count; k++) {
                ZBaseUnitModel *unitModel = menu.units[k];
                if (subTitle.length == 0) {
                    subTitle = [NSString stringWithFormat:@"%@~%@",[self getStartTime:unitModel],[self getEndTime:unitModel]];
                }else{
                    subTitle = [NSString stringWithFormat:@"%@   %@~%@",subTitle,[self getStartTime:unitModel],[self getEndTime:unitModel]];
                }
            }
            ZLineCellModel *model = ZLineCellModel.zz_lineCellModel_create(@"fix_time")
            .zz_cellHeight(CGFloatIn750(60))
            .zz_lineHidden(YES)
            .zz_fontLeft([UIFont boldFontContent])
            .zz_titleLeft(menu.name)
            .zz_titleRight(subTitle)
            .zz_rightMultiLine(YES)
            .zz_alignmentRight(NSTextAlignmentLeft)
            .zz_fontLeft([UIFont fontSmall])
            .zz_fontRight([UIFont fontSmall])
            .zz_colorLeft([UIColor colorTextGray])
            .zz_colorDarkLeft([UIColor colorTextGray])
            .zz_colorRight([UIColor colorTextGray])
            .zz_colorDarkRight([UIColor colorTextGray]);
            
            ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZBaseLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZBaseLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
            [self.cellConfigArr addObject:menuCellConfig];
        }
    }
    
    [self addExperienceTimeOrder];
}


- (void)addExperienceTimeOrder {
    if ([self.addModel.is_experience intValue] == 1) {
        [self.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(30))];
        
        ZLineCellModel *model = ZLineCellModel.zz_lineCellModel_create(@"fix_timeTitle")
        .zz_cellHeight(CGFloatIn750(30))
        .zz_lineHidden(YES)
        .zz_fontLeft([UIFont boldFontContent])
        .zz_titleLeft(@"接受课程预约")
        .zz_leftMultiLine(YES);
        
        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZBaseLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZBaseLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
        [self.cellConfigArr addObject:menuCellConfig];
        
        {
            ZLineCellModel *model = ZLineCellModel.zz_lineCellModel_create(@"fix_timeTitle")
            .zz_cellHeight(CGFloatIn750(62))
            .zz_lineHidden(YES)
            .zz_fontLeft([UIFont fontSmall])
            .zz_titleLeft([NSString stringWithFormat:@"体验课价格￥%@",self.addModel.experience_price])
            .zz_leftMultiLine(YES)
            .zz_colorLeft([UIColor colorTextGray])
            .zz_colorDarkLeft([UIColor colorTextGrayDark]);
            
            ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZBaseLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZBaseLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
            [self.cellConfigArr addObject:menuCellConfig];
        }
        {
            ZLineCellModel *model = ZLineCellModel.zz_lineCellModel_create(@"fix_timeTitle")
            .zz_cellHeight(CGFloatIn750(62))
            .zz_lineHidden(YES)
            .zz_fontLeft([UIFont fontSmall])
            .zz_titleLeft([NSString stringWithFormat:@"单次体验时长%@分钟",self.addModel.experience_duration])
            .zz_leftMultiLine(YES)
            .zz_colorLeft([UIColor colorTextGray])
            .zz_colorDarkLeft([UIColor colorTextGrayDark]);
            
            ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZBaseLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZBaseLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
            [self.cellConfigArr addObject:menuCellConfig];
        }
        
        {
           NSMutableArray *tempArr = @[].mutableCopy;
           for (int i = 0; i < self.addModel.experience_time.count; i++) {
               ZBaseMenuModel *menuModel = self.addModel.experience_time[i];
               
               if (menuModel && menuModel.units && menuModel.units.count > 0) {
                   NSMutableArray *tempSubArr = @[].mutableCopy;
                   [tempSubArr addObject:menuModel.name];
                   NSString *subTitle = @"";
                   for (int k = 0; k < menuModel.units.count; k++) {
                       ZBaseUnitModel *unitModel = menuModel.units[k];
                       if (subTitle.length == 0) {
                           subTitle = [NSString stringWithFormat:@"%@~%@",unitModel.name,unitModel.subName];
                       }else{
                           subTitle = [NSString stringWithFormat:@"%@   %@~%@",subTitle,unitModel.name,unitModel.subName];
                       }
                   }
                   [tempSubArr addObject:subTitle];
                   
                   [tempArr addObject:tempSubArr];
               }
           }
            
            for (int j = 0; j < tempArr.count; j++) {
                ZLineCellModel *model = ZLineCellModel.zz_lineCellModel_create(@"fix_time")
                .zz_cellHeight(CGFloatIn750(60))
                .zz_lineHidden(YES)
                .zz_fontLeft([UIFont boldFontContent])
                .zz_titleLeft(tempArr[j][0])
                .zz_titleRight(tempArr[j][1])
                .zz_rightMultiLine(YES)
                .zz_alignmentRight(NSTextAlignmentLeft)
                .zz_fontLeft([UIFont fontSmall])
                .zz_fontRight([UIFont fontSmall])
                .zz_colorLeft([UIColor colorTextGray])
                .zz_colorDarkLeft([UIColor colorTextGray])
                .zz_colorRight([UIColor colorTextGray])
                .zz_colorDarkRight([UIColor colorTextGray]);
                
                ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZBaseLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZBaseLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
                [self.cellConfigArr addObject:menuCellConfig];
            }
        }
    }
}

- (void)setEva {
    ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
    model.lineLeftMargin = CGFloatIn750(30);
    model.lineRightMargin = CGFloatIn750(30);
    model.isHiddenLine = NO;
    model.cellHeight = CGFloatIn750(10);
    ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
    
    [self.cellConfigArr addObject:menuCellConfig];
    [self.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(30))];
    
    {
        ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
        model.leftTitle = @"课程评价";
        model.leftFont = [UIFont boldFontTitle];
        model.cellHeight = CGFloatIn750(50);
        model.isHiddenLine = YES;
        
        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
        [self.cellConfigArr addObject:menuCellConfig];
    }
    
    for (ZOrderEvaListModel *evaModel in self.dataSources) {
        ZCellConfig *evaCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentEvaListCell className] title:[ZStudentEvaListCell className] showInfoMethod:@selector(setModel:) heightOfCell:[ZStudentEvaListCell z_getCellHeight:evaModel] cellType:ZCellTypeClass dataModel:evaModel];
        [self.cellConfigArr addObject:evaCellConfig];
    }
}


- (NSString *)getStartTime:(ZBaseUnitModel *)model {
    if ([model.subName intValue] < 10) {
        return  [NSString stringWithFormat:@"%@:0%@",model.name,model.subName];
    }else{
        return  [NSString stringWithFormat:@"%@:%@",model.name,model.subName];
    }
}

- (NSString *)getEndTime:(ZBaseUnitModel *)model {
    NSInteger temp = [self.addModel.course_min intValue]/60;
    NSInteger subTemp = [self.addModel.course_min intValue]%60;
    
    NSInteger hourTemp = [model.name intValue] + temp;
    NSInteger minTemp = [model.subName intValue] + subTemp;
    if (minTemp > 59) {
        minTemp -= 60;
        hourTemp++;
    }
    
    if (hourTemp > 24) {
        hourTemp -= 24;
    }
    
    ZBaseUnitModel *uModel = [[ZBaseUnitModel alloc] init];
    uModel.name = [NSString stringWithFormat:@"%ld",hourTemp];
    uModel.subName = [NSString stringWithFormat:@"%ld",minTemp];
    
    return [self getStartTime:uModel];
}

- (void)refreshHeader {
    __weak typeof(self) weakSelf = self;
    self.loading = YES;
    [ZOriganizationLessonViewModel getLessonDetail:@{@"id":SafeStr(self.model.lessonID)} completeBlock:^(BOOL isSuccess, ZOriganizationLessonDetailModel *addModel) {
        weakSelf.loading = NO;
        if (isSuccess) {
            weakSelf.addModel = addModel;
            [weakSelf initCellConfigArr];
            [weakSelf.iTableView reloadData];
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
    [ZOriganizationOrderViewModel getLessonCommentListList:param completeBlock:^(BOOL isSuccess, ZOrderEvaListNetModel *data) {
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
    [ZOriganizationOrderViewModel getLessonCommentListList:self.param completeBlock:^(BOOL isSuccess, ZOrderEvaListNetModel *data) {
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

- (void)setPostCommonData {
    [self.param setObject:[NSString stringWithFormat:@"%ld",self.currentPage] forKey:@"page"];
    [self.param setObject:self.model.lessonID forKey:@"stores_courses_id"];
}

- (void)collectionLesson:(BOOL)isCollection {
    [TLUIUtility showLoading:@""];
    __weak typeof(self) weakSelf = self;
    [ZStudentCollectionViewModel collectionLesson:@{@"course":SafeStr(self.addModel.lessonID),@"type":isCollection ? @"1":@"2"} completeBlock:^(BOOL isSuccess, id data) {
        [TLUIUtility hiddenLoading];
        if (isSuccess) {
            [TLUIUtility showSuccessHint:data];
            if ([weakSelf.addModel.collection intValue] == 1) {
                weakSelf.addModel.collection = @"0";
            }else{
                weakSelf.addModel.collection = @"1";
            }
            weakSelf.bottomView.isCollection = [weakSelf.addModel.collection intValue] == 1 ? YES:NO;
        }else{
            [TLUIUtility showInfoHint:data];
        }
    }];
}
@end

