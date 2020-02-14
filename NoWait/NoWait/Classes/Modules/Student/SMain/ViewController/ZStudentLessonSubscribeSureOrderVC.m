//
//  ZStudentLessonSubscribeSureOrderVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/10.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentLessonSubscribeSureOrderVC.h"
#import "ZStudentLessonOrderSuccessVC.h"

#import "ZCellConfig.h"
#import "ZStudentDetailModel.h"

#import "ZSpaceEmptyCell.h"
#import "ZStudentLessonOrderNormalCell.h"
#import "ZStudentLessonOrderCompleteCell.h"
#import "ZStudentLessonOrderMoreInputCell.h"
#import "ZStudentLessonOrderCoachCell.h"

@interface ZStudentLessonSubscribeSureOrderVC ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic,strong) UITableView *iTableView;
@property (nonatomic,strong) UIButton *bottomBtn;

@property (nonatomic,strong) NSMutableArray *dataSources;
@property (nonatomic,strong) NSMutableArray *cellConfigArr;
@end

@implementation ZStudentLessonSubscribeSureOrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigation];
    [self setDataSource];
    [self initCellConfigArr];
    [self setupMainView];
}

- (void)setDataSource {
    _dataSources = @[].mutableCopy;
    _cellConfigArr = @[].mutableCopy;
    
    [self initCellConfigArr];
}

- (void)initCellConfigArr {
    [_cellConfigArr removeAllObjects];
    
    {
        ZStudentDetailOrderSubmitListModel *model = [[ZStudentDetailOrderSubmitListModel alloc] init];
        model.leftImage = @"orderOrgLesson";
        model.leftTitle = @"才玩俱乐部";
        model.rightImage = @"orderTelLesson";
        
        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentLessonOrderCompleteCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZStudentLessonOrderCompleteCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:model];
        [self.cellConfigArr addObject:menuCellConfig];
        
        ZCellConfig *spacCellConfig = [ZCellConfig cellConfigWithClassName:[ZSpaceEmptyCell className] title:[ZSpaceEmptyCell className] showInfoMethod:@selector(setBackColor:) heightOfCell:CGFloatIn750(40) cellType:ZCellTypeClass dataModel:KAdaptAndDarkColor([UIColor colorGrayBG], [UIColor colorBlackBG])];
           [self.cellConfigArr addObject:spacCellConfig];
    }
    
    {
        ZStudentDetailOrderSubmitListModel *model = [[ZStudentDetailOrderSubmitListModel alloc] init];
        model.leftImage = @"orderCoachLesson";
        model.leftTitle = @"教练";
        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentLessonOrderCompleteCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZStudentLessonOrderCompleteCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:model];
        [self.cellConfigArr addObject:menuCellConfig];
        
        ZStudentDetailLessonOrderCoachModel *coachModel = [[ZStudentDetailLessonOrderCoachModel alloc] init];
        coachModel.coachImage = @"orderCoachLesson";
        coachModel.coachName = @"赵忠";
        coachModel.auth = @"平台认证教练";
        coachModel.labelArr = @[@"明星教师", @"明星教师"];
        coachModel.adeptArr = @[@"蛙泳", @"蝶泳", @"塑性",@"好频率b100%",];
        coachModel.desStr = @"高傲机构按时间哦给大家哦我按设计工具偶见过的搜啊解耦股建瓯市大家宫颈癌搜";
        ZCellConfig *coachCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentLessonOrderCoachCell className] title:[ZStudentLessonOrderCompleteCell className] showInfoMethod:@selector(setModel:) heightOfCell:[ZStudentLessonOrderCoachCell z_getCellHeight:coachModel] cellType:ZCellTypeClass dataModel:coachModel];
        [self.cellConfigArr addObject:coachCellConfig];
        
        
        
        ZCellConfig *spacCellConfig = [ZCellConfig cellConfigWithClassName:[ZSpaceEmptyCell className] title:[ZSpaceEmptyCell className] showInfoMethod:@selector(setBackColor:) heightOfCell:CGFloatIn750(40) cellType:ZCellTypeClass dataModel:KAdaptAndDarkColor([UIColor colorGrayBG], [UIColor colorBlackBG])];
        [self.cellConfigArr addObject:spacCellConfig];
           
    }
    
    {
       ZStudentDetailOrderSubmitListModel *model = [[ZStudentDetailOrderSubmitListModel alloc] init];
       model.leftImage = @"orderOrgLessonH";
       model.leftTitle = @"课程";
       ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentLessonOrderCompleteCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZStudentLessonOrderCompleteCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:model];
       [self.cellConfigArr addObject:menuCellConfig];
        
        ZStudentDetailOrderSubmitListModel *model1 = [[ZStudentDetailOrderSubmitListModel alloc] init];
        model1.leftTitle = @"单人游泳教学";
        ZCellConfig *menu1CellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentLessonOrderNormalCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZStudentLessonOrderNormalCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:model1];
        [self.cellConfigArr addObject:menu1CellConfig];
        
        ZCellConfig *spacCellConfig = [ZCellConfig cellConfigWithClassName:[ZSpaceEmptyCell className] title:[ZSpaceEmptyCell className] showInfoMethod:@selector(setBackColor:) heightOfCell:CGFloatIn750(40) cellType:ZCellTypeClass dataModel:KAdaptAndDarkColor([UIColor colorGrayBG], [UIColor colorBlackBG])];
        [self.cellConfigArr addObject:spacCellConfig];
           
    }
    
    {
       ZStudentDetailOrderSubmitListModel *model = [[ZStudentDetailOrderSubmitListModel alloc] init];
       model.leftImage = @"orderRevlLesson";
       model.leftTitle = @"预约到校时间";
       ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentLessonOrderCompleteCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZStudentLessonOrderCompleteCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:model];
       [self.cellConfigArr addObject:menuCellConfig];
        
        ZStudentDetailOrderSubmitListModel *model1 = [[ZStudentDetailOrderSubmitListModel alloc] init];
        model1.leftTitle = @"10月26日 周六 14：00";
        model1.rightImage = @"mineLessonRight";
        
        ZCellConfig *menu1CellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentLessonOrderNormalCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZStudentLessonOrderNormalCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:model1];
        [self.cellConfigArr addObject:menu1CellConfig];
        
        ZCellConfig *spacCellConfig = [ZCellConfig cellConfigWithClassName:[ZSpaceEmptyCell className] title:[ZSpaceEmptyCell className] showInfoMethod:@selector(setBackColor:) heightOfCell:CGFloatIn750(40) cellType:ZCellTypeClass dataModel:KAdaptAndDarkColor([UIColor colorGrayBG], [UIColor colorBlackBG])];
        [self.cellConfigArr addObject:spacCellConfig];
    }
    
    {
       ZStudentDetailOrderSubmitListModel *model = [[ZStudentDetailOrderSubmitListModel alloc] init];
       model.leftImage = @"orderUserlLesson";
       model.leftTitle = @"姓名";
       model.rightTitle = @"韩丽";
       ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentLessonOrderCompleteCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZStudentLessonOrderCompleteCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:model];
       [self.cellConfigArr addObject:menuCellConfig];

       ZStudentDetailOrderSubmitListModel *model2 = [[ZStudentDetailOrderSubmitListModel alloc] init];
       model2.leftImage = @"orderPhonelLesson";
       model2.leftTitle = @"手机号码";
       model2.rightTitle = @"1393223432";
       ZCellConfig *menuCellConfig2 = [ZCellConfig cellConfigWithClassName:[ZStudentLessonOrderCompleteCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZStudentLessonOrderCompleteCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:model2];
       [self.cellConfigArr addObject:menuCellConfig2];
        
        ZCellConfig *spacCellConfig = [ZCellConfig cellConfigWithClassName:[ZSpaceEmptyCell className] title:[ZSpaceEmptyCell className] showInfoMethod:@selector(setBackColor:) heightOfCell:CGFloatIn750(40) cellType:ZCellTypeClass dataModel:KAdaptAndDarkColor([UIColor colorGrayBG], [UIColor colorBlackBG])];
        [self.cellConfigArr addObject:spacCellConfig];
    }
    
    
    {
        ZCellConfig *spacSectionCellConfig = [ZCellConfig cellConfigWithClassName:[ZSpaceEmptyCell className] title:[ZSpaceEmptyCell className] showInfoMethod:@selector(setBackColor:) heightOfCell:CGFloatIn750(40) cellType:ZCellTypeClass dataModel:KAdaptAndDarkColor([UIColor colorGrayBG], [UIColor colorBlackBG])];
        [self.cellConfigArr addObject:spacSectionCellConfig];
        
        ZCellConfig *moreIntputCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentLessonOrderMoreInputCell className] title:[ZStudentLessonOrderMoreInputCell className] showInfoMethod:nil heightOfCell:[ZStudentLessonOrderMoreInputCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:nil];
        [self.cellConfigArr addObject:moreIntputCellConfig];
        
        
    }
    ZCellConfig *spacSectionCellConfig = [ZCellConfig cellConfigWithClassName:[ZSpaceEmptyCell className] title:[ZSpaceEmptyCell className] showInfoMethod:@selector(setBackColor:) heightOfCell:CGFloatIn750(40) cellType:ZCellTypeClass dataModel:KAdaptAndDarkColor([UIColor colorGrayBG], [UIColor colorBlackBG])];
    [self.cellConfigArr addObject:spacSectionCellConfig];
    
}


- (void)setNavigation {
    self.isHidenNaviBar = NO;
    [self.navigationItem setTitle:@"确认订单"];
}

- (void)setupMainView {
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectZero];
    bottomView.backgroundColor = KAdaptAndDarkColor([UIColor colorGrayBG], [UIColor colorBlackBG]);
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(CGFloatIn750(140));
        make.left.right.bottom.equalTo(self.view);
    }];
    
    [bottomView addSubview:self.bottomBtn];
    [self.bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bottomView.mas_left).offset(CGFloatIn750(60));
        make.right.equalTo(bottomView.mas_right).offset(CGFloatIn750(-60));
        make.height.mas_equalTo(CGFloatIn750(80));
        make.top.equalTo(bottomView.mas_top).offset(CGFloatIn750(20));
    }];
    
    [self.view addSubview:self.iTableView];
    [_iTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(bottomView.mas_top);
        make.top.equalTo(self.view.mas_top).offset(0);
    }];
}

#pragma mark lazy loading...
-(UITableView *)iTableView {
    if (!_iTableView) {
        _iTableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _iTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _iTableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        if ([_iTableView respondsToSelector:@selector(contentInsetAdjustmentBehavior)]) {
            _iTableView.estimatedRowHeight = 0;
            _iTableView.estimatedSectionHeaderHeight = 0;
            _iTableView.estimatedSectionFooterHeight = 0;
            if (@available(iOS 11.0, *)) {
                _iTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            } else {
                // Fallback on earlier versions
            }
        } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
            self.automaticallyAdjustsScrollViewInsets = NO;
#pragma clang diagnostic pop
        }
        _iTableView.delegate = self;
        _iTableView.dataSource = self;
        _iTableView.backgroundColor = KAdaptAndDarkColor([UIColor colorGrayBG], [UIColor colorBlackBG]);
    }
    return _iTableView;
}


- (UIButton *)bottomBtn {
    if (!_bottomBtn) {
        __weak typeof(self) weakSelf = self;
        _bottomBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        _bottomBtn.layer.masksToBounds = YES;
        _bottomBtn.layer.cornerRadius = CGFloatIn750(40);
        [_bottomBtn setTitle:@"去支付" forState:UIControlStateNormal];
        [_bottomBtn setTitleColor:[UIColor colorWhite] forState:UIControlStateNormal];
        [_bottomBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:CGFloatIn750(38)]];
        [_bottomBtn setBackgroundColor:[UIColor  colorMain] forState:UIControlStateNormal];
        [_bottomBtn bk_whenTapped:^{
            ZStudentLessonOrderSuccessVC *successvc = [[ZStudentLessonOrderSuccessVC alloc] init];
            [weakSelf.navigationController pushViewController:successvc animated:YES];
        }];
    }
    return _bottomBtn;
}


#pragma mark tableView -------datasource-----
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _cellConfigArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZCellConfig *cellConfig = [_cellConfigArr objectAtIndex:indexPath.row];
    ZBaseCell *cell;
    cell = (ZBaseCell*)[cellConfig cellOfCellConfigWithTableView:tableView dataModel:cellConfig.dataModel];
    if ([cellConfig.title isEqualToString:@"ZSpaceEmptyCell"]){
//        ZSpaceEmptyCell *enteryCell = (ZSpaceEmptyCell *)cell;
        
    }
    return cell;
}

#pragma mark tableView ------delegate-----
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZCellConfig *cellConfig = _cellConfigArr[indexPath.row];
    CGFloat cellHeight =  cellConfig.heightOfCell;
    return cellHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ZCellConfig *cellConfig = [_cellConfigArr objectAtIndex:indexPath.row];
    if ([cellConfig.title isEqualToString:@"ZSpaceCell"]) {
        
    }
}

#pragma mark vc delegate-------------------
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}
@end


