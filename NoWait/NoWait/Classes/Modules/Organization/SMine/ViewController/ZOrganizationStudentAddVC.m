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
#import "ZOriganizationTeachHeadImageCell.h"
#import "ZOrganizationLessonAddPhotosCell.h"
#import "ZOriganizationTextViewCell.h"
#import "ZOriganizationIDCardCell.h"
#import "ZOrganizationCampusTextLabelCell.h"
#import "ZAddPhotosCell.h"

#import "ZBaseUnitModel.h"
#import "ZAlertDataSinglePickerView.h"
#import "ZAlertDataPickerView.h"

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
    
    if (ValidStr(self.viewModel.addModel.studentID)) {
        ZCellConfig *progressCellConfig = [ZCellConfig cellConfigWithClassName:[ZOriganizationTeachHeadImageCell className] title:[ZOriganizationTeachHeadImageCell className] showInfoMethod:@selector(setImage:) heightOfCell:[ZOriganizationTeachHeadImageCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:imageFullUrl(self.viewModel.addModel.image)];
        [self.cellConfigArr addObject:progressCellConfig];
    }
    
    NSArray <NSArray *>*textArr = @[@[@"真实姓名", @"请输入真实姓名", @YES, @"", @"name",SafeStr(self.viewModel.addModel.name),@30,[NSNumber numberWithInt:ZFormatterTypeAnyByte]],
                         @[@"MID", @"请输入MID", @YES, @"", @"MID",SafeStr(self.viewModel.addModel.code_id),@12,[NSNumber numberWithInt:ZFormatterTypeNumber]],
                         @[@"手机号", @"请输入手机号", @YES, @"", @"phone",SafeStr(self.viewModel.addModel.phone),@11,[NSNumber numberWithInt:ZFormatterTypePhoneNumber]],
                         @[@"性别", @"请选择性别", @NO, @"rightBlackArrowN", @"sex",[SafeStr(self.viewModel.addModel.sex) intValue] == 1 ? @"男":@"女",@2,[NSNumber numberWithInt:ZFormatterTypeAny]],
                         @[@"出生日期", @"请选择出生日期(选填)", @NO, @"rightBlackArrowN", @"birthday",[SafeStr(self.viewModel.addModel.birthday) timeStringWithFormatter:@"yyyy-MM-dd"],@12,[NSNumber numberWithInt:ZFormatterTypeAny]],
                         @[@"报名日期", @"请选择报名日期(选填)", @NO, @"rightBlackArrowN", @"registrationDate",[SafeStr(self.viewModel.addModel.sign_up_at) timeStringWithFormatter:@"yyyy-MM-dd"],@12,[NSNumber numberWithInt:ZFormatterTypeAny]],
                                    @[@"报名课程", @"请选择课程", @NO, @"rightBlackArrowN", @"lesson",[NSString stringWithFormat:@"%@%@%@%@",SafeStr(self.viewModel.addModel.courses_name),ValidStr(self.viewModel.addModel.courses_name)? @"(共":@"",SafeStr(self.viewModel.addModel.total_progress),ValidStr(self.viewModel.addModel.courses_name)?@"节)":@""],@30,[NSNumber numberWithInt:ZFormatterTypeAny]],
                         @[@"已上课进度", @"请输入上课进度（默认0）", @YES, @"", @"now_progress",SafeStr(self.viewModel.addModel.now_progress),@6,[NSNumber numberWithInt:ZFormatterTypePhoneNumber]],
                         @[@"分配教师", @"请选择教师", @NO, @"rightBlackArrowN", @"teacher",SafeStr(self.viewModel.addModel.teacher),@10,[NSNumber numberWithInt:ZFormatterTypeAny]]];
    __weak typeof(self) weakSelf = self;
    [textArr enumerateObjectsUsingBlock:^(NSArray * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        ZTextFieldModel *model = ZTextFieldModel.zz_textCellModel_create(SafeStr(obj[4]))
        .zz_heightTextField(CGFloatIn750(84))
        .zz_titleLeft(SafeStr(obj[0]))
        .zz_placeholder(SafeStr(obj[1]))
        .zz_textEnabled([obj[2] boolValue])
        .zz_content(SafeStr(obj[5]))
        .zz_max([obj[6] intValue])
        .zz_formatter([obj[7] intValue])
        .zz_cellHeight(CGFloatIn750(86));
        
        if (ValidStr(weakSelf.viewModel.addModel.studentID)
            && ([SafeStr(obj[4]) isEqualToString:@"MID"]
            || [SafeStr(obj[4]) isEqualToString:@"registrationDate"]
            || [SafeStr(obj[4]) isEqualToString:@"lesson"]
            || [SafeStr(obj[4]) isEqualToString:@"now_progress"]
            || [SafeStr(obj[4]) isEqualToString:@"teacher"])) {
            model.zz_colorText([UIColor colorTextGray1])
            .zz_colorDarkText([UIColor colorTextGray1Dark])
            .zz_colorSubRight([UIColor colorTextGray1])
            .zz_colorDarkSubRight([UIColor colorTextGray1Dark])
            .zz_textEnabled(NO);
        }else {
            model.zz_colorText([UIColor colorTextBlack])
            .zz_colorDarkText([UIColor colorTextBlackDark])
            .zz_colorSubRight([UIColor colorTextBlack])
            .zz_colorDarkSubRight([UIColor colorTextBlackDark])
            .zz_textEnabled([obj[2] boolValue]);
            if (ValidStr(obj[3])) {
                model.zz_imageRight(SafeStr(obj[3]))
                .zz_imageRightHeight(CGFloatIn750(14));
            }
        }
        
        ZCellConfig *nameCellConfig = [ZCellConfig cellConfigWithClassName:[ZBaseTextFieldCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZBaseTextFieldCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
        [weakSelf.cellConfigArr addObject:nameCellConfig];
    }];
    
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
    
    if (ValidStr(self.viewModel.addModel.is_star) && [self.viewModel.addModel.is_star intValue] == 1) {
        ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
        model.leftTitle = @"学员简介";
        model.leftFont = [UIFont boldFontTitle];
        model.isHiddenLine = YES;
        model.cellHeight = CGFloatIn750(92);
        
        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
        [self.cellConfigArr addObject:menuCellConfig];
        
        ZCellConfig *textCellConfig = [ZCellConfig cellConfigWithClassName:[ZOriganizationTextViewCell className] title:@"specialty_desc" showInfoMethod:@selector(setIsBackColor:) heightOfCell:CGFloatIn750(274) cellType:ZCellTypeClass dataModel:@"yes"];
        [self.cellConfigArr addObject:textCellConfig];
    }
    
    if(ValidStr(self.viewModel.addModel.is_star) && [self.viewModel.addModel.is_star intValue] == 1){
        {
            ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
            model.leftTitle = @"学员相册";
            model.leftFont = [UIFont boldFontTitle];
            model.isHiddenLine = YES;
            model.cellHeight = CGFloatIn750(92);
            
            ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
            [self.cellConfigArr addObject:menuCellConfig];
        }
        
        ZBaseMenuModel *model = [[ZBaseMenuModel alloc] init];
        NSMutableArray *menulist = @[].mutableCopy;
        for (int j = 0; j < self.viewModel.addModel.images_list.count; j++) {
            ZBaseUnitModel *model = [[ZBaseUnitModel alloc] init];
            if (j < self.viewModel.addModel.images_list.count) {
                if (![self.viewModel.addModel.images_list[j] isKindOfClass:[UIImage class]]) {
                    model.data = imageFullUrl(self.viewModel.addModel.images_list[j]);
                }else{
                    model.data = self.viewModel.addModel.images_list[j];
                }
                model.uid = [NSString stringWithFormat:@"%d", j];
            }
            
            model.isEdit = YES;
            [menulist addObject:model];
        }
        model.uid = @"9";
        model.name = @"添加图片";
        model.subName = @"选填";
        model.units = menulist;
        
        ZCellConfig *progressCellConfig = [ZCellConfig cellConfigWithClassName:[ZAddPhotosCell className] title:[ZAddPhotosCell className] showInfoMethod:@selector(setModel:) heightOfCell:[ZAddPhotosCell z_getCellHeight:menulist] cellType:ZCellTypeClass dataModel:model];
        [self.cellConfigArr addObject:progressCellConfig];
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
    
    [self.view addSubview:bottomView];
    [self.view addSubview:self.bottomBtn];
    [self.bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bottomView.mas_left).offset(CGFloatIn750(60));
        make.right.equalTo(bottomView.mas_right).offset(CGFloatIn750(-60));
        make.height.mas_equalTo(CGFloatIn750(80));
        make.top.equalTo(bottomView.mas_top).offset(CGFloatIn750(20));
    }];
    
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom).offset(-safeAreaBottom());
        make.height.mas_equalTo(CGFloatIn750(80));
    }];
    
    [self.iTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(bottomView.mas_top);
        make.top.equalTo(self.view.mas_top);
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
        [_bottomBtn bk_addEventHandler:^(id sender) {
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
            if ([weakSelf.viewModel.addModel.phone length] != 11) {
                [TLUIUtility showErrorHint:@"请输入正确的手机号"];
                return ;
            }
            if (!ValidStr(weakSelf.viewModel.addModel.stores_courses_class_id)) {
                [TLUIUtility showErrorHint:@"请选择课程"];
                return ;
            }
            NSMutableDictionary *otherDict = @{}.mutableCopy;
            if (ValidStr(weakSelf.viewModel.addModel.now_progress)) {
                if ([weakSelf.viewModel.addModel.now_progress intValue] - [weakSelf.viewModel.addModel.total_progress intValue] >= 0) {
                    [TLUIUtility showErrorHint:@"课程进度已大于总课程数"];
                    return;
                }
                [otherDict setObject:weakSelf.viewModel.addModel.now_progress forKey:@"now_progress"];
            }else{
                [otherDict setObject:@"0" forKey:@"now_progress"];
            }
            if (!ValidStr(weakSelf.viewModel.addModel.teacher_id)) {
                [TLUIUtility showErrorHint:@"请选择教师"];
                return ;
            }
            
            
            
            [otherDict setObject:weakSelf.viewModel.addModel.name forKey:@"name"];
            [otherDict setObject:weakSelf.viewModel.addModel.phone forKey:@"phone"];
            
            [otherDict setObject:weakSelf.viewModel.addModel.stores_courses_class_id forKey:@"stores_courses_class_id"];
            [otherDict setObject:weakSelf.viewModel.addModel.teacher_id forKey:@"teacher_id"];
            
            [otherDict setObject:weakSelf.viewModel.addModel.stores_id forKey:@"stores_id"];
            [otherDict setObject:weakSelf.viewModel.addModel.code_id forKey:@"code_id"];
            [otherDict setObject:weakSelf.viewModel.addModel.sex forKey:@"sex"];
            
            
            
            
            if (ValidStr(weakSelf.viewModel.addModel.birthday)) {
                [otherDict setObject:weakSelf.viewModel.addModel.birthday forKey:@"birthday"];
            }
            
            if (ValidStr(weakSelf.viewModel.addModel.sign_up_at)) {
                [otherDict setObject:weakSelf.viewModel.addModel.sign_up_at forKey:@"sign_up_at"];
            }
            
            
            if (ValidStr(weakSelf.viewModel.addModel.is_star)) {
                [otherDict setObject:weakSelf.viewModel.addModel.is_star forKey:@"is_star"];
            }
            
            if (ValidStr(weakSelf.viewModel.addModel.specialty_desc)) {
                [otherDict setObject:weakSelf.viewModel.addModel.specialty_desc forKey:@"specialty_desc"];
            }
            
            if (ValidStr(weakSelf.viewModel.addModel.remark)) {
                [otherDict setObject:weakSelf.viewModel.addModel.remark forKey:@"remark"];
            }
            
            [weakSelf updateImageWithOtherParams:otherDict];
        } forControlEvents:UIControlEventTouchUpInside];
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
                [weakSelf updatePhotosStep1WithOtherParams:otherDict];
            }else{
                [TLUIUtility hiddenLoading];
                [TLUIUtility showErrorHint:message];
            }
        }];
        return;
    }
    
    [self updatePhotosStep1WithOtherParams:otherDict];
}


- (NSInteger)checkIsHavePhotos {
    NSInteger index = 0;
    for (int i = 0; i < self.viewModel.addModel.images_list.count; i++) {
        id temp = self.viewModel.addModel.images_list[i];
        if ([temp isKindOfClass:[UIImage class]]) {
            index++;
        }else if ([temp isKindOfClass:[NSString class]]){
            NSString *tempStr = temp;
            if (tempStr.length > 0) {
                index++;
            }
        }
    }
    return index;
}

- (void)updatePhotosStep1WithOtherParams:(NSMutableDictionary *)otherDict {
    if ([self checkIsHavePhotos] > 0) {
        [TLUIUtility showLoading:@"上传明星学员相册中"];
        NSInteger tindex = 0;
        [self updatePhotosStep2WithImage:tindex otherParams:otherDict];
    }else{
        if (self.isEdit) {
            [self editOtherDataWithParams:otherDict];
        }else{
            [self updateOtherDataWithParams:otherDict];
        }
    }
    
}

 - (void)updatePhotosStep2WithImage:(NSInteger)index otherParams:(NSMutableDictionary *)otherDict {
     __weak typeof(self) weakSelf = self;
     [self updatePhotosStep3WithImage:index otherParams:otherDict complete:^(BOOL isSuccess, NSInteger index) {
         if (index == weakSelf.viewModel.addModel.images_list.count-1) {
             if (weakSelf.isEdit) {
                 [weakSelf editOtherDataWithParams:otherDict];
             }else{
                 [weakSelf updateOtherDataWithParams:otherDict];
             }
         }else{
             index++;
             [weakSelf updatePhotosStep2WithImage:index otherParams:otherDict];
         }
    }];
}

- (void)updatePhotosStep3WithImage:(NSInteger)index otherParams:(NSMutableDictionary *)otherDict complete:(void(^)(BOOL, NSInteger))complete{
    [TLUIUtility showLoading:[NSString stringWithFormat:@"上传明星学员相册中 %ld/%ld",index+1,self.viewModel.addModel.images_list.count]];
    
    id temp = self.viewModel.addModel.images_list[index];
    UIImage *image;
    if ([temp isKindOfClass:[UIImage class]]) {
        image = temp;
    }
    if (!image) {
        complete(YES,index);
        return;
    }
    __weak typeof(self) weakSelf = self;
    [ZOriganizationLessonViewModel uploadImageList:@{@"type":@"2",@"imageKey":@{@"file":image}} completeBlock:^(BOOL isSuccess, NSString *message) {
        if (isSuccess) {
            [weakSelf.viewModel.addModel.images_list replaceObjectAtIndex:index withObject:message];
            complete(YES,index);
        }else{
            [TLUIUtility hiddenLoading];
            [TLUIUtility showErrorHint:message];
        }
    }];
}

- (void)updateOtherDataWithParams:(NSMutableDictionary *)otherDict {
    if (ValidStr(self.viewModel.addModel.image)) {
        [otherDict setObject:self.viewModel.addModel.image forKey:@"image"];
    }
    if (ValidArray(self.viewModel.addModel.images_list)) {
        NSMutableArray *imageList = @[].mutableCopy;
        for (int i = 0; i < self.viewModel.addModel.images_list.count; i++) {
            [imageList addObject:self.viewModel.addModel.images_list[i]];
        }
        [otherDict setObject:imageList forKey:@"images_list"];
    }
    
    __weak typeof(self) weakSelf = self;
    [TLUIUtility showLoading:@"上传其他数据"];
    [ZOriganizationStudentViewModel addStudent:otherDict completeBlock:^(BOOL isSuccess, NSString *message) {
        [TLUIUtility hiddenLoading];
        if (isSuccess) {
            [TLUIUtility showSuccessHint:message];
            [weakSelf.navigationController popViewControllerAnimated:YES];
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
    
    if (ValidArray(self.viewModel.addModel.images_list)) {
        NSMutableArray *imageList = @[].mutableCopy;
        for (int i = 0; i < self.viewModel.addModel.images_list.count; i++) {
            [imageList addObject:self.viewModel.addModel.images_list[i]];
        }
        [otherDict setObject:imageList forKey:@"images_list"];
    }
    
    
    if (ValidStr(self.viewModel.addModel.studentID)) {
        [otherDict setObject:self.viewModel.addModel.studentID forKey:@"id"];
    }
    
    __weak typeof(self) weakSelf = self;
    [TLUIUtility showLoading:@"上传其他数据"];
    [ZOriganizationStudentViewModel editStudent:otherDict completeBlock:^(BOOL isSuccess, NSString *message) {
        [TLUIUtility hiddenLoading];
        if (isSuccess) {
            [TLUIUtility showSuccessHint:message];
            [weakSelf.navigationController popViewControllerAnimated:YES];
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
            [[ZImagePickerManager sharedManager] setAvatarSelectMenu:^(NSArray<ZImagePickerModel *> *list) {
                if (list && list.count > 0) {
                    ZImagePickerModel *model = list[0];
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
    }else  if ([cellConfig.title isEqualToString:@"ZOriganizationTextViewCell"]) {
        ZOriganizationTextViewCell *lcell = (ZOriganizationTextViewCell *)cell;
        lcell.max = 300;
        lcell.hint = @"选填";
        lcell.content = self.viewModel.addModel.remark;
        lcell.textChangeBlock = ^(NSString * text) {
            weakSelf.viewModel.addModel.remark = text;
        };
    }else  if ([cellConfig.title isEqualToString:@"specialty_desc"]) {
        ZOriganizationTextViewCell *lcell = (ZOriganizationTextViewCell *)cell;
        lcell.max = 300;
        lcell.hint = @"选填";
        lcell.content = self.viewModel.addModel.specialty_desc;
        lcell.textChangeBlock = ^(NSString * text) {
            weakSelf.viewModel.addModel.specialty_desc = text;
        };
    }else if([cellConfig.title isEqualToString:@"now_progress"]){
        ZTextFieldCell *lcell = (ZTextFieldCell *)cell;
        lcell.valueChangeBlock = ^(NSString * text) {
            weakSelf.viewModel.addModel.now_progress = text;
        };
    }else if ([cellConfig.title isEqualToString:@"ZAddPhotosCell"]) {
        ZAddPhotosCell *tCell = (ZAddPhotosCell *)cell;
        tCell.seeBlock = ^(NSInteger index) {
            [[ZImagePickerManager sharedManager] showBrowser:weakSelf.viewModel.addModel.images_list withIndex:index];
        } ;
        tCell.menuBlock = ^(NSInteger index, BOOL isAdd) {
            [weakSelf.iTableView endEditing:YES];
            if (isAdd) {
                [[ZImagePickerManager sharedManager] setImagesWithMaxCount:9 - weakSelf.viewModel.addModel.images_list.count SelectMenu:^(NSArray<ZImagePickerModel *> *list) {
                    if (list && list.count > 0){;
                        for (ZImagePickerModel *model in list) {
//                            [weakSelf.uploadArr addObject:model.image];
                            [weakSelf.viewModel.addModel.images_list addObject:model.image];
                        }
                        [weakSelf initCellConfigArr];
                        [weakSelf.iTableView reloadData];
                    }
                }];
            }else{
                if (index < weakSelf.viewModel.addModel.images_list.count) {
                    [weakSelf.viewModel.addModel.images_list removeObjectAtIndex:index];
                    [weakSelf initCellConfigArr];
                    [weakSelf.iTableView reloadData];
                }
            }
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
        [ZAlertDataSinglePickerView setAlertName:@"性别选择" selectedIndex:[weakSelf.viewModel.addModel.sex intValue] > 0 ? [weakSelf.viewModel.addModel.sex intValue]-1:0 items:items handlerBlock:^(NSInteger index) {
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
        if (!ValidStr(self.viewModel.addModel.studentID)) {
            [self.iTableView endEditing:YES];
            [ZDatePickerManager showDatePickerWithTitle:@"报名日期" type:PGDatePickerModeDate handle:^(NSDateComponents * date) {
                weakSelf.viewModel.addModel.sign_up_at = [NSString stringWithFormat:@"%ld",(long)[[NSDate dateFromComponents:date] timeIntervalSince1970]];
                [weakSelf initCellConfigArr];
                [weakSelf.iTableView reloadData];
            }];
        }
    }else if ([cellConfig.title isEqualToString:@"lesson"]) {
        if (!ValidStr(self.viewModel.addModel.studentID)) {
            [self.iTableView endEditing:YES];
            [ZAlertLessonCheckBoxView  setAlertName:@"选择课程" schoolID:[ZUserHelper sharedHelper].school.schoolID handlerBlock:^(NSInteger index,ZOriganizationLessonListModel *model) {
                if (model) {
                    weakSelf.viewModel.addModel.stores_courses_class_id = model.lessonID;
                    weakSelf.viewModel.addModel.courses_name = model.name;
                    weakSelf.viewModel.addModel.total_progress = model.course_number;
                    [weakSelf initCellConfigArr];
                    [weakSelf.iTableView reloadData];
                }
            }];
        }
    }else if ([cellConfig.title isEqualToString:@"teacher"]) {
        if (!ValidStr(self.viewModel.addModel.studentID)) {
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
}

@end
