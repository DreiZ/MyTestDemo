//
//  ZOrganizationCampusManagementVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/2/16.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationCampusManagementVC.h"
#import "ZOrganizationCampusManagementAddressVC.h"

#import "ZCellConfig.h"
#import "ZStudentDetailModel.h"

#import "ZOrganizationCampusCell.h"
#import "ZSpaceEmptyCell.h"
#import "ZOrganizationCampusTextFieldCell.h"
#import "ZOrganizationRadiusCell.h"
#import "ZOrganizationCampusTextLabelCell.h"

#import "ZAlertDataPickerView.h"
#import "ZAlertDataModel.h"

#import "ZOrganizationCampusManagementAddressVC.h"
#import "ZOrganizationCampusManageAddLabelVC.h"
#import "ZOrganizationCampusManageTimeVC.h"

@interface ZOrganizationCampusManagementVC ()
@property (nonatomic,strong) UIButton *bottomBtn;

@property (nonatomic,strong) NSMutableArray <ZAlertDataItemModel*> *items;

@end

@implementation ZOrganizationCampusManagementVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigation];
    [self initCellConfigArr];
}

- (void)setDataSource {
    [super setDataSource];
    _items = @[].mutableCopy;
}

- (void)initCellConfigArr {
    [super initCellConfigArr];
    
    ZCellConfig *campusCellConfig = [ZCellConfig cellConfigWithClassName:[ZOrganizationCampusCell className] title:@"school" showInfoMethod:nil heightOfCell:[ZOrganizationCampusCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:nil];
    [self.cellConfigArr addObject:campusCellConfig];
    
    ZCellConfig *spacCellConfig = [ZCellConfig cellConfigWithClassName:[ZSpaceEmptyCell className] title:[ZSpaceEmptyCell className] showInfoMethod:@selector(setBackColor:) heightOfCell:CGFloatIn750(20) cellType:ZCellTypeClass dataModel:adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark])];
    [self.cellConfigArr addObject:spacCellConfig];
    
    ZCellConfig *topCellConfig = [ZCellConfig cellConfigWithClassName:[ZOrganizationRadiusCell className] title:[ZOrganizationRadiusCell className] showInfoMethod:@selector(setIsTop:) heightOfCell:CGFloatIn750(20) cellType:ZCellTypeClass dataModel:@"yes"];
    [self.cellConfigArr addObject:topCellConfig];
    
    NSArray *textArr = @[@[@"校区名称", @"请输入校区名称", @YES, @NO, @"name"],
                         @[@"校区类型", @"请选择校区类型", @NO, @NO, @"type"],
                         @[@"校区电话", @"请输入校区电话", @YES, @NO, @"phone"],
                         @[@"校区地址", @"请选择校区地址", @NO, @NO, @"address"],
                         @[@"校区标签", @"请添加校区标签", @NO, @YES, @"label"],
                         @[@"营业时间", @"请选择营业时间", @NO, @NO, @"time"],
                         @[@"基础设置", @"请添加基础设施", @NO, @YES, @"setting"],
                         @[@"机构特色", @"请添加结构特色", @NO, @YES, @"characteristic"]];
    
    for (int i = 0; i < textArr.count; i++) {
        if ([textArr[i][3] boolValue]) {
            ZBaseTextFieldCellModel *cellModel = [[ZBaseTextFieldCellModel alloc] init];
            cellModel.leftTitle = textArr[i][0];
            cellModel.placeholder = textArr[i][1];
            cellModel.isTextEnabled = [textArr[i][2] boolValue];
            cellModel.isHiddenLine = YES;
            cellModel.rightMargin = CGFloatIn750(0);
            cellModel.cellHeight = CGFloatIn750(108);
            cellModel.data = @[@"免费停车",@"免费停车",@"免费停车",@"免费停车",@"免费停车"];
            ZCellConfig *textCellConfig = [ZCellConfig cellConfigWithClassName:[ZOrganizationCampusTextLabelCell className] title:textArr[i][4] showInfoMethod:@selector(setModel:) heightOfCell:[ZOrganizationCampusTextLabelCell z_getCellHeight:cellModel] cellType:ZCellTypeClass dataModel:cellModel];
            [self.cellConfigArr addObject:textCellConfig];
        }else{
            ZBaseTextFieldCellModel *cellModel = [[ZBaseTextFieldCellModel alloc] init];
            cellModel.leftTitle = textArr[i][0];
            cellModel.placeholder = textArr[i][1];
            cellModel.isTextEnabled = [textArr[i][2] boolValue];
            cellModel.isHiddenLine = YES;
            cellModel.cellHeight = CGFloatIn750(108);
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
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, CGFloatIn750(60))];
    bottomView.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
    
    
    [bottomView addSubview:self.bottomBtn];
    [self.bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bottomView.mas_left).offset(CGFloatIn750(60));
        make.right.equalTo(bottomView.mas_right).offset(CGFloatIn750(-60));
        make.height.mas_equalTo(CGFloatIn750(80));
        make.centerY.equalTo(bottomView.mas_centerY);
    }];
    
    [self.iTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom);
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
- (void)zz_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
    
    if ([cellConfig.title isEqualToString:@"address"]) {
        ZOrganizationCampusManagementAddressVC *mvc = [[ZOrganizationCampusManagementAddressVC alloc] init];
        [self.navigationController pushViewController:mvc animated:YES];
    }else if ([cellConfig.title isEqualToString:@"type"]) {
        NSMutableArray *items = @[].mutableCopy;
        NSArray *temp = @[@"舞蹈",@"球类",@"教育",@"书法"];
        for (int i = 0; i < temp.count; i++) {
            ZAlertDataItemModel *model = [[ZAlertDataItemModel alloc] init];
            model.name = temp[i];
            
            NSMutableArray *subItems = @[].mutableCopy;
            
            NSArray *temp = @[@"篮球",@"排球",@"乒乓球",@"足球"];
            for (int i = 0; i < temp.count; i++) {
                ZAlertDataItemModel *model = [[ZAlertDataItemModel alloc] init];
                model.name = temp[i];
                [subItems addObject:model];
            }
            model.ItemArr = subItems;
            [items addObject:model];
        }
        
        [self.items removeAllObjects];
        [self.items addObjectsFromArray:items];
        [ZAlertDataPickerView setAlertName:@"校区选择" items:self.items handlerBlock:^(NSInteger index,NSInteger subIndex) {
            
        }];
    }else if ([cellConfig.title isEqualToString:@"school"]) {
        NSMutableArray *items = @[].mutableCopy;
        NSArray *temp = @[@"舞蹈",@"球类",@"教育",@"书法"];
        for (int i = 0; i < temp.count; i++) {
            ZAlertDataItemModel *model = [[ZAlertDataItemModel alloc] init];
            model.name = temp[i];
            
            NSMutableArray *subItems = @[].mutableCopy;
            
            NSArray *temp = @[@"篮球",@"排球",@"乒乓球",@"足球"];
            for (int i = 0; i < temp.count; i++) {
                ZAlertDataItemModel *model = [[ZAlertDataItemModel alloc] init];
                model.name = temp[i];
                [subItems addObject:model];
            }
            model.ItemArr = subItems;
            [items addObject:model];
        }
        
        [self.items removeAllObjects];
        [self.items addObjectsFromArray:items];
        [ZAlertDataPickerView setAlertName:@"校区选择" items:self.items handlerBlock:^(NSInteger index,NSInteger subIndex) {
            
        }];
    }else if ([cellConfig.title isEqualToString:@"label"]) {
        ZOrganizationCampusManageAddLabelVC *lvc = [[ZOrganizationCampusManageAddLabelVC alloc] init];
        [self.navigationController pushViewController:lvc animated:YES];
    }else if ([cellConfig.title isEqualToString:@"time"]) {
        ZOrganizationCampusManageTimeVC *lvc = [[ZOrganizationCampusManageTimeVC alloc] init];
        [self.navigationController pushViewController:lvc animated:YES];
    }
    
}
@end
