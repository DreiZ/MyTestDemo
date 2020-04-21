//
//  ZOrganizationStudentJionInLessonVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/4/9.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationStudentJionInLessonVC.h"
#import "ZOrganizationStudentJionInLessonCell.h"
#import "ZTableViewListCell.h"

#import "ZOriganizationLessonViewModel.h"


@interface ZOrganizationStudentJionInLessonVC ()
@property (nonatomic,strong) UIButton *bottomBtn;

@end

@implementation ZOrganizationStudentJionInLessonVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigation];
    [self initCellConfigArr];
}

- (ZOriganizationStudentViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[ZOriganizationStudentViewModel alloc] init];
        _viewModel.addModel.name = [ZUserHelper sharedHelper].user.nikeName;
        _viewModel.addModel.phone = [ZUserHelper sharedHelper].user.phone;
        _viewModel.addModel.code_id = [ZUserHelper sharedHelper].user.userCodeID;
    }
    return _viewModel;
}

- (void)initCellConfigArr {
    [super initCellConfigArr];
    
    ZCellConfig *progressCellConfig = [ZCellConfig cellConfigWithClassName:[ZOrganizationStudentJionInLessonCell className] title:[ZOrganizationStudentJionInLessonCell className] showInfoMethod:@selector(setModel:) heightOfCell:[ZOrganizationStudentJionInLessonCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:self.viewModel.addModel];
    [self.cellConfigArr addObject:progressCellConfig];
    
    NSArray *textArr = @[@[@"真实姓名", @"请输入真实姓名", @YES, @"", @"name",SafeStr(self.viewModel.addModel.name),@10,[NSNumber numberWithInt:ZFormatterTypeAny]],
                         @[@"手机号", @"请输入手机号", @YES, @"", @"phone",SafeStr(self.viewModel.addModel.phone),@11,[NSNumber numberWithInt:ZFormatterTypePhoneNumber]],
                         @[@"课程进度", SafeStr(self.viewModel.addModel.total_progress), @YES, @"", @"now_progress",SafeStr(self.viewModel.addModel.now_progress),@12,[NSNumber numberWithInt:ZFormatterTypeNumber]],
                         @[@"紧急联系人姓名", @"选填", @YES, @"", @"contactName",SafeStr(self.viewModel.addModel.emergency_name),@10,[NSNumber numberWithInt:ZFormatterTypeAny]],
                         @[@"紧急联系人电话", @"选填", @YES, @"", @"contactTel",SafeStr(self.viewModel.addModel.emergency_phone),@11,[NSNumber numberWithInt:ZFormatterTypePhoneNumber]],
                        @[@"紧急联系人与学员关系",@"选填", @YES, @"", @"relationship",SafeStr(self.viewModel.addModel.emergency_contact),@10,[NSNumber numberWithInt:ZFormatterTypeAny]]];
    NSMutableArray *configArr = @[].mutableCopy;
    for (int i = 0; i < textArr.count; i++) {
       ZBaseTextFieldCellModel *cellModel = [[ZBaseTextFieldCellModel alloc] init];
        cellModel.leftTitle = textArr[i][0];
        cellModel.placeholder = textArr[i][1];
        cellModel.isTextEnabled = [textArr[i][2] boolValue];
        cellModel.rightImage = textArr[i][3];
        cellModel.cellTitle = textArr[i][4];
        cellModel.content = textArr[i][5];
        cellModel.max = [textArr[i][6] intValue];
        cellModel.formatterType = [textArr[i][7] intValue];
        cellModel.isHiddenLine = YES;
        if ([textArr[i][4] isEqualToString:@"now_progress"]) {
            cellModel.rightTitle = @"节";
        }
        cellModel.cellHeight = CGFloatIn750(108);
        ZCellConfig *textCellConfig = [ZCellConfig cellConfigWithClassName:[ZTextFieldCell className] title:textArr[i][4] showInfoMethod:@selector(setModel:) heightOfCell:[ZTextFieldCell z_getCellHeight:cellModel] cellType:ZCellTypeClass dataModel:cellModel];
        [configArr addObject:textCellConfig];
    }
    
    ZCellConfig *bottomCellConfig = [ZCellConfig cellConfigWithClassName:[ZTableViewListCell className] title:[ZTableViewListCell className] showInfoMethod:@selector(setConfigList:) heightOfCell:[ZTableViewListCell z_getCellHeight:configArr] cellType:ZCellTypeClass dataModel:configArr];
    [self.cellConfigArr addObject:bottomCellConfig];
}

- (void)setNavigation {
    self.isHidenNaviBar = NO;
    
    [self.navigationItem setTitle:@"加入课程"];
}

- (void)setupMainView {
    [super setupMainView];
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, CGFloatIn750(180))];
    bottomView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
    self.iTableView.tableFooterView = bottomView;
    
    [bottomView addSubview:self.bottomBtn];
    [self.bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bottomView.mas_left).offset(CGFloatIn750(60));
        make.right.equalTo(bottomView.mas_right).offset(CGFloatIn750(-60));
        make.height.mas_equalTo(CGFloatIn750(80));
        make.centerY.equalTo(bottomView.mas_centerY);
    }];
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
        [_bottomBtn bk_whenTapped:^{
            if (!ValidStr(weakSelf.viewModel.addModel.name)) {
                [TLUIUtility showErrorHint:@"请输入真实姓名"];
                return ;
            }
            if (!ValidStr(weakSelf.viewModel.addModel.phone)) {
                [TLUIUtility showErrorHint:@"请输入手机号"];
                return ;
            }
            if (!ValidStr(weakSelf.viewModel.addModel.now_progress)) {
                [TLUIUtility showErrorHint:@"请输入课程进度"];
                return ;
            }
            if ([weakSelf.viewModel.addModel.now_progress intValue] > [weakSelf.viewModel.addModel.total_progress intValue]) {
                [TLUIUtility showErrorHint:@"课程已大约总课时"];
                return ;
            }
            NSMutableDictionary *otherDict = @{}.mutableCopy;
            [otherDict setObject:self.viewModel.addModel.name forKey:@"name"];
            [otherDict setObject:self.viewModel.addModel.phone forKey:@"phone"];
            
            [otherDict setObject:self.viewModel.addModel.now_progress forKey:@"now_progress"];
            
            [otherDict setObject:self.viewModel.addModel.teacher_id forKey:@"teacher_id"];
            [otherDict setObject:self.viewModel.addModel.stores_courses_class_id forKey:@"stores_courses_class_id"];
            [otherDict setObject:self.viewModel.addModel.stores_id forKey:@"stores_id"];
            [otherDict setObject:self.viewModel.addModel.code_id forKey:@"code_id"];
            
            if (ValidStr(self.viewModel.addModel.emergency_name)) {
                [otherDict setObject:self.viewModel.addModel.emergency_name forKey:@"emergency_name"];
            }
            if (ValidStr(self.viewModel.addModel.emergency_phone)) {
                [otherDict setObject:self.viewModel.addModel.emergency_phone forKey:@"emergency_phone"];
            }
            if (ValidStr(self.viewModel.addModel.emergency_contact)) {
                [otherDict setObject:self.viewModel.addModel.emergency_contact forKey:@"emergency_contact"];
            }
            
            
            [weakSelf updateOtherDataWithParams:otherDict];
        }];
    }
    return _bottomBtn;
}

- (void)updateOtherDataWithParams:(NSMutableDictionary *)otherDict {
 
    
    [TLUIUtility showLoading:@"上传其他数据"];
    [ZOriganizationStudentViewModel addStudent:otherDict completeBlock:^(BOOL isSuccess, NSString *message) {
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


#pragma mark tableView -------datasource-----
- (void)zz_tableView:(UITableView *)tableView cell:(UITableViewCell *)cell cellForRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
    __weak typeof(self) weakSelf = self;
    if ([cellConfig.title isEqualToString:@"ZTableViewListCell"]) {
        ZTableViewListCell *lcell = (ZTableViewListCell *)cell;
        lcell.cellSetBlock = ^(UITableViewCell *cell, NSIndexPath *indexPath, ZCellConfig *cellConfig) {
            if ([cellConfig.title isEqualToString:@"name"]) {
                ZTextFieldCell *lcell = (ZTextFieldCell *)cell;
                lcell.valueChangeBlock = ^(NSString * text) {
                    weakSelf.viewModel.addModel.name = text;
                };
            }else  if ([cellConfig.title isEqualToString:@"now_progress"]) {
                ZTextFieldCell *lcell = (ZTextFieldCell *)cell;
                lcell.valueChangeBlock = ^(NSString * text) {
                    weakSelf.viewModel.addModel.now_progress = text;
                };
            }else  if ([cellConfig.title isEqualToString:@"phone"]) {
                ZTextFieldCell *lcell = (ZTextFieldCell *)cell;
                lcell.valueChangeBlock = ^(NSString * text) {
                    weakSelf.viewModel.addModel.phone = text;
                };
            }else  if ([cellConfig.title isEqualToString:@"contactName"]) {
                ZTextFieldCell *lcell = (ZTextFieldCell *)cell;
                lcell.valueChangeBlock = ^(NSString * text) {
                    weakSelf.viewModel.addModel.emergency_name = text;
                };
            }else  if ([cellConfig.title isEqualToString:@"contactTel"]) {
                ZTextFieldCell *lcell = (ZTextFieldCell *)cell;
                lcell.valueChangeBlock = ^(NSString * text) {
                    weakSelf.viewModel.addModel.emergency_phone = text;
                };
            }else  if ([cellConfig.title isEqualToString:@"relationship"]) {
                ZTextFieldCell *lcell = (ZTextFieldCell *)cell;
                lcell.valueChangeBlock = ^(NSString * text) {
                    weakSelf.viewModel.addModel.emergency_contact = text;
                };
            }
        };
    }
    
}

- (void)zz_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
//    __weak typeof(self) weakSelf = self;
    
}

@end

