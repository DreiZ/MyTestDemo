//
//  ZOrganizationTrachingScheduleNewClassVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/2/26.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationTrachingScheduleNewClassVC.h"

#import "ZOrganizationTimeSelectVC.h"
#import "ZAlertTeacherCheckBoxView.h"
#import "ZTextFieldMultColCell.h"
#import "ZOriganizationTeachingScheduleViewModel.h"
#import "ZBaseUnitModel.h"

@interface ZOrganizationTrachingScheduleNewClassVC ()
@property (nonatomic,strong) UIButton *bottomBtn;
@property (nonatomic,strong) ZOriganizationTeachingScheduleViewModel *viewModel;

@end

@implementation ZOrganizationTrachingScheduleNewClassVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _viewModel.addModel.lessonOrderArr = _lessonOrderArr;
    [self initCellConfigArr];
}

- (void)setDataSource {
    [super setDataSource];
    _viewModel = [[ZOriganizationTeachingScheduleViewModel alloc] init];
}

- (void)initCellConfigArr {
    [super initCellConfigArr];
    
    
    {
        NSArray *textArr = @[@[@"班级名称", @"请输入班级名称", @YES, @"", @"name"],
                             @[@"上课时间", @"选择", @NO, @"rightBlackArrowN", @"time"],
                             @[@"分配教师", @"选择", @NO, @"rightBlackArrowN",  @"teacher"]];
        
        for (int i = 0; i < textArr.count; i++) {
            if (i == 1) {
                ZBaseTextFieldCellModel *cellModel = [[ZBaseTextFieldCellModel alloc] init];
                cellModel.leftTitle = textArr[i][0];
                cellModel.placeholder = textArr[i][1];
                cellModel.isTextEnabled = [textArr[i][2] boolValue];
                cellModel.rightImage = textArr[i][3];
                cellModel.cellTitle = textArr[i][4];
                cellModel.isHiddenLine = YES;
                cellModel.cellHeight = CGFloatIn750(116);
                cellModel.textColor = [UIColor colorTextGray];
                cellModel.leftContentWidth = CGFloatIn750(260);
                cellModel.cellTitle = @"lessonTime";
                
                
                NSMutableArray *multArr = @[].mutableCopy;
                NSMutableArray *tempArr = @[].mutableCopy;
                for (int i = 0; i < self.viewModel.addModel.lessonTimeArr.count; i++) {
                    ZBaseMenuModel *menuModel = self.viewModel.addModel.lessonTimeArr[i];
                    
                    if (menuModel && menuModel.units && menuModel.units.count > 0) {
                        NSMutableArray *tempSubArr = @[].mutableCopy;
                        [tempSubArr addObject:menuModel.name];
                        NSString *subTitle = @"";
                        for (int k = 0; k < menuModel.units.count; k++) {
                            ZBaseUnitModel *unitModel = menuModel.units[k];
                            if (subTitle.length == 0) {
                                subTitle = [NSString stringWithFormat:@"%@",unitModel.data];
                            }else{
                                subTitle = [NSString stringWithFormat:@"%@   %@",subTitle,unitModel.data];
                            }
                        }
                        [tempSubArr addObject:subTitle];
                        
                        [tempArr addObject:tempSubArr];
                    }
                }
                
                for (int j = 0; j < tempArr.count; j++) {
                    ZBaseMultiseriateCellModel *mModel = [[ZBaseMultiseriateCellModel alloc] init];
                    mModel.cellWidth = KScreenWidth - cellModel.leftContentWidth - cellModel.leftMargin - cellModel.rightMargin - cellModel.contentSpace * 2;
                    mModel.rightFont = [UIFont fontSmall];
                    mModel.leftFont = [UIFont fontSmall];
                    mModel.rightColor = [UIColor colorTextGray];
                    mModel.leftColor = [UIColor colorTextGray];
                    mModel.rightDarkColor = [UIColor colorTextGrayDark];
                    mModel.leftDarkColor = [UIColor colorTextGrayDark];
                    mModel.singleCellHeight = CGFloatIn750(44);
                    mModel.rightTitle = tempArr[j][1];
                    mModel.leftTitle = tempArr[j][0];
                    mModel.leftContentSpace = CGFloatIn750(4);
                    mModel.rightContentSpace = CGFloatIn750(16);
                    mModel.leftMargin = CGFloatIn750(2);
                    mModel.rightMargin = CGFloatIn750(2);
                    mModel.isHiddenLine = YES;
                    mModel.textAlignment = NSTextAlignmentLeft;
                    
                    [multArr addObject:mModel];
                }
                cellModel.data = multArr;
                
                ZCellConfig *textCellConfig = [ZCellConfig cellConfigWithClassName:[ZTextFieldMultColCell className] title:cellModel.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZTextFieldMultColCell z_getCellHeight:cellModel] cellType:ZCellTypeClass dataModel:cellModel];
                [self.cellConfigArr addObject:textCellConfig];
            }else{
                ZBaseTextFieldCellModel *cellModel = [[ZBaseTextFieldCellModel alloc] init];
                cellModel.leftTitle = textArr[i][0];
                cellModel.placeholder = textArr[i][1];
                cellModel.isTextEnabled = [textArr[i][2] boolValue];
                cellModel.rightImage = textArr[i][3];
                cellModel.cellTitle = textArr[i][4];
                cellModel.isHiddenLine = YES;
                cellModel.cellHeight = CGFloatIn750(116);
                cellModel.textColor = [UIColor colorTextGray];
                if (i == 0) {
                    cellModel.content = self.viewModel.addModel.class_Name;
                    cellModel.max = 10;
                    cellModel.formatterType = ZFormatterTypeAny;
                }else{
                    cellModel.content = self.viewModel.addModel.teacherName;
                }
                ZCellConfig *textCellConfig = [ZCellConfig cellConfigWithClassName:[ZTextFieldCell className] title:cellModel.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZTextFieldCell z_getCellHeight:cellModel] cellType:ZCellTypeClass dataModel:cellModel];
                [self.cellConfigArr addObject:textCellConfig];
            }
        }
    }
}


- (void)setNavigation {
    self.isHidenNaviBar = NO;
    [self.navigationItem setTitle:@"新增排课"];
}

- (void)setupMainView {
    [super setupMainView];
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, CGFloatIn750(170))];
    bottomView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
    [bottomView addSubview:self.bottomBtn];
    [self.bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bottomView.mas_left).offset(CGFloatIn750(60));
        make.right.equalTo(bottomView.mas_right).offset(CGFloatIn750(-60));
        make.height.mas_equalTo(CGFloatIn750(80));
        make.top.equalTo(bottomView.mas_top).offset(CGFloatIn750(20));
    }];
    
    [self.iTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom);
        make.top.equalTo(self.view.mas_top).offset(10);
    }];
    self.iTableView.tableFooterView = bottomView;
}

#pragma mark - lazy loading...
- (UIButton *)bottomBtn {
    if (!_bottomBtn) {
        __weak typeof(self) weakSelf = self;
        _bottomBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        _bottomBtn.layer.masksToBounds = YES;
        _bottomBtn.layer.cornerRadius = CGFloatIn750(40);
        [_bottomBtn setTitle:@"保存" forState:UIControlStateNormal];
        [_bottomBtn setTitleColor:[UIColor colorWhite] forState:UIControlStateNormal];
        [_bottomBtn.titleLabel setFont:[UIFont fontContent]];
        [_bottomBtn setBackgroundColor:[UIColor  colorMain] forState:UIControlStateNormal];
        [_bottomBtn bk_whenTapped:^{
            if (!ValidStr(weakSelf.viewModel.addModel.class_Name)) {
                [TLUIUtility showErrorHint:@"请输入班级名称"];
                return ;
            }
            if (!ValidArray(weakSelf.viewModel.addModel.lessonTimeArr)) {
                [TLUIUtility showErrorHint:@"请添加开课时间"];
                return ;
            }
            if (!ValidStr(weakSelf.viewModel.addModel.teacherName)) {
                [TLUIUtility showErrorHint:@"请选择任课老师"];
                return ;
            }
            [weakSelf updateData];
        }];
    }
    return _bottomBtn;
}


- (void)updateData {
    NSMutableDictionary *params = @{}.mutableCopy;
    if (self.isBu) {
        [params setObject:@"2" forKey:@"type"];
    }else{
        [params setObject:@"1" forKey:@"type"];
    }
    [params setObject:SafeStr(self.school.schoolID) forKey:@"stores_id"];
    [params setObject:SafeStr(self.viewModel.addModel.teacherID) forKey:@"teacher_id"];
    [params setObject:SafeStr(self.viewModel.addModel.class_Name) forKey:@"name"];
    NSMutableArray *tempArr = @[].mutableCopy;
    if (ValidArray(self.viewModel.addModel.lessonOrderArr)) {
        for (ZOriganizationStudentListModel *model in self.viewModel.addModel.lessonOrderArr) {
            [tempArr addObject:model.studentID];
        }
    }
    [params setObject:tempArr forKey:@"student_ids"];
    
    NSMutableDictionary *orderDict = @{}.mutableCopy;
    for (ZBaseMenuModel *menuModel in self.viewModel.addModel.lessonTimeArr) {
        if (menuModel && menuModel.units && menuModel.units.count > 0) {
            
            NSMutableArray *tempSubArr = @[].mutableCopy;
            for (int k = 0; k < menuModel.units.count; k++) {
                ZBaseUnitModel *unitModel = menuModel.units[k];
                [tempSubArr addObject:SafeStr(unitModel.data)];
                
            }
            
            [orderDict setObject:tempSubArr forKey:SafeStr([menuModel.name weekToIndex])];
        }
    }
    
    [params setObject:orderDict forKey:@"classes_date"];
    
    [TLUIUtility showLoading:@""];
    [ZOriganizationTeachingScheduleViewModel addCourseClass:params completeBlock:^(BOOL isSuccess, NSString *message) {
        [TLUIUtility hiddenLoading];
        if (isSuccess) {
            [TLUIUtility showSuccessHint:message];
            [self.navigationController popViewControllerAnimated:YES];
            return ;
        }else {
            [TLUIUtility showErrorHint:message];
        }
    }];
}

#pragma mark tableView ------delegate-----
- (void)zz_tableView:(UITableView *)tableView cell:(UITableViewCell *)cell cellForRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig{
    __weak typeof(self) weakSelf = self;
    if ([cellConfig.title isEqualToString:@"lessonTime"]) {
        ZTextFieldMultColCell *lcell = (ZTextFieldMultColCell *)cell;
        lcell.selectBlock = ^{
            ZOrganizationTimeSelectVC *svc = [[ZOrganizationTimeSelectVC alloc] init];
            svc.timeArr = weakSelf.viewModel.addModel.lessonTimeArr;
            svc.timeBlock = ^(NSMutableArray <ZBaseMenuModel *>*timeArr) {
                weakSelf.viewModel.addModel.lessonTimeArr = timeArr;
                [weakSelf initCellConfigArr];
                [weakSelf.iTableView reloadData];
            };
            [weakSelf.navigationController pushViewController:svc animated:YES];
        };
        
    }else if ([cellConfig.title isEqualToString:@"name"]) {
        ZTextFieldCell *lcell = (ZTextFieldCell *)cell;
        lcell.valueChangeBlock = ^(NSString * text) {
            weakSelf.viewModel.addModel.class_Name = text;
        };
    }
}

- (void)zz_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
    __weak typeof(self) weakSelf = self;
    if ([cellConfig.title isEqualToString:@"school"]) {
       
    }else if ([cellConfig.title isEqualToString:@"teacher"]) {
        [self.iTableView endEditing:YES];
        [ZAlertTeacherCheckBoxView setAlertName:@"选择教师" schoolID:self.school.schoolID handlerBlock:^(NSInteger index,ZOriganizationTeacherListModel *model) {
            if (model) {
                weakSelf.viewModel.addModel.teacherName = model.teacher_name;
                weakSelf.viewModel.addModel.teacherID  = model.teacherID;
                [weakSelf initCellConfigArr];
                [weakSelf.iTableView reloadData];
            }
        }];
    } 
}
@end
