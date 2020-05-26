//
//  ZOrganizationClassManageDetailVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/2/26.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationClassManageDetailVC.h"
#import "ZTextFieldMultColCell.h"
#import "ZBaseUnitModel.h"

#import "ZOrganizationClassDetailStudentListVC.h"
#import "ZOrganizationClassDetailStudentListAddVC.h"
#import "ZOriganizationClassViewModel.h"
#import "ZOrganizationTimeSelectVC.h"
#import "ZTeacherClassDetailSignDetailVC.h"
#import "ZAlertMoreView.h"
#import "ZOrganizationTrachingScheduleOutlineErweimaVC.h"

@interface ZOrganizationClassManageDetailVC ()
@property (nonatomic,strong) UIButton *bottomBtn;
@property (nonatomic,strong) UIButton *navLeftBtn;
@property (nonatomic,strong) UIView *bottomView;

@end

@implementation ZOrganizationClassManageDetailVC

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self refreshData];
    [self setNavigation];
    [self initCellConfigArr];
}

- (void)setDataSource {
    [super setDataSource];
}

- (void)initCellConfigArr {
    [super initCellConfigArr];
//     0：全部 1：待开课 2：已开课 3：已结课
    NSString *status = @"";
    self.isOpen = YES;
    switch ([SafeStr(self.model.status) intValue]) {
        case 1:
            status = @"待开课";
            self.isOpen = NO;
            break;
        case 2:
            status = @"已开课";
            break;
        case 3:
            status = @"已结课";
            break;
            
        default:
            break;
    }
    
    NSMutableArray *textArr = @[@[@"校区名称", @"", @"", @"schoolName",SafeStr(self.model.stores_name)],
                         @[@"班级名称", @"", @"", @"className",SafeStr(self.model.name)],
                         @[@"班级人数", @"", @"", @"num",[NSString stringWithFormat:@"%@人",SafeStr(self.model.nums)]],
                         @[@"班级状态", @"", @"", @"classStutas",status],
                         @[@"课程名称", @"", @"", @"lessonName",SafeStr(self.model.stores_courses_name)],
                         @[@"教师名称", @"", @"", @"techerName",SafeStr(self.model.teacher_name)],
                                @[@"开课日期", @"请选择开课日期", !self.isOpen ?@"rightBlackArrowN":@"", @"openTime",[self.model.start_time isEqualToString:@"0"]? @"":SafeStr([self.model.start_time timeStringWithFormatter:@"yyyy-MM-dd"])],
                         @[@"学员列表", @"查看", @"rightBlackArrowN", @"studentList",@"查看"],
                        @[@"上课时间", @"选择上课时间", @"rightBlackArrowN", @"beginTime",@""]].mutableCopy;
    
    if ([self.model.status intValue] == 2 || [self.model.status intValue] == 3) {
        [textArr insertObject:@[@"班级签到", @"查看", @"rightBlackArrowN", @"detail",@"查看"] atIndex:textArr.count-1];
    }
    
    for (int i = 0; i < textArr.count; i++) {
        if ([textArr[i][3] isEqualToString:@"beginTime"]) {
            ZBaseTextFieldCellModel *cellModel = [[ZBaseTextFieldCellModel alloc] init];
            cellModel.leftTitle = textArr[i][0];
            cellModel.placeholder = textArr[i][1];
            cellModel.isTextEnabled = NO;
            cellModel.rightImage = textArr[i][2];
            cellModel.cellTitle = textArr[i][3];
            cellModel.content = textArr[i][4];
            cellModel.isHiddenLine = YES;
            cellModel.cellHeight = CGFloatIn750(108);
            cellModel.rightFont = [UIFont fontContent];
            cellModel.rightColor = [UIColor colorTextGray];
            cellModel.rightDarkColor = [UIColor colorTextGrayDark];
            
            
            NSMutableArray *multArr = @[].mutableCopy;
            NSMutableArray *tempArr = @[].mutableCopy;
            for (int i = 0; i < self.model.classes_dateArr.count; i++) {
                ZBaseMenuModel *menuModel = self.model.classes_dateArr[i];
                
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
                mModel.rightContentSpace = CGFloatIn750(4);
                mModel.leftMargin = CGFloatIn750(2);
                mModel.rightMargin = CGFloatIn750(2);
                mModel.isHiddenLine = YES;
                
                [multArr addObject:mModel];
            }
            cellModel.data = multArr;
            
            ZCellConfig *textCellConfig = [ZCellConfig cellConfigWithClassName:[ZTextFieldMultColCell className] title:cellModel.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZTextFieldMultColCell z_getCellHeight:cellModel] cellType:ZCellTypeClass dataModel:cellModel];
            [self.cellConfigArr addObject:textCellConfig];
        }else{
            ZBaseTextFieldCellModel *cellModel = [[ZBaseTextFieldCellModel alloc] init];
            cellModel.leftTitle = textArr[i][0];
            cellModel.placeholder = textArr[i][1];
            if (!self.isOpen && [textArr[i][3] isEqualToString:@"className"]) {
                cellModel.isTextEnabled = YES;
            }else{
                cellModel.isTextEnabled = NO;
            }
            
            cellModel.rightImage = textArr[i][2];
            cellModel.cellTitle = textArr[i][3];
            cellModel.content = textArr[i][4];
            cellModel.isHiddenLine = YES;
            cellModel.cellHeight = CGFloatIn750(108);
            cellModel.rightFont = [UIFont fontContent];
            cellModel.rightColor = [UIColor colorTextGray];
            cellModel.rightDarkColor = [UIColor colorTextGrayDark];
            
            ZCellConfig *textCellConfig = [ZCellConfig cellConfigWithClassName:[ZTextFieldCell className] title:cellModel.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZTextFieldCell z_getCellHeight:cellModel] cellType:ZCellTypeClass dataModel:cellModel];
            [self.cellConfigArr addObject:textCellConfig];
        }
    }
    
    if ([SafeStr(self.model.status) intValue] == 3) {
         [self.iTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
             make.left.equalTo(self.view.mas_left).offset(CGFloatIn750(0));
             make.right.equalTo(self.view.mas_right).offset(CGFloatIn750(-0));
             make.bottom.equalTo(self.view.mas_bottom).offset(-CGFloatIn750(0));
             make.top.equalTo(self.view.mas_top).offset(-CGFloatIn750(0));
         }];
        self.bottomView.hidden = YES;
    }else{
        self.bottomView.hidden = NO;
        [self.bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.view);
            make.height.mas_equalTo(CGFloatIn750(182));
        }];
        
        [self.iTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view.mas_left).offset(CGFloatIn750(0));
            make.right.equalTo(self.view.mas_right).offset(CGFloatIn750(-0));
            make.bottom.equalTo(self.bottomView.mas_top).offset(-CGFloatIn750(0));
            make.top.equalTo(self.view.mas_top).offset(-CGFloatIn750(0));
        }];
    }
    
    
//    if (_isOpen) {
//        [self.navigationItem setRightBarButtonItem:nil] ;
//    }else{
//        [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:self.navLeftBtn]] ;
//    }
}

- (void)setNavigation {
    self.isHidenNaviBar = NO;
    [self.navigationItem setTitle:@"班级详情"];
}


- (void)setupMainView {
    [super setupMainView];
    if ([SafeStr(self.model.status) intValue] == 3) {
         [self.iTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
             make.left.equalTo(self.view.mas_left).offset(CGFloatIn750(0));
             make.right.equalTo(self.view.mas_right).offset(CGFloatIn750(-0));
             make.bottom.equalTo(self.view.mas_bottom).offset(-CGFloatIn750(0));
             make.top.equalTo(self.view.mas_top).offset(-CGFloatIn750(0));
         }];
        self.bottomView.hidden = YES;
    }else{
        self.bottomView.hidden = NO;
        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, CGFloatIn750(182))];
        _bottomView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
        [self.view addSubview:_bottomView];
        
        [self.bottomView addSubview:self.bottomBtn];
        [self.bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.bottomView.mas_left).offset(CGFloatIn750(0));
            make.right.equalTo(self.bottomView.mas_right).offset(CGFloatIn750(0));
            make.height.mas_equalTo(CGFloatIn750(96));
            make.top.equalTo(self.bottomView.mas_top);
        }];
        
        [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.view);
            make.height.mas_equalTo(CGFloatIn750(182));
        }];
        
        [self.iTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view.mas_left).offset(CGFloatIn750(0));
            make.right.equalTo(self.view.mas_right).offset(CGFloatIn750(-0));
            make.bottom.equalTo(self.bottomView.mas_top).offset(-CGFloatIn750(0));
            make.top.equalTo(self.view.mas_top).offset(-CGFloatIn750(0));
        }];
    }
}


#pragma mark - lazy loading...
- (UIButton *)navLeftBtn {
    if (!_navLeftBtn) {
        __weak typeof(self) weakSelf = self;
        _navLeftBtn = [[ZButton alloc] initWithFrame:CGRectMake(0, 0, CGFloatIn750(118), CGFloatIn750(50))];
        [_navLeftBtn setTitle:@"加入学员" forState:UIControlStateNormal];
        [_navLeftBtn setTitleColor:adaptAndDarkColor([UIColor colorWhite], [UIColor colorWhite]) forState:UIControlStateNormal];
        [_navLeftBtn.titleLabel setFont:[UIFont fontSmall]];
        [_navLeftBtn setBackgroundColor:adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]) forState:UIControlStateNormal];
        ViewRadius(_navLeftBtn, CGFloatIn750(25));
        [_navLeftBtn bk_addEventHandler:^(id sender) {
            NSArray *weekArr = @[@[@"线上学员",@"listadd",@"add"],@[@"二维码添加线下学员",@"erweimlist",@"code"]];
            [ZAlertMoreView setMoreAlertWithTitleArr:weekArr handlerBlock:^(NSString *index) {
                if ([index isEqualToString:@"code"]) {
                    ZOriganizationStudentCodeAddModel *addModel = [[ZOriganizationStudentCodeAddModel alloc] init];
                    ZOrganizationTrachingScheduleOutlineErweimaVC *avc = [[ZOrganizationTrachingScheduleOutlineErweimaVC alloc] init];
                    avc.class_id = weakSelf.model.classID;
                    addModel.class_name = weakSelf.model.name;
                    addModel.nick_name = weakSelf.model.teacher_name;
                    addModel.teacher_image = weakSelf.model.teacher_image;
                    addModel.image = weakSelf.model.stores_course_image;
                    addModel.courses_name = weakSelf.model.stores_courses_name;
                    avc.codeAddModel = addModel;
                    [weakSelf.navigationController pushViewController:avc animated:YES];
                }else{
                    ZOrganizationClassDetailStudentListAddVC *avc = [[ZOrganizationClassDetailStudentListAddVC alloc] init];
                    avc.model = weakSelf.model;
                    [weakSelf.navigationController pushViewController:avc animated:YES];
                }
            }];
            
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _navLeftBtn;
}

- (UIButton *)bottomBtn {
    if (!_bottomBtn) {
        __weak typeof(self) weakSelf = self;
        _bottomBtn = [[ZButton alloc] initWithFrame:CGRectZero];
        [_bottomBtn setTitle:@"编辑" forState:UIControlStateNormal];
        [_bottomBtn setTitleColor:[UIColor colorWhite] forState:UIControlStateNormal];
        [_bottomBtn.titleLabel setFont:[UIFont fontContent]];
        [_bottomBtn setBackgroundColor:adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]) forState:UIControlStateNormal];
        [_bottomBtn bk_addEventHandler:^(id sender) {
            if (!ValidStr(weakSelf.model.start_time)) {
                [TLUIUtility showErrorHint:@"请添加开课时间"];
                return ;
            }
            if (!ValidArray(weakSelf.model.classes_dateArr)) {
                [TLUIUtility showErrorHint:@"请添加上课时间"];
                return ;
            }
            [weakSelf editClass];
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _bottomBtn;
}

- (ZOriganizationClassDetailModel *)model {
    if (!_model) {
        _model = [[ZOriganizationClassDetailModel alloc] init];
    }
    return _model;
}

#pragma mark tableView -------datasource-----
- (void)zz_tableView:(UITableView *)tableView cell:(UITableViewCell *)cell cellForRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
    __weak typeof(self) weakSelf = self;
    if ([cellConfig.title isEqualToString:@"beginTime"]) {
        ZTextFieldMultColCell *lcell = (ZTextFieldMultColCell *)cell;
        lcell.selectBlock = ^{
            ZOrganizationTimeSelectVC *svc = [[ZOrganizationTimeSelectVC alloc] init];
            svc.course_min = weakSelf.model.course_min;
            svc.timeArr =  [[NSMutableArray alloc] initWithArray: weakSelf.model.classes_dateArr];
            svc.timeBlock = ^(NSMutableArray <ZBaseMenuModel *>*timeArr) {
                weakSelf.model.classes_dateArr = timeArr;
                [weakSelf initCellConfigArr];
                [weakSelf.iTableView reloadData];
            };
            [weakSelf.navigationController pushViewController:svc animated:YES];
        };
    }else if([cellConfig.title isEqualToString:@"className"]){
        ZTextFieldCell *lcell = (ZTextFieldCell *)cell;
        lcell.valueChangeBlock = ^(NSString * text) {
            weakSelf.model.name = text;
        };
    }
}

- (void)zz_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
    __weak typeof(self) weakSelf = self;
    if ([cellConfig.title isEqualToString:@"openTime"]) {
        if (!self.isOpen) {
            [ZDatePickerManager showDatePickerWithTitle:@"开课日期" type:PGDatePickerModeDate viewController:self handle:^(NSDateComponents * date) {
                weakSelf.model.start_time = [NSString stringWithFormat:@"%ld",(long)[[NSDate dateFromComponents:date] timeIntervalSince1970]];
                [weakSelf initCellConfigArr];
                [weakSelf.iTableView reloadData];
            }];
        }
        
    }else if ([cellConfig.title isEqualToString:@"studentList"]) {
        ZOrganizationClassDetailStudentListVC *lvc = [[ZOrganizationClassDetailStudentListVC  alloc] init];
        lvc.isEnd = [self.model.status intValue] == 3;
        lvc.model = self.model;
//        lvc.type = 2;
        [self.navigationController pushViewController:lvc animated:YES];
    }else if ([cellConfig.title isEqualToString:@"detail"]){
        ZTeacherClassDetailSignDetailVC *sdvc = [[ZTeacherClassDetailSignDetailVC alloc] init];
        sdvc.model = self.model;
        [self.navigationController pushViewController:sdvc animated:YES];
    }
}


- (void)refreshData {
    __weak typeof(self) weakSelf = self;
    self.loading = YES;
    [ZOriganizationClassViewModel getClassDetail:@{@"id":SafeStr(self.model.classID)} completeBlock:^(BOOL isSuccess, ZOriganizationClassDetailModel *addModel) {
        weakSelf.loading = NO;
        if (isSuccess) {
            weakSelf.model = addModel;
            [weakSelf initCellConfigArr];
            [weakSelf.iTableView reloadData];
        }
    }];
}


- (void)editClass {
    NSMutableDictionary *params = @{}.mutableCopy;
    [params setObject:SafeStr(self.model.stores_id) forKey:@"stores_id"];
    [params setObject:SafeStr(self.model.classID) forKey:@"id"];
    [params setObject:SafeStr(self.model.name) forKey:@"name"];
    [params setObject:SafeStr(self.model.teacher_id) forKey:@"teacher_id"];
    [params setObject:SafeStr(self.model.start_time) forKey:@"start_time"];
    
    NSMutableDictionary *orderDict = @{}.mutableCopy;
    for (ZBaseMenuModel *menuModel in self.model.classes_dateArr) {
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
    
    __weak typeof(self) weakSelf = self;
    [TLUIUtility showLoading:@""];
    [ZOriganizationClassViewModel editClass:params completeBlock:^(BOOL isSuccess, NSString *message) {
        [TLUIUtility hiddenLoading];
        if (isSuccess) {
            [TLUIUtility showSuccessHint:message];
            [weakSelf refreshData];
            return ;
        }else {
            [TLUIUtility showErrorHint:message];
        }
    }];
}
@end
