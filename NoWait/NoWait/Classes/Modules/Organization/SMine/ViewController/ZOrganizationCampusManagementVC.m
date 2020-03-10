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

#import "ZAlertDataPickerView.h"
#import "ZAlertDataSinglePickerView.h"
#import "ZAlertDataModel.h"

#import "ZOrganizationCampusManagementAddressVC.h"
#import "ZOrganizationCampusManageAddLabelVC.h"
#import "ZOrganizationCampusManageTimeVC.h"
#import "ZOriganizationViewModel.h"

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
    _typeList = @[@"体育",@"艺术",@"兴趣",@"其他"];
    _model = [[ZOriganizationSchoolDetailModel alloc] init];
}

- (void)initCellConfigArr {
    [super initCellConfigArr];
    
    ZCellConfig *spacCellConfig = [ZCellConfig cellConfigWithClassName:[ZSpaceEmptyCell className] title:[ZSpaceEmptyCell className] showInfoMethod:@selector(setBackColor:) heightOfCell:CGFloatIn750(20) cellType:ZCellTypeClass dataModel:adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark])];
    [self.cellConfigArr addObject:spacCellConfig];
    
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
    NSArray *textArr = @[@[@"校区名称", @"请输入校区名称", @YES, @NO, @"name",self.model? SafeStr(self.model.name):@""],
                         @[@"校区类型", @"请选择校区类型", @NO, @NO, @"type", type],
                         @[@"校区电话", @"请输入校区电话", @YES, @NO, @"phone", self.model? SafeStr(self.model.phone):@""],
                         @[@"校区地址", @"请选择校区地址", @NO, @NO, @"address", self.model?  SafeStr(self.model.address):@""],
                         @[@"营业时间", @"请选择营业时间", @NO, @NO, @"time",time],
                         @[@"基础设置", @"请添加基础设施", @NO, @YES, @"setting",self.model? self.model.stores_info:@[]],
                         @[@"机构特色", @"请添加结构特色", @NO, @YES, @"characteristic",self.model.merchant_stores_tags? self.model.merchant_stores_tags:@[]]];
    
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
            
            ZCellConfig *textCellConfig = [ZCellConfig cellConfigWithClassName:[ZOrganizationCampusTextLabelCell className] title:textArr[i][4] showInfoMethod:@selector(setModel:) heightOfCell:[ZOrganizationCampusTextLabelCell z_getCellHeight:cellModel] cellType:ZCellTypeClass dataModel:cellModel];
            [self.cellConfigArr addObject:textCellConfig];
        }else{
            if (i == 3) {
                if (self.model.address && self.model.address.length > 0) {
                    ZBaseMultiseriateCellModel *model = [[ZBaseMultiseriateCellModel alloc] init];
                    model.leftTitle = textArr[i][0];
                    model.rightTitle = [NSString stringWithFormat:@"%@%@%@%@",SafeStr(self.model.province),SafeStr(self.model.city),SafeStr(self.model.county),SafeStr(self.model.brief_address)].length > 0 ? [NSString stringWithFormat:@"%@%@%@%@%@",SafeStr(self.model.province),SafeStr(self.model.city),SafeStr(self.model.county),SafeStr(self.model.brief_address),SafeStr(self.model.address)] : @"请选择地址";
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
            if (i == 2) {
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
        [_bottomBtn setBackgroundColor:[UIColor  colorMain] forState:UIControlStateNormal];
        [_bottomBtn bk_whenTapped:^{

        }];
    }
    return _bottomBtn;
}


#pragma mark tableView -------datasource-----
- (void)zz_tableView:(UITableView *)tableView cell:(UITableViewCell *)cell cellForRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
    if ([cellConfig.title isEqualToString:@"ZOrganizationRadiusCell"]){
        ZOrganizationRadiusCell *enteryCell = (ZOrganizationRadiusCell *)cell;
        enteryCell.leftMargin = CGFloatIn750(0);
    }
}

- (void)zz_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
    __weak typeof(self) weakSelf = self;
    if ([cellConfig.title isEqualToString:@"address"]) {
        ZOrganizationCampusManagementAddressVC *mvc = [[ZOrganizationCampusManagementAddressVC alloc] init];
        mvc.addressBlock = ^(NSString * _Nonnull province, NSString * _Nonnull city, NSString * _Nonnull county, NSString * _Nonnull brief_address, NSString * _Nonnull address) {
            weakSelf.model.province = province;
            weakSelf.model.city = city;
            weakSelf.model.county = county;
            weakSelf.model.brief_address = brief_address;
            weakSelf.model.address = address;
            [weakSelf initCellConfigArr];
            [weakSelf.iTableView reloadData];
        };
        [self.navigationController pushViewController:mvc animated:YES];
    }else if ([cellConfig.title isEqualToString:@"type"]) {
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
        lvc.list = self.model.merchant_stores_tags;
        lvc.handleBlock = ^(NSArray * labelArr) {
            [weakSelf.model.merchant_stores_tags removeAllObjects];
            [weakSelf.model.merchant_stores_tags addObjectsFromArray:labelArr];
            [weakSelf initCellConfigArr];
            [weakSelf.iTableView reloadData];
        };
       [self.navigationController pushViewController:lvc animated:YES];
    }else if ([cellConfig.title isEqualToString:@"setting"]) {
        ZOrganizationCampusManageAddLabelVC *lvc = [[ZOrganizationCampusManageAddLabelVC alloc] init];
        lvc.max = 5;
        lvc.list = self.model.stores_info;
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
    [ZOriganizationViewModel getSchoolDetail:@{@"id":SafeStr(self.schoolID)} completeBlock:^(BOOL isSuccess, id data) {
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
            
            if (ValidArray(weakSelf.model.merchant_stores_tags)) {
                weakSelf.model.merchant_stores_tags = [[NSMutableArray alloc] initWithArray:weakSelf.model.merchant_stores_tags];
            }else{
                weakSelf.model.merchant_stores_tags = @[].mutableCopy;
            }
            
            [weakSelf initCellConfigArr];
            [weakSelf.iTableView reloadData];
        }
        
    }];
}
@end
