//
//  ZStudentLessonOrderLessonVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/11.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentLessonOrderLessonVC.h"
#import "ZCellConfig.h"

#import "ZSpaceEmptyCell.h"
#import "ZStudentLessonOrderStatusCell.h"
#import "ZStudentLessonOrderIntroCell.h"
#import "ZStudentLessonOrderHintCell.h"
#import "ZStudentLessonOrderCompleteCell.h"
#import "ZStudentLessonOrderCoachCell.h"
#import "ZStudentLessonOrderDetailOrganizationCell.h"

#import "ZStudentLessonBottomView.h"

@interface ZStudentLessonOrderLessonVC ()
@property (nonatomic,strong) ZStudentLessonBottomView *bottomView;

@end

@implementation ZStudentLessonOrderLessonVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigation];
    [self initCellConfigArr];
}


- (void)initCellConfigArr {
    [super initCellConfigArr];
    
    ZCellConfig *statusCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentLessonOrderStatusCell className] title:[ZStudentLessonOrderStatusCell className] showInfoMethod:nil heightOfCell:[ZStudentLessonOrderStatusCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:nil];
    [self.cellConfigArr addObject:statusCellConfig];
    
    ZStudentLessonOrderInfoModel *infoModel = [[ZStudentLessonOrderInfoModel alloc] init];
    infoModel.orderUserName = @"韩丽佳";
    infoModel.orderUserTel = @"123342354235";
    infoModel.orderTime = @"10月27日 周日19:00";
    infoModel.orderNum = @"MDX3489759374653486893";
    infoModel.orderLesson = @"单人游泳教学";
    infoModel.orderStatus = @"已支付";
    
    ZCellConfig *infoCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentLessonOrderIntroCell className] title:[ZStudentLessonOrderIntroCell className] showInfoMethod:@selector(setModel:) heightOfCell:[ZStudentLessonOrderIntroCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:infoModel];
    [self.cellConfigArr addObject:infoCellConfig];
    
    ZStudentLessonOrderInfoCellModel *hintModel = [[ZStudentLessonOrderInfoCellModel alloc] init];
    hintModel.title = @"温馨提示：如果行程有变，请体检两小时取消或联系门店，调整预约时间，以免给你带来不便！";
    hintModel.subTitle = @"（0516-56894562）";
    
    ZCellConfig *hintCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentLessonOrderHintCell className] title:[ZStudentLessonOrderHintCell className] showInfoMethod:@selector(setModel:) heightOfCell:[ZStudentLessonOrderHintCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:hintModel];
    [self.cellConfigArr addObject:hintCellConfig];
    
    ZStudentDetailOrderSubmitListModel *model = [[ZStudentDetailOrderSubmitListModel alloc] init];
    model.leftTitle = @"才玩俱乐部";
    model.rightImage = @"rightBlackArrowN";
    ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentLessonOrderCompleteCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZStudentLessonOrderCompleteCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:model];
    [self.cellConfigArr addObject:menuCellConfig];
    
    ZStudentLessonOrganizationModel *orgModel = [[ZStudentLessonOrganizationModel alloc] init];
    orgModel.image = @"studentLessonCocah1";
    orgModel.address = @"江苏省徐州市泉山区建国西路才湾游泳俱乐部";
    orgModel.tel = @"0516-3485873443";
    
    ZCellConfig *orgCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentLessonOrderDetailOrganizationCell className] title:[ZStudentLessonOrderDetailOrganizationCell className] showInfoMethod:@selector(setModel:) heightOfCell:[ZStudentLessonOrderDetailOrganizationCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:orgModel];
    [self.cellConfigArr addObject:orgCellConfig];
    
    
    
    ZCellConfig *spacCellConfig = [ZCellConfig cellConfigWithClassName:[ZSpaceEmptyCell className] title:[ZSpaceEmptyCell className] showInfoMethod:@selector(setBackColor:) heightOfCell:CGFloatIn750(40) cellType:ZCellTypeClass dataModel:adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark])];
    [self.cellConfigArr addObject:spacCellConfig];
    
    ZStudentDetailOrderSubmitListModel *coachHModel = [[ZStudentDetailOrderSubmitListModel alloc] init];
    coachHModel.leftTitle = @"教师";
    coachHModel.rightImage = @"rightBlackArrowN";
    ZCellConfig *menu1CellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentLessonOrderCompleteCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZStudentLessonOrderCompleteCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:coachHModel];
    [self.cellConfigArr addObject:menu1CellConfig];
    
    ZStudentDetailLessonOrderCoachModel *coachModel = [[ZStudentDetailLessonOrderCoachModel alloc] init];
    coachModel.coachImage = @"orderCoachLesson";
    coachModel.coachName = @"赵忠";
    coachModel.auth = @"平台认证教师";
    coachModel.labelArr = @[@"明星教师", @"明星教师"];
    coachModel.adeptArr = @[@"蛙泳", @"蝶泳", @"塑性",@"好频率b100%",];
    coachModel.desStr = @"高傲机构按时间哦给大家哦我按设计工具偶见过的搜啊解耦股建瓯市大家宫颈癌搜";
    ZCellConfig *coachCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentLessonOrderCoachCell className] title:[ZStudentLessonOrderCompleteCell className] showInfoMethod:@selector(setModel:) heightOfCell:[ZStudentLessonOrderCoachCell z_getCellHeight:coachModel] cellType:ZCellTypeClass dataModel:coachModel];
    [self.cellConfigArr addObject:coachCellConfig];
}


- (void)setNavigation {
    self.isHidenNaviBar = NO;
    [self.navigationItem setTitle:@"预约详情"];
}

- (void)setupMainView {
    [super setupMainView];
    
    [self.view addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.mas_equalTo(CGFloatIn750(90 + 60));
    }];
    
    [self.iTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.bottomView.mas_top);
        make.top.equalTo(self.view.mas_top).offset(0);
    }];
}

#pragma mark lazy loading...
- (ZStudentLessonBottomView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[ZStudentLessonBottomView alloc] init];
        _bottomView.orderType = ZLessonOrderTypeWaitPay;
    }
    
    return _bottomView;
}

@end
