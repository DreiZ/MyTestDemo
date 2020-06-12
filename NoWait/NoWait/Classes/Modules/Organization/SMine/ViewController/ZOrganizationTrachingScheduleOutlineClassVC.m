//
//  ZOrganizationTrachingScheduleOutlineClassVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/4/20.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationTrachingScheduleOutlineClassVC.h"
#import "ZOrganizationTimeSelectVC.h"
#import "ZAlertTeacherCheckBoxView.h"
#import "ZTextFieldMultColCell.h"
#import "ZOriganizationTeachingScheduleViewModel.h"
#import "ZBaseUnitModel.h"
#import "ZAlertLessonCheckBoxView.h"
#import "ZOrganizationTrachingScheduleOutlineErweimaVC.h"

@interface ZOrganizationTrachingScheduleOutlineClassVC ()
@property (nonatomic,strong) UIButton *bottomBtn;
@property (nonatomic,strong) ZOriganizationTeachingScheduleViewModel *viewModel;

@end

@implementation ZOrganizationTrachingScheduleOutlineClassVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
                             @[@"选择课程", @"选择", @NO, @"rightBlackArrowN",  @"lesson"],
                             @[@"分配教师", @"选择", @NO, @"rightBlackArrowN",  @"teacher"],
                             @[@"上课时间", @"选择(非必选)", @NO, @"rightBlackArrowN", @"time"],
                             @[@"开课日期", @"选择(非必选)", @NO, @"rightBlackArrowN",  @"openTime"]];
        
        for (int i = 0; i < textArr.count; i++) {
            if ([textArr[i][4] isEqualToString:@"time"]) {
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
                    mModel.cellWidth = KScreenWidth - cellModel.leftContentWidth - cellModel.leftMargin - cellModel.rightMargin - cellModel.contentSpace * 3;
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
                if ([textArr[i][4] isEqualToString:@"name"]) {
                    cellModel.content = self.viewModel.addModel.class_Name;
                    cellModel.max = 10;
                    cellModel.formatterType = ZFormatterTypeAny;
                }else if ([textArr[i][4] isEqualToString:@"openTime"]){
                    cellModel.content = [self.viewModel.addModel.openTime timeStringWithFormatter:@"yyyy-MM-dd"];
                }else if([textArr[i][4] isEqualToString:@"lesson"]){
                    cellModel.content = self.viewModel.addModel.courses_name;
                }else if([textArr[i][4] isEqualToString:@"teacher"]){
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
    [self.navigationItem setTitle:@"线下排课"];
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
        [_bottomBtn setBackgroundColor:adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]) forState:UIControlStateNormal];
        [_bottomBtn bk_addEventHandler:^(id sender) {
//            ZOrganizationTrachingScheduleOutlineErweimaVC *evc = [[ZOrganizationTrachingScheduleOutlineErweimaVC alloc] init];
//            [weakSelf.navigationController pushViewController:evc animated:YES];
            if (!ValidStr(weakSelf.viewModel.addModel.class_Name)) {
                [TLUIUtility showErrorHint:@"请输入班级名称"];
                return ;
            }
//            if (!ValidArray(weakSelf.viewModel.addModel.lessonTimeArr)) {
//                [TLUIUtility showErrorHint:@"请添加开课时间"];
//                return ;
//            }
            if (!ValidStr(weakSelf.viewModel.addModel.courses_id)) {
                [TLUIUtility showErrorHint:@"请选择课程"];
                return ;
            }
            if (!ValidStr(weakSelf.viewModel.addModel.teacherName)) {
                [TLUIUtility showErrorHint:@"请选择任课教师"];
                return ;
            }
            
            [weakSelf updateData];
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _bottomBtn;
}


- (void)updateData {
    NSMutableDictionary *params = @{}.mutableCopy;
    
    [params setObject:SafeStr([ZUserHelper sharedHelper].school.schoolID) forKey:@"stores_id"];
    [params setObject:SafeStr(self.viewModel.addModel.courses_id) forKey:@"courses_id"];
    [params setObject:SafeStr(self.viewModel.addModel.teacherID) forKey:@"teacher_id"];
    [params setObject:SafeStr(self.viewModel.addModel.class_Name) forKey:@"name"];
    
    if (self.viewModel.addModel.lessonTimeArr.count > 0) {
        NSMutableDictionary *orderDict = @{}.mutableCopy;
        for (ZBaseMenuModel *menuModel in self.viewModel.addModel.lessonTimeArr) {
            if (menuModel && menuModel.units && menuModel.units.count > 0) {
                
                NSMutableArray *tempSubArr = @[].mutableCopy;
                for (int k = 0; k < menuModel.units.count; k++) {
                    ZBaseUnitModel *unitModel = menuModel.units[k];
                    [tempSubArr addObject:SafeStr(unitModel.data)];
                    
                }
                
                [orderDict setObject:tempSubArr forKey:SafeStr([menuModel.name zz_weekToIndex])];
            }
        }
        
        [params setObject:orderDict forKey:@"classes_date"];
    }
    if (self.viewModel.addModel.openTime) {
        [params setObject:self.viewModel.addModel.openTime forKey:@"start_time"];
    }
    
    __weak typeof(self) weakSelf = self;
    [TLUIUtility showLoading:@""];
    [ZOriganizationTeachingScheduleViewModel addClassQrcode:params completeBlock:^(BOOL isSuccess, NSString *message) {
        [TLUIUtility hiddenLoading];
        if (isSuccess) {
            ZOriganizationStudentCodeAddModel *model = [[ZOriganizationStudentCodeAddModel alloc] init];
            model.teacher_name = weakSelf.viewModel.addModel.teacherName;
            model.teacher_image = weakSelf.viewModel.addModel.teacherImage;
            model.courses_name = weakSelf.viewModel.addModel.courses_name;
            model.class_name = weakSelf.viewModel.addModel.class_Name;

            model.url = message;
            model.nick_name = weakSelf.viewModel.addModel.teacherName;
            model.image = weakSelf.viewModel.addModel.teacherImage;
            ZOrganizationTrachingScheduleOutlineErweimaVC *evc = [[ZOrganizationTrachingScheduleOutlineErweimaVC alloc] init];
            evc.codeAddModel = model;
            [weakSelf.navigationController pushViewController:evc animated:YES];
            return ;
        }else {
            [TLUIUtility showErrorHint:message];
        }
    }];
}

#pragma mark - tableView ------delegate-----
- (void)zz_tableView:(UITableView *)tableView cell:(UITableViewCell *)cell cellForRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig{
    __weak typeof(self) weakSelf = self;
    if ([cellConfig.title isEqualToString:@"lessonTime"]) {
        ZTextFieldMultColCell *lcell = (ZTextFieldMultColCell *)cell;
        lcell.selectBlock = ^{
            if (!ValidStr(weakSelf.viewModel.addModel.courses_id)) {
                [TLUIUtility showErrorHint:@"请先选择课程"];
                return;
            }
            ZOrganizationTimeSelectVC *svc = [[ZOrganizationTimeSelectVC alloc] init];
            svc.course_min = weakSelf.viewModel.addModel.course_min;
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
        if (!ValidStr(weakSelf.viewModel.addModel.courses_id)) {
            [TLUIUtility showErrorHint:@"请先选择课程"];
            return;
        }
        [ZAlertTeacherCheckBoxView setAlertName:@"选择教师" schoolID:self.viewModel.addModel.courses_id handlerBlock:^(NSInteger index,ZOriganizationTeacherListModel *model) {
            if (model) {
                weakSelf.viewModel.addModel.teacherName = model.teacher_name;
                weakSelf.viewModel.addModel.teacherID  = model.teacherID;
                weakSelf.viewModel.addModel.teacherImage  = model.image;
                [weakSelf initCellConfigArr];
                [weakSelf.iTableView reloadData];
            }
        }];
    }else if ([cellConfig.title isEqualToString:@"openTime"]){
        [self.iTableView endEditing:YES];
        [ZDatePickerManager showDatePickerWithTitle:@"开课日期" type:PGDatePickerModeDate handle:^(NSDateComponents * date) {
            date.hour = 0;
            date.minute = 0;
            date.second = 0;
            weakSelf.viewModel.addModel.openTime = [NSString stringWithFormat:@"%ld",(long)[[NSDate dateFromComponents:date] timeIntervalSince1970]];
            [weakSelf initCellConfigArr];
            [weakSelf.iTableView reloadData];
        }];
    }else if([cellConfig.title isEqualToString:@"lesson"]){
        [self.iTableView endEditing:YES];
        [ZAlertLessonCheckBoxView  setAlertName:@"选择课程" schoolID:[ZUserHelper sharedHelper].school.schoolID handlerBlock:^(NSInteger index,ZOriganizationLessonListModel *model) {
            if (model) {
                weakSelf.viewModel.addModel.courses_id = model.lessonID;
                weakSelf.viewModel.addModel.courses_name = model.short_name;
                weakSelf.viewModel.addModel.course_min = model.course_min;
                weakSelf.viewModel.addModel.lessonTimeArr = model.fix_timeArr;
                [weakSelf initCellConfigArr];
                [weakSelf.iTableView reloadData];
            }
        }];
    }
}

@end

