//
//  ZOrganizationStudentAddVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/2/22.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationStudentAddVC.h"
#import "ZOriganizationTeachListCell.h"
#import "ZOriganizationTeachAddHeadImageCell.h"
#import "ZOrganizationLessonAddPhotosCell.h"
#import "ZOriganizationTextViewCell.h"
#import "ZOriganizationIDCardCell.h"
#import "ZOrganizationCampusTextLabelCell.h"

#import "ZBaseUnitModel.h"
#import "ZAlertDataSinglePickerView.h"
#import "ZAlertDataPickerView.h"

#import "ZOrganizationCampusManageAddLabelVC.h"
#import "ZOrganizationTeacherLessonSelectVC.h"
#import "ZOriganizationLessonViewModel.h"

#import "ZAlertTeacherCheckBoxView.h"
#import "ZAlertLessonCheckBoxView.h"

@interface ZOrganizationStudentAddVC ()
@property (nonatomic,strong) UIButton *bottomBtn;

@end

@implementation ZOrganizationStudentAddVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigation];
    [self initCellConfigArr];
}

- (ZOriganizationStudentViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[ZOriganizationStudentViewModel alloc] init];
        _viewModel.addModel.sex = @"1";
        _viewModel.addModel.birthday = [NSString stringWithFormat:@"%.0f",[[NSDate new] timeIntervalSince1970]];
        _viewModel.addModel.sign_up_at = [NSString stringWithFormat:@"%.0f",[[NSDate new] timeIntervalSince1970]];
        _viewModel.addModel.stores_id = [ZUserHelper sharedHelper].school.schoolID;
        _viewModel.addModel.stores_name = [ZUserHelper sharedHelper].school.name;
    }
    return _viewModel;
}

- (void)initCellConfigArr {
    [super initCellConfigArr];
    
//    ZCellConfig *progressCellConfig = [ZCellConfig cellConfigWithClassName:[ZOriganizationTeachAddHeadImageCell className] title:[ZOriganizationTeachAddHeadImageCell className] showInfoMethod:@selector(setImage:) heightOfCell:[ZOriganizationTeachAddHeadImageCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:self.viewModel.addModel.image];
//    [self.cellConfigArr addObject:progressCellConfig];
    
    NSArray *textArr = @[@[@"真实姓名", @"请输入真实姓名", @YES, @"", @"name",SafeStr(self.viewModel.addModel.name),@30,[NSNumber numberWithInt:ZFormatterTypeAnyByte]],
                         @[@"MID", @"请输入MID", @YES, @"", @"MID",SafeStr(self.viewModel.addModel.code_id),@12,[NSNumber numberWithInt:ZFormatterTypeNumber]],
                         @[@"手机号", @"请输入手机号", @YES, @"", @"phone",SafeStr(self.viewModel.addModel.phone),@11,[NSNumber numberWithInt:ZFormatterTypePhoneNumber]],
                         @[@"性别", @"请选择性别", @NO, @"rightBlackArrowN", @"sex",[SafeStr(self.viewModel.addModel.sex) intValue] == 1 ? @"男":@"女",@2,[NSNumber numberWithInt:ZFormatterTypeAny]],
                         @[@"出生日期", @"请选择出生日期(选填)", @NO, @"rightBlackArrowN", @"birthday",[SafeStr(self.viewModel.addModel.birthday) timeStringWithFormatter:@"yyyy-MM-dd"],@12,[NSNumber numberWithInt:ZFormatterTypeAny]],
                         @[@"报名日期", @"请选择报名日期(选填)", @NO, @"rightBlackArrowN", @"registrationDate",[SafeStr(self.viewModel.addModel.sign_up_at) timeStringWithFormatter:@"yyyy-MM-dd"],@12,[NSNumber numberWithInt:ZFormatterTypeAny]],
                         @[@"报名课程", @"请选择课程", @NO, @"rightBlackArrowN", @"lesson",SafeStr(self.viewModel.addModel.courses_name),@30,[NSNumber numberWithInt:ZFormatterTypeAny]],
                         @[@"已上课进度", @"请输入上课进度（默认0）", @YES, @"", @"now_progress",SafeStr(self.viewModel.addModel.now_progress),@6,[NSNumber numberWithInt:ZFormatterTypePhoneNumber]],
                         @[@"分配教师", @"请选择教师", @NO, @"rightBlackArrowN", @"teacher",SafeStr(self.viewModel.addModel.teacher),@10,[NSNumber numberWithInt:ZFormatterTypeAny]],
                         
                         @[@"身份证号码", @"请输入身份号(选填)", @YES, @"", @"cid",SafeStr   (self.viewModel.addModel.id_card),@18,[NSNumber numberWithInt:ZFormatterTypeAny]],
                         @[@"工作单位", @"选填", @YES, @"", @"work",SafeStr(self.viewModel.addModel.work_place),@20,[NSNumber numberWithInt:ZFormatterTypeAny]],
                         @[@"来源渠道", @"选填", @YES, @"", @"channel",SafeStr(self.viewModel.addModel.source),@10,[NSNumber numberWithInt:ZFormatterTypeAny]],
                         
                         @[@"微信", @"选填", @YES, @"", @"weixin",SafeStr(self.viewModel.addModel.wechat),@30,[NSNumber numberWithInt:ZFormatterTypeAny]],
                         @[@"推荐人", @"选填", @YES, @"", @"Recommend",SafeStr(self.viewModel.addModel.referees),@10,[NSNumber numberWithInt:ZFormatterTypeAny]],
                         @[@"紧急联系人姓名", @"选填", @YES, @"", @"contactName",SafeStr(self.viewModel.addModel.emergency_name),@10,[NSNumber numberWithInt:ZFormatterTypeAny]],
                         @[@"紧急联系人电话", @"选填", @YES, @"", @"contactTel",SafeStr(self.viewModel.addModel.emergency_phone),@11,[NSNumber numberWithInt:ZFormatterTypePhoneNumber]],
                        @[@"紧急联系人与学员关系",@"选填", @YES, @"", @"relationship",SafeStr(self.viewModel.addModel.emergency_contact),@10,[NSNumber numberWithInt:ZFormatterTypeAny]]];
    if (ValidStr(self.viewModel.addModel.studentID)) {
        textArr = @[@[@"真实姓名", @"请输入真实姓名", @YES, @"", @"name",SafeStr(self.viewModel.addModel.name),@10,[NSNumber numberWithInt:ZFormatterTypeAny]],
         @[@"手机号", @"请输入手机号", @YES, @"", @"phone",SafeStr(self.viewModel.addModel.phone),@11,[NSNumber numberWithInt:ZFormatterTypePhoneNumber]],
         @[@"性别", @"请选择性别", @NO, @"rightBlackArrowN", @"sex",[SafeStr(self.viewModel.addModel.sex) intValue] == 1 ? @"男":@"女",@2,[NSNumber numberWithInt:ZFormatterTypeAny]],
         @[@"出生日期", @"请选择出生日期(选填)", @NO, @"rightBlackArrowN", @"birthday",[SafeStr(self.viewModel.addModel.birthday) timeStringWithFormatter:@"yyyy-MM-dd"],@12,[NSNumber numberWithInt:ZFormatterTypeAny]],
         @[@"报名日期", @"请选择报名日期(选填)", @NO, @"rightBlackArrowN", @"registrationDate",[SafeStr(self.viewModel.addModel.sign_up_at) timeStringWithFormatter:@"yyyy-MM-dd"],@12,[NSNumber numberWithInt:ZFormatterTypeAny]],
         
         @[@"身份证号码", @"请输入身份号(选填)", @YES, @"", @"cid",SafeStr   (self.viewModel.addModel.id_card),@18,[NSNumber numberWithInt:ZFormatterTypeAny]],
         @[@"工作单位", @"选填", @YES, @"", @"work",SafeStr(self.viewModel.addModel.work_place),@20,[NSNumber numberWithInt:ZFormatterTypeAny]],
         @[@"来源渠道", @"选填", @YES, @"", @"channel",SafeStr(self.viewModel.addModel.source),@10,[NSNumber numberWithInt:ZFormatterTypeAny]],
         
         @[@"微信", @"选填", @YES, @"", @"weixin",SafeStr(self.viewModel.addModel.wechat),@30,[NSNumber numberWithInt:ZFormatterTypeAny]],
         @[@"推荐人", @"选填", @YES, @"", @"Recommend",SafeStr(self.viewModel.addModel.referees),@10,[NSNumber numberWithInt:ZFormatterTypeAny]],
         @[@"紧急联系人姓名", @"选填", @YES, @"", @"contactName",SafeStr(self.viewModel.addModel.emergency_name),@10,[NSNumber numberWithInt:ZFormatterTypeAny]],
         @[@"紧急联系人电话", @"选填", @YES, @"", @"contactTel",SafeStr(self.viewModel.addModel.emergency_phone),@11,[NSNumber numberWithInt:ZFormatterTypePhoneNumber]],
                    @[@"紧急联系人与学员关系",@"选填", @YES, @"", @"relationship",SafeStr(self.viewModel.addModel.emergency_contact),@10,[NSNumber numberWithInt:ZFormatterTypeAny]]];
    }
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
        cellModel.cellHeight = CGFloatIn750(108);
        ZCellConfig *textCellConfig = [ZCellConfig cellConfigWithClassName:[ZTextFieldCell className] title:textArr[i][4] showInfoMethod:@selector(setModel:) heightOfCell:[ZTextFieldCell z_getCellHeight:cellModel] cellType:ZCellTypeClass dataModel:cellModel];
        [self.cellConfigArr addObject:textCellConfig];
    }
    
    {
        ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
        model.leftTitle = @"备注";
        model.leftFont = [UIFont boldFontTitle];
        model.isHiddenLine = YES;
        model.cellHeight = CGFloatIn750(92);
        
        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
        [self.cellConfigArr addObject:menuCellConfig];
        
        ZCellConfig *textCellConfig = [ZCellConfig cellConfigWithClassName:[ZOriganizationTextViewCell className] title:@"ZOriganizationTextViewCell" showInfoMethod:@selector(setIsBackColor:) heightOfCell:CGFloatIn750(274) cellType:ZCellTypeClass dataModel:@"yes"];
        [self.cellConfigArr addObject:textCellConfig];
    }
}

- (void)setNavigation {
    self.isHidenNaviBar = NO;
    if (!_isEdit) {
        [self.navigationItem setTitle:@"新增学员"];
    }else{
        [self.navigationItem setTitle:@"编辑学员"];
    }
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
                [TLUIUtility showErrorHint:@"请输入学员姓名"];
                return ;
            }
            if (!ValidStr(weakSelf.viewModel.addModel.code_id)) {
                [TLUIUtility showErrorHint:@"请输入学员MID"];
                return ;
            }
            if (!ValidStr(weakSelf.viewModel.addModel.phone)) {
                [TLUIUtility showErrorHint:@"请输入学员手机号"];
                return ;
            }
            if (!ValidStr(weakSelf.viewModel.addModel.stores_courses_class_id)) {
                [TLUIUtility showErrorHint:@"请选择课程"];
                return ;
            }
            if (!ValidStr(weakSelf.viewModel.addModel.teacher_id)) {
                [TLUIUtility showErrorHint:@"请选择教师"];
                return ;
            }
            
            
            NSMutableDictionary *otherDict = @{}.mutableCopy;
            [otherDict setObject:self.viewModel.addModel.name forKey:@"name"];
            [otherDict setObject:self.viewModel.addModel.phone forKey:@"phone"];
            
            [otherDict setObject:self.viewModel.addModel.stores_courses_class_id forKey:@"stores_courses_class_id"];
            [otherDict setObject:self.viewModel.addModel.teacher_id forKey:@"teacher_id"];
            
            [otherDict setObject:self.viewModel.addModel.stores_id forKey:@"stores_id"];
            [otherDict setObject:self.viewModel.addModel.code_id forKey:@"code_id"];
            [otherDict setObject:self.viewModel.addModel.sex forKey:@"sex"];
            
            
            if (ValidStr(self.viewModel.addModel.now_progress)) {
                [otherDict setObject:self.viewModel.addModel.now_progress forKey:@"now_progress"];
            }else{
                [otherDict setObject:@"0" forKey:@"now_progress"];
            }
            
            if (ValidStr(self.viewModel.addModel.id_card)) {
                [otherDict setObject:self.viewModel.addModel.id_card forKey:@"id_card"];
                [otherDict setObject:@"1" forKey:@"card_type"];
            }
            if (ValidStr(self.viewModel.addModel.birthday)) {
                [otherDict setObject:self.viewModel.addModel.birthday forKey:@"birthday"];
            }
            if (ValidStr(self.viewModel.addModel.work_place)) {
                [otherDict setObject:self.viewModel.addModel.work_place forKey:@"work_place"];
            }
            if (ValidStr(self.viewModel.addModel.sign_up_at)) {
                [otherDict setObject:self.viewModel.addModel.sign_up_at forKey:@"sign_up_at"];
            }
            if (ValidStr(self.viewModel.addModel.source)) {
                [otherDict setObject:self.viewModel.addModel.source forKey:@"source"];
            }
            if (ValidStr(self.viewModel.addModel.wechat)) {
                [otherDict setObject:self.viewModel.addModel.wechat forKey:@"wechat"];
            }
            if (ValidStr(self.viewModel.addModel.referees)) {
                [otherDict setObject:self.viewModel.addModel.referees forKey:@"referees"];
            }
            if (ValidStr(self.viewModel.addModel.emergency_name)) {
                [otherDict setObject:self.viewModel.addModel.emergency_name forKey:@"emergency_name"];
            }
            if (ValidStr(self.viewModel.addModel.emergency_phone)) {
                [otherDict setObject:self.viewModel.addModel.emergency_phone forKey:@"emergency_phone"];
            }
            if (ValidStr(self.viewModel.addModel.emergency_contact)) {
                [otherDict setObject:self.viewModel.addModel.emergency_contact forKey:@"emergency_contact"];
            }
            
            if (ValidStr(self.viewModel.addModel.remark)) {
                [otherDict setObject:self.viewModel.addModel.remark forKey:@"remark"];
            }
            
            [weakSelf updateImageWithOtherParams:otherDict];
        }];
    }
    return _bottomBtn;
}


- (void)updateImageWithOtherParams:(NSMutableDictionary *)otherDict {
    if (self.viewModel.addModel.image && [self.viewModel.addModel.image isKindOfClass:[UIImage class]]) {
        [TLUIUtility showLoading:@"上传图片中"];
        __weak typeof(self) weakSelf = self;
        [ZOriganizationLessonViewModel uploadImageList:@{@"type":@"3",@"imageKey":@{@"file":self.viewModel.addModel.image}} completeBlock:^(BOOL isSuccess, NSString *message) {
            if (isSuccess) {
                weakSelf.viewModel.addModel.image = message;
                if (weakSelf.isEdit) {
                    [weakSelf editOtherDataWithParams:otherDict];
                }else{
                    [weakSelf updateOtherDataWithParams:otherDict];
                }
            }else{
                [TLUIUtility hiddenLoading];
                [TLUIUtility showErrorHint:message];
            }
        }];
        return;
    }
    
    if (self.isEdit) {
        [self editOtherDataWithParams:otherDict];
    }else{
        [self updateOtherDataWithParams:otherDict];
    }
}

- (void)updateOtherDataWithParams:(NSMutableDictionary *)otherDict {
    if (ValidStr(self.viewModel.addModel.image)) {
        [otherDict setObject:self.viewModel.addModel.image forKey:@"image"];
    }
    
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


- (void)editOtherDataWithParams:(NSMutableDictionary *)otherDict {
    if (ValidStr(self.viewModel.addModel.image)) {
        [otherDict setObject:self.viewModel.addModel.image forKey:@"image"];
    }
    
    if (ValidStr(self.viewModel.addModel.studentID)) {
        [otherDict setObject:self.viewModel.addModel.studentID forKey:@"id"];
    }
    
    [TLUIUtility showLoading:@"上传其他数据"];
    [ZOriganizationStudentViewModel editStudent:otherDict completeBlock:^(BOOL isSuccess, NSString *message) {
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
    if ([cellConfig.title isEqualToString:@"ZOriganizationTeachAddHeadImageCell"]) {
        ZOriganizationTeachAddHeadImageCell *lcell = (ZOriganizationTeachAddHeadImageCell *)cell;
        lcell.handleBlock = ^(NSInteger index) {
            [self.iTableView endEditing:YES];
            [[ZPhotoManager sharedManager] showCropOriginalSelectMenuWithCropSize:CGSizeMake(KScreenWidth*0.6, KScreenWidth*0.6) complete:^(NSArray<LLImagePickerModel *> *list) {
                if (list && list.count > 0) {
                    LLImagePickerModel *model = list[0];
                    weakSelf.viewModel.addModel.image = model.image;
                    [weakSelf initCellConfigArr];
                    [weakSelf.iTableView reloadData];
                }
            }];
        };
    }else  if ([cellConfig.title isEqualToString:@"name"]) {
        ZTextFieldCell *lcell = (ZTextFieldCell *)cell;
        lcell.valueChangeBlock = ^(NSString * text) {
            weakSelf.viewModel.addModel.name = text;
        };
    }else  if ([cellConfig.title isEqualToString:@"MID"]) {
        ZTextFieldCell *lcell = (ZTextFieldCell *)cell;
        lcell.valueChangeBlock = ^(NSString * text) {
            weakSelf.viewModel.addModel.code_id = text;
        };
    }else  if ([cellConfig.title isEqualToString:@"phone"]) {
        ZTextFieldCell *lcell = (ZTextFieldCell *)cell;
        lcell.valueChangeBlock = ^(NSString * text) {
            weakSelf.viewModel.addModel.phone = text;
        };
    }else  if ([cellConfig.title isEqualToString:@"cid"]) {
        ZTextFieldCell *lcell = (ZTextFieldCell *)cell;
        lcell.valueChangeBlock = ^(NSString * text) {
            weakSelf.viewModel.addModel.id_card = text;
        };
    }else  if ([cellConfig.title isEqualToString:@"channel"]) {
        ZTextFieldCell *lcell = (ZTextFieldCell *)cell;
        lcell.valueChangeBlock = ^(NSString * text) {
            weakSelf.viewModel.addModel.source = text;
        };
    }else  if ([cellConfig.title isEqualToString:@"work"]) {
        ZTextFieldCell *lcell = (ZTextFieldCell *)cell;
        lcell.valueChangeBlock = ^(NSString * text) {
            weakSelf.viewModel.addModel.work_place = text;
        };
    }else  if ([cellConfig.title isEqualToString:@"weixin"]) {
        ZTextFieldCell *lcell = (ZTextFieldCell *)cell;
        lcell.valueChangeBlock = ^(NSString * text) {
            weakSelf.viewModel.addModel.wechat = text;
        };
    }else  if ([cellConfig.title isEqualToString:@"Recommend"]) {
        ZTextFieldCell *lcell = (ZTextFieldCell *)cell;
        lcell.valueChangeBlock = ^(NSString * text) {
            weakSelf.viewModel.addModel.referees = text;
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
    }else  if ([cellConfig.title isEqualToString:@"ZOriganizationTextViewCell"]) {
        ZOriganizationTextViewCell *lcell = (ZOriganizationTextViewCell *)cell;
        lcell.max = 300;
        lcell.hint = @"选填";
        lcell.content = self.viewModel.addModel.remark;
        lcell.textChangeBlock = ^(NSString * text) {
            weakSelf.viewModel.addModel.remark = text;
        };
    }else if([cellConfig.title isEqualToString:@"now_progress"]){
        ZTextFieldCell *lcell = (ZTextFieldCell *)cell;
        lcell.valueChangeBlock = ^(NSString * text) {
            weakSelf.viewModel.addModel.now_progress = text;
        };
    }
}

- (void)zz_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
    __weak typeof(self) weakSelf = self;
    if ([cellConfig.title isEqualToString:@"sex"]) {
        [self.iTableView endEditing:YES];
        NSMutableArray *items = @[].mutableCopy;
        NSArray *temp = @[@"男",@"女"];
        for (int i = 0; i < temp.count; i++) {
           ZAlertDataItemModel *model = [[ZAlertDataItemModel alloc] init];
           model.name = temp[i];
           [items addObject:model];
        }
        
        [ZAlertDataSinglePickerView setAlertName:@"性别选择" items:items handlerBlock:^(NSInteger index) {
            weakSelf.viewModel.addModel.sex = [NSString stringWithFormat:@"%ld",index + 1];
            [weakSelf initCellConfigArr];
            [weakSelf.iTableView reloadData];
        }];
    }else if ([cellConfig.title isEqualToString:@"birthday"]) {
        [self.iTableView endEditing:YES];
        [ZDatePickerManager showDatePickerWithTitle:@"出生日期" type:PGDatePickerModeDate handle:^(NSDateComponents * date) {
            weakSelf.viewModel.addModel.birthday = [NSString stringWithFormat:@"%ld",(long)[[NSDate dateFromComponents:date] timeIntervalSince1970]];
            [weakSelf initCellConfigArr];
            [weakSelf.iTableView reloadData];
        }];
    }else if ([cellConfig.title isEqualToString:@"registrationDate"]) {
        [self.iTableView endEditing:YES];
        [ZDatePickerManager showDatePickerWithTitle:@"报名日期" type:PGDatePickerModeDate handle:^(NSDateComponents * date) {
            weakSelf.viewModel.addModel.sign_up_at = [NSString stringWithFormat:@"%ld",(long)[[NSDate dateFromComponents:date] timeIntervalSince1970]];
            [weakSelf initCellConfigArr];
            [weakSelf.iTableView reloadData];
        }];
    }else if ([cellConfig.title isEqualToString:@"lesson"]) {
        [self.iTableView endEditing:YES];
        [ZAlertLessonCheckBoxView  setAlertName:@"选择课程" schoolID:[ZUserHelper sharedHelper].school.schoolID handlerBlock:^(NSInteger index,ZOriganizationLessonListModel *model) {
            if (model) {
                weakSelf.viewModel.addModel.stores_courses_class_id = model.lessonID;
                weakSelf.viewModel.addModel.courses_name = model.short_name;
                [weakSelf initCellConfigArr];
                [weakSelf.iTableView reloadData];
            }
        }];
    }else if ([cellConfig.title isEqualToString:@"teacher"]) {
        [self.iTableView endEditing:YES];
        if (ValidStr(self.viewModel.addModel.stores_courses_class_id)) {
            [ZAlertTeacherCheckBoxView  setAlertName:@"选择教师" schoolID:self.viewModel.addModel.stores_courses_class_id  handlerBlock:^(NSInteger index,ZOriganizationTeacherListModel *model) {
                if (model) {
                    weakSelf.viewModel.addModel.teacher = model.teacher_name;
                    weakSelf.viewModel.addModel.teacher_id  = model.teacherID;
                    [weakSelf initCellConfigArr];
                    [weakSelf.iTableView reloadData];
                }
            }];
        }else{
            [TLUIUtility showErrorHint:@"请先选择课程"];
        }
    }
}

@end
