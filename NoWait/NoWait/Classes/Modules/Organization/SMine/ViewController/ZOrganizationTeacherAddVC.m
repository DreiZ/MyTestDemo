//
//  ZOrganizationTeacherAddVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/2/19.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationTeacherAddVC.h"
#import "ZOriganizationTeachListCell.h"
#import "ZOriganizationTeachAddHeadImageCell.h"
#import "ZAddPhotosCell.h"
#import "ZOriganizationTextViewCell.h"
#import "ZOriganizationIDCardCell.h"
#import "ZOrganizationCampusTextLabelCell.h"

#import "ZBaseUnitModel.h"
#import "ZAlertDataSinglePickerView.h"
#import "ZAlertDataPickerView.h"
#import "ZOriganizationLessonViewModel.h"

#import "ZOrganizationCampusManageAddLabelVC.h"
#import "ZOrganizationTeacherLessonSelectVC.h"

@interface ZOrganizationTeacherAddVC ()
@property (nonatomic,strong) UIButton *bottomBtn;

@end

@implementation ZOrganizationTeacherAddVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigation];
    self.viewModel.addModel.school = [ZUserHelper sharedHelper].school.name;
    self.viewModel.addModel.stores_id = [ZUserHelper sharedHelper].school.schoolID;
    if (!ValidStr(self.viewModel.addModel.sex)) {
        self.viewModel.addModel.sex = @"1";
    }
    [self initCellConfigArr];
    [self.iTableView reloadData];
}


- (ZOriganizationTeacherViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[ZOriganizationTeacherViewModel alloc] init];
        _viewModel.addModel.school = [ZUserHelper sharedHelper].school.name;
        _viewModel.addModel.stores_id = [ZUserHelper sharedHelper].school.schoolID;
        _viewModel.addModel.sex = @"1";
        _viewModel.addModel.c_level = @"1";
//        for (int j = 0; j < 9; j++) {
//            [_viewModel.addModel.images_list addObject:@""];
//            [_viewModel.addModel.images_list_net addObject:@""];
//        }
    }
    return _viewModel;
}

- (void)initCellConfigArr {
    [super initCellConfigArr];
    NSString *level = @"";
    NSArray *temp = @[@"初级教师",@"高级教师"];
    if ([_viewModel.addModel.c_level intValue] > 0 && [_viewModel.addModel.c_level intValue] <= temp.count) {
        level = temp[[_viewModel.addModel.c_level intValue] - 1];
    }
    
//    ZCellConfig *progressCellConfig = [ZCellConfig cellConfigWithClassName:[ZOriganizationTeachAddHeadImageCell className] title:[ZOriganizationTeachAddHeadImageCell className] showInfoMethod:@selector(setImage:) heightOfCell:[ZOriganizationTeachAddHeadImageCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:self.viewModel.addModel.image];
//    [self.cellConfigArr addObject:progressCellConfig];
    
    NSArray *textArr = @[@[@"真实姓名", @"请输入真实姓名", @YES, @"", @"name",@10,SafeStr(self.viewModel.addModel.real_name),[NSNumber numberWithInt:ZFormatterTypeAny]],
                         @[@"昵称", @"请输入昵称", @YES, @"", @"nikeName",@10,SafeStr(self.viewModel.addModel.nick_name),[NSNumber numberWithInt:ZFormatterTypeAny]],
                         @[@"性别", @"请选择性别", @NO, @"rightBlackArrowN", @"sex",@2,[SafeStr(self.viewModel.addModel.sex) intValue] == 1 ? @"男":@"女",[NSNumber numberWithInt:ZFormatterTypeAny]],
                         @[@"手机号", @"请输入手机号", @YES, @"", @"phone",@11,SafeStr(self.viewModel.addModel.phone),[NSNumber numberWithInt:ZFormatterTypeNumber]],
                         @[@"身份证号码", @"请输入身份号", @YES, @"", @"cid",@18,SafeStr(self.viewModel.addModel.id_card),[NSNumber numberWithInt:ZFormatterTypeAny]],
//                        @[@"教师等级", @"请选择等级", @NO, @"rightBlackArrowN", @"class",@18,level,[NSNumber numberWithInt:ZFormatterTypeAny]],
                        @[@"教师职称", @"请输入教师职称", @YES, @"", @"title",@10,SafeStr(self.viewModel.addModel.position),[NSNumber numberWithInt:ZFormatterTypeAny]],
                        @[@"任课课程", @"请选择课程", @YES, @"rightBlackArrowN", @"lesson",@30,SafeStr(self.viewModel.addModel.real_name),[NSNumber numberWithInt:ZFormatterTypeAny]],
                        @[@"特长技能", @"请添加特长技能", @YES, @"rightBlackArrowN", @"skill",@40,SafeStr(self.viewModel.addModel.real_name),[NSNumber numberWithInt:ZFormatterTypeAny]]];
    
    for (int i = 0; i < textArr.count; i++) {
        if ([textArr[i][4] isEqualToString:@"skill"] || [textArr[i][4] isEqualToString:@"lesson"]) {
            ZBaseTextFieldCellModel *cellModel = [[ZBaseTextFieldCellModel alloc] init];
            cellModel.leftTitle = textArr[i][0];
            cellModel.placeholder = textArr[i][1];
            cellModel.isTextEnabled = [textArr[i][2] boolValue];
            cellModel.rightImage = textArr[i][3];
            cellModel.isHiddenLine = YES;
            cellModel.cellHeight = CGFloatIn750(108);
            cellModel.contBackMargin = CGFloatIn750(0);
            cellModel.contentSpace = CGFloatIn750(30);
            cellModel.leftFont = [UIFont boldFontTitle];
            if ([textArr[i][4] isEqualToString:@"skill"]) {
                cellModel.data = self.viewModel.addModel.skills;
            }else{
                NSMutableArray *temp = @[].mutableCopy;
                for (ZOriganizationLessonListModel *tmodel in self.viewModel.addModel.lessonList) {
                    [temp addObject:[NSString stringWithFormat:@"%@    %@元    %@元",tmodel.short_name,SafeStr(tmodel.price),ValidStr(tmodel.teacherPirce)?  SafeStr(tmodel.teacherPirce) : SafeStr(tmodel.price)]];
                }
                cellModel.data = temp;
            }
            
            ZCellConfig *textCellConfig = [ZCellConfig cellConfigWithClassName:[ZOrganizationCampusTextLabelCell className] title:textArr[i][4] showInfoMethod:@selector(setModel:) heightOfCell:[ZOrganizationCampusTextLabelCell z_getCellHeight:cellModel] cellType:ZCellTypeClass dataModel:cellModel];
            [self.cellConfigArr addObject:textCellConfig];
        }else{
            ZBaseTextFieldCellModel *cellModel = [[ZBaseTextFieldCellModel alloc] init];
            cellModel.leftTitle = textArr[i][0];
            cellModel.placeholder = textArr[i][1];
            cellModel.isTextEnabled = [textArr[i][2] boolValue];
            cellModel.rightImage = textArr[i][3];
            cellModel.max = [textArr[i][5] intValue];
            cellModel.content = textArr[i][6];
            cellModel.formatterType = [textArr[i][7] intValue];
            cellModel.isHiddenLine = YES;
            cellModel.cellHeight = CGFloatIn750(108);
            ZCellConfig *textCellConfig = [ZCellConfig cellConfigWithClassName:[ZTextFieldCell className] title:textArr[i][4] showInfoMethod:@selector(setModel:) heightOfCell:[ZTextFieldCell z_getCellHeight:cellModel] cellType:ZCellTypeClass dataModel:cellModel];
            [self.cellConfigArr addObject:textCellConfig];
            
            NSMutableArray *tempArr = @[].mutableCopy;
            if (self.viewModel.addModel.cardImageUp) {
                [tempArr addObject:self.viewModel.addModel.cardImageUp];
            }else{
                [tempArr addObject:@""];
            }
            if (self.viewModel.addModel.cardImageDown) {
                [tempArr addObject:self.viewModel.addModel.cardImageDown];
            }else{
                [tempArr addObject:@""];
            }
            if ([textArr[i][4] isEqualToString:@"cid"]) {
                ZCellConfig *textCellConfig = [ZCellConfig cellConfigWithClassName:[ZOriganizationIDCardCell className] title:@"IDCard" showInfoMethod:@selector(setImages:) heightOfCell:[ZOriganizationIDCardCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:tempArr];
                [self.cellConfigArr addObject:textCellConfig];
            }
        }
    }
    
    {
        ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
        model.leftTitle = @"教师简介";
        model.leftFont = [UIFont boldFontTitle];
        model.isHiddenLine = YES;
        model.cellHeight = CGFloatIn750(92);
        
        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
        
        [self.cellConfigArr addObject:menuCellConfig];
        
        ZCellConfig *textCellConfig = [ZCellConfig cellConfigWithClassName:[ZOriganizationTextViewCell className] title:@"ZOriganizationTextViewCell" showInfoMethod:@selector(setIsBackColor:) heightOfCell:CGFloatIn750(274) cellType:ZCellTypeClass dataModel:@"yes"];
        
        [self.cellConfigArr addObject:textCellConfig];
    }
    
    {
        ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
        model.leftTitle = @"教师相册";
        model.leftFont = [UIFont boldFontTitle];
        model.isHiddenLine = YES;
        model.cellHeight = CGFloatIn750(92);
        
        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
        
        [self.cellConfigArr addObject:menuCellConfig];
    }
    
    {
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
        //            model.name = tempArr[j][0];
        //            model.imageName = tempArr[j][1];
        //            model.uid = tempArr[j][2];
            [menulist addObject:model];
        }
        model.name = @"添加图片";
        model.subName = @"选填";
        model.uid = @"9";
        model.units = menulist;

        ZCellConfig *progressCellConfig = [ZCellConfig cellConfigWithClassName:[ZAddPhotosCell className] title:[ZAddPhotosCell className] showInfoMethod:@selector(setModel:) heightOfCell:[ZAddPhotosCell z_getCellHeight:menulist] cellType:ZCellTypeClass dataModel:model];
        [self.cellConfigArr addObject:progressCellConfig];
    }
}

- (void)setNavigation {
    self.isHidenNaviBar = NO;
    if (!_isEdit) {
        [self.navigationItem setTitle:@"新增教师"];
    }else{
        [self.navigationItem setTitle:@"编辑教师"];
    }
}

- (void)setupMainView {
    [super setupMainView];
   
    [self.iTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(CGFloatIn750(0));
        make.right.equalTo(self.view.mas_right).offset(CGFloatIn750(-0));
        make.bottom.equalTo(self.view.mas_bottom).offset(-CGFloatIn750(0));
        make.top.equalTo(self.view.mas_top).offset(-CGFloatIn750(0));
    }];
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, CGFloatIn750(160))];
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
            if (!ValidStr(self.viewModel.addModel.real_name)) {
                [TLUIUtility showErrorHint:@"请输入真实姓名"];
                return ;
            }
            if (!ValidStr(self.viewModel.addModel.nick_name)) {
                [TLUIUtility showErrorHint:@"请输入昵称"];
                return ;
            }
            if (!ValidStr(self.viewModel.addModel.phone)) {
                [TLUIUtility showErrorHint:@"请输入手机号"];
                return ;
            }
            if (!ValidStr(self.viewModel.addModel.id_card)) {
                [TLUIUtility showErrorHint:@"请输入身份证号"];
                return ;
            }
            if (!(ValidStr(self.viewModel.addModel.cardImageUp) || ValidClass(self.viewModel.addModel.cardImageUp, [UIImage class]))) {
                [TLUIUtility showErrorHint:@"请添加身份证正面"];
                return ;
            }
            if (!(ValidStr(self.viewModel.addModel.cardImageDown) || ValidClass(self.viewModel.addModel.cardImageDown, [UIImage class]))) {
                [TLUIUtility showErrorHint:@"请添加身份证反面"];
                return ;
            }
            if (!ValidStr(self.viewModel.addModel.position)) {
                [TLUIUtility showErrorHint:@"请输入教师职称"];
                return ;
            }
            
            NSMutableDictionary *params = @{}.mutableCopy;
            [params setObject:SafeStr([ZUserHelper sharedHelper].school.schoolID) forKey:@"stores_id"];
            [params setObject:SafeStr(weakSelf.viewModel.addModel.real_name) forKey:@"real_name"];
            [params setObject:SafeStr(weakSelf.viewModel.addModel.nick_name) forKey:@"nick_name"];
            [params setObject:SafeStr(weakSelf.viewModel.addModel.sex) forKey:@"sex"];
            [params setObject:SafeStr(weakSelf.viewModel.addModel.phone) forKey:@"phone"];
            [params setObject:SafeStr(weakSelf.viewModel.addModel.id_card) forKey:@"id_card"];
//            [params setObject:SafeStr(weakSelf.viewModel.addModel.c_level) forKey:@"c_level"];
            [params setObject:SafeStr(weakSelf.viewModel.addModel.position) forKey:@"position"];
            
            if (ValidArray(weakSelf.viewModel.addModel.lessonList)) {
                NSMutableArray *temp = @[].mutableCopy;
                for (ZOriganizationLessonListModel *model in self.viewModel.addModel.lessonList) {
                    [temp addObject:@{@"courses_id":SafeStr(model.lessonID),@"price":ValidStr(model.teacherPirce) ? SafeStr(model.teacherPirce):SafeStr(model.price)}];
                }
                if (temp.count > 0) {
                    [params setObject:temp forKey:@"class_ids"];
                }
            }
            if (ValidArray(weakSelf.viewModel.addModel.skills)) {
                NSMutableArray *temp = @[].mutableCopy;
                for (NSString *str in self.viewModel.addModel.skills) {
                    [temp addObject:str];
                }
                if (temp.count > 0) {
                    [params setObject:temp forKey:@"skills"];
                }
            }
            
            if (ValidStr(weakSelf.viewModel.addModel.des)) {
                [params setObject:weakSelf.viewModel.addModel.des forKey:@"description"];
            }
            [weakSelf updateImageWithOtherParams:params];
        }];
    }
    return _bottomBtn;
}


- (void)updateImageWithOtherParams:(NSMutableDictionary *)otherDict {
    if (self.viewModel.addModel.image && [self.viewModel.addModel.image isKindOfClass:[UIImage class]]) {
        __weak typeof(self) weakSelf = self;
        [TLUIUtility showLoading:@"上传头像图片中"];
        [self uploadImage:self.viewModel.addModel.image complete:^(BOOL isSuccess, NSString *message) {
            if (isSuccess) {
                weakSelf.viewModel.addModel.image = message;
                [weakSelf updateCardIDOneWithOtherParams:otherDict];
            }
        }];
        return;
    }
    [self updateCardIDOneWithOtherParams:otherDict];
}

- (void)updateCardIDOneWithOtherParams:(NSMutableDictionary *)otherDict {
    if (ValidStr(self.viewModel.addModel.cardImageUp)) {
        [self updateCardIDTwoWithOtherParams:otherDict];
        return;
    }
    __weak typeof(self) weakSelf = self;
    [TLUIUtility showLoading:@"上传身份证中"];
    [self uploadImage:self.viewModel.addModel.cardImageUp complete:^(BOOL isSuccess, NSString *message) {
        if (isSuccess) {
            weakSelf.viewModel.addModel.cardImageUp = message;
            [weakSelf updateCardIDTwoWithOtherParams:otherDict];
        }
    }];
}

- (void)updateCardIDTwoWithOtherParams:(NSMutableDictionary *)otherDict {
    if (ValidStr(self.viewModel.addModel.cardImageDown)) {
        [self updatePhotosStep1WithOtherParams:otherDict];
        return;
    }
    __weak typeof(self) weakSelf = self;
    [TLUIUtility showLoading:@"上传身份证中"];
    [self uploadImage:self.viewModel.addModel.cardImageDown complete:^(BOOL isSuccess, NSString *message) {
        if (isSuccess) {
            weakSelf.viewModel.addModel.cardImageDown = message;
            [weakSelf updatePhotosStep1WithOtherParams:otherDict];
        }
    }];
}

- (void)uploadImage:(UIImage *)image complete:(void(^)(BOOL, NSString*))complete {
    [ZOriganizationLessonViewModel uploadImageList:@{@"type":@"4",@"imageKey":@{@"file":image}} completeBlock:^(BOOL isSuccess, NSString *message) {
           if (isSuccess) {
               complete(YES,message);
           }else{
               [TLUIUtility hiddenLoading];
               [TLUIUtility showErrorHint:message];
               complete(NO,message);
           }
    }];
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
        [TLUIUtility showLoading:@"上传课程相册中"];
        NSInteger tindex = 0;
        [self updatePhotosStep2WithImage:tindex otherParams:otherDict];
    }else{
        [self updateOtherDataWithParams:otherDict];
    }
    
}

 - (void)updatePhotosStep2WithImage:(NSInteger)index otherParams:(NSMutableDictionary *)otherDict {
     [self updatePhotosStep3WithImage:index otherParams:otherDict complete:^(BOOL isSuccess, NSInteger index) {
         if (index == self.viewModel.addModel.images_list.count-1) {
             [self updateOtherDataWithParams:otherDict];
         }else{
             index++;
             [self updatePhotosStep2WithImage:index otherParams:otherDict];
         }
    }];
}

- (void)updatePhotosStep3WithImage:(NSInteger)index otherParams:(NSMutableDictionary *)otherDict complete:(void(^)(BOOL, NSInteger))complete{
    [TLUIUtility showLoading:[NSString stringWithFormat:@"上传课程相册中 %ld/%ld",index+1,self.viewModel.addModel.images_list.count]];
    
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
    [ZOriganizationLessonViewModel uploadImageList:@{@"type":@"4",@"imageKey":@{@"file":image}} completeBlock:^(BOOL isSuccess, NSString *message) {
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
    
    if (ValidStr(self.viewModel.addModel.cardImageUp) && ValidStr(self.viewModel.addModel.cardImageDown)) {
        [otherDict setObject:@[self.viewModel.addModel.cardImageUp,self.viewModel.addModel.cardImageDown] forKey:@"card_image"];
    }else{
        [TLUIUtility showErrorHint:@"身份证照片出错"];
        return;
    }
    
    if ([self checkIsHavePhotos] > 0) {
        NSMutableArray *photos = @[].mutableCopy;
        for (int i = 0; i < self.viewModel.addModel.images_list.count; i++) {
            NSString *temp = self.viewModel.addModel.images_list[i];
            if (ValidStr(temp)) {
                [photos addObject:temp];
            }
        }
        if (photos.count > 0) {
            [otherDict setObject:photos forKey:@"images_list"];
        }
    }
    
    if (ValidStr(self.viewModel.addModel.teacherID)) {
        [otherDict setObject:self.viewModel.addModel.teacherID forKey:@"id"];
    }
    
    [TLUIUtility showLoading:@"上传其他数据"];
    [ZOriganizationTeacherViewModel addTeacher:otherDict isEdit:ValidStr(self.viewModel.addModel.teacherID) ? YES:NO completeBlock:^(BOOL isSuccess, NSString *message) {
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


#pragma mark - tableView -------datasource-----
- (void)zz_tableView:(UITableView *)tableView cell:(UITableViewCell *)cell cellForRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
    __weak typeof(self) weakSelf = self;
    if ([cellConfig.title isEqualToString:@"name"]) {
        ZTextFieldCell *tCell = (ZTextFieldCell *)cell;
        tCell.valueChangeBlock = ^(NSString * text) {
            weakSelf.viewModel.addModel.real_name = text;
        };
    }else if ([cellConfig.title isEqualToString:@"nikeName"]) {
        ZTextFieldCell *tCell = (ZTextFieldCell *)cell;
        tCell.valueChangeBlock = ^(NSString * text) {
            weakSelf.viewModel.addModel.nick_name = text;
        };
    }else if ([cellConfig.title isEqualToString:@"phone"]) {
        ZTextFieldCell *tCell = (ZTextFieldCell *)cell;
        tCell.valueChangeBlock = ^(NSString * text) {
            weakSelf.viewModel.addModel.phone = text;
        };
    }else if ([cellConfig.title isEqualToString:@"cid"]) {
        ZTextFieldCell *tCell = (ZTextFieldCell *)cell;
        tCell.valueChangeBlock = ^(NSString * text) {
            weakSelf.viewModel.addModel.id_card = text;
        };
    }else if ([cellConfig.title isEqualToString:@"title"]) {
        ZTextFieldCell *tCell = (ZTextFieldCell *)cell;
        tCell.valueChangeBlock = ^(NSString * text) {
            weakSelf.viewModel.addModel.position = text;
        };
    }else if ([cellConfig.title isEqualToString:@"ZOriganizationTeachAddHeadImageCell"]) {
        ZOriganizationTeachAddHeadImageCell *lcell = (ZOriganizationTeachAddHeadImageCell *)cell;
        lcell.handleBlock = ^(NSInteger index) {
            [weakSelf.iTableView endEditing:YES];
            [[ZPhotoManager sharedManager] showCropOriginalSelectMenuWithCropSize:CGSizeMake(KScreenWidth * (0.6), KScreenWidth*(0.6)) complete:^(NSArray<LLImagePickerModel *> *list) {
                if (list && list.count > 0) {
                    LLImagePickerModel *model = list[0];
                    weakSelf.viewModel.addModel.image = model.image;
                    [weakSelf initCellConfigArr];
                    [weakSelf.iTableView reloadData];
                }
            }];
        };
    }else if ([cellConfig.title isEqualToString:@"ZAddPhotosCell"]) {
        ZAddPhotosCell *tCell = (ZAddPhotosCell *)cell;
        
        tCell.seeBlock = ^(NSInteger index) {
            [[ZPhotoManager sharedManager] showBrowser:weakSelf.viewModel.addModel.images_list withIndex:index];
        } ;
        
        tCell.menuBlock = ^(NSInteger index, BOOL isAdd) {
            [weakSelf.iTableView endEditing:YES];
            if (isAdd) {
                [ZPhotoManager sharedManager].maxImageSelected = 9 - weakSelf.viewModel.addModel.images_list.count;
                
                [[ZPhotoManager sharedManager] showSelectMenu:^(NSArray<LLImagePickerModel *> *list) {
                    if (list && list.count > 0){;
                        for (LLImagePickerModel *model in list) {
//                            [weakSelf.uploadArr addObject:model.image];
                            [weakSelf.viewModel.addModel.images_list addObject:model.image];
                        }
                        [weakSelf initCellConfigArr];
                        [weakSelf.iTableView reloadData];
                    }
                }];
//                [[ZPhotoManager sharedManager] showCropOriginalSelectMenuWithCropSize:CGSizeMake(KScreenWidth, 74/111.0f * KScreenWidth) complete:^(NSArray<LLImagePickerModel *> *list) {
//                    if (list && list.count > 0) {
//                        if (index < weakSelf.viewModel.addModel.images_list.count) {
//                            LLImagePickerModel *model = list[0];
//                            [weakSelf.viewModel.addModel.images_list replaceObjectAtIndex:index withObject:model.image];
//                            [weakSelf.viewModel.addModel.images_list_net replaceObjectAtIndex:index withObject:@""];
//                            [weakSelf initCellConfigArr];
//                            [weakSelf.iTableView reloadData];
//                        }
//                    }
//                }];
            }else{
                if (index < weakSelf.viewModel.addModel.images_list.count) {
                    [weakSelf.viewModel.addModel.images_list removeObjectAtIndex:index];
                    [weakSelf initCellConfigArr];
                    [weakSelf.iTableView reloadData];
                }
            }
        };
    }else if ([cellConfig.title isEqualToString:@"ZOriganizationTextViewCell"]) {
        ZOriganizationTextViewCell *lcell = (ZOriganizationTextViewCell *)cell;
        lcell.max = 300;
        lcell.hint = @"介绍一下任课老师吧";
        lcell.content = self.viewModel.addModel.des;
        lcell.textChangeBlock = ^(NSString * text) {
            weakSelf.viewModel.addModel.des = text;
        };
    }else if ([cellConfig.title isEqualToString:@"IDCard"]) {
        ZOriganizationIDCardCell *lcell = (ZOriganizationIDCardCell *)cell;
        lcell.handleBlock = ^(NSInteger index) {
            [weakSelf.iTableView endEditing:YES];
            [[ZPhotoManager sharedManager] showIDCropOriginalSelectMenuWithCropSize:CGSizeMake(CGFloatIn750(720), CGFloatIn750(452)) complete:^(NSArray<LLImagePickerModel *> *list) {
                if (list && list.count > 0) {
                    LLImagePickerModel *model = list[0];
                    if (index == 0) {
                        weakSelf.viewModel.addModel.cardImageUp = model.image;
                    }
                    if (index == 1 ) {
                        weakSelf.viewModel.addModel.cardImageDown = model.image;
                    }
                    
                    [weakSelf initCellConfigArr];
                    [weakSelf.iTableView reloadData];
                }
            }];
        };
    }
}

- (void)zz_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig  {
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
    }else if ([cellConfig.title isEqualToString:@"class"]) {
        [self.iTableView endEditing:YES];
        NSMutableArray *items = @[].mutableCopy;
        NSArray *temp = @[@"普通教师",@"明星教师"];
        for (int i = 0; i < temp.count; i++) {
            ZAlertDataItemModel *model = [[ZAlertDataItemModel alloc] init];
            model.name = temp[i];
            [items addObject:model];
        }
        
        [ZAlertDataSinglePickerView setAlertName:@"教师等级" items:items handlerBlock:^(NSInteger index) {
            weakSelf.viewModel.addModel.c_level = [NSString stringWithFormat:@"%ld",index + 1];
            [weakSelf initCellConfigArr];
            [weakSelf.iTableView reloadData];
        }];
    }else if ([cellConfig.title isEqualToString:@"skill"]) {
        [self.iTableView endEditing:YES];
        ZOrganizationCampusManageAddLabelVC *lvc = [[ZOrganizationCampusManageAddLabelVC alloc] init];
        lvc.max = 5;
        lvc.list = self.viewModel.addModel.skills;
        lvc.handleBlock = ^(NSArray * labelArr) {
            [weakSelf.self.viewModel.addModel.skills removeAllObjects];
            [weakSelf.self.viewModel.addModel.skills addObjectsFromArray:labelArr];
            [weakSelf initCellConfigArr];
            [weakSelf.iTableView reloadData];
        };
        [self.navigationController pushViewController:lvc animated:YES];
    }else if ([cellConfig.title isEqualToString:@"lesson"]) {
        [self.iTableView endEditing:YES];
        ZOrganizationTeacherLessonSelectVC *lvc = [[ZOrganizationTeacherLessonSelectVC alloc] init];
        lvc.lessonList = self.viewModel.addModel.lessonList;
        lvc.handleBlock = ^(NSMutableArray<ZOriganizationLessonListModel *> *list, BOOL isAll) {
            weakSelf.viewModel.addModel.lessonList = list;
            [weakSelf initCellConfigArr];
            [weakSelf.iTableView reloadData];
        };
        [self.navigationController pushViewController:lvc animated:YES];
    }
}

@end
