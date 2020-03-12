//
//  ZOrganizationLessonAddVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/2/19.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationLessonAddVC.h"
#import "ZOrganizationLessonAddImageCell.h"
#import "ZOrganizationLessonAddPhotosCell.h"
#import "ZOrganizationLessonTypeCell.h"
#import "ZTextFieldMultColCell.h"

#import "ZStudentDetailModel.h"
#import "ZOriganizationModel.h"

#import "ZAlertDataPickerView.h"
#import "ZAlertDateHourPickerView.h"
#import "ZAlertDataSinglePickerView.h"
#import "ZAlertDateWeekAndHourPickerView.h"
#import "ZAlertDataModel.h"
#import "ZOrganizationTimeSelectVC.h"
#import "ZOrganizationLessonDetailVC.h"
#import "ZOrganizationLessonTextViewVC.h"

@interface ZOrganizationLessonAddVC ()
@property (nonatomic,strong) UIButton *navLeftBtn;
@property (nonatomic,strong) UIButton *bottomBtn;

@property (nonatomic,strong) NSMutableArray <ZAlertDataItemModel*> *items;
@end

@implementation ZOrganizationLessonAddVC

#pragma mark vc delegate-------------------
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.isHidenNaviBar = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigation];
    [self initCellConfigArr];
    [self.iTableView reloadData];
}

#pragma mark - setdata
- (void)setDataSource {
    [super setDataSource];
    _items = @[].mutableCopy;
}

- (ZOriganizationLessonViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[ZOriganizationLessonViewModel alloc] init];
        _viewModel.addModel.school = self.school.name;
        _viewModel.addModel.stores_id = self.school.schoolID;
        for (int j = 0; j < 9; j++) {
            [_viewModel.addModel.images addObject:@""];
            [_viewModel.addModel.net_images addObject:@""];
        }
    }
    return _viewModel;
}

- (void)initCellConfigArr {
    [super initCellConfigArr];
    
    [self addTopAndNameDetai];//封面、简称、简介
    [self addDesAndPrice];//详情、价格
    [self addImages];
    [self addSchoolAndClass];
    [self addOrder];
    [self addValidity];
}

#pragma mark - setmain
- (void)setNavigation {
    [self.navigationItem setTitle:@"新增课程"];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:self.navLeftBtn];
    [self.navigationItem setRightBarButtonItem:item];
}

- (void)setupMainView {
    [super setupMainView];
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, CGFloatIn750(180))];
    bottomView.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
    [bottomView addSubview:self.bottomBtn];
    [self.bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bottomView.mas_left).offset(CGFloatIn750(60));
        make.right.equalTo(bottomView.mas_right).offset(CGFloatIn750(-60));
        make.height.mas_equalTo(CGFloatIn750(80));
        make.top.equalTo(bottomView.mas_top).offset(CGFloatIn750(30));
    }];
    
    self.iTableView.tableFooterView = bottomView;
}

#pragma mark - lazy loading...
- (UIButton *)navLeftBtn {
    if (!_navLeftBtn) {
        __weak typeof(self) weakSelf = self;
        _navLeftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, CGFloatIn750(106), CGFloatIn750(48))];
        [_navLeftBtn setTitle:@"预览" forState:UIControlStateNormal];
        [_navLeftBtn setTitleColor:adaptAndDarkColor([UIColor colorTextGray1], [UIColor colorTextGray1Dark]) forState:UIControlStateNormal];
        [_navLeftBtn.titleLabel setFont:[UIFont fontContent]];
        [_navLeftBtn bk_whenTapped:^{
            ZOrganizationLessonDetailVC *dvc = [[ZOrganizationLessonDetailVC alloc] init];
            dvc.addModel = weakSelf.viewModel.addModel;
            [weakSelf.navigationController pushViewController:dvc animated:YES];
        }];
    }
    return _navLeftBtn;
}

- (UIButton *)bottomBtn {
    if (!_bottomBtn) {
        __weak typeof(self) weakSelf = self;
        _bottomBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        _bottomBtn.layer.masksToBounds = YES;
        _bottomBtn.layer.cornerRadius = CGFloatIn750(40);
        [_bottomBtn setTitle:@"提交审核" forState:UIControlStateNormal];
        [_bottomBtn setTitleColor:[UIColor colorWhite] forState:UIControlStateNormal];
        [_bottomBtn.titleLabel setFont:[UIFont boldFontTitle]];
        [_bottomBtn setBackgroundColor:[UIColor  colorMain] forState:UIControlStateNormal];
        [_bottomBtn bk_whenTapped:^{
            if (!weakSelf.viewModel.addModel.image_url) {
                [TLUIUtility showErrorHint:@"请添加封面图片"];
                return ;
            }
            if (!ValidStr(weakSelf.viewModel.addModel.name)) {
                [TLUIUtility showErrorHint:@"请输入课程名称"];
                return ;
            }
            if (!ValidStr(weakSelf.viewModel.addModel.short_name)) {
                [TLUIUtility showErrorHint:@"请输入课程简称"];
                return ;
            }
            if (!ValidStr(weakSelf.viewModel.addModel.info)) {
                [TLUIUtility showErrorHint:@"请添加课程介绍"];
                return ;
            }
            if (!ValidStr(weakSelf.viewModel.addModel.price)) {
                [TLUIUtility showErrorHint:@"请输入课程价格"];
                return ;
            }
            if (!ValidStr(weakSelf.viewModel.addModel.stores_id)) {
                [TLUIUtility showErrorHint:@"请添加适用校区"];
                return ;
            }
            if (!ValidStr(weakSelf.viewModel.addModel.level)) {
                [TLUIUtility showErrorHint:@"请选择课程级别"];
                return ;
            }
            if (!ValidStr(weakSelf.viewModel.addModel.course_min)) {
                [TLUIUtility showErrorHint:@"请输入单节课时"];
                return ;
            }
            if (!ValidStr(weakSelf.viewModel.addModel.course_number)) {
                [TLUIUtility showErrorHint:@"请输入课程节数"];
                return ;
            }
            if (!ValidStr(weakSelf.viewModel.addModel.course_class_number)) {
                [TLUIUtility showErrorHint:@"请输入课程人数"];
                return ;
            }
            
            if([weakSelf.viewModel.addModel.is_experience intValue] == 1){
                if (!ValidStr(weakSelf.viewModel.addModel.experience_price)) {
                    [TLUIUtility showErrorHint:@"请输入预约价格"];
                    return ;
                }
                if (!ValidStr(weakSelf.viewModel.addModel.experience_duration)) {
                    [TLUIUtility showErrorHint:@"请输入预约单次时长"];
                    return ;
                }
                if (!ValidArray(weakSelf.viewModel.addModel.experience_time)) {
                    [TLUIUtility showErrorHint:@"请添加可以预约时间"];
                    return ;
                }
            }
            
            
            if (!ValidStr(weakSelf.viewModel.addModel.valid_at)) {
                [TLUIUtility showErrorHint:@"请输入课程有效期"];
                return ;
            }
            
            if([weakSelf.viewModel.addModel.type intValue] == 1){
                if (!ValidArray(weakSelf.viewModel.addModel.fix_time)) {
                    [TLUIUtility showErrorHint:@"请添加固定上课时间"];
                    return ;
                }
            }
            if (!ValidStr(weakSelf.viewModel.addModel.p_information)) {
                [TLUIUtility showErrorHint:@"请添加购买须知"];
                return ;
            }
            NSMutableDictionary *otherDict = @{}.mutableCopy;
            
            [otherDict setObject:self.viewModel.addModel.name forKey:@"name"];
            [otherDict setObject:self.viewModel.addModel.short_name forKey:@"short_name"];
            [otherDict setObject:self.viewModel.addModel.info forKey:@"info"];
            [otherDict setObject:self.viewModel.addModel.price forKey:@"price"];
            [otherDict setObject:self.viewModel.addModel.stores_id forKey:@"stores_id"];
            [otherDict setObject:self.viewModel.addModel.level forKey:@"level"];
            [otherDict setObject:self.viewModel.addModel.course_min forKey:@"course_min"];
            [otherDict setObject:self.viewModel.addModel.course_number forKey:@"course_number"];
            [otherDict setObject:self.viewModel.addModel.course_class_number forKey:@"course_class_number"];
            [otherDict setObject:self.viewModel.addModel.is_experience forKey:@"is_experience"];
            [otherDict setObject:self.viewModel.addModel.valid_at forKey:@"valid_at"];
            [otherDict setObject:self.viewModel.addModel.type forKey:@"type"];
            [otherDict setObject:self.viewModel.addModel.p_information forKey:@"p_information"];
            
            if([self.viewModel.addModel.is_experience intValue] == 1){
                
                [otherDict setObject:self.viewModel.addModel.experience_price forKey:@"experience_price"];
                [otherDict setObject:self.viewModel.addModel.experience_duration forKey:@"experience_duration"];
                
                //可预约时间段
                NSMutableDictionary *orderDict = @{}.mutableCopy;
                for (ZBaseMenuModel *menuModel in self.viewModel.addModel.experience_time) {
                    if (menuModel && menuModel.units && menuModel.units.count > 0) {
                        
                        NSMutableArray *tempSubArr = @[].mutableCopy;
                        for (int k = 0; k < menuModel.units.count; k++) {
                            ZBaseUnitModel *unitModel = menuModel.units[k];
                            [tempSubArr addObject:[NSString stringWithFormat:@"%@~%@",SafeStr(unitModel.name),SafeStr(unitModel.subName)]];
                        }
                        
                        [orderDict setObject:tempSubArr forKey:[self getWeekIndex:menuModel.name]];
                    }
                }
                
                [otherDict setObject:orderDict forKey:@"experience_time"];
            }
            
            if([weakSelf.viewModel.addModel.type intValue] == 1){
                NSMutableDictionary *orderDict = @{}.mutableCopy;
                for (ZBaseMenuModel *menuModel in self.viewModel.addModel.fix_time) {
                    if (menuModel && menuModel.units && menuModel.units.count > 0) {
                        
                        NSMutableArray *tempSubArr = @[].mutableCopy;
                        for (int k = 0; k < menuModel.units.count; k++) {
                            ZBaseUnitModel *unitModel = menuModel.units[k];
                            [tempSubArr addObject:[NSString stringWithFormat:@"%@~%@",[self getStartTime:unitModel],[self getEndTime:unitModel]]];
                            
                        }
                        
                        [orderDict setObject:tempSubArr forKey:[self getWeekIndex:menuModel.name]];
                    }
                }
                
                [otherDict setObject:orderDict forKey:@"fix_time"];
            }
            
            [self updateImageWithOtherParams:otherDict];
        }];
    }
    return _bottomBtn;
}

- (NSString *)getWeekIndex:(NSString *)weekName {
    NSArray *leftTitleArr = @[@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六",@"星期天"];
    for (int i = 0; i < leftTitleArr.count; i++) {
        if ([weekName isEqualToString:leftTitleArr[i]]) {
            return [NSString stringWithFormat:@"%d",i + 1];
        }
    }
    return @"1";
}

- (void)updateImageWithOtherParams:(NSMutableDictionary *)otherDict {
    if (self.viewModel.addModel.image_net_url && self.viewModel.addModel.image_net_url.length > 0) {
        [self updateOtherDataWithParams:otherDict];
        return;
    }
    [TLUIUtility showLoading:@"上传封面图片中"];
    __weak typeof(self) weakSelf = self;
    [ZOriganizationLessonViewModel uploadImageList:@{@"type":@"2",@"imageKey":@{@"coverImage":self.viewModel.addModel.image_url}} completeBlock:^(BOOL isSuccess, NSString *message) {
        if (isSuccess) {
            weakSelf.viewModel.addModel.image_net_url = message;
            [weakSelf updatePhotosStep1WithOtherParams:otherDict];
        }else{
            [TLUIUtility hiddenLoading];
            [TLUIUtility showErrorHint:message];
        }
    }];
}

- (NSInteger)checkIsHavePhotos {
    NSInteger index = 0;
    for (int i = 0; i < self.viewModel.addModel.images.count; i++) {
        id temp = self.viewModel.addModel.images[i];
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
         if (index == self.viewModel.addModel.images.count-1) {
             [self updateOtherDataWithParams:otherDict];
         }else{
             index++;
             [self updatePhotosStep2WithImage:index otherParams:otherDict];
         }
    }];
     
}

- (void)updatePhotosStep3WithImage:(NSInteger)index otherParams:(NSMutableDictionary *)otherDict complete:(void(^)(BOOL, NSInteger))complete{
    [TLUIUtility showLoading:[NSString stringWithFormat:@"上传课程相册中 %ld/%ld",index+1,self.viewModel.addModel.images.count]];
    
    id temp = self.viewModel.addModel.images[index];
    NSString *tempNet = self.viewModel.addModel.net_images[index];
    UIImage *image;
    if ([temp isKindOfClass:[UIImage class]]) {
        image = temp;
        if (tempNet && tempNet.length > 0) {
            complete(YES,index);
            return;
        }
    }else if ([temp isKindOfClass:[NSString class]]){
        NSString *tempStr = temp;
        if (tempStr.length > 0) {
            [self.viewModel.addModel.net_images replaceObjectAtIndex:index withObject:tempStr];
        }
        complete(YES,index);
        return;
    }else{
        complete(YES,index);
        return;
    }
    if (!image) {
        complete(YES,index);
        return;
    }
    __weak typeof(self) weakSelf = self;
    [ZOriganizationLessonViewModel uploadImageList:@{@"type":@"2",@"imageKey":@{@"coverImage":self.viewModel.addModel.image_url}} completeBlock:^(BOOL isSuccess, NSString *message) {
        if (isSuccess) {
            [weakSelf.viewModel.addModel.net_images replaceObjectAtIndex:index withObject:message];
            complete(YES,index);
        }else{
            [TLUIUtility hiddenLoading];
            [TLUIUtility showErrorHint:message];
        }
    }];
}


- (void)updateOtherDataWithParams:(NSMutableDictionary *)otherDict {
    if (self.viewModel.addModel.image_net_url) {
        [otherDict setObject:self.viewModel.addModel.image_net_url forKey:@"image_url"];
        
    }
    if ([self checkIsHavePhotos] > 0) {
        NSMutableArray *photos = @[].mutableCopy;
        for (int i = 0; i < self.viewModel.addModel.net_images.count; i++) {
            NSString *temp = self.viewModel.addModel.net_images[i];
            if (ValidStr(temp)) {
                [photos addObject:temp];
            }
        }
        if (photos.count > 0) {
            [otherDict setObject:photos forKey:@"images"];
        }
        
    }
    [TLUIUtility showLoading:@"上传其他数据"];
    [ZOriganizationLessonViewModel addLesson:otherDict completeBlock:^(BOOL isSuccess, NSString *message) {
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

#pragma mark - setCellData
- (void)addTopAndNameDetai {
    ZCellConfig *addImageCellConfig = [ZCellConfig cellConfigWithClassName:[ZOrganizationLessonAddImageCell className] title:[ZOrganizationLessonAddImageCell className] showInfoMethod:@selector(setImage:) heightOfCell:[ZOrganizationLessonAddImageCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:self.viewModel.addModel.image_url];
    [self.cellConfigArr addObject:addImageCellConfig];
    
    NSArray *titleArr = @[@[@"请输入课程名称", @"lessonName",self.viewModel.addModel.name,@8,[NSNumber numberWithInt:ZFormatterTypeAny]],@[@"请输入课程简介",@"lessonIntro",self.viewModel.addModel.short_name,@6,[NSNumber numberWithInt:ZFormatterTypeAny]]];
    
    for (int i = 0 ; i < titleArr.count; i++) {
        ZBaseTextFieldCellModel *model = [[ZBaseTextFieldCellModel alloc] init];
        model.textColor = [UIColor colorTextGray];
        model.leftContentWidth = CGFloatIn750(0);
        model.isHiddenLine = YES;
        model.textAlignment = NSTextAlignmentLeft;
        model.isHiddenInputLine = YES;
        model.textFont = i == 0 ?  [UIFont boldFontMax1Title] : [UIFont fontContent];
        model.cellHeight = CGFloatIn750(110);
        model.lineLeftMargin = CGFloatIn750(30);
        model.lineLeftMargin = CGFloatIn750(30);
        model.textFieldHeight = CGFloatIn750(110);
        model.isTextEnabled = YES;
        model.leftMargin = CGFloatIn750(10);
        
        model.placeholder = titleArr[i][0];
        model.content = titleArr[i][2];
        model.cellTitle = titleArr[i][1];
        model.max = [titleArr[i][3] intValue];
        model.formatterType = [titleArr[i][4] intValue];

        ZCellConfig *nameCellConfig = [ZCellConfig cellConfigWithClassName:[ZTextFieldCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZTextFieldCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
        [self.cellConfigArr addObject:nameCellConfig];
    }
}

- (void)addDesAndPrice {
    ZBaseSingleCellModel *detailModel = [[ZBaseSingleCellModel alloc] init];
    detailModel.leftTitle = @"课程详情";
    detailModel.leftFont = [UIFont boldFontTitle];
    detailModel.rightImage = @"rightBlackArrowN";
    detailModel.isHiddenLine = YES;
    detailModel.cellTitle = @"detail";
    detailModel.cellHeight = CGFloatIn750(116);
    if (self.viewModel.addModel.info && self.viewModel.addModel.info.length > 0) {
        detailModel.rightTitle = @"已编辑";
    }else{
        detailModel.rightTitle = @"";
    }
    
    ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:detailModel.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:detailModel] cellType:ZCellTypeClass dataModel:detailModel];
    
    [self.cellConfigArr addObject:menuCellConfig];
    
    ZBaseTextFieldCellModel *model = [[ZBaseTextFieldCellModel alloc] init];
    model.leftTitle = @"课程价格";
    model.cellTitle = @"lessonPrice";
    model.placeholder = @"0";
    model.isHiddenLine = NO;
    model.rightTitle = @"元";
    model.cellHeight = CGFloatIn750(116);
    model.textFieldHeight = CGFloatIn750(110);
    model.textColor = [UIColor colorTextGray];
    
    model.formatterType = ZFormatterTypeDecimal;
    model.content = self.viewModel.addModel.price;
    model.max = 6;
    
    ZCellConfig *nameCellConfig = [ZCellConfig cellConfigWithClassName:[ZTextFieldCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZTextFieldCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
    [self.cellConfigArr addObject:nameCellConfig];
}

- (void)addImages {
    ZBaseSingleCellModel *titleModel = [[ZBaseSingleCellModel alloc] init];
    titleModel.leftTitle = @"课程相册";
    titleModel.leftFont = [UIFont boldFontTitle];
    titleModel.isHiddenLine = YES;
    titleModel.cellHeight = CGFloatIn750(92);
    
    ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:titleModel.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:titleModel] cellType:ZCellTypeClass dataModel:titleModel];
    [self.cellConfigArr addObject:menuCellConfig];
        
    
    
    ZBaseMenuModel *model = [[ZBaseMenuModel alloc] init];
    NSMutableArray *menulist = @[].mutableCopy;

    for (int j = 0; j < 9; j++) {
        ZBaseUnitModel *model = [[ZBaseUnitModel alloc] init];
        if (j < self.viewModel.addModel.images.count) {
            model.data = self.viewModel.addModel.images[j];
            model.uid = [NSString stringWithFormat:@"%d", j];
        }
        model.name = @"必选";
    //            model.name = tempArr[j][0];
    //            model.imageName = tempArr[j][1];
    //            model.uid = tempArr[j][2];
        [menulist addObject:model];
    }

    model.units = menulist;

    ZCellConfig *progressCellConfig = [ZCellConfig cellConfigWithClassName:[ZOrganizationLessonAddPhotosCell className] title:[ZOrganizationLessonAddPhotosCell className] showInfoMethod:@selector(setModel:) heightOfCell:[ZOrganizationLessonAddPhotosCell z_getCellHeight:menulist] cellType:ZCellTypeClass dataModel:model];
    [self.cellConfigArr addObject:progressCellConfig];
}

- (void)addSchoolAndClass {
    if ([self.viewModel.addModel.level intValue] < 1) {
        self.viewModel.addModel.level = @"1";
    }
    NSArray *temp = @[@"初级",@"进阶",@"精英"];
    NSArray *textArr = @[@[@"适用校区", @"请选择适用校区", @NO, @"rightBlackArrowN", @"", @"school",self.viewModel.addModel.school,@20,[NSNumber numberWithInt:ZFormatterTypeAny]],
                         @[@"课程级别", @"请选择课程级别", @NO, @"rightBlackArrowN", @"", @"class",temp[[self.viewModel.addModel.level intValue]-1],@20,[NSNumber numberWithInt:ZFormatterTypeAny]],
                         @[@"单节课时", @"请输入单节课时", @YES, @"", @"分钟", @"time",self.viewModel.addModel.course_min,@3,[NSNumber numberWithInt:ZFormatterTypeNumber]],
                         @[@"课程节数", @"请输入课程节数", @YES, @"", @"节", @"num",self.viewModel.addModel.course_number,@4,[NSNumber numberWithInt:ZFormatterTypeNumber]],
                         @[@"班级人数", @"请输入班级人数", @YES, @"", @"人", @"peoples",self.viewModel.addModel.course_class_number,@5,[NSNumber numberWithInt:ZFormatterTypeNumber]]];
    
    for (int i = 0; i < textArr.count; i++) {
        ZBaseTextFieldCellModel *cellModel = [[ZBaseTextFieldCellModel alloc] init];
        cellModel.isHiddenLine = YES;
        cellModel.cellHeight = CGFloatIn750(116);
        cellModel.textColor = [UIColor colorTextGray];
        
        cellModel.leftTitle = textArr[i][0];
        cellModel.placeholder = textArr[i][1];
        cellModel.isTextEnabled = [textArr[i][2] boolValue];
        cellModel.rightImage = textArr[i][3];
        cellModel.rightTitle = textArr[i][4];
        cellModel.cellTitle = textArr[i][5];
        cellModel.content = textArr[i][6];
        cellModel.max = [textArr[i][7] intValue];
        cellModel.formatterType = [textArr[i][8] intValue];
        
        ZCellConfig *textCellConfig = [ZCellConfig cellConfigWithClassName:[ZTextFieldCell className] title:cellModel.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZTextFieldCell z_getCellHeight:cellModel] cellType:ZCellTypeClass dataModel:cellModel];
        [self.cellConfigArr addObject:textCellConfig];
    }
}

- (void)addOrder {
    ZCellConfig *topCellConfig = [ZCellConfig cellConfigWithClassName:[ZSpaceEmptyCell className] title:[ZSpaceEmptyCell className] showInfoMethod:@selector(setBackColor:) heightOfCell:CGFloatIn750(21) cellType:ZCellTypeClass dataModel:adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark])];
    [self.cellConfigArr addObject:topCellConfig];
    
    ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
    model.leftTitle = @"是否接受预约体验";
    model.leftFont = [UIFont boldFontTitle];
    model.isHiddenLine = YES;
    model.cellHeight = CGFloatIn750(74);
    model.rightImage = @"selectedCycle";//unSelectedCycle
    model.rightMargin = CGFloatIn750(50);
    model.cellTitle = @"isOrder";
    
    if ([self.viewModel.addModel.is_experience intValue] == 1) {
        model.rightImage = @"selectedCycle";
    }else{
        model.rightImage = @"unSelectedCycle";
    }
    
    ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
    
    [self.cellConfigArr addObject:menuCellConfig];
    if ([self.viewModel.addModel.is_experience intValue] == 1) {
        NSArray *textArr = @[@[@"体验课价格", @"0", @YES, @"", @"元", @"tiMoney",self.viewModel.addModel.experience_price,@5,[NSNumber numberWithInt:ZFormatterTypeDecimal]],
                             @[@"单次体验时长 ", @"0", @YES, @"", @"分钟", @"tiMin",self.viewModel.addModel.experience_duration,@3,[NSNumber numberWithInt:ZFormatterTypeNumber]]];
        
//                             @[@"可体验时间段", @"", @NO, @"rightBlackArrowN", @"", @"orderTimeToTime",[NSString stringWithFormat:@"%@~%@",self.viewModel.addModel.orderTimeBegin,self.viewModel.addModel.orderTimeEnd],@30,[NSNumber numberWithInt:ZFormatterTypeAny]]];
        
        for (int i = 0; i < textArr.count; i++) {
            ZBaseTextFieldCellModel *cellModel = [[ZBaseTextFieldCellModel alloc] init];
            cellModel.isHiddenLine = YES;
            cellModel.cellHeight = CGFloatIn750(74);
            cellModel.textColor = [UIColor colorTextGray];
            cellModel.leftFont = [UIFont fontContent];
            cellModel.cellHeight = CGFloatIn750(116);
            
            cellModel.leftTitle = textArr[i][0];
            cellModel.placeholder = textArr[i][1];
            cellModel.isTextEnabled = [textArr[i][2] boolValue];
            cellModel.rightImage = textArr[i][3];
            cellModel.rightTitle = textArr[i][4];
            cellModel.cellTitle = textArr[i][5];
            cellModel.max = [textArr[i][7] intValue];
            cellModel.formatterType = [textArr[i][8] intValue];
            cellModel.content = textArr[i][6];
            
            ZCellConfig *textCellConfig = [ZCellConfig cellConfigWithClassName:[ZTextFieldCell className] title:cellModel.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZTextFieldCell z_getCellHeight:cellModel] cellType:ZCellTypeClass dataModel:cellModel];
            [self.cellConfigArr addObject:textCellConfig];
        }
        
        [self addTimeOrder];
    }
    
    {
        ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
        model.isHiddenLine = NO;
        model.cellHeight = CGFloatIn750(21);
        model.lineLeftMargin = CGFloatIn750(30);
        model.lineRightMargin = CGFloatIn750(30);
        
        ZCellConfig *spaceLineCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
        
        [self.cellConfigArr addObject:spaceLineCellConfig];
    }
}

- (void)addValidity {
    {
        ZBaseTextFieldCellModel *cellModel = [[ZBaseTextFieldCellModel alloc] init];
        cellModel.leftTitle = @"课程有效期";
        cellModel.placeholder = @"请输入课程有效期";
        cellModel.isTextEnabled = YES;
        cellModel.rightTitle = @"月";
        cellModel.cellTitle = @"validityTime";
        cellModel.isHiddenLine = YES;
        cellModel.cellHeight = CGFloatIn750(116);
        cellModel.textColor = [UIColor colorTextGray];
        cellModel.content = self.viewModel.addModel.valid_at;
        cellModel.max = 3;
        
        ZCellConfig *textCellConfig = [ZCellConfig cellConfigWithClassName:[ZTextFieldCell className] title:cellModel.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZTextFieldCell z_getCellHeight:cellModel] cellType:ZCellTypeClass dataModel:cellModel];
        [self.cellConfigArr addObject:textCellConfig];
    }
    
    {
        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZOrganizationLessonTypeCell className] title:@"type" showInfoMethod:@selector(setIsGu:) heightOfCell:[ZOrganizationLessonTypeCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:self.viewModel.addModel.type];
        
        [self.cellConfigArr addObject:menuCellConfig];
        if ([self.viewModel.addModel.type intValue] == 1) {
            [self addTimeLesson];
            ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
            model.isHiddenLine = NO;
            model.cellHeight = CGFloatIn750(20);
            model.lineLeftMargin = CGFloatIn750(30);
            model.lineRightMargin = CGFloatIn750(30);
            
            ZCellConfig *spaceLineCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
            
            [self.cellConfigArr addObject:spaceLineCellConfig];
        }
    }
    
    {
        ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
        model.leftTitle = @"购买须知";
        model.leftFont = [UIFont boldFontTitle];
        model.isHiddenLine = YES;
        model.cellHeight = CGFloatIn750(119);
        model.rightImage = @"rightBlackArrowN";
        model.cellTitle = @"p_information";
        if (ValidStr(self.viewModel.addModel.p_information)) {
            model.rightTitle = @"已编辑";
        }
        
        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
        
        [self.cellConfigArr addObject:menuCellConfig];
    }
}


- (void)addTimeOrder {
    ZBaseTextFieldCellModel *cellModel = [[ZBaseTextFieldCellModel alloc] init];
    cellModel.leftTitle = @"可体验时间段";
    cellModel.isTextEnabled = NO;
    cellModel.rightImage = @"rightBlackArrowN";
    cellModel.cellTitle = @"orderTimeToTime";
    cellModel.isHiddenLine = YES;
    cellModel.cellHeight = CGFloatIn750(116);
    cellModel.rightFont = [UIFont fontContent];
    cellModel.rightColor = [UIColor colorTextGray];
    cellModel.rightDarkColor = [UIColor colorTextGrayDark];
    cellModel.leftFont = [UIFont fontContent];
    
    NSMutableArray *multArr = @[].mutableCopy;
    NSMutableArray *tempArr = @[].mutableCopy;
    for (int i = 0; i < self.viewModel.addModel.experience_time.count; i++) {
        ZBaseMenuModel *menuModel = self.viewModel.addModel.experience_time[i];
        
        if (menuModel && menuModel.units && menuModel.units.count > 0) {
            NSMutableArray *tempSubArr = @[].mutableCopy;
            [tempSubArr addObject:menuModel.name];
            NSString *subTitle = @"";
            for (int k = 0; k < menuModel.units.count; k++) {
                ZBaseUnitModel *unitModel = menuModel.units[k];
                if (subTitle.length == 0) {
                    subTitle = [NSString stringWithFormat:@"%@~%@",unitModel.name,unitModel.subName];
                }else{
                    subTitle = [NSString stringWithFormat:@"%@   %@~%@",subTitle,unitModel.name,unitModel.subName];
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
}

- (void)addTimeLesson {
    ZBaseTextFieldCellModel *cellModel = [[ZBaseTextFieldCellModel alloc] init];
    cellModel.leftTitle = @"选择日期";
    cellModel.isTextEnabled = NO;
    cellModel.rightImage = @"rightBlackArrowN";
    cellModel.cellTitle = @"lessonTime";
    cellModel.isHiddenLine = YES;
    cellModel.cellHeight = CGFloatIn750(60);
    cellModel.rightFont = [UIFont fontContent];
    cellModel.rightColor = [UIColor colorTextGray];
    cellModel.rightDarkColor = [UIColor colorTextGrayDark];
    cellModel.leftFont = [UIFont fontContent];
    
    NSMutableArray *multArr = @[].mutableCopy;
    NSMutableArray *tempArr = @[].mutableCopy;
    for (int i = 0; i < self.viewModel.addModel.fix_time.count; i++) {
        ZBaseMenuModel *menuModel = self.viewModel.addModel.fix_time[i];
        
        if (menuModel && menuModel.units && menuModel.units.count > 0) {
            NSMutableArray *tempSubArr = @[].mutableCopy;
            [tempSubArr addObject:menuModel.name];
            NSString *subTitle = @"";
            for (int k = 0; k < menuModel.units.count; k++) {
                ZBaseUnitModel *unitModel = menuModel.units[k];
                if (subTitle.length == 0) {
                    subTitle = [NSString stringWithFormat:@"%@~%@",[self getStartTime:unitModel],[self getEndTime:unitModel]];
                }else{
                    subTitle = [NSString stringWithFormat:@"%@   %@~%@",subTitle,[self getStartTime:unitModel],[self getEndTime:unitModel]];
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
}

- (NSString *)getStartTime:(ZBaseUnitModel *)model {
    if ([model.subName intValue] < 10) {
        return  [NSString stringWithFormat:@"%@:0%@",model.name,model.subName];
    }else{
        return  [NSString stringWithFormat:@"%@:%@",model.name,model.subName];
    }
}

- (NSString *)getEndTime:(ZBaseUnitModel *)model {
    NSInteger temp = [self.viewModel.addModel.course_min intValue]/60;
    NSInteger subTemp = [self.viewModel.addModel.course_min intValue]%60;
    
    NSInteger hourTemp = [model.name intValue] + temp;
    NSInteger minTemp = [model.subName intValue] + subTemp;
    if (minTemp > 59) {
        minTemp -= 60;
        hourTemp++;
    }
    
    if (hourTemp > 24) {
        hourTemp -= 24;
    }
    
    
    ZBaseUnitModel *uModel = [[ZBaseUnitModel alloc] init];
    uModel.name = [NSString stringWithFormat:@"%ld",hourTemp];
    uModel.subName = [NSString stringWithFormat:@"%ld",minTemp];
    
    return [self getStartTime:uModel];
}

#pragma mark - tableView -------datasource-----
- (void)zz_tableView:(UITableView *)tableView cell:(UITableViewCell *)cell cellForRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
    __weak typeof(self) weakSelf = self;
    if ([cellConfig.title isEqualToString:@"lessonName"]) {
        ZTextFieldCell *tCell = (ZTextFieldCell *)cell;
        tCell.valueChangeBlock = ^(NSString * text) {
            weakSelf.viewModel.addModel.name = text;
        };
    }else if ([cellConfig.title isEqualToString:@"lessonIntro"]) {
        ZTextFieldCell *tCell = (ZTextFieldCell *)cell;
        tCell.valueChangeBlock = ^(NSString * text) {
            weakSelf.viewModel.addModel.short_name = text;
        };
    }else if ([cellConfig.title isEqualToString:@"lessonPrice"]) {
        ZTextFieldCell *tCell = (ZTextFieldCell *)cell;
        tCell.valueChangeBlock = ^(NSString * text) {
            weakSelf.viewModel.addModel.price = text;
        };
    }else if ([cellConfig.title isEqualToString:@"time"]) {
        ZTextFieldCell *tCell = (ZTextFieldCell *)cell;
        tCell.valueChangeBlock = ^(NSString * text) {
            weakSelf.viewModel.addModel.course_min = text;
        };
    }else if ([cellConfig.title isEqualToString:@"num"]) {
        ZTextFieldCell *tCell = (ZTextFieldCell *)cell;
        tCell.valueChangeBlock = ^(NSString * text) {
            weakSelf.viewModel.addModel.course_number = text;
        };
    }else if ([cellConfig.title isEqualToString:@"peoples"]) {
        ZTextFieldCell *tCell = (ZTextFieldCell *)cell;
        tCell.valueChangeBlock = ^(NSString * text) {
            weakSelf.viewModel.addModel.course_class_number = text;
        };
    }else if ([cellConfig.title isEqualToString:@"tiMoney"]) {
        ZTextFieldCell *tCell = (ZTextFieldCell *)cell;
        tCell.valueChangeBlock = ^(NSString * text) {
            weakSelf.viewModel.addModel.experience_price = text;
        };
    }else if ([cellConfig.title isEqualToString:@"tiMin"]) {
        ZTextFieldCell *tCell = (ZTextFieldCell *)cell;
        tCell.valueChangeBlock = ^(NSString * text) {
            weakSelf.viewModel.addModel.experience_duration = text;
        };
    }else if ([cellConfig.title isEqualToString:@"validityTime"]) {
        ZTextFieldCell *tCell = (ZTextFieldCell *)cell;
        tCell.valueChangeBlock = ^(NSString * text) {
            weakSelf.viewModel.addModel.valid_at = text;
        };
    }else if ([cellConfig.title isEqualToString:@"ZOrganizationLessonAddPhotosCell"]) {
        ZOrganizationLessonAddPhotosCell *tCell = (ZOrganizationLessonAddPhotosCell *)cell;
        tCell.menuBlock = ^(NSInteger index, BOOL isAdd) {
            if (isAdd) {
                [[ZPhotoManager sharedManager] showCropOriginalSelectMenuWithCropSize:CGSizeMake(KScreenWidth, 74/111.0f * KScreenWidth) complete:^(NSArray<LLImagePickerModel *> *list) {
                    if (list && list.count > 0) {
                        if (index < weakSelf.viewModel.addModel.images.count) {
                            LLImagePickerModel *model = list[0];
                            [weakSelf.viewModel.addModel.images replaceObjectAtIndex:index withObject:model.image];
                            [weakSelf.viewModel.addModel.net_images replaceObjectAtIndex:index withObject:@""];
                            [weakSelf initCellConfigArr];
                            [weakSelf.iTableView reloadData];
                        }
                    }
                }];
            }else{
                if (index < weakSelf.viewModel.addModel.images.count) {
                    [weakSelf.viewModel.addModel.images replaceObjectAtIndex:index withObject:@""];
                    [weakSelf.viewModel.addModel.net_images replaceObjectAtIndex:index withObject:@""];
                    [weakSelf initCellConfigArr];
                    [weakSelf.iTableView reloadData];
                }
            }
        };
    }else if ([cellConfig.title isEqualToString:@"type"]) {
        ZOrganizationLessonTypeCell *tCell = (ZOrganizationLessonTypeCell *)cell;
        tCell.handleBlock = ^(NSInteger index) {
            weakSelf.viewModel.addModel.type = (index==0? @"1":@"2");
            [weakSelf initCellConfigArr];
            [weakSelf.iTableView reloadData];
        };
    }else if ([cellConfig.title isEqualToString:@"lessonTime"]){
        
        ZTextFieldMultColCell *tCell = (ZTextFieldMultColCell *)cell;
        tCell.selectBlock = ^{
            [weakSelf.iTableView endEditing:YES];
            ZOrganizationTimeSelectVC *svc = [[ZOrganizationTimeSelectVC alloc] init];
            svc.timeArr = weakSelf.viewModel.addModel.fix_time;
            svc.timeBlock = ^(NSMutableArray <ZBaseMenuModel *>*timeArr) {
                weakSelf.viewModel.addModel.fix_time = timeArr;
                [weakSelf initCellConfigArr];
                [weakSelf.iTableView reloadData];
            };
            [weakSelf.navigationController pushViewController:svc animated:YES];
        };
        
    }else if ([cellConfig.title isEqualToString:@"orderTimeToTime"]){
        ZTextFieldMultColCell *tCell = (ZTextFieldMultColCell *)cell;
        tCell.selectBlock = ^{
            ZOrganizationTimeSelectVC *svc = [[ZOrganizationTimeSelectVC alloc] init];
            svc.timeArr = weakSelf.viewModel.addModel.experience_time;
            svc.isStartAndEnd = YES;
            svc.timeBlock = ^(NSMutableArray <ZBaseMenuModel *>*timeArr) {
                weakSelf.viewModel.addModel.experience_time = timeArr;
                [weakSelf initCellConfigArr];
                [weakSelf.iTableView reloadData];
            };
            [weakSelf.navigationController pushViewController:svc animated:YES];
        };
        
    }
}

- (void)zz_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
    __weak typeof(self) weakSelf = self;
    
    if ([cellConfig.title isEqualToString:@"ZOrganizationLessonAddImageCell"]){
        [self.iTableView endEditing:YES];
        [[ZPhotoManager sharedManager] showCropOriginalSelectMenuWithCropSize:CGSizeMake(KScreenWidth, CGFloatIn750(400)) complete:^(NSArray<LLImagePickerModel *> *list) {
            if (list && list.count > 0) {
                LLImagePickerModel *model = list[0];
                weakSelf.viewModel.addModel.image_url = model.image;
                weakSelf.viewModel.addModel.image_net_url = @"";
                [weakSelf initCellConfigArr];
                [weakSelf.iTableView reloadData];
            }
        }];
    }else if ([cellConfig.title isEqualToString:@"school"]) {
//        NSMutableArray *items = @[].mutableCopy;
//        for (int i = 0; i < self.schoolList.count; i++) {
//            ZOriganizationSchoolListModel *smodel = self.schoolList[i];
//            ZAlertDataItemModel *model = [[ZAlertDataItemModel alloc] init];
//            model.name = smodel.name;
//            [items addObject:model];
//        }
//
//        [self.items removeAllObjects];
//        [self.items addObjectsFromArray:items];
//        [ZAlertDataSinglePickerView setAlertName:@"校区类型" items:self.items handlerBlock:^(NSInteger index) {
//            ZOriganizationSchoolListModel *smodel = self.schoolList[index];
//            weakSelf.viewModel.addModel.school = smodel.name;
//            weakSelf.viewModel.addModel.stores_id = smodel.schoolID;
//           [weakSelf initCellConfigArr];
//           [weakSelf.iTableView reloadData];
//        }];
    }else if ([cellConfig.title isEqualToString:@"class"]) {
        [self.iTableView endEditing:YES];
        NSMutableArray *items = @[].mutableCopy;
        NSArray *temp = @[@"初级",@"进阶",@"精英"];
        for (int i = 0; i < temp.count; i++) {
           ZAlertDataItemModel *model = [[ZAlertDataItemModel alloc] init];
           model.name = temp[i];
           [items addObject:model];
        }

        [self.items removeAllObjects];
        [self.items addObjectsFromArray:items];
        [ZAlertDataSinglePickerView setAlertName:@"级别选择" items:self.items handlerBlock:^(NSInteger index) {
            weakSelf.viewModel.addModel.level = [NSString stringWithFormat:@"%ld",index+1];
           [weakSelf initCellConfigArr];
           [weakSelf.iTableView reloadData];
        }];
    } else if ([cellConfig.title isEqualToString:@"orderTimeToTime"]) {
        [self.iTableView endEditing:YES];
        ZOrganizationTimeSelectVC *svc = [[ZOrganizationTimeSelectVC alloc] init];
        svc.timeArr = weakSelf.viewModel.addModel.experience_time;
        svc.isStartAndEnd = YES;
        svc.timeBlock = ^(NSMutableArray <ZBaseMenuModel *>*timeArr) {
            weakSelf.viewModel.addModel.experience_time = timeArr;
            [weakSelf initCellConfigArr];
            [weakSelf.iTableView reloadData];
        };
        [weakSelf.navigationController pushViewController:svc animated:YES];
    }else if ([cellConfig.title isEqualToString:@"isOrder"]){
        self.viewModel.addModel.is_experience = [self.viewModel.addModel.is_experience intValue] == 1? @"2": @"1";
        [self initCellConfigArr];
        [self.iTableView reloadData];
    }else if ([cellConfig.title isEqualToString:@"detail"]){
        [self.iTableView endEditing:YES];
        ZOrganizationLessonTextViewVC * tvc = [[ZOrganizationLessonTextViewVC alloc] init];
        tvc.navTitle = @"课程介绍";
        tvc.max = 1000;
        tvc.hintStr = @"请输入课程介绍，1000字以内";
        tvc.content = self.viewModel.addModel.info;
        tvc.handleBlock = ^(NSString * text) {
            weakSelf.viewModel.addModel.info = text;
            [weakSelf initCellConfigArr];
            [weakSelf.iTableView reloadData];
        };
        [self.navigationController pushViewController:tvc animated:YES];
    }else if ([cellConfig.title isEqualToString:@"p_information"]){
        [self.iTableView endEditing:YES];
        ZOrganizationLessonTextViewVC * tvc = [[ZOrganizationLessonTextViewVC alloc] init];
        tvc.navTitle = @"购买须知";
        tvc.max = 200;
        tvc.hintStr = @"请输入购买须知，200字以内";
        tvc.content = self.viewModel.addModel.p_information;
        tvc.handleBlock = ^(NSString * text) {
            weakSelf.viewModel.addModel.p_information = text;
            [weakSelf initCellConfigArr];
            [weakSelf.iTableView reloadData];
        };
        [self.navigationController pushViewController:tvc animated:YES];
    }
}
@end
