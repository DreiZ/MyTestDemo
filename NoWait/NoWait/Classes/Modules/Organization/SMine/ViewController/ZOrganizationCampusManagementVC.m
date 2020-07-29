//
//  ZOrganizationCampusManagementVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/2/16.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationCampusManagementVC.h"
#import "ZOrganizationCampusManagementAddressVC.h"

#import "ZOriganizationModel.h"
#import "ZStudentDetailModel.h"

#import "ZOrganizationCampusTextFieldCell.h"
#import "ZOrganizationRadiusCell.h"
#import "ZOrganizationCampusTextLabelCell.h"
#import "ZOrganizationSwitchSchoolCell.h"

#import "ZAlertDataModel.h"

#import "ZOrganizationCampusManagementAddressVC.h"
#import "ZOrganizationCampusManageTimeVC.h"


#import "ZOriganizationViewModel.h"
#import "ZOriganizationLessonViewModel.h"
#import "ZAlertClassifyPickerView.h"
#import "ZStudentMainViewModel.h"

@interface ZOrganizationCampusManagementVC ()
@property (nonatomic,strong) UIButton *bottomBtn;
@property (nonatomic,strong) ZOriganizationSchoolDetailModel *model;
@property (nonatomic,strong) NSMutableArray <ZAlertDataItemModel*> *items;

@end

@implementation ZOrganizationCampusManagementVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigation];
    [self setTableViewGaryBack];
    [self initCellConfigArr];
    [self getDataList];
}

- (void)setDataSource {
    [super setDataSource];
    _items = @[].mutableCopy;
    _model = [[ZOriganizationSchoolDetailModel alloc] init];
}

- (void)initCellConfigArr {
    [super initCellConfigArr];
    
    ZCellConfig *imageCellConfig = [ZCellConfig cellConfigWithClassName:[ZOrganizationSwitchSchoolCell className] title:[ZOrganizationSwitchSchoolCell className] showInfoMethod:@selector(setModel:) heightOfCell:[ZOrganizationSwitchSchoolCell z_getCellHeight:self.model] cellType:ZCellTypeClass dataModel:self.model];
    [self.cellConfigArr addObject:imageCellConfig];
    
    ZCellConfig *topCellConfig = [ZCellConfig cellConfigWithClassName:[ZOrganizationRadiusCell className] title:[ZOrganizationRadiusCell className] showInfoMethod:@selector(setIsTop:) heightOfCell:CGFloatIn750(20) cellType:ZCellTypeClass dataModel:@"yes"];
    [self.cellConfigArr addObject:topCellConfig];
    
    NSString *time = @"";
    if (self.model && ValidStr(self.model.opend_start)&& ValidStr(self.model.opend_end) && self.model.week_days && self.model.months && self.model.week_days.count > 0 && self.model.months.count > 0) {
        time = @"已编辑";
    }
    
    NSString *info = @"";
    if (self.model && ValidStr(self.model.info)) {
        info = @"已编辑";
    }
    
    NSMutableArray *classify = @[].mutableCopy;
    for (int i = 0; i < self.model.category.count; i++) {
        ZMainClassifyOneModel *model = self.model.category[i];
        [classify addObject:model.name];
    }
    
    NSArray *textArr = @[@[@"校区名称", @"请输入校区名称", [[NSNumber alloc] initWithBool: ![SafeStr(self.model.hash_update_name) boolValue]], @NO, @"name",self.model? SafeStr(self.model.name):@""],
                         @[@"校区类型", @"请选择校区类型", @YES, @YES, @"type", classify],
                         @[@"校区电话", @"请输入校区电话", @YES, @NO, @"phone", self.model? SafeStr(self.model.phone):@""],
                         @[@"校区地址", @"请选择校区地址", @NO, @NO, @"address", self.model?  SafeStr(self.model.address):@""],
                         @[@"营业时间", @"请选择营业时间", @NO, @NO, @"time",time],
                         @[@"基础设置", @"请添加基础设施", @YES, @YES, @"setting",self.model? self.model.stores_info:@[]],
                         @[@"机构特色", @"请添加结构特色", @YES, @YES, @"characteristic",self.model.merchants_stores_tags? self.model.merchants_stores_tags:@[]],
                         @[@"校区简介", @"请填写校区简介", @NO, @NO, @"info",info]];
    
    for (int i = 0; i < textArr.count; i++) {
        if ([textArr[i][4] isEqualToString:@"type"] || [textArr[i][4] isEqualToString:@"setting"] || [textArr[i][4] isEqualToString:@"characteristic"]) {
            ZBaseTextFieldCellModel *cellModel = [[ZBaseTextFieldCellModel alloc] init];
            cellModel.leftFont = [UIFont fontContent];
            cellModel.leftTitle = textArr[i][0];
            cellModel.placeholder = textArr[i][1];
            cellModel.isTextEnabled = [textArr[i][2] boolValue];
            cellModel.isHiddenLine = YES;
            cellModel.rightMargin = CGFloatIn750(0);
            cellModel.leftMargin = CGFloatIn750(30);
            cellModel.cellHeight = CGFloatIn750(86);
            cellModel.contBackMargin = CGFloatIn750(0);
            cellModel.data = textArr[i][5];
            cellModel.cellWidth = KScreenWidth - CGFloatIn750(60);
            if ([SafeStr(self.model.hash_update_store_type_id) boolValue] && [textArr[i][4] isEqualToString:@"type"]) {
                cellModel.isTextEnabled = NO;
            }else{
                cellModel.isTextEnabled = [textArr[i][2] boolValue];
            }
            
            ZCellConfig *textCellConfig = [ZCellConfig cellConfigWithClassName:[ZOrganizationCampusTextLabelCell className] title:textArr[i][4] showInfoMethod:@selector(setModel:) heightOfCell:[ZOrganizationCampusTextLabelCell z_getCellHeight:cellModel] cellType:ZCellTypeClass dataModel:cellModel];
            [self.cellConfigArr addObject:textCellConfig];
        }else{
            if ([textArr[i][4] isEqualToString:@"address"]) {
                if (self.model.address && self.model.address.length > 0) {
                    ZLineCellModel *model = ZLineCellModel.zz_lineCellModel_create(textArr[i][4])
                    .zz_titleLeft(textArr[i][0])
                    .zz_titleRight([NSString stringWithFormat:@"%@%@",SafeStr(self.model.brief_address),SafeStr(self.model.address)].length > 0 ? [NSString stringWithFormat:@"%@%@",SafeStr(self.model.brief_address),SafeStr(self.model.address)] : @"请选择地址")
                    .zz_lineHidden(YES)
                    .zz_rightMultiLine(YES)
                    .zz_cellHeight(CGFloatIn750(86))
                    .zz_cellWidth(KScreenWidth - CGFloatIn750(60))
                    .zz_marginLeft(CGFloatIn750(20))
                    .zz_imageRightHeight(CGFloatIn750(14));
                    
                    if ([SafeStr(self.model.hash_update_address) boolValue]) {
                        model.zz_colorRight([UIColor colorTextGray1])
                        .zz_colorDarkRight([UIColor colorTextGray1Dark])
                        .zz_imageRight(nil);
                    }else{
                        model.zz_colorRight([UIColor colorTextBlack])
                        .zz_colorDarkRight([UIColor colorTextBlackDark])
                        .zz_imageRight(@"rightBlackArrowN");
                    }
                    
                    ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZBaseLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZBaseLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
                    
                    [self.cellConfigArr addObject:menuCellConfig];
                    
                    continue;
                }
            }
            ZBaseTextFieldCellModel *cellModel = [[ZBaseTextFieldCellModel alloc] init];
            cellModel.leftFont = [UIFont fontContent];
            cellModel.leftTitle = textArr[i][0];
            cellModel.placeholder = textArr[i][1];
            cellModel.isTextEnabled = [textArr[i][2] boolValue];
            cellModel.isHiddenLine = YES;
            cellModel.cellHeight = CGFloatIn750(86);
            cellModel.content = textArr[i][5];
            if ([textArr[i][4] isEqualToString:@"phone"]) {
                cellModel.formatterType = ZFormatterTypePhoneNumber;
                cellModel.max = 20;
            }else if ([textArr[i][4] isEqualToString:@"name"]) {
                cellModel.max = 60;
                cellModel.formatterType = ZFormatterTypeAnyByte;
                if ([SafeStr(self.model.hash_update_name) boolValue]) {
                    cellModel.rightColor = [UIColor colorTextGray1];
                    cellModel.rightDarkColor = [UIColor colorTextGray1Dark];
                }else{
                    cellModel.rightColor = [UIColor colorTextBlack];
                    cellModel.rightDarkColor = [UIColor colorTextBlackDark];
                }
            }
            
            ZCellConfig *textCellConfig = [ZCellConfig cellConfigWithClassName:[ZOrganizationCampusTextFieldCell className] title:textArr[i][4] showInfoMethod:@selector(setModel:) heightOfCell:[ZOrganizationCampusTextFieldCell z_getCellHeight:cellModel] cellType:ZCellTypeClass dataModel:cellModel];
            [self.cellConfigArr addObject:textCellConfig];
        }
    }
    
    ZCellConfig *bottomCellConfig = [ZCellConfig cellConfigWithClassName:[ZOrganizationRadiusCell className] title:[ZOrganizationRadiusCell className] showInfoMethod:@selector(setIsTop:) heightOfCell:[ZOrganizationRadiusCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:@""];
    [self.cellConfigArr addObject:bottomCellConfig];
}


- (void)setNavigation {
    self.isHidenNaviBar = NO;
    [self.navigationItem setTitle:@"校区管理"];
}

- (void)setupMainView {
    [super setupMainView];
    self.view.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, CGFloatIn750(160))];
    bottomView.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
    
    
    [bottomView addSubview:self.bottomBtn];
    [self.bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bottomView.mas_left).offset(CGFloatIn750(60));
        make.right.equalTo(bottomView.mas_right).offset(CGFloatIn750(-60));
        make.height.mas_equalTo(CGFloatIn750(80));
        make.top.equalTo(bottomView.mas_top).offset(CGFloatIn750(40));
    }];
    
    [self.iTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view);
        make.left.equalTo(self.view.mas_left).offset(CGFloatIn750(30));
        make.right.equalTo(self.view.mas_right).offset(-CGFloatIn750(30));
        make.top.equalTo(self.view.mas_top).offset(CGFloatIn750(20));
    }];
    self.iTableView.tableFooterView = bottomView;
}

#pragma mark lazy loading...
- (UIButton *)bottomBtn {
    if (!_bottomBtn) {
        __weak typeof(self) weakSelf = self;
        _bottomBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        _bottomBtn.layer.masksToBounds = YES;
        _bottomBtn.layer.cornerRadius = CGFloatIn750(40);
        [_bottomBtn setTitle:@"保存设置" forState:UIControlStateNormal];
        [_bottomBtn setTitleColor:[UIColor colorWhite] forState:UIControlStateNormal];
        [_bottomBtn.titleLabel setFont:[UIFont boldFontTitle]];
        [_bottomBtn setBackgroundColor:adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]) forState:UIControlStateNormal];
        [_bottomBtn bk_addEventHandler:^(id sender) {
            if (!ValidStr(weakSelf.model.schoolID)) {
                [TLUIUtility showErrorHint:@"校区数据获取异常，请退出后从事"];
                return ;
            }
            if (!ValidArray(weakSelf.model.category)) {
                [TLUIUtility showErrorHint:@"请选择校区类型"];
                return ;
            }
            if (!ValidStr(weakSelf.model.phone)) {
                [TLUIUtility showErrorHint:@"请输入校区电话"];
                return ;
            }
            if (!ValidStr(weakSelf.model.address)) {
                [TLUIUtility showErrorHint:@"请选择校区地址"];
                return ;
            }
            if (!ValidArray(weakSelf.model.months)) {
                [TLUIUtility showErrorHint:@"请选择营业月份"];
                return ;
            }
            if (!ValidArray(weakSelf.model.week_days)) {
                [TLUIUtility showErrorHint:@"请选择营业时间"];
                return ;
            }
            if (!ValidStr(weakSelf.model.opend_start)) {
                [TLUIUtility showErrorHint:@"请选择营业时段"];
                return ;
            }
            if (!ValidArray(weakSelf.model.stores_info)) {
                [TLUIUtility showErrorHint:@"请添加基础设施"];
                return ;
            }
            if (!ValidArray(weakSelf.model.merchants_stores_tags)) {
                [TLUIUtility showErrorHint:@"请添加机构特色"];
                return ;
            }
            
            NSMutableArray *months = @[].mutableCopy;
            [weakSelf.model.months enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [months addObject:[obj stringByReplacingOccurrencesOfString:@"月" withString:@""]];
            }];
            
            NSMutableDictionary *params = @{}.mutableCopy;
            [params setObject:weakSelf.model.schoolID forKey:@"id"];
//            [params setObject:self.model.store_type_id forKey:@"store_type_id"];
            [params setObject:weakSelf.model.phone forKey:@"phone"];
            [params setObject:weakSelf.model.name forKey:@"name"];
            [params setObject:weakSelf.model.province forKey:@"province"];
            [params setObject:weakSelf.model.city forKey:@"city"];
            [params setObject:weakSelf.model.county forKey:@"county"];
            [params setObject:weakSelf.model.brief_address forKey:@"brief_address"];
            [params setObject:weakSelf.model.address forKey:@"address"];
            [params setObject:weakSelf.model.longitude forKey:@"longitude"];
            [params setObject:weakSelf.model.latitude forKey:@"latitude"];
            [params setObject:weakSelf.model.week_days forKey:@"week_days"];
            [params setObject:months forKey:@"months"];
            [params setObject:weakSelf.model.opend_start forKey:@"opend_start"];
            [params setObject:weakSelf.model.opend_end forKey:@"opend_end"];
            [params setObject:weakSelf.model.merchants_stores_tags forKey:@"merchants_stores_tags"];
            [params setObject:weakSelf.model.stores_info forKey:@"stores_info"];
            
            if (ValidStr(weakSelf.model.info)) {
                [params setObject:weakSelf.model.info forKey:@"info"];
            }
            NSString *cat = @"";
            for (int i = 0; i < weakSelf.model.category.count; i++) {
                ZMainClassifyOneModel *model = weakSelf.model.category[i];
                if (i == 0) {
                    cat = model.classify_id;
                }else{
                    cat = [NSString stringWithFormat:@"%@,%@",cat,model.classify_id];
                }
            }
            
            [params setObject:cat forKey:@"category"];
            [weakSelf updateImageWithOtherParams:params];
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _bottomBtn;
}


#pragma mark - 提交数据Z
- (void)updateImageWithOtherParams:(NSMutableDictionary *)otherDict {
    if (!ValidClass(self.model.image, [UIImage class])) {
        [self updateOtherParams:otherDict];
        return;
    }
    [TLUIUtility showLoading:@"上传封面图片中"];
    __weak typeof(self) weakSelf = self;
    [ZOriganizationLessonViewModel uploadImageList:@{@"type":@"1",@"imageKey":@{@"file":self.model.image}} completeBlock:^(BOOL isSuccess, NSString *message) {
        if (isSuccess) {
            weakSelf.model.image = message;
            [weakSelf updateOtherParams:otherDict];
        }else{
            [TLUIUtility hiddenLoading];
            [TLUIUtility showErrorHint:message];
        }
    }];
}

- (void)updateOtherParams:(NSMutableDictionary *)params {
    if (ValidStr(self.model.image)) {
        [params setObject:SafeStr(self.model.image) forKey:@"image"];
    }
    __weak typeof(self) weakSelf = self;
    [ZOriganizationViewModel updateSchoolDetail:params completeBlock:^(BOOL isSuccess, NSString *message) {
        if (isSuccess) {
            [TLUIUtility showSuccessHint:message];
            [weakSelf.navigationController popViewControllerAnimated:YES];
            return ;
        }else {
            [TLUIUtility showErrorHint:message];
        }
    }];
}

#pragma mark - tableView -------datasource-----
- (void)zz_tableView:(UITableView *)tableView cell:(UITableViewCell *)cell cellForRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
    __weak typeof(self) weakSelf = self;
    if ([cellConfig.title isEqualToString:@"ZOrganizationRadiusCell"]){
        ZOrganizationRadiusCell *enteryCell = (ZOrganizationRadiusCell *)cell;
        enteryCell.leftMargin = CGFloatIn750(0);
    }else if ([cellConfig.title isEqualToString:@"phone"]){
        ZOrganizationCampusTextFieldCell *enteryCell = (ZOrganizationCampusTextFieldCell *)cell;
        enteryCell.valueChangeBlock = ^(NSString * _Nonnull text) {
            weakSelf.model.phone = text;
        };
    }else if ([cellConfig.title isEqualToString:@"name"]){
        ZOrganizationCampusTextFieldCell *enteryCell = (ZOrganizationCampusTextFieldCell *)cell;
        enteryCell.valueChangeBlock = ^(NSString * _Nonnull text) {
            weakSelf.model.name = text;
        };
    }else if ([cellConfig.title isEqualToString:@"ZOrganizationSwitchSchoolCell"]){
        ZOrganizationSwitchSchoolCell *tCell = (ZOrganizationSwitchSchoolCell *)cell;
        tCell.handleBlock = ^(NSInteger index) {
            [[ZImagePickerManager sharedManager] setCropRect:CGSizeMake(KScreenWidth, 2/3.0f * KScreenWidth) SelectMenu:^(NSArray<ZImagePickerModel *> *list) {
                if (list && list.count > 0) {
                    ZImagePickerModel *model = list[0];
                    weakSelf.model.image = model.image;
                    [weakSelf initCellConfigArr];
                    [weakSelf.iTableView reloadData];
                }
            }];
        };
    }
}

- (void)zz_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
    __weak typeof(self) weakSelf = self;
    if ([cellConfig.title isEqualToString:@"name"]) {
        if ([SafeStr(self.model.hash_update_name) boolValue]){
            [TLUIUtility showErrorHint:@"名称已不可修改"];
            return;
        }
    }else if ([cellConfig.title isEqualToString:@"address"]) {
        if ([SafeStr(self.model.hash_update_address) boolValue]) {
            [TLUIUtility showErrorHint:@"地址已不可修改"];
            return;
        }
        ZOrganizationCampusManagementAddressVC *mvc = [[ZOrganizationCampusManagementAddressVC alloc] init];
        mvc.address = self.model.address;
        mvc.brief_address = self.model.brief_address;
        mvc.province = self.model.province;
        mvc.city = self.model.city;
        mvc.county = self.model.county;

        mvc.latitude = [self.model.latitude doubleValue];
        mvc.longitude = [self.model.longitude doubleValue];
        
        mvc.addressBlock = ^(NSString * province, NSString * city, NSString * county, NSString * brief_address, NSString * address, double latitude, double  longitude) {
            weakSelf.model.province = province;
            weakSelf.model.city = city;
            weakSelf.model.county = county;
            weakSelf.model.brief_address = brief_address;
            weakSelf.model.address = address;
            weakSelf.model.latitude = [NSString stringWithFormat:@"%f",latitude];
            weakSelf.model.longitude = [NSString stringWithFormat:@"%f",longitude];
            [weakSelf initCellConfigArr];
            [weakSelf.iTableView reloadData];
        };
        [self.navigationController pushViewController:mvc animated:YES];
        
    }else if ([cellConfig.title isEqualToString:@"type"]) {
        if ([SafeStr(self.model.hash_update_store_type_id) boolValue]){
            [TLUIUtility showErrorHint:@"类型已不可修改"];
            return;
        }

        NSMutableArray *classify = @[].mutableCopy;
        [classify addObjectsFromArray:[ZStudentMainViewModel mainClassifyOneData]];
        if (ValidArray(classify)) {
            [self showTypeSelect:classify];
        }else{
            __weak typeof(self) weakSelf = self;
            [TLUIUtility showLoading:nil];
            [ZStudentMainViewModel getCategoryList:@{} completeBlock:^(BOOL isSuccess, id data) {
                [TLUIUtility hiddenLoading];
                if (isSuccess) {
                    ZMainClassifyNetModel *model = data;
                    [model.list enumerateObjectsUsingBlock:^(ZMainClassifyOneModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        [obj.secondary enumerateObjectsUsingBlock:^(ZMainClassifyOneModel *sobj, NSUInteger idx, BOOL * _Nonnull stop) {
                            sobj.superClassify_id = obj.classify_id;
                        }];
                    }];
                    [ZStudentMainViewModel updateMainClassifysOne:model.list];
                    [classify removeAllObjects];
                    [classify addObjectsFromArray:model.list];
                    [weakSelf showTypeSelect:classify];
                }
            }];
        }
    }else if ([cellConfig.title isEqualToString:@"characteristic"]) {
        NSMutableDictionary *tempDict = @{@"navTitle":@"机构特色",@"max":@"15"}.mutableCopy;
        if (self.model.merchants_stores_tags) {
            [tempDict setObject:self.model.merchants_stores_tags forKey:@"list"];
        }
        
        routePushVC(ZRoute_org_addLabel, tempDict, ^(NSArray *labelArr, NSError * _Nullable error) {
            [weakSelf.model.merchants_stores_tags removeAllObjects];
            [weakSelf.model.merchants_stores_tags addObjectsFromArray:labelArr];
            [weakSelf initCellConfigArr];
            [weakSelf.iTableView reloadData];
        });
    }else if ([cellConfig.title isEqualToString:@"setting"]) {
        NSMutableDictionary *tempDict = @{@"navTitle":@"基础设置",@"max":@"15"}.mutableCopy;
        if (self.model.stores_info) {
            [tempDict setObject:self.model.stores_info forKey:@"list"];
        }
        
        routePushVC(ZRoute_org_addLabel, tempDict, ^(NSArray *labelArr, NSError * _Nullable error) {
            [weakSelf.model.stores_info removeAllObjects];
            [weakSelf.model.stores_info addObjectsFromArray:labelArr];
            [weakSelf initCellConfigArr];
            [weakSelf.iTableView reloadData];
        });
    }else if ([cellConfig.title isEqualToString:@"time"]) {
        ZOrganizationCampusManageTimeVC *lvc = [[ZOrganizationCampusManageTimeVC alloc] init];
        lvc.weeks = self.model.week_days;
        lvc.months = self.model.months;
        lvc.start = self.model.opend_start;
        lvc.end = self.model.opend_end;
        lvc.timeBlock = ^(NSMutableArray * mouths, NSMutableArray * weeks, NSString * start, NSString * end) {
            weakSelf.model.week_days = weeks;
            weakSelf.model.months = mouths;
            weakSelf.model.opend_start = start;
            weakSelf.model.opend_end = end;
            [weakSelf initCellConfigArr];
            [weakSelf.iTableView reloadData];
        };
        [self.navigationController pushViewController:lvc animated:YES];
    }else if ([cellConfig.title isEqualToString:@"info"]){
        [self.iTableView endEditing:YES];
        routePushVC(ZRoute_org_textViewVC, @{@"navTitle":@"校区简介",@"max":@"1500",@"hintStr":@"请输入校区简介，1500字节以内",@"content":SafeStr(self.model.info)}, ^(NSString * text, NSError * _Nullable error) {
            weakSelf.model.info = text;
            [weakSelf initCellConfigArr];
            [weakSelf.iTableView reloadData];
        });
    }
    
}

- (void)showTypeSelect:(NSMutableArray *)classify {
    __weak typeof(self) weakSelf = self;
    [classify enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(ZMainClassifyOneModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.name hasPrefix:@"全部"]) {
            [classify removeObject:obj];
        }else{
            [obj.secondary enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(ZMainClassifyOneModel *sobj, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([sobj.name hasPrefix:@"全部"]) {
                    NSMutableArray *tempArr = @[].mutableCopy;
                    [tempArr addObjectsFromArray:obj.secondary];
                    [tempArr removeObject:sobj];
                    obj.secondary = tempArr;
                }
            }];
        }
    }];
    
    [classify enumerateObjectsUsingBlock:^(ZMainClassifyOneModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj.secondary enumerateObjectsUsingBlock:^(ZMainClassifyOneModel * sobj, NSUInteger sidx, BOOL * _Nonnull sstop) {
            [weakSelf.model.category enumerateObjectsUsingBlock:^(ZMainClassifyOneModel * cobj, NSUInteger cidx, BOOL * _Nonnull cstop) {
                if ([cobj.classify_id isEqualToString:sobj.classify_id]) {
                    obj.isSelected = YES;
                    sobj.isSelected = YES;
                }
            }];
        }];
    }];
    
    [ZAlertClassifyPickerView setClassifyAlertWithClassifyArr:classify handlerBlock:^(NSMutableArray *classify) {
        [weakSelf.model.category removeAllObjects];
        [weakSelf.model.category addObjectsFromArray:classify];
        [weakSelf initCellConfigArr];
        [weakSelf.iTableView reloadData];
    }];
}

- (void)getDataList {
    __weak typeof(self) weakSelf = self;
    [TLUIUtility showLoading:@""];
    [ZOriganizationViewModel getSchoolDetail:@{@"id":SafeStr([ZUserHelper sharedHelper].school.schoolID)} completeBlock:^(BOOL isSuccess, id data) {
        [TLUIUtility hiddenLoading];
        if (isSuccess && data && [data isKindOfClass:[ZOriganizationSchoolDetailModel class]]) {
            weakSelf.model = data;
            
            if (ValidArray(weakSelf.model.months)) {
                weakSelf.model.months = [[NSMutableArray alloc] initWithArray:weakSelf.model.months];
            }else{
                weakSelf.model.months = @[].mutableCopy;
            }
            
            if (ValidArray(weakSelf.model.stores_info)) {
                weakSelf.model.stores_info = [[NSMutableArray alloc] initWithArray:weakSelf.model.stores_info];
            }else{
                weakSelf.model.stores_info = @[].mutableCopy;
            }
            
            if (ValidArray(weakSelf.model.week_days)) {
                weakSelf.model.week_days = [[NSMutableArray alloc] initWithArray:weakSelf.model.week_days];
            }else{
                weakSelf.model.week_days = @[].mutableCopy;
            }
            
            if (ValidArray(weakSelf.model.merchants_stores_tags)) {
                weakSelf.model.merchants_stores_tags = [[NSMutableArray alloc] initWithArray:weakSelf.model.merchants_stores_tags];
            }else{
                weakSelf.model.merchants_stores_tags = @[].mutableCopy;
            }
            
            [weakSelf initCellConfigArr];
            [weakSelf.iTableView reloadData];
        }
        
    }];
}
@end

#pragma mark - RouteHandler
@interface ZOrganizationCampusManagementVC (RouteHandler)<SJRouteHandler>

@end

@implementation ZOrganizationCampusManagementVC (RouteHandler)

+ (NSString *)routePath {
    return ZRoute_org_schoolManager;
}

+ (void)handleRequest:(SJRouteRequest *)request topViewController:(UIViewController *)topViewController completionHandler:(SJCompletionHandler)completionHandler {
    ZOrganizationCampusManagementVC *routevc = [[ZOrganizationCampusManagementVC alloc] init];
    [topViewController.navigationController pushViewController:routevc animated:YES];
}
@end
