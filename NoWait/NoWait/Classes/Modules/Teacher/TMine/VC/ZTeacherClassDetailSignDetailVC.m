//
//  ZTeacherClassDetailSignDetailVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/4/13.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZTeacherClassDetailSignDetailVC.h"
#import "ZTeacherMineSignListCell.h"

#import "ZTeacherClassDetailVC.h"
#import "ZOriganizationClassViewModel.h"
#import "ZOrganizationClassDetailStudentListVC.h"
#import "ZAlertView.h"

#import "ZTeacherMineSignListDetailTitleCell.h"
#import "ZTeacherMineSignListDetailListCell.h"
#import "ZTeacherSignTopTitleView.h"
#import "ZTeacherSignStudentListBottomView.h"
#import "ZSignViewModel.h"
#import "ZMineSignListDetailImageCell.h"

#import "ZOriganizationLessonViewModel.h"
#import "ZAlertImageView.h"
#import "ZAlertView.h"

@interface ZTeacherClassDetailSignDetailVC ()
@property (nonatomic,strong) ZOriganizationSignListNetModel *detailModel;
@property (nonatomic,strong) NSMutableArray *list;
@property (nonatomic,strong) ZTeacherSignTopTitleView *topTitleView;
@property (nonatomic,strong) ZTeacherSignStudentListBottomView *bottomView;
@property (nonatomic,strong) UIButton *navRightBtn;
@property (nonatomic,strong) UIImage *avterImage;

@end

@implementation ZTeacherClassDetailSignDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _list = @[].mutableCopy;
    
    self.isTeacher = [[ZUserHelper sharedHelper].user.type intValue] == 2?YES:NO;
    
    [self refreshData];
    [self setNavigation];
    [self initCellConfigArr];
    [self setTableViewRefreshHeader];
    [self setTableViewEmptyDataDelegate];
    [self setIsEdit:NO];
}

- (void)initCellConfigArr {
    [super initCellConfigArr];
    self.model.index = [self.model.now_progress intValue];
//    /类型 1：签课 2：教师代签 3：补签 4：请假 5：旷课 6:待签课 7:未设置课程进度
    
    if (ValidArray(self.detailModel.image)) {
        ZCellConfig *listCellConfig = [ZCellConfig cellConfigWithClassName:[ZMineSignListDetailImageCell className] title:[ZMineSignListDetailImageCell className] showInfoMethod:@selector(setDetailModel:) heightOfCell:[ZMineSignListDetailImageCell z_getCellHeight:self.detailModel] cellType:ZCellTypeClass dataModel:self.detailModel];
        [self.cellConfigArr addObject:listCellConfig];
        
        [self.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(20))];
    }
    
    [self.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(20))];
    
    NSArray *tarr = @[@"签课",@"教师代签",@"补签",@"请假",@"旷课",@"待签课",@"待设置课程进度"];
    NSArray *iarr = @[@"signzheng",@"signzheng",@"signbu",@"signqing",@"signkuang",@"signkuang",@"signkuang"];
    for (ZOriganizationSignListModel *model in self.detailModel.list) {
        ZBaseSingleCellModel *cellmodel = [[ZBaseSingleCellModel alloc] init];
         cellmodel.rightTitle = [NSString stringWithFormat:@"%ld人",model.list.count];
        if ([model.type intValue] <= tarr.count && [model.type intValue] > 0) {
            cellmodel.leftImage = iarr[[model.type intValue] -1];
            cellmodel.leftTitle = tarr[[model.type intValue] -1];
        }
        if ([self.detailModel.sign_time isEqualToString:@"0"]) {
            model.isOpen = NO;
        }else if ([self.detailModel.sign_time length] == 10){
            model.isOpen = YES;
        }
        if ([self.model.status intValue] == 3) {
            model.isOpen = NO;
        }
        model.isTeacher = self.isTeacher;
        cellmodel.data = model;
        ZCellConfig *orderCellConfig = [ZCellConfig cellConfigWithClassName:[ZTeacherMineSignListDetailTitleCell className] title:[ZTeacherMineSignListDetailTitleCell className] showInfoMethod:@selector(setModel:) heightOfCell:[ZTeacherMineSignListDetailTitleCell z_getCellHeight:cellmodel] cellType:ZCellTypeClass dataModel:cellmodel];
        [self.cellConfigArr addObject:orderCellConfig];
        
        ZCellConfig *listCellConfig = [ZCellConfig cellConfigWithClassName:[ZTeacherMineSignListDetailListCell className] title:[ZTeacherMineSignListDetailListCell className] showInfoMethod:@selector(setModel:) heightOfCell:[ZTeacherMineSignListDetailListCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
        [self.cellConfigArr addObject:listCellConfig];
        
        [self.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(60))];
    }
    _topTitleView.model = self.model;
    _topTitleView.time = self.detailModel.sign_time;
    
    if (![self.detailModel.sign_time isEqualToString:@"0"] && !ValidArray(self.detailModel.image) && self.isTeacher) {
        [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:self.navRightBtn]];
    }else{
       [self.navigationItem setRightBarButtonItem:nil];
    }
}


- (void)setNavigation {
    self.isHidenNaviBar = NO;
    
    [self.navigationItem setTitle:self.model.stores_courses_name];
    if (!self.isTeacher) {
        [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:self.navRightBtn]];
    }
}

- (void)setupMainView {
    [super setupMainView];
    
    [self.view addSubview:self.topTitleView];
    [self.topTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.height.mas_equalTo(CGFloatIn750(88));
    }];
    
    [self.view addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom).offset(-safeAreaBottom());
        make.height.mas_equalTo(CGFloatIn750(90));
    }];
    
    [self.iTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.bottomView.mas_top);
        make.top.equalTo(self.topTitleView.mas_bottom).offset(10);
    }];
}

- (void)setIsEdit:(BOOL)isEdit {
    if (isEdit) {
        [self.bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view);
            make.bottom.equalTo(self.view.mas_bottom).offset(-safeAreaBottom());
            make.height.mas_equalTo(CGFloatIn750(90));
        }];
    }else{
        [self.bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view);
            make.top.equalTo(self.view.mas_bottom);
            make.height.mas_equalTo(CGFloatIn750(90));
        }];
    }
}

#pragma mark - lazy loading
- (ZTeacherSignTopTitleView *)topTitleView {
    if (!_topTitleView) {
        __weak typeof(self) weakSelf = self;
        _topTitleView = [[ZTeacherSignTopTitleView alloc] init];
        _topTitleView.model = self.model;
        _topTitleView.handleBlock = ^(NSInteger index) {
            if (index == 0) {
                weakSelf.model.now_progress = [NSString stringWithFormat:@"%d",[weakSelf.model.now_progress intValue] - 1];
            }else{
                weakSelf.model.now_progress = [NSString stringWithFormat:@"%d",[weakSelf.model.now_progress intValue] + 1];
            }
            [weakSelf refreshData];
        };
    }
    return _topTitleView;
}


- (ZTeacherSignStudentListBottomView *)bottomView {
    if (!_bottomView) {
        __weak typeof(self) weakSelf = self;
        _bottomView = [[ZTeacherSignStudentListBottomView alloc] init];
        _bottomView.handleBlock = ^(NSInteger index) {
            [weakSelf teacherSign:index];
        };
    }
    return _bottomView;
}


- (UIButton *)navRightBtn {
    if (!_navRightBtn) {
        __weak typeof(self) weakSelf = self;
        _navRightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, CGFloatIn750(90), CGFloatIn750(50))];
        
        [_navRightBtn setBackgroundColor:[UIColor colorMain] forState:UIControlStateNormal];
        
        UIImageView *photo = [[UIImageView alloc] initWithFrame:CGRectMake(CGFloatIn750(30), CGFloatIn750(10), CGFloatIn750(30), CGFloatIn750(30) *(45.0/55.0f))];
        photo.image = [[UIImage imageNamed:@"camera_hint"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        photo.tintColor = [UIColor whiteColor];
        photo.layer.masksToBounds = YES;
        [_navRightBtn addSubview:photo];
        
        ViewRadius(_navRightBtn, CGFloatIn750(25));
        [_navRightBtn bk_addEventHandler:^(id sender) {
            [[ZImagePickerManager sharedManager] setImagesWithMaxCount:1 SelectMenu:^(NSArray<ZImagePickerModel *> *list) {
                if (list && list.count > 0) {
                    weakSelf.avterImage = list[0].image;
                    if (weakSelf.avterImage) {
                        [ZAlertImageView setAlertWithTitle:@"小提示" subTitle:@"确定上传此签到照片？" image:weakSelf.avterImage leftBtnTitle:@"取消" rightBtnTitle:@"确定" handlerBlock:^(NSInteger index) {
                            if (index == 1) {
                                 [ZOriganizationLessonViewModel uploadImageList:@{@"type":@"9",@"imageKey":@{@"file":list[0].image}} completeBlock:^(BOOL isSuccess, id data) {
                                   if (isSuccess) {
                                       [weakSelf updateLessonSign:SafeStr(data)];
                                   }else{
                                       weakSelf.avterImage = nil;
                                   }
                               }];
                            }
                        }];
                    }
                }
            }];
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _navRightBtn;
}

#pragma mark - tableView -------datasource-----
- (void)zz_tableView:(UITableView *)tableView cell:(UITableViewCell *)cell cellForRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
    __weak typeof(self) weakSelf = self;
    if ([cellConfig.title isEqualToString:@"ZTeacherMineSignListDetailListCell"]){
        ZTeacherMineSignListDetailListCell *enteryCell = (ZTeacherMineSignListDetailListCell *)cell;
        enteryCell.handleBlock = ^(ZOriganizationSignListModel *model) {
            [weakSelf initCellConfigArr];
            [weakSelf.iTableView reloadData];
        };
    }else if ([cellConfig.title isEqualToString:@"ZTeacherMineSignListDetailTitleCell"]){
        ZTeacherMineSignListDetailTitleCell *lcell = (ZTeacherMineSignListDetailTitleCell *)cell;
        lcell.handleBlock = ^(ZOriganizationSignListModel *model) {
            if (model.isEdit) {
                model.isEdit = NO;
                [weakSelf initCellConfigArr];
                [weakSelf.iTableView reloadData];
            }else{
                [self.detailModel.list enumerateObjectsUsingBlock:^(ZOriganizationSignListModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    if (obj == model) {
                        obj.isEdit = YES;
                    }else{
                        obj.isEdit = NO;
                    }
                }];
                [weakSelf initCellConfigArr];
                [weakSelf.iTableView reloadData];
            }
            ZOriganizationSignListModel *editModel = [weakSelf checkEditModel];
            if (editModel) {
                [weakSelf setIsEdit:YES];
            }else{
                [weakSelf setIsEdit:NO];
            }
            weakSelf.bottomView.type = editModel.type;
        };
    }
}

- (void)zz_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
     if ([cellConfig.title isEqualToString:@"ZTeacherMineSignListCell"]){
         ZOriganizationClassListModel *model = cellConfig.dataModel;
         ZTeacherClassDetailVC *dvc = [[ZTeacherClassDetailVC alloc] init];
         dvc.model.courses_name = model.courses_name;
         dvc.model.classID = model.classID;
         dvc.model.name = model.name;
         dvc.model.nums = model.nums;
         dvc.model.status = model.status;
         [self.navigationController pushViewController:dvc animated:YES];
    }
}


#pragma mark - 数据处理
- (void)refreshData {
    __weak typeof(self) weakSelf = self;
    self.loading = YES;
    [ZOriganizationClassViewModel getMyClassSignList:@{@"courses_class_id":SafeStr(self.model.classID),@"courses_num":SafeStr(self.model.now_progress)} completeBlock:^(BOOL isSuccess, ZOriganizationSignListNetModel *addModel) {
        self.loading = NO;
        if (isSuccess) {
            [weakSelf setIsEdit:NO];
            weakSelf.detailModel = addModel;
            [weakSelf initCellConfigArr];
            [weakSelf.iTableView reloadData];
        }
        [weakSelf.iTableView tt_endRefreshing];
    }];
}

- (void)teacherSign:(NSInteger)index {
    NSMutableDictionary *param = @{}.mutableCopy;
    
    if (self.model) {
        [param setObject:self.model.classID forKey:@"courses_class_id"];
    }
    
    if (index == 0) {
        [param setObject:@"2" forKey:@"type"];
    }else if (index == 1){
        [param setObject:@"4" forKey:@"type"];
    }else if (index == 2){
        [param setObject:@"5" forKey:@"type"];
    }else if (index == 3){
        [param setObject:@"3" forKey:@"type"];
    }
    
    
    
    NSMutableArray *ids = @[].mutableCopy;
    NSArray *studentlist = [self selectLessonOrderArr];
    
    
    if (studentlist.count == 0) {
        
        [TLUIUtility showErrorHint:@"您还没有选择学员"];
        return;
    }
    
    for (ZOriganizationSignListStudentModel *studentModel in studentlist) {
        [ids addObject:@{@"student_id":studentModel.student_id,@"nums":SafeStr(studentModel.nums)}];
    }
    [param setObject:ids forKey:@"students"];
//    1：签课 2：老师代签 3：补签 4：请假 5：旷课
    NSString *notice = @"";
    if ([param objectForKey:@"type"]) {
        if ([param[@"type"] isEqualToString:@"2"]) {
            notice = [NSString stringWithFormat:@"确定为这%lu位学员签课吗？", (unsigned long)ids.count];
        }else if ([param[@"type"] isEqualToString:@"3"]) {
            notice = [NSString stringWithFormat:@"确定为这%lu位学员补签吗？", (unsigned long)ids.count];
        }else if ([param[@"type"] isEqualToString:@"4"]) {
            notice = [NSString stringWithFormat:@"确定为这%lu位学员请假吗？", (unsigned long)ids.count];
        }else if ([param[@"type"] isEqualToString:@"5"]) {
            notice = [NSString stringWithFormat:@"确定为这%lu位学员做旷课处理吗？", (unsigned long)ids.count];
        }
    }
    [ZAlertView setAlertWithTitle:@"提示" subTitle:notice leftBtnTitle:@"取消" rightBtnTitle:@"确定" handlerBlock:^(NSInteger index) {
        if (index == 1) {
            [ZSignViewModel teacherSign:param completeBlock:^(BOOL isSuccess, id data) {
                if (isSuccess) {
                    [TLUIUtility showSuccessHint:data];
                    [self refreshData];
                }else{
                    [TLUIUtility showErrorHint:data];
                }
            }];
        }
    }];
}


- (ZOriganizationSignListModel *)checkEditModel {
    for (ZOriganizationSignListModel *model in self.detailModel.list) {
        if (model.isEdit) {
            return model;
        }
    }
    return nil;
}

- (NSMutableArray *)selectLessonOrderArr {
    NSMutableArray *selectArr = @[].mutableCopy;
    for (ZOriganizationSignListModel *model in self.detailModel.list) {
        if (model.isEdit) {
            [model.list enumerateObjectsUsingBlock:^(ZOriganizationSignListStudentModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if (obj.isSelected) {
                    [selectArr addObject:obj];
                }
            }];
        }
    }
    return selectArr;
}

- (void)updateLessonSign:(NSString *)signImageStr {
    __weak typeof(self) weakSelf = self;
    
    [ZOriganizationClassViewModel upLessonImageStr:@{@"courses_class_id":SafeStr(self.model.classID),@"nums":[NSString stringWithFormat:@"%ld",self.model.index],@"image":getJSONStr(@[SafeStr(signImageStr)])} completeBlock:^(BOOL isSuccess, id data) {
        [TLUIUtility hiddenLoading];
        if (isSuccess) {
            [TLUIUtility showSuccessHint:data];
            [weakSelf refreshData];
        }else{
            [TLUIUtility showInfoHint:data];
        }
    }];
}
@end


