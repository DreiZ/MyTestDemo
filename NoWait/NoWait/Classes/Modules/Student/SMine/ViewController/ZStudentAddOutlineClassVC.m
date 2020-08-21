//
//  ZStudentAddOutlineClassVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/8/21.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentAddOutlineClassVC.h"
#import "ZOrganizationTimeSelectVC.h"
#import "ZAlertTeacherCheckBoxView.h"
#import "ZTextFieldMultColCell.h"
#import "ZOriganizationTeachingScheduleViewModel.h"
#import "ZBaseUnitModel.h"
#import "ZAlertLessonCheckBoxView.h"
#import "ZOrganizationTrachingScheduleOutlineErweimaVC.h"

@interface ZStudentAddOutlineClassVC ()
@property (nonatomic,strong) UIButton *bottomBtn;
@property (nonatomic,strong) ZOriganizationTeachingScheduleViewModel *viewModel;

@end

@implementation ZStudentAddOutlineClassVC

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
        NSArray *textArr = @[@[@"课程简称", @"请输入简称", @YES, @"", @"name",@"15",SafeStr(self.viewModel.addStudentModel.courses_name)],
                             @[@"课程节数", @"请输入课程节数", @YES, @"", @"num",@"3",SafeStr(self.viewModel.addStudentModel.course_num)],
                             @[@"单节课时", @"请输入单节课时", @YES, @"分钟", @"min",@"3",SafeStr(self.viewModel.addStudentModel.singleTime )],
                             @[@"上课时间", @"选择(非必选)", @NO, @"rightBlackArrowN", @"time",@"50",@""]];
        
        for (int i = 0; i < textArr.count; i++) {
            if ([textArr[i][4] isEqualToString:@"time"]) {
                ZBaseTextFieldCellModel *cellModel = [[ZBaseTextFieldCellModel alloc] init];
                cellModel.leftTitle = textArr[i][0];
                cellModel.placeholder = textArr[i][1];
                cellModel.isTextEnabled = [textArr[i][2] boolValue];
                cellModel.rightImage = textArr[i][3];
                cellModel.cellTitle = textArr[i][4];
                cellModel.isHiddenLine = YES;
                cellModel.cellHeight = CGFloatIn750(86);
                cellModel.textColor = [UIColor colorTextGray];
                cellModel.leftContentWidth = CGFloatIn750(260);
                cellModel.cellTitle = @"lessonTime";
                cellModel.leftFont = [UIFont fontContent];
                
                NSMutableArray *multArr = @[].mutableCopy;
                NSMutableArray *tempArr = @[].mutableCopy;
                for (int i = 0; i < self.viewModel.addStudentModel.lessonTimeArr.count; i++) {
                    ZBaseMenuModel *menuModel = self.viewModel.addStudentModel.lessonTimeArr[i];
                    
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
                    ZLineCellModel *mModel = ZLineCellModel.zz_lineCellModel_create(@"sub")
                    .zz_titleLeft(tempArr[j][0])
                    .zz_titleRight(tempArr[j][1])
                    .zz_lineHidden(YES)
                    .zz_rightMultiLine(YES)
                    .zz_alignmentRight(NSTextAlignmentLeft)
                    .zz_marginLeft(CGFloatIn750(2))
                    .zz_marginRight(CGFloatIn750(2))
                    .zz_cellHeight(CGFloatIn750(44))
                    .zz_fontLeft([UIFont fontSmall])
                    .zz_fontRight([UIFont fontSmall])
                    .zz_colorLeft([UIColor colorTextGray])
                    .zz_colorDarkLeft([UIColor colorTextGrayDark])
                    .zz_colorRight([UIColor colorTextGray])
                    .zz_colorDarkRight([UIColor colorTextGrayDark])
                    .zz_cellWidth(KScreenWidth - cellModel.leftContentWidth - cellModel.leftMargin - cellModel.rightMargin - cellModel.contentSpace * 3);
                    
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
//                cellModel.rightImage = textArr[i][3];
                cellModel.cellTitle = textArr[i][4];
                cellModel.isHiddenLine = YES;
                cellModel.cellHeight = CGFloatIn750(86);
                cellModel.textColor = [UIColor colorTextGray];
                cellModel.leftFont = [UIFont fontContent];
                
                if ([textArr[i][4] isEqualToString:@"name"]) {
                    cellModel.content = self.viewModel.addStudentModel.courses_name;
                    cellModel.max = 15;
                    cellModel.formatterType = ZFormatterTypeAnyByte;
                }else if ([textArr[i][4] isEqualToString:@"num"]){
                    cellModel.content = self.viewModel.addStudentModel.course_num;
                    cellModel.rightTitle = @"节";
                }else if([textArr[i][4] isEqualToString:@"min"]){
                    cellModel.content = self.viewModel.addStudentModel.singleTime;
                    cellModel.rightTitle = @"分钟";
                }
                ZCellConfig *textCellConfig = [ZCellConfig cellConfigWithClassName:[ZTextFieldCell className] title:cellModel.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZTextFieldCell z_getCellHeight:cellModel] cellType:ZCellTypeClass dataModel:cellModel];
                [self.cellConfigArr addObject:textCellConfig];
            }
        }
    }
}


- (void)setNavigation {
    self.isHidenNaviBar = NO;
    [self.navigationItem setTitle:@"添加课程"];
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
            if (!ValidStr(weakSelf.viewModel.addStudentModel.courses_name)) {
                [TLUIUtility showErrorHint:@"请输入课程简称"];
                return ;
            }
            if (!ValidStr(weakSelf.viewModel.addStudentModel.course_num)) {
                [TLUIUtility showErrorHint:@"请输入课程节数"];
                return ;
            }
            if (!ValidStr(weakSelf.viewModel.addStudentModel.singleTime)) {
                [TLUIUtility showErrorHint:@"请输入课程单节课时"];
                return ;
            }
            
            if(!ValidArray(self.viewModel.addStudentModel.lessonTimeArr)){
                [TLUIUtility showErrorHint:@"请选择上课时间"];
                return ;
            }
            [weakSelf updateData];
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _bottomBtn;
}


- (void)updateData {
    NSMutableDictionary *params = @{}.mutableCopy;
    
    [params setObject:SafeStr(self.viewModel.addStudentModel.singleTime) forKey:@"course_min"];
    [params setObject:SafeStr(self.viewModel.addStudentModel.courses_name) forKey:@"name"];
    [params setObject:SafeStr(self.viewModel.addStudentModel.course_num) forKey:@"course_number"];
    
    if (self.viewModel.addStudentModel.lessonTimeArr.count > 0) {
        NSMutableDictionary *orderDict = @{}.mutableCopy;
        for (ZBaseMenuModel *menuModel in self.viewModel.addStudentModel.lessonTimeArr) {
            if (menuModel && menuModel.units && menuModel.units.count > 0) {
                
                NSMutableArray *tempSubArr = @[].mutableCopy;
                for (int k = 0; k < menuModel.units.count; k++) {
                    ZBaseUnitModel *unitModel = menuModel.units[k];
                    [tempSubArr addObject:SafeStr(unitModel.data)];
                    
                }
                
                [orderDict setObject:tempSubArr forKey:SafeStr([menuModel.name zz_weekToIndex])];
            }
        }
        
        [params setObject:orderDict forKey:@"week_date"];
    }
    
    __weak typeof(self) weakSelf = self;
    [TLUIUtility showLoading:@""];
    [ZOriganizationTeachingScheduleViewModel addStudentCourseClass:params completeBlock:^(BOOL isSuccess, NSString *message) {
        [TLUIUtility hiddenLoading];
        if (isSuccess) {
            [weakSelf.navigationController popViewControllerAnimated:YES];
            [TLUIUtility showSuccessHint:message];
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
            if (!ValidStr(weakSelf.viewModel.addStudentModel.singleTime)) {
                [TLUIUtility showErrorHint:@"请先输入单节课时"];
                return;
            }
            ZOrganizationTimeSelectVC *svc = [[ZOrganizationTimeSelectVC alloc] init];
            svc.course_min = weakSelf.viewModel.addStudentModel.singleTime;
            svc.timeArr = weakSelf.viewModel.addStudentModel.lessonTimeArr;
            svc.timeBlock = ^(NSMutableArray <ZBaseMenuModel *>*timeArr) {
                weakSelf.viewModel.addStudentModel.lessonTimeArr = timeArr;
                [weakSelf initCellConfigArr];
                [weakSelf.iTableView reloadData];
            };
            [weakSelf.navigationController pushViewController:svc animated:YES];
        };
        
    }else if ([cellConfig.title isEqualToString:@"name"]) {
        ZTextFieldCell *lcell = (ZTextFieldCell *)cell;
        lcell.valueChangeBlock = ^(NSString * text) {
            weakSelf.viewModel.addStudentModel.courses_name = text;
        };
    }else if ([cellConfig.title isEqualToString:@"num"]) {
        ZTextFieldCell *lcell = (ZTextFieldCell *)cell;
        lcell.valueChangeBlock = ^(NSString * text) {
            weakSelf.viewModel.addStudentModel.course_num = text;
        };
    }else if ([cellConfig.title isEqualToString:@"min"]) {
        ZTextFieldCell *lcell = (ZTextFieldCell *)cell;
        lcell.valueChangeBlock = ^(NSString * text) {
            weakSelf.viewModel.addStudentModel.singleTime = text;
        };
    }
}

- (void)zz_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
//    __weak typeof(self) weakSelf = self;
    if ([cellConfig.title isEqualToString:@"school"]) {
       
    }
}

@end


