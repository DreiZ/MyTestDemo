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

#import "ZOrganizationCampusCell.h"
#import "ZSpaceEmptyCell.h"
#import "ZOrganizationCampusTextFieldCell.h"
#import "ZOrganizationRadiusCell.h"
#import "ZOrganizationCampusTextLabelCell.h"
#import "ZMultiseriateContentLeftLineCell.h"
#import "ZOrganizationSwitchSchoolCell.h"

#import "ZAlertDataPickerView.h"
#import "ZAlertDataSinglePickerView.h"
#import "ZAlertDataModel.h"

#import "ZOrganizationCampusManagementAddressVC.h"
#import "ZOrganizationCampusManageAddLabelVC.h"
#import "ZOrganizationCampusManageTimeVC.h"
#import "ZOriganizationViewModel.h"
#import "ZOriganizationLessonViewModel.h"

@interface ZOrganizationCampusManagementVC ()
@property (nonatomic,strong) UIButton *bottomBtn;
@property (nonatomic,strong) ZOriganizationSchoolDetailModel *model;
@property (nonatomic,strong) NSMutableArray <ZAlertDataItemModel*> *items;
@property (nonatomic,strong) NSArray *typeList;

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
    _typeList = @[@"体育竞技",@"艺术舞蹈",@"兴趣爱好",@"其他"];
    _model = [[ZOriganizationSchoolDetailModel alloc] init];
}

- (void)initCellConfigArr {
    [super initCellConfigArr];
    
    
    ZCellConfig *imageCellConfig = [ZCellConfig cellConfigWithClassName:[ZOrganizationSwitchSchoolCell className] title:[ZOrganizationSwitchSchoolCell className] showInfoMethod:@selector(setModel:) heightOfCell:[ZOrganizationSwitchSchoolCell z_getCellHeight:self.model] cellType:ZCellTypeClass dataModel:self.model];
    [self.cellConfigArr addObject:imageCellConfig];
    
    ZCellConfig *topCellConfig = [ZCellConfig cellConfigWithClassName:[ZOrganizationRadiusCell className] title:[ZOrganizationRadiusCell className] showInfoMethod:@selector(setIsTop:) heightOfCell:CGFloatIn750(20) cellType:ZCellTypeClass dataModel:@"yes"];
    [self.cellConfigArr addObject:topCellConfig];
    
    NSString *type = @"";
    if (self.model && [SafeStr(self.model.store_type_id) intValue] > 0 && [SafeStr(self.model.store_type_id) intValue] <= _typeList.count) {
        type = _typeList[[SafeStr(self.model.store_type_id) intValue] - 1];
    }
    NSString *time = @"";
    if (self.model && ValidStr(self.model.opend_start)&& ValidStr(self.model.opend_end) && self.model.week_days && self.model.months && self.model.week_days.count > 0 && self.model.months.count > 0) {
        time = @"已编辑";
    }
    
    NSArray *textArr = @[@[@"校区名称", @"请输入校区名称", SafeStr(self.model.hash_update_name), @NO, @"name",self.model? SafeStr(self.model.name):@""],
                         @[@"校区类型", @"请选择校区类型", @NO, @NO, @"type", type],
                         @[@"校区电话", @"请输入校区电话", @YES, @NO, @"phone", self.model? SafeStr(self.model.phone):@""],
                         @[@"校区地址", @"请选择校区地址", @NO, @NO, @"address", self.model?  SafeStr(self.model.address):@""],
                         @[@"营业时间", @"请选择营业时间", @NO, @NO, @"time",time],
                         @[@"基础设置", @"请添加基础设施", @YES, @YES, @"setting",self.model? self.model.stores_info:@[]],
                         @[@"机构特色", @"请添加结构特色", @YES, @YES, @"characteristic",self.model.merchants_stores_tags? self.model.merchants_stores_tags:@[]]];
    
    for (int i = 0; i < textArr.count; i++) {
        if ([textArr[i][3] boolValue]) {
            ZBaseTextFieldCellModel *cellModel = [[ZBaseTextFieldCellModel alloc] init];
            cellModel.leftFont = [UIFont boldFontTitle];
            cellModel.leftTitle = textArr[i][0];
            cellModel.placeholder = textArr[i][1];
            cellModel.isTextEnabled = [textArr[i][2] boolValue];
            cellModel.isHiddenLine = YES;
            cellModel.rightMargin = CGFloatIn750(30);
            cellModel.leftMargin = CGFloatIn750(30);
            cellModel.cellHeight = CGFloatIn750(108);
            cellModel.contBackMargin = CGFloatIn750(0);
            cellModel.data = textArr[i][5];
            cellModel.cellWidth = KScreenWidth - CGFloatIn750(60);
            
            ZCellConfig *textCellConfig = [ZCellConfig cellConfigWithClassName:[ZOrganizationCampusTextLabelCell className] title:textArr[i][4] showInfoMethod:@selector(setModel:) heightOfCell:[ZOrganizationCampusTextLabelCell z_getCellHeight:cellModel] cellType:ZCellTypeClass dataModel:cellModel];
            [self.cellConfigArr addObject:textCellConfig];
        }else{
            if ([textArr[i][4] isEqualToString:@"address"]) {
                if (self.model.address && self.model.address.length > 0) {
                    ZBaseMultiseriateCellModel *model = [[ZBaseMultiseriateCellModel alloc] init];
                    model.leftTitle = textArr[i][0];
                    model.rightTitle = [NSString stringWithFormat:@"%@%@",SafeStr(self.model.brief_address),SafeStr(self.model.address)].length > 0 ? [NSString stringWithFormat:@"%@%@",SafeStr(self.model.brief_address),SafeStr(self.model.address)] : @"请选择地址";
                    model.isHiddenLine = YES;
                    model.cellWidth = KScreenWidth - CGFloatIn750(60);
                    model.rightColor = [UIColor colorBlack];
                    model.singleCellHeight = CGFloatIn750(106);
                    model.lineLeftMargin = CGFloatIn750(30);
                    model.lineRightMargin = CGFloatIn750(30);
                    model.cellHeight = CGFloatIn750(108);
                    model.leftFont = [UIFont boldFontTitle];
                    model.rightFont = [UIFont fontContent];
                    model.cellTitle = textArr[i][4];
                    model.leftMargin = CGFloatIn750(20);
                    model.rightImage = @"rightBlackArrowN";
                    
                    ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZMultiseriateContentLeftLineCell className] title:model.cellTitle showInfoMethod:@selector(setMModel:) heightOfCell:[ZMultiseriateContentLeftLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
                    
                    [self.cellConfigArr addObject:menuCellConfig];
                    
                    continue;
                }
            }
            ZBaseTextFieldCellModel *cellModel = [[ZBaseTextFieldCellModel alloc] init];
            cellModel.leftFont = [UIFont boldFontTitle];
            cellModel.leftTitle = textArr[i][0];
            cellModel.placeholder = textArr[i][1];
            cellModel.isTextEnabled = [textArr[i][2] boolValue];
            cellModel.isHiddenLine = YES;
            cellModel.cellHeight = CGFloatIn750(108);
            cellModel.content = textArr[i][5];
            if ([textArr[i][4] isEqualToString:@"phone"]) {
                cellModel.formatterType = ZFormatterTypePhoneNumber;
                cellModel.max = 20;
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
        make.top.equalTo(self.view.mas_top).offset(10);
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
        [_bottomBtn bk_whenTapped:^{
            if (!ValidStr(weakSelf.model.schoolID)) {
                [TLUIUtility showErrorHint:@"校区数据获取异常，请退出后从事"];
                return ;
            }
            if (!ValidStr(weakSelf.model.store_type_id)) {
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
            
            NSMutableDictionary *params = @{}.mutableCopy;
            [params setObject:self.model.schoolID forKey:@"id"];
            [params setObject:self.model.store_type_id forKey:@"store_type_id"];
            [params setObject:self.model.phone forKey:@"phone"];
            [params setObject:self.model.name forKey:@"name"];
            [params setObject:self.model.province forKey:@"province"];
            [params setObject:self.model.city forKey:@"city"];
            [params setObject:self.model.county forKey:@"county"];
            [params setObject:self.model.brief_address forKey:@"brief_address"];
            [params setObject:self.model.address forKey:@"address"];
            [params setObject:self.model.longitude forKey:@"longitude"];
            [params setObject:self.model.latitude forKey:@"latitude"];
            [params setObject:self.model.week_days forKey:@"week_days"];
            [params setObject:self.model.months forKey:@"months"];
            [params setObject:self.model.opend_start forKey:@"opend_start"];
            [params setObject:self.model.opend_end forKey:@"opend_end"];
            [params setObject:self.model.merchants_stores_tags forKey:@"merchants_stores_tags"];
            [params setObject:self.model.stores_info forKey:@"stores_info"];
            
            [weakSelf updateImageWithOtherParams:params];
        }];
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
    
    [ZOriganizationViewModel updateSchoolDetail:params completeBlock:^(BOOL isSuccess, NSString *message) {
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
            [[ZPhotoManager sharedManager] showCropOriginalSelectMenuWithCropSize:CGSizeMake(KScreenWidth, 2/3.0f * KScreenWidth) complete:^(NSArray<LLImagePickerModel *> *list) {
                if (list && list.count > 0) {
                    LLImagePickerModel *model = list[0];
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
        NSMutableArray *items = @[].mutableCopy;
        NSArray *temp = _typeList;
        for (int i = 0; i < temp.count; i++) {
           ZAlertDataItemModel *model = [[ZAlertDataItemModel alloc] init];
           model.name = temp[i];
           [items addObject:model];
        }
        
        [ZAlertDataSinglePickerView setAlertName:@"类别选择" items:items handlerBlock:^(NSInteger index) {
            weakSelf.model.store_type_id = [NSString stringWithFormat:@"%ld",index+1];
            [weakSelf initCellConfigArr];
            [weakSelf.iTableView reloadData];
        }];
    }else if ([cellConfig.title isEqualToString:@"characteristic"]) {
       ZOrganizationCampusManageAddLabelVC *lvc = [[ZOrganizationCampusManageAddLabelVC alloc] init];
        lvc.max = 5;
        lvc.list = self.model.merchants_stores_tags;
        lvc.navTitle = @"机构特色";
        lvc.handleBlock = ^(NSArray * labelArr) {
            [weakSelf.model.merchants_stores_tags removeAllObjects];
            [weakSelf.model.merchants_stores_tags addObjectsFromArray:labelArr];
            [weakSelf initCellConfigArr];
            [weakSelf.iTableView reloadData];
        };
       [self.navigationController pushViewController:lvc animated:YES];
    }else if ([cellConfig.title isEqualToString:@"setting"]) {
        ZOrganizationCampusManageAddLabelVC *lvc = [[ZOrganizationCampusManageAddLabelVC alloc] init];
        lvc.max = 5;
        lvc.list = self.model.stores_info;
        lvc.navTitle = @"基础设置";
        lvc.handleBlock = ^(NSArray * labelArr) {
            [weakSelf.model.stores_info removeAllObjects];
            [weakSelf.model.stores_info addObjectsFromArray:labelArr];
            [weakSelf initCellConfigArr];
            [weakSelf.iTableView reloadData];
        };
        [self.navigationController pushViewController:lvc animated:YES];
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
    }
    
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
