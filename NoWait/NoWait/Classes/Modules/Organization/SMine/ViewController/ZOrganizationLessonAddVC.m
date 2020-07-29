//
//  ZOrganizationLessonAddVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/2/19.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationLessonAddVC.h"
#import "ZOrganizationLessonAddImageCell.h"
#import "ZAddPhotosCell.h"
#import "ZOrganizationLessonTypeCell.h"
#import "ZTextFieldMultColCell.h"

#import "ZStudentDetailModel.h"

#import "ZAlertDataPickerView.h"
#import "ZAlertDateHourPickerView.h"
#import "ZAlertDataSinglePickerView.h"
#import "ZAlertDateWeekAndHourPickerView.h"
#import "ZAlertDataModel.h"
#import "ZOrganizationTimeSelectVC.h"

@interface ZOrganizationLessonAddVC ()
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
    
    _viewModel.addModel.school = [ZUserHelper sharedHelper].school.name;
    _viewModel.addModel.stores_id = [ZUserHelper sharedHelper].school.schoolID;
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
        _viewModel.addModel.school = [ZUserHelper sharedHelper].school.name;
        _viewModel.addModel.stores_id = [ZUserHelper sharedHelper].school.schoolID;
    }
    return _viewModel;
}

- (void)initCellConfigArr {
    [super initCellConfigArr];
    
    [self addLessonBaseInfo];
    [self addOrderLabel];
    [self addDetailInfo];
}

#pragma mark - setmain
- (void)setNavigation {
    if (ValidStr(self.viewModel.addModel.lessonID)) {
        [self.navigationItem setTitle:@"编辑课程"];
    }else{
        [self.navigationItem setTitle:@"新增课程"];
    }
}

- (void)setupMainView {
    [super setupMainView];
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, CGFloatIn750(180))];
    bottomView.backgroundColor = adaptAndDarkColor(HexAColor(0xffffff, 0.1), HexAColor(0x1a1a1a, 0.1));
    
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
        [_bottomBtn setTitle:@"提交" forState:UIControlStateNormal];
        [_bottomBtn setTitleColor:[UIColor colorWhite] forState:UIControlStateNormal];
        [_bottomBtn.titleLabel setFont:[UIFont boldFontTitle]];
        [_bottomBtn setBackgroundColor:adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]) forState:UIControlStateNormal];
        [_bottomBtn bk_addEventHandler:^(id sender) {
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
            
            if (!ValidStr(weakSelf.viewModel.addModel.price)) {
                [TLUIUtility showErrorHint:@"请输入课程价格"];
                return ;
            }
            if ([weakSelf.viewModel.addModel.price intValue] - 1 < 0) {
                [TLUIUtility showErrorHint:@"课程价格不得少于1元"];
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
            if ([weakSelf.viewModel.addModel.course_min intValue] < 1) {
                [TLUIUtility showErrorHint:@"单节课时不能小于1"];
                return ;
            }
            if (!ValidStr(weakSelf.viewModel.addModel.course_number)) {
                [TLUIUtility showErrorHint:@"请输入课程节数"];
                return ;
            }
            if ([weakSelf.viewModel.addModel.course_number intValue] < 1) {
                [TLUIUtility showErrorHint:@"课程节数不能小于1"];
                return ;
            }
            if (!ValidStr(weakSelf.viewModel.addModel.course_class_number)) {
                [TLUIUtility showErrorHint:@"请输入班级人数"];
                return ;
            }
            if ([weakSelf.viewModel.addModel.course_class_number intValue] < 1) {
                [TLUIUtility showErrorHint:@"班级人数不能小于1"];
                return ;
            }

            if (!ValidStr(weakSelf.viewModel.addModel.valid_at)) {
                [TLUIUtility showErrorHint:@"请输入课程有效期"];
                return ;
            }
            if ([weakSelf.viewModel.addModel.valid_at intValue] < 1) {
                [TLUIUtility showErrorHint:@"课程有效期不能小于1个月"];
                return ;
            }
            
            if([weakSelf.viewModel.addModel.type intValue] == 1){
                if (!ValidArray(weakSelf.viewModel.addModel.fix_time)) {
                    [TLUIUtility showErrorHint:@"请添加固定上课时间"];
                    return ;
                }
            }
            
            if([weakSelf.viewModel.addModel.is_experience intValue] == 1){
                if (!ValidStr(weakSelf.viewModel.addModel.experience_price)) {
                    [TLUIUtility showErrorHint:@"请输入预约价格"];
                    return ;
                }
                if ([weakSelf.viewModel.addModel.experience_price intValue] < 1) {
                    [TLUIUtility showErrorHint:@"预约价格不得小于1元"];
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
            
            if (!ValidStr(weakSelf.viewModel.addModel.info)) {
                [TLUIUtility showErrorHint:@"请添加课程详情"];
                return ;
            }
            if (!ValidStr(weakSelf.viewModel.addModel.p_information)) {
                [TLUIUtility showErrorHint:@"请添加购买须知"];
                return ;
            }
            NSMutableDictionary *otherDict = @{}.mutableCopy;
            if (ValidStr(weakSelf.viewModel.addModel.lessonID)) {
                [otherDict setObject:weakSelf.viewModel.addModel.lessonID forKey:@"id"];
            }
            
            if (ValidStr(weakSelf.viewModel.addModel.limit_purchase) && [weakSelf.viewModel.addModel.limit_purchase intValue] > 0) {
                [otherDict setObject:weakSelf.viewModel.addModel.limit_purchase forKey:@"limit_purchase"];
            }
            
            if (ValidStr(weakSelf.viewModel.addModel.account_limit_purchase) && [weakSelf.viewModel.addModel.account_limit_purchase intValue] > 0) {
                [otherDict setObject:weakSelf.viewModel.addModel.account_limit_purchase forKey:@"account_limit_purchase"];
            }
            
            
            [otherDict setObject:weakSelf.viewModel.addModel.name forKey:@"name"];
            [otherDict setObject:weakSelf.viewModel.addModel.short_name forKey:@"short_name"];
            [otherDict setObject:weakSelf.viewModel.addModel.info forKey:@"info"];
            [otherDict setObject:weakSelf.viewModel.addModel.price forKey:@"price"];
            [otherDict setObject:weakSelf.viewModel.addModel.stores_id forKey:@"stores_id"];
            [otherDict setObject:weakSelf.viewModel.addModel.level forKey:@"level"];
            [otherDict setObject:weakSelf.viewModel.addModel.course_min forKey:@"course_min"];
            [otherDict setObject:weakSelf.viewModel.addModel.course_number forKey:@"course_number"];
            [otherDict setObject:weakSelf.viewModel.addModel.course_class_number forKey:@"course_class_number"];
            [otherDict setObject:weakSelf.viewModel.addModel.is_experience forKey:@"is_experience"];
            [otherDict setObject:weakSelf.viewModel.addModel.valid_at forKey:@"valid_at"];
            [otherDict setObject:weakSelf.viewModel.addModel.type forKey:@"type"];
            [otherDict setObject:weakSelf.viewModel.addModel.p_information forKey:@"p_information"];
            
            if([weakSelf.viewModel.addModel.is_experience intValue] == 1){
                
                [otherDict setObject:weakSelf.viewModel.addModel.experience_price forKey:@"experience_price"];
                [otherDict setObject:weakSelf.viewModel.addModel.experience_duration forKey:@"experience_duration"];
                
                //可预约时间段
                NSMutableDictionary *orderDict = @{}.mutableCopy;
                for (ZBaseMenuModel *menuModel in weakSelf.viewModel.addModel.experience_time) {
                    if (menuModel && menuModel.units && menuModel.units.count > 0) {
                        
                        NSMutableArray *tempSubArr = @[].mutableCopy;
                        for (int k = 0; k < menuModel.units.count; k++) {
                            ZBaseUnitModel *unitModel = menuModel.units[k];
                            [tempSubArr addObject:[NSString stringWithFormat:@"%@~%@",SafeStr(unitModel.name),SafeStr(unitModel.subName)]];
                        }
                        
                        [orderDict setObject:tempSubArr forKey:[menuModel.name zz_weekToIndex]];
                    }
                }
                
                [otherDict setObject:orderDict forKey:@"experience_time"];
            }
            
            if([weakSelf.viewModel.addModel.type intValue] == 1){
                NSMutableDictionary *orderDict = @{}.mutableCopy;
                for (ZBaseMenuModel *menuModel in weakSelf.viewModel.addModel.fix_time) {
                    if (menuModel && menuModel.units && menuModel.units.count > 0) {
                        
                        NSMutableArray *tempSubArr = @[].mutableCopy;
                        for (int k = 0; k < menuModel.units.count; k++) {
                            ZBaseUnitModel *unitModel = menuModel.units[k];
                            [tempSubArr addObject:[NSString stringWithFormat:@"%@~%@",[weakSelf getStartTime:unitModel],[weakSelf getEndTime:unitModel]]];
                            
                        }
                        
                        [orderDict setObject:tempSubArr forKey:[menuModel.name zz_weekToIndex]];
                    }
                }
                
                [otherDict setObject:orderDict forKey:@"fix_time"];
            }
            
            [weakSelf updateImageWithOtherParams:otherDict];
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _bottomBtn;
}

#pragma mark - setCellData
- (void)addLessonBaseInfo {
    ZLineCellModel *model = ZLineCellModel.zz_lineCellModel_create(@"hint_title")
    .zz_titleLeft(@"基本信息")
    .zz_lineHidden(YES)
    .zz_cellHeight(CGFloatIn750(60))
    .zz_fontLeft([UIFont fontMin])
    .zz_colorLeft([UIColor colorTextGray])
    .zz_colorDarkLeft([UIColor colorTextGrayDark])
    .zz_colorDarkBack([UIColor colorGrayBGDark])
    .zz_colorBack([UIColor colorGrayBG]);
    
    ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZBaseLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZBaseLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
    [self.cellConfigArr addObject:menuCellConfig];
    
    id image = self.viewModel.addModel.image_url;
    if (![image isKindOfClass:[UIImage class]]) {
        image = imageFullUrl(image);
    }
    ZCellConfig *addImageCellConfig = [ZCellConfig cellConfigWithClassName:[ZOrganizationLessonAddImageCell className] title:[ZOrganizationLessonAddImageCell className] showInfoMethod:@selector(setData:) heightOfCell:[ZOrganizationLessonAddImageCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:@{@"image":image?image:@"",@"name":SafeStr(self.viewModel.addModel.name),@"subName":SafeStr(self.viewModel.addModel.short_name),@"edit":ValidStr(self.viewModel.addModel.lessonID) ? @"1":@"2"}];
    [self.cellConfigArr addObject:addImageCellConfig];
    
    if ([self.viewModel.addModel.level intValue] < 1) {
        self.viewModel.addModel.level = @"1";
    }
    
    NSArray *temp = @[@"初级",@"进阶",@"精英"];
    NSArray <NSArray *>*textArr = @[@[@"课程价格", @"课程价格不得小于1", @YES, @"", @"元", @"lessonPrice",SafeStr(self.viewModel.addModel.price),@10,[NSNumber numberWithInt:ZFormatterTypeDecimal]],
    @[@"课程级别", @"请选择课程级别", @NO, ValidStr(self.viewModel.addModel.lessonID)? @"":@"rightBlackArrowN", @"", @"class",temp[[self.viewModel.addModel.level intValue]-1],@20,[NSNumber numberWithInt:ZFormatterTypeAny]],
    @[@"单节课时", @"请输入单节课时", @YES, @"", @"分钟", @"time",SafeStr(self.viewModel.addModel.course_min),@3,[NSNumber numberWithInt:ZFormatterTypeNumber]],
    @[@"课程节数", @"请输入课程节数", @YES, @"", @"节", @"num",SafeStr(self.viewModel.addModel.course_number),@5,[NSNumber numberWithInt:ZFormatterTypeNumber]],
    @[@"班级人数", @"请输入班级人数", @YES, @"", @"人", @"peoples",SafeStr(self.viewModel.addModel.course_class_number),@5,[NSNumber numberWithInt:ZFormatterTypeNumber]],
    @[@"课程有效期", @"请输入课程有效期", @YES, @"", @"个月", @"validityTime",SafeStr(self.viewModel.addModel.valid_at),@3,[NSNumber numberWithInt:ZFormatterTypeNumber]],
    @[@"总限购数", @"不填写则无限购数", @YES, @"", @"次", @"limit_purchase",SafeStr(self.viewModel.addModel.limit_purchase),@7,[NSNumber numberWithInt:ZFormatterTypeNumber]],
    @[@"单人限购", @"不填写则无限购数", @YES, @"", @"次", @"account_limit_purchase",SafeStr(self.viewModel.addModel.account_limit_purchase),@7,[NSNumber numberWithInt:ZFormatterTypeNumber]]];
    
    __weak typeof(self) weakSelf = self;
    [textArr enumerateObjectsUsingBlock:^(NSArray * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        ZTextFieldModel *model = ZTextFieldModel.zz_textCellModel_create(SafeStr(obj[5]))
        .zz_heightTextField(CGFloatIn750(84))
        .zz_titleLeft(SafeStr(obj[0]))
        .zz_placeholder(SafeStr(obj[1]))
        .zz_textEnabled([obj[2] boolValue])
        .zz_subTitleRight(SafeStr(obj[4]))
        .zz_content(SafeStr(obj[6]))
        .zz_max([obj[7] intValue])
        .zz_formatter([obj[8] intValue])
        .zz_cellHeight(CGFloatIn750(86));
        if (ValidStr(obj[3])) {
            model.zz_imageRight(SafeStr(obj[3]))
            .zz_imageRightHeight(CGFloatIn750(14));
        }
        if (ValidStr(weakSelf.viewModel.addModel.lessonID) && ![SafeStr(obj[5]) isEqualToString:@"lessonPrice"]) {
            model.zz_colorText([UIColor colorTextGray1])
            .zz_colorDarkText([UIColor colorTextGray1Dark])
            .zz_colorSubRight([UIColor colorTextGray1])
            .zz_colorDarkSubRight([UIColor colorTextGray1Dark])
            .zz_textEnabled(NO);
        }else{
            model.zz_colorText([UIColor colorTextBlack])
            .zz_colorDarkText([UIColor colorTextBlackDark])
            .zz_colorSubRight([UIColor colorTextBlack])
            .zz_colorDarkSubRight([UIColor colorTextBlackDark])
            .zz_textEnabled([obj[2] boolValue]);
        }
        
        ZCellConfig *nameCellConfig = [ZCellConfig cellConfigWithClassName:[ZBaseTextFieldCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZBaseTextFieldCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
        [weakSelf.cellConfigArr addObject:nameCellConfig];
    }];
    
    ZCellConfig *typeCellConfig = [ZCellConfig cellConfigWithClassName:[ZOrganizationLessonTypeCell className] title:@"type" showInfoMethod:@selector(setIsGu:) heightOfCell:[ZOrganizationLessonTypeCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:self.viewModel.addModel.type];
    [self.cellConfigArr addObject:typeCellConfig];
    
    if ([self.viewModel.addModel.type intValue] == 1) {
        [self addTimeLesson];
    }
}

- (void)addOrderLabel {
    ZLineCellModel *titleModel = ZLineCellModel.zz_lineCellModel_create(@"hint_title")
    .zz_titleLeft(@"体验课设置")
    .zz_lineHidden(YES)
    .zz_cellHeight(CGFloatIn750(60))
    .zz_fontLeft([UIFont fontMin])
    .zz_colorLeft([UIColor colorTextGray])
    .zz_colorDarkLeft([UIColor colorTextGrayDark])
    .zz_colorDarkBack([UIColor colorGrayBGDark])
    .zz_colorBack([UIColor colorGrayBG]);
    
    ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZBaseLineCell className] title:titleModel.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZBaseLineCell z_getCellHeight:titleModel] cellType:ZCellTypeClass dataModel:titleModel];
    [self.cellConfigArr addObject:menuCellConfig];
    
    ZLineCellModel *model = ZLineCellModel.zz_lineCellModel_create(@"isOrder")
    .zz_titleLeft(@"是否添加体验课")
    .zz_cellHeight(CGFloatIn750(86));
    
    if ([self.viewModel.addModel.is_experience intValue] == 1) {
        model.rightImage = @"selectedCycle";
    }else{
        model.rightImage = @"unSelectedCycle";
    }
    
    ZCellConfig *orderCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
    [self.cellConfigArr addObject:orderCellConfig];
    __weak typeof(self) weakSelf = self;
    if ([self.viewModel.addModel.is_experience intValue] == 1) {
        NSArray <NSArray *>*textArr = @[@[@"体验课价格", @"0", @YES, @"", @"元", @"tiMoney",self.viewModel.addModel.experience_price,@5,[NSNumber numberWithInt:ZFormatterTypeDecimal]],
                         @[@"单次体验时长 ", @"0", @YES, @"", @"分钟", @"tiMin",self.viewModel.addModel.experience_duration,@5,[NSNumber numberWithInt:ZFormatterTypeNumber]]];
        [textArr enumerateObjectsUsingBlock:^(NSArray * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            ZTextFieldModel *model = ZTextFieldModel.zz_textCellModel_create(SafeStr(obj[5]))
            .zz_heightTextField(CGFloatIn750(84))
            .zz_titleLeft(SafeStr(obj[0]))
            .zz_placeholder(SafeStr(obj[1]))
            .zz_textEnabled([obj[2] boolValue])
            .zz_subTitleRight(SafeStr(obj[4]))
            .zz_content(SafeStr(obj[6]))
            .zz_max([obj[7] intValue])
            .zz_formatter([obj[8] intValue])
            .zz_cellHeight(CGFloatIn750(86));
            if (ValidStr(obj[3])) {
                model.zz_imageRight(SafeStr(obj[3]))
                .zz_imageRightHeight(CGFloatIn750(14));
            }
            if ([SafeStr(obj[2]) boolValue]) {
                model.zz_colorText([UIColor colorTextGray])
                .zz_colorDarkText([UIColor colorTextGrayDark])
                .zz_colorSubRight([UIColor colorTextGray])
                .zz_colorDarkSubRight([UIColor colorTextGrayDark]);
            }else{
                model.zz_colorText([UIColor colorTextBlack])
                .zz_colorDarkText([UIColor colorTextBlackDark])
                .zz_colorSubRight([UIColor colorTextBlack])
                .zz_colorDarkSubRight([UIColor colorTextBlackDark]);
            }
            ZCellConfig *nameCellConfig = [ZCellConfig cellConfigWithClassName:[ZBaseTextFieldCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZBaseTextFieldCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
            [weakSelf.cellConfigArr addObject:nameCellConfig];
        }];
        
        [self addTimeOrder];
    }
    
}

- (void)addDetailInfo {
    ZLineCellModel *titleModel = ZLineCellModel.zz_lineCellModel_create(@"hint_title")
    .zz_titleLeft(@"详情编辑")
    .zz_lineHidden(YES)
    .zz_cellHeight(CGFloatIn750(60))
    .zz_fontLeft([UIFont fontMin])
    .zz_colorLeft([UIColor colorTextGray])
    .zz_colorDarkLeft([UIColor colorTextGrayDark])
    .zz_colorDarkBack([UIColor colorGrayBGDark])
    .zz_colorBack([UIColor colorGrayBG]);

    ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZBaseLineCell className] title:titleModel.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZBaseLineCell z_getCellHeight:titleModel] cellType:ZCellTypeClass dataModel:titleModel];
    [self.cellConfigArr addObject:menuCellConfig];
    
    NSArray <NSArray *>*titleArr = @[@[@"课程详情", @"rightBlackArrowN", @"detail",ValidStr(self.viewModel.addModel.info) ? @"已编辑":@""],
                                     @[@"购买须知", @"rightBlackArrowN", @"p_information", ValidStr(self.viewModel.addModel.p_information)? @"已编辑":@""],
                                     @[@"课程相册", @"", @"", @""]];
    __weak typeof(self) weakSelf = self;
    [titleArr enumerateObjectsUsingBlock:^(NSArray * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        ZLineCellModel *titleModel = ZLineCellModel.zz_lineCellModel_create(obj[2])
        .zz_titleLeft(obj[0])
        .zz_lineHidden(YES)
        .zz_cellHeight(CGFloatIn750(86))
        .zz_imageRight(ValidStr(obj[1])? obj[1]:nil)
        .zz_imageRightHeight(CGFloatIn750(14))
        .zz_titleRight(SafeStr(obj[3]));

        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZBaseLineCell className] title:titleModel.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZBaseLineCell z_getCellHeight:titleModel] cellType:ZCellTypeClass dataModel:titleModel];
        [weakSelf.cellConfigArr addObject:menuCellConfig];
    }];
    
    ZBaseMenuModel *model = [[ZBaseMenuModel alloc] init];
    NSMutableArray *menulist = @[].mutableCopy;

    for (int j = 0; j < self.viewModel.addModel.images.count; j++) {
       ZBaseUnitModel *model = [[ZBaseUnitModel alloc] init];
       if (j < self.viewModel.addModel.images.count) {
           if (![self.viewModel.addModel.images[j] isKindOfClass:[UIImage class]]) {
               model.data = imageFullUrl(self.viewModel.addModel.images[j]);
           }else{
               model.data = self.viewModel.addModel.images[j];
           }
           model.uid = [NSString stringWithFormat:@"%d", j];
       }
       model.isEdit = YES;
       [menulist addObject:model];
    }
    model.name = @"添加图片";
    model.subName = @"必选";
    model.uid = @"9";
    model.units = menulist;

    ZCellConfig *progressCellConfig = [ZCellConfig cellConfigWithClassName:[ZAddPhotosCell className] title:[ZAddPhotosCell className] showInfoMethod:@selector(setModel:) heightOfCell:[ZAddPhotosCell z_getCellHeight:menulist] cellType:ZCellTypeClass dataModel:model];
    [self.cellConfigArr addObject:progressCellConfig];
}

- (void)addTimeOrder {
    ZBaseTextFieldCellModel *cellModel = [[ZBaseTextFieldCellModel alloc] init];
    cellModel.leftTitle = @"可体验时间段";
    cellModel.isTextEnabled = NO;
    cellModel.rightImage = @"rightBlackArrowN";
    cellModel.cellTitle = @"orderTimeToTime";
    cellModel.isHiddenLine = YES;
    cellModel.cellHeight = CGFloatIn750(86);
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
    cellModel.rightImage = ValidStr(self.viewModel.addModel.lessonID)? @"":@"rightBlackArrowN";
    cellModel.cellTitle = @"lessonTime";
    cellModel.isHiddenLine = YES;
    cellModel.cellHeight = CGFloatIn750(86);
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
    
    if ([cellConfig.title isEqualToString:@"ZOrganizationLessonAddImageCell"]) {
        ZOrganizationLessonAddImageCell *tCell = (ZOrganizationLessonAddImageCell *)cell;
        tCell.valueChangeBlock = ^(NSString * text, NSInteger index) {
            if (index == 0) {
                weakSelf.viewModel.addModel.name = text;
            }else {
                weakSelf.viewModel.addModel.short_name = text;
            }
        };
        tCell.imageBlock = ^(NSInteger index) {
            [weakSelf.iTableView endEditing:YES];
            [[ZImagePickerManager sharedManager] setCropRect:CGSizeMake(KScreenWidth, (66.0/105.0)*KScreenWidth) SelectMenu:^(NSArray<ZImagePickerModel *> *list) {
                if (list && list.count > 0) {
                    ZImagePickerModel *model = list[0];
                    weakSelf.viewModel.addModel.image_url = model.image;
                    weakSelf.viewModel.addModel.image_net_url = @"";
                    [weakSelf initCellConfigArr];
                    [weakSelf.iTableView reloadData];
                }
            }];
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
    }else if ([cellConfig.title isEqualToString:@"account_limit_purchase"]) {
        ZTextFieldCell *tCell = (ZTextFieldCell *)cell;
        tCell.valueChangeBlock = ^(NSString * text) {
            weakSelf.viewModel.addModel.account_limit_purchase = text;
        };
    }else if ([cellConfig.title isEqualToString:@"limit_purchase"]) {
        ZTextFieldCell *tCell = (ZTextFieldCell *)cell;
        tCell.valueChangeBlock = ^(NSString * text) {
            weakSelf.viewModel.addModel.limit_purchase = text;
        };
    }else if ([cellConfig.title isEqualToString:@"ZAddPhotosCell"]) {
        ZAddPhotosCell *tCell = (ZAddPhotosCell *)cell;
        tCell.seeBlock = ^(NSInteger index) {
            [[ZImagePickerManager sharedManager] showBrowser:weakSelf.viewModel.addModel.images withIndex:index];
        } ;
        tCell.menuBlock = ^(NSInteger index, BOOL isAdd) {
            [weakSelf.iTableView endEditing:YES];
            if (isAdd) {
                [[ZImagePickerManager sharedManager] setImagesWithMaxCount:9 - weakSelf.viewModel.addModel.images.count SelectMenu:^(NSArray<ZImagePickerModel *> *list) {
                    if (list && list.count > 0){;
                        for (ZImagePickerModel *model in list) {
    //                            [weakSelf.uploadArr addObject:model.image];
                            [weakSelf.viewModel.addModel.images addObject:model.image];
                        }
                        [weakSelf initCellConfigArr];
                        [weakSelf.iTableView reloadData];
                    }
                }];
            }else{
                if (index < weakSelf.viewModel.addModel.images.count) {
                    [weakSelf.viewModel.addModel.images removeObjectAtIndex:index];
                    [weakSelf initCellConfigArr];
                    [weakSelf.iTableView reloadData];
                }
            }
        };
    }else if ([cellConfig.title isEqualToString:@"type"]) {
        ZOrganizationLessonTypeCell *tCell = (ZOrganizationLessonTypeCell *)cell;
        tCell.handleBlock = ^(NSInteger index) {
            if (!ValidStr(weakSelf.viewModel.addModel.lessonID)) {
                weakSelf.viewModel.addModel.type = (index==0? @"1":@"2");
                [weakSelf initCellConfigArr];
                [weakSelf.iTableView reloadData];
            }
        };
        tCell.isEdit = !ValidStr(self.viewModel.addModel.lessonID);
    }else if ([cellConfig.title isEqualToString:@"lessonTime"]){
        
        ZTextFieldMultColCell *tCell = (ZTextFieldMultColCell *)cell;
        tCell.selectBlock = ^{
            [weakSelf.iTableView endEditing:YES];
            if (!ValidStr(weakSelf.viewModel.addModel.course_min)) {
                [TLUIUtility showErrorHint:@"请先输入单节课时"];
                return;
            }
            if (!ValidStr(weakSelf.viewModel.addModel.lessonID)) {
                ZOrganizationTimeSelectVC *svc = [[ZOrganizationTimeSelectVC alloc] init];
                svc.course_min = weakSelf.viewModel.addModel.course_min;
                svc.timeArr = weakSelf.viewModel.addModel.fix_time;
                svc.timeBlock = ^(NSMutableArray <ZBaseMenuModel *>*timeArr) {
                    weakSelf.viewModel.addModel.fix_time = timeArr;
                    [weakSelf initCellConfigArr];
                    [weakSelf.iTableView reloadData];
                };
                [weakSelf.navigationController pushViewController:svc animated:YES];
            }
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
    
    if ([cellConfig.title isEqualToString:@"school"]) {

    }else if ([cellConfig.title isEqualToString:@"class"]) {
        [self.iTableView endEditing:YES];
        if (!ValidStr(self.viewModel.addModel.lessonID)) {
            NSMutableArray *items = @[].mutableCopy;
            NSArray *temp = @[@"初级",@"进阶",@"精英"];
            for (int i = 0; i < temp.count; i++) {
               ZAlertDataItemModel *model = [[ZAlertDataItemModel alloc] init];
               model.name = temp[i];
               [items addObject:model];
            }

            [self.items removeAllObjects];
            [self.items addObjectsFromArray:items];
            [ZAlertDataSinglePickerView setAlertName:@"级别选择" selectedIndex:[weakSelf.viewModel.addModel.level intValue] > 0 ? [weakSelf.viewModel.addModel.level intValue]-1:0 items:items handlerBlock:^(NSInteger index) {
                weakSelf.viewModel.addModel.level = [NSString stringWithFormat:@"%ld",index + 1];
                [weakSelf initCellConfigArr];
                [weakSelf.iTableView reloadData];
            }];
        }
        
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
        routePushVC(ZRoute_org_textViewVC, @{@"navTitle":@"课程详情",@"max":@"1500",@"hintStr":@"请输入课程详情，1500字节以内",@"content":SafeStr(self.viewModel.addModel.info)}, ^(NSString * text, NSError * _Nullable error) {
            weakSelf.viewModel.addModel.info = text;
            [weakSelf initCellConfigArr];
            [weakSelf.iTableView reloadData];
        });
    }else if ([cellConfig.title isEqualToString:@"p_information"]){
        [self.iTableView endEditing:YES];
        routePushVC(ZRoute_org_textViewVC, @{@"navTitle":@"购买须知",@"max":@"1500",@"hintStr":@"请输入购买须知，1500字节以内",@"content":SafeStr(self.viewModel.addModel.p_information)}, ^(NSString * text, NSError * _Nullable error) {
            weakSelf.viewModel.addModel.p_information = text;
            [weakSelf initCellConfigArr];
            [weakSelf.iTableView reloadData];
        });
    }
}


#pragma mark - 提交数据Z
- (void)updateImageWithOtherParams:(NSMutableDictionary *)otherDict {
    if (self.viewModel.addModel.image_net_url && self.viewModel.addModel.image_net_url.length > 0) {
        [self updatePhotosStep1WithOtherParams:otherDict];
        return;
    }
    [TLUIUtility showLoading:@"上传封面图片中"];
    __weak typeof(self) weakSelf = self;
    [ZOriganizationLessonViewModel uploadImageList:@{@"type":@"2",@"imageKey":@{@"file":self.viewModel.addModel.image_url}} completeBlock:^(BOOL isSuccess, NSString *message) {
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
     __weak typeof(self) weakSelf = self;
     [self updatePhotosStep3WithImage:index otherParams:otherDict complete:^(BOOL isSuccess, NSInteger index) {
         if (index == weakSelf.viewModel.addModel.images.count-1) {
             [weakSelf updateOtherDataWithParams:otherDict];
         }else{
             index++;
             [weakSelf updatePhotosStep2WithImage:index otherParams:otherDict];
         }
    }];
}

- (void)updatePhotosStep3WithImage:(NSInteger)index otherParams:(NSMutableDictionary *)otherDict complete:(void(^)(BOOL, NSInteger))complete{
    [TLUIUtility showLoading:[NSString stringWithFormat:@"上传课程相册中 %ld/%ld",index+1,self.viewModel.addModel.images.count]];
    
    id temp = self.viewModel.addModel.images[index];
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
            [weakSelf.viewModel.addModel.images replaceObjectAtIndex:index withObject:message];
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
        for (int i = 0; i < self.viewModel.addModel.images.count; i++) {
            NSString *temp = self.viewModel.addModel.images[i];
            if (ValidStr(temp)) {
                [photos addObject:temp];
            }
        }
        if (photos.count > 0) {
            [otherDict setObject:photos forKey:@"images"];
        }
        
    }
    __weak typeof(self) weakSelf = self;
    [TLUIUtility showLoading:@"上传其他数据"];
    [ZOriganizationLessonViewModel addLesson:otherDict isEdit:ValidStr(self.viewModel.addModel.lessonID) ? YES:NO completeBlock:^(BOOL isSuccess, NSString *message) {
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
@end

#pragma mark - RouteHandler
@interface ZOrganizationLessonAddVC (RouteHandler)<SJRouteHandler>

@end

@implementation ZOrganizationLessonAddVC (RouteHandler)

+ (NSString *)routePath {
    return ZRoute_org_lessonAdd;
}

+ (void)handleRequest:(SJRouteRequest *)request topViewController:(UIViewController *)topViewController completionHandler:(SJCompletionHandler)completionHandler {
    ZOrganizationLessonAddVC *routevc = [[ZOrganizationLessonAddVC alloc] init];
    if (request.prts) {
        routevc.viewModel.addModel = request.prts;
    }
    [topViewController.navigationController pushViewController:routevc animated:YES];
}
@end
